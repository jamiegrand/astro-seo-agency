---
description: Index internal links and keywords from project content
argument-hint: "[--full|--collection name|--dry-run]"
---

# Index Links

Scans your Astro project to build the internal link graph and extract keywords from frontmatter. This data enables:
- Auto-detection of target keywords in `/audit content`
- Internal link analysis via `/seo links`
- Orphan page detection
- Content relationship mapping

---

## Prerequisites

- Database at `.planning/seo-audit.db` (schema v4+)
- Content in `src/content/` directory

---

## Command Variants

### `/index links`
Incremental update - only adds new/changed pages.

### `/index links --full`
Full re-index - clears existing data and rescans everything.

### `/index links --collection blog`
Only index a specific collection.

### `/index links --dry-run`
Preview what would be indexed without writing to database.

---

## What Gets Indexed

### From Each Markdown File:

| Data | Source | Used For |
|------|--------|----------|
| URL | File path → route | Link graph |
| Title | `title` frontmatter | Display |
| Description | `description` frontmatter | Display |
| Topic | `topic` or `category` | Clustering |
| Keywords | `seoKeyword`, `targetKeyword`, `keywords`, `tags` | Auto-detection |
| Internal links | `[text](url)` and `href=""` patterns | Link graph |
| Word count | Body content | Analysis |

### Link Graph Built From:

```markdown
<!-- This markdown... -->
Check out our [web design services](/services/web-design/) for more info.

<!-- Creates this link record: -->
source: /blog/current-post/
target: /services/web-design/
```

---

## Step 1: Check Prerequisites

```bash
# Verify database exists and has v4 schema
sqlite3 .planning/seo-audit.db "SELECT version FROM schema_version ORDER BY version DESC LIMIT 1;"
```

**If missing or outdated:**
```markdown
⚠️ Database needs initialization

Run:
```bash
# Create database with all tables
node scripts/index-links.js --init
```
```

---

## Step 2: Run Indexer

### Option A: Use Node.js Script (Recommended)

```bash
# From project root
node scripts/index-links.js

# Or with options
node scripts/index-links.js --full      # Full re-index
node scripts/index-links.js --dry-run   # Preview only
```

### Option B: Manual Execution (Claude does this)

If the script isn't available, Claude can perform the same steps:

1. **Scan content directory**
```bash
find src/content -name "*.md" -o -name "*.mdx"
```

2. **For each file, extract:**
   - Frontmatter (title, description, keywords)
   - Internal links from body
   - Word count

3. **Write to database:**
```sql
INSERT INTO page_analysis (url, source_file, page_title, ...) VALUES (...);
INSERT INTO page_keywords (page_id, keyword, is_primary) VALUES (...);
INSERT INTO internal_links (source_page_id, target_page_id) VALUES (...);
```

---

## Step 3: Display Results

```markdown
## 🔗 Link Index Complete

**Session:** scan_1705312345678
**Duration:** 2.3s

### Summary

| Metric | Count |
|--------|-------|
| Pages indexed | 68 |
| Keywords extracted | 245 |
| Internal links mapped | 312 |
| Orphan pages found | 7 |

### Collections Indexed

| Collection | Pages | Keywords | Links |
|------------|-------|----------|-------|
| blog | 52 | 198 | 267 |
| services | 8 | 32 | 28 |
| pages | 8 | 15 | 17 |

### Keyword Coverage

| Status | Pages |
|--------|-------|
| ✅ Has keywords | 61 |
| ⚠️ No keywords | 7 |

**Pages without keywords:**
- /about/
- /contact/
- /privacy-policy/
- ...

### Link Health

| Status | Pages |
|--------|-------|
| 🔴 Orphan (0 inbound) | 7 |
| 🟡 Low links (<3) | 12 |
| 🟢 Well-linked (3+) | 49 |

---

### Next Steps

1. **"Show orphans"** → `/seo links orphans`
2. **"Add keywords"** → Edit frontmatter for pages without keywords
3. **"Run audit"** → `/audit content [page]` (keywords auto-detected!)
```

---

## Automation Options

### Option 1: npm Script

Add to `package.json`:
```json
{
  "scripts": {
    "index:links": "node scripts/index-links.js",
    "index:links:full": "node scripts/index-links.js --full"
  }
}
```

Run with: `npm run index:links`

### Option 2: Git Hook (Pre-commit)

Add to `.husky/pre-commit`:
```bash
#!/bin/sh
node scripts/index-links.js 2>/dev/null || true
```

### Option 3: CI/CD Pipeline

```yaml
# In your build pipeline
- name: Index content links
  run: node scripts/index-links.js --full
```

### Option 4: Watch Mode (Development)

```bash
# Using nodemon or similar
nodemon --watch src/content --ext md,mdx --exec "node scripts/index-links.js"
```

---

## Troubleshooting

### "Database not found"
```bash
node scripts/index-links.js --init
```

### "Schema version too old"
```bash
sqlite3 .planning/seo-audit.db < scripts/migrate-v4.sql
```

### "No content found"
Check that `src/content/` exists and contains `.md` or `.mdx` files.

### "Keywords not being extracted"
Ensure frontmatter uses one of these fields:
- `seoKeyword`
- `targetKeyword`
- `keyword`
- `keywords` (array)
- `tags` (array)

---

## Example Output

```bash
$ node scripts/index-links.js

🔗 Link Indexer for Astro SEO Agency

✅ Database OK (schema v4)

Scanning content...
  Scanned blog: 52 pages
  Scanned services: 8 pages
  Scanned pages: 8 pages

Building link graph...

📊 Scan Results:
   Pages found:     68
   Keywords found:  245
   Internal links:  312
   Orphan pages:    7

Writing to database...

✅ Database Updated:
   Pages written:    68
   Keywords written: 245
   Links written:    312
   Session ID:       scan_1705312345678

Run '/seo links' to analyze the link structure.
```
