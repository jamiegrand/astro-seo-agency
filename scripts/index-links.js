#!/usr/bin/env node

/**
 * Link Indexer for Astro SEO Agency
 * 
 * Scans an Astro project to build internal link graph and extract keywords.
 * Can be run standalone or integrated with the /index command.
 * 
 * Usage:
 *   node scripts/index-links.js [options]
 * 
 * Options:
 *   --init          Create database if missing
 *   --full          Full re-index (clear existing data)
 *   --collection    Only index specific collection (e.g., --collection blog)
 *   --dry-run       Preview without writing to database
 *   --verbose       Show detailed output
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// Configuration
const CONFIG = {
  dbPath: '.planning/seo-audit.db',
  contentDir: 'src/content',
  pagesDir: 'src/pages',
  baseUrl: '', // Will be detected from astro.config
  
  // Patterns to extract internal links from markdown
  linkPatterns: [
    /\[([^\]]*)\]\(([^)]+)\)/g,           // [text](url)
    /href=["']([^"']+)["']/g,              // href="url"
    /<a[^>]+href=["']([^"']+)["']/g,       // <a href="url">
  ],
  
  // Frontmatter fields to check for keywords
  keywordFields: [
    'seoKeyword',
    'targetKeyword', 
    'keyword',
    'keywords',
    'tags',
  ],
  
  // Fields to extract for page analysis
  metaFields: [
    'title',
    'description',
    'topic',
    'category',
    'author',
  ]
};

// ============================================================================
// DATABASE HELPERS
// ============================================================================

function dbExec(sql, dbPath = CONFIG.dbPath) {
  try {
    return execSync(`sqlite3 "${dbPath}" "${sql.replace(/"/g, '\\"')}"`, {
      encoding: 'utf-8',
      stdio: ['pipe', 'pipe', 'pipe']
    }).trim();
  } catch (e) {
    return null;
  }
}

function dbQuery(sql, dbPath = CONFIG.dbPath) {
  const result = dbExec(sql, dbPath);
  if (!result) return [];
  return result.split('\n').filter(Boolean);
}

function checkDatabase() {
  if (!fs.existsSync(CONFIG.dbPath)) {
    return { exists: false, version: 0 };
  }
  
  const version = dbExec('SELECT COALESCE(MAX(version), 0) FROM schema_version;');
  return { 
    exists: true, 
    version: parseInt(version) || 0 
  };
}

function initDatabase() {
  const dir = path.dirname(CONFIG.dbPath);
  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir, { recursive: true });
  }
  
  // Run init script
  if (fs.existsSync('scripts/init-db.sql')) {
    execSync(`sqlite3 "${CONFIG.dbPath}" < scripts/init-db.sql`);
  }
  
  // Run v4 migration for link tables
  if (fs.existsSync('scripts/migrate-v4.sql')) {
    execSync(`sqlite3 "${CONFIG.dbPath}" < scripts/migrate-v4.sql`);
  }
}

// ============================================================================
// CONTENT PARSING
// ============================================================================

function parseFrontmatter(content) {
  const match = content.match(/^---\r?\n([\s\S]*?)\r?\n---/);
  if (!match) return {};
  
  const frontmatter = {};
  const lines = match[1].split('\n');
  
  for (const line of lines) {
    const colonIndex = line.indexOf(':');
    if (colonIndex === -1) continue;
    
    const key = line.slice(0, colonIndex).trim();
    let value = line.slice(colonIndex + 1).trim();
    
    // Remove quotes
    if ((value.startsWith('"') && value.endsWith('"')) ||
        (value.startsWith("'") && value.endsWith("'"))) {
      value = value.slice(1, -1);
    }
    
    // Handle arrays (simple case)
    if (value.startsWith('[') && value.endsWith(']')) {
      value = value.slice(1, -1).split(',').map(v => v.trim().replace(/["']/g, ''));
    }
    
    frontmatter[key] = value;
  }
  
  return frontmatter;
}

function extractLinks(content, sourceUrl) {
  const links = new Set();
  const body = content.replace(/^---[\s\S]*?---/, ''); // Remove frontmatter
  
  for (const pattern of CONFIG.linkPatterns) {
    let match;
    const regex = new RegExp(pattern.source, pattern.flags);
    
    while ((match = regex.exec(body)) !== null) {
      // Get the URL (might be in different capture groups)
      const url = match[2] || match[1];
      
      // Only internal links
      if (url && !url.startsWith('http') && !url.startsWith('mailto:') && !url.startsWith('#')) {
        // Normalize the URL
        let normalized = url.split('#')[0].split('?')[0];
        if (!normalized.startsWith('/')) {
          // Relative URL - resolve against source
          const sourceDir = path.dirname(sourceUrl);
          normalized = path.join(sourceDir, normalized).replace(/\\/g, '/');
        }
        if (normalized && normalized !== sourceUrl) {
          links.add(normalized);
        }
      }
    }
  }
  
  return Array.from(links);
}

function extractKeywords(frontmatter) {
  const keywords = [];
  
  for (const field of CONFIG.keywordFields) {
    if (frontmatter[field]) {
      const value = frontmatter[field];
      if (Array.isArray(value)) {
        keywords.push(...value);
      } else if (typeof value === 'string') {
        // Could be comma-separated
        keywords.push(...value.split(',').map(k => k.trim()));
      }
    }
  }
  
  return [...new Set(keywords.filter(Boolean))];
}

function getWordCount(content) {
  const body = content.replace(/^---[\s\S]*?---/, '').trim();
  const text = body.replace(/<[^>]+>/g, ' ').replace(/[#*_`\[\]()]/g, ' ');
  return text.split(/\s+/).filter(Boolean).length;
}

function contentToUrl(filePath, collection) {
  // Convert src/content/blog/my-post.md to /blog/my-post
  const slug = path.basename(filePath, path.extname(filePath));
  
  // Handle index files
  if (slug === 'index') {
    return `/${collection}/`;
  }
  
  // Handle language suffixes (my-post-en.md -> my-post)
  const cleanSlug = slug.replace(/-(?:en|es|fr|de|it|pt)$/, '');
  
  return `/${collection}/${cleanSlug}/`;
}

// ============================================================================
// INDEXING
// ============================================================================

function scanCollection(collectionPath, collectionName) {
  const pages = [];
  
  if (!fs.existsSync(collectionPath)) {
    return pages;
  }
  
  const files = fs.readdirSync(collectionPath, { recursive: true });
  
  for (const file of files) {
    const filePath = path.join(collectionPath, file);
    const stat = fs.statSync(filePath);
    
    if (stat.isFile() && (file.endsWith('.md') || file.endsWith('.mdx'))) {
      const content = fs.readFileSync(filePath, 'utf-8');
      const frontmatter = parseFrontmatter(content);
      const url = contentToUrl(filePath, collectionName);
      
      pages.push({
        url,
        sourceFile: file,
        filePath,
        title: frontmatter.title || '',
        description: frontmatter.description || '',
        topic: frontmatter.topic || frontmatter.category || '',
        contentType: collectionName === 'blog' ? 'Blog Post' : 'Page',
        keywords: extractKeywords(frontmatter),
        outboundLinks: extractLinks(content, url),
        wordCount: getWordCount(content),
        publishDate: frontmatter.pubDate || frontmatter.date || null,
        draft: frontmatter.draft === true || frontmatter.draft === 'true',
      });
    }
  }
  
  return pages;
}

function scanAllContent() {
  const allPages = [];
  
  if (!fs.existsSync(CONFIG.contentDir)) {
    console.log(`Content directory not found: ${CONFIG.contentDir}`);
    return allPages;
  }
  
  const collections = fs.readdirSync(CONFIG.contentDir);
  
  for (const collection of collections) {
    const collectionPath = path.join(CONFIG.contentDir, collection);
    const stat = fs.statSync(collectionPath);
    
    if (stat.isDirectory()) {
      const pages = scanCollection(collectionPath, collection);
      allPages.push(...pages);
      console.log(`  Scanned ${collection}: ${pages.length} pages`);
    }
  }
  
  return allPages;
}

function buildLinkGraph(pages) {
  // Create URL -> page lookup
  const urlToPage = new Map();
  for (const page of pages) {
    urlToPage.set(page.url, page);
    // Also map without trailing slash
    urlToPage.set(page.url.replace(/\/$/, ''), page);
  }
  
  // Build inbound link counts
  for (const page of pages) {
    page.inboundLinks = [];
  }
  
  for (const page of pages) {
    for (const link of page.outboundLinks) {
      const targetPage = urlToPage.get(link) || urlToPage.get(link + '/');
      if (targetPage) {
        targetPage.inboundLinks.push(page.url);
      }
    }
  }
  
  return pages;
}

// ============================================================================
// DATABASE WRITING
// ============================================================================

function escapeSQL(str) {
  if (str === null || str === undefined) return 'NULL';
  return `'${String(str).replace(/'/g, "''")}'`;
}

function writeToDatabase(pages, sessionId) {
  console.log('\nWriting to database...');
  
  // Create session
  dbExec(`
    INSERT INTO link_import_sessions (session_id, source_file, source_tool)
    VALUES (${escapeSQL(sessionId)}, 'project_scan', 'index-links');
  `);
  
  let pagesWritten = 0;
  let keywordsWritten = 0;
  let linksWritten = 0;
  
  // Write pages
  for (const page of pages) {
    dbExec(`
      INSERT OR REPLACE INTO page_analysis (
        url, source_file, page_title, page_description,
        primary_topic, content_type, word_count,
        out_links_count, in_links_count, session_id, last_indexed
      ) VALUES (
        ${escapeSQL(page.url)},
        ${escapeSQL(page.sourceFile)},
        ${escapeSQL(page.title)},
        ${escapeSQL(page.description)},
        ${escapeSQL(page.topic)},
        ${escapeSQL(page.contentType)},
        ${page.wordCount},
        ${page.outboundLinks.length},
        ${page.inboundLinks.length},
        ${escapeSQL(sessionId)},
        CURRENT_TIMESTAMP
      );
    `);
    pagesWritten++;
    
    // Write keywords
    const pageId = dbExec(`SELECT id FROM page_analysis WHERE url = ${escapeSQL(page.url)};`);
    
    for (let i = 0; i < page.keywords.length; i++) {
      const keyword = page.keywords[i];
      dbExec(`
        INSERT OR IGNORE INTO page_keywords (page_id, keyword, is_primary, source)
        VALUES (${pageId}, ${escapeSQL(keyword)}, ${i === 0 ? 1 : 0}, 'frontmatter');
      `);
      keywordsWritten++;
    }
  }
  
  // Write links (second pass - all pages must exist first)
  for (const page of pages) {
    const sourceId = dbExec(`SELECT id FROM page_analysis WHERE url = ${escapeSQL(page.url)};`);
    
    for (const targetUrl of page.outboundLinks) {
      const targetId = dbExec(`
        SELECT id FROM page_analysis 
        WHERE url = ${escapeSQL(targetUrl)} 
           OR url = ${escapeSQL(targetUrl + '/')};
      `);
      
      if (targetId) {
        dbExec(`
          INSERT OR IGNORE INTO internal_links (source_page_id, target_page_id)
          VALUES (${sourceId}, ${targetId});
        `);
        linksWritten++;
      }
    }
  }
  
  // Update session stats
  dbExec(`
    UPDATE link_import_sessions
    SET pages_imported = ${pagesWritten},
        links_imported = ${linksWritten},
        keywords_imported = ${keywordsWritten}
    WHERE session_id = ${escapeSQL(sessionId)};
  `);
  
  return { pagesWritten, keywordsWritten, linksWritten };
}

// ============================================================================
// MAIN
// ============================================================================

function main() {
  const args = process.argv.slice(2);
  const options = {
    init: args.includes('--init'),
    full: args.includes('--full'),
    dryRun: args.includes('--dry-run'),
    verbose: args.includes('--verbose'),
    collection: args.find(a => a.startsWith('--collection='))?.split('=')[1],
  };
  
  console.log('🔗 Link Indexer for Astro SEO Agency\n');
  
  // Check database
  const dbStatus = checkDatabase();
  
  if (!dbStatus.exists) {
    if (options.init) {
      console.log('Initializing database...');
      initDatabase();
      console.log('✅ Database created\n');
    } else {
      console.error('❌ Database not found. Run with --init to create.');
      process.exit(1);
    }
  } else if (dbStatus.version < 4) {
    console.log(`⚠️  Database schema v${dbStatus.version} - needs migration to v4`);
    if (options.init) {
      console.log('Running migration...');
      if (fs.existsSync('scripts/migrate-v4.sql')) {
        execSync(`sqlite3 "${CONFIG.dbPath}" < scripts/migrate-v4.sql`);
        console.log('✅ Migrated to v4\n');
      }
    } else {
      console.error('Run with --init to migrate.');
      process.exit(1);
    }
  } else {
    console.log(`✅ Database OK (schema v${dbStatus.version})\n`);
  }
  
  // Clear existing data if full re-index
  if (options.full) {
    console.log('Clearing existing link data...');
    dbExec('DELETE FROM internal_links;');
    dbExec('DELETE FROM page_keywords;');
    dbExec('DELETE FROM page_analysis;');
  }
  
  // Scan content
  console.log('Scanning content...');
  const pages = scanAllContent();
  
  if (pages.length === 0) {
    console.log('No content found.');
    return;
  }
  
  // Build link graph
  console.log('\nBuilding link graph...');
  buildLinkGraph(pages);
  
  // Stats
  const totalOutbound = pages.reduce((sum, p) => sum + p.outboundLinks.length, 0);
  const totalInbound = pages.reduce((sum, p) => sum + p.inboundLinks.length, 0);
  const orphans = pages.filter(p => p.inboundLinks.length === 0).length;
  const totalKeywords = pages.reduce((sum, p) => sum + p.keywords.length, 0);
  
  console.log(`
📊 Scan Results:
   Pages found:     ${pages.length}
   Keywords found:  ${totalKeywords}
   Internal links:  ${totalOutbound}
   Orphan pages:    ${orphans}
`);
  
  if (options.dryRun) {
    console.log('Dry run - not writing to database.');
    
    if (options.verbose) {
      console.log('\nSample data:');
      for (const page of pages.slice(0, 3)) {
        console.log(`\n  ${page.url}`);
        console.log(`    Title: ${page.title}`);
        console.log(`    Keywords: ${page.keywords.join(', ') || '(none)'}`);
        console.log(`    Links out: ${page.outboundLinks.length}, in: ${page.inboundLinks.length}`);
      }
    }
    return;
  }
  
  // Write to database
  const sessionId = `scan_${Date.now()}`;
  const stats = writeToDatabase(pages, sessionId);
  
  console.log(`
✅ Database Updated:
   Pages written:    ${stats.pagesWritten}
   Keywords written: ${stats.keywordsWritten}
   Links written:    ${stats.linksWritten}
   Session ID:       ${sessionId}

Run '/seo links' to analyze the link structure.
`);
}

main();
