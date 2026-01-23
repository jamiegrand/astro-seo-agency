-- Migration Script: v3 -> v4
-- Adds link analysis tables for internal linking graph and content metadata
-- Safe to run multiple times (uses IF NOT EXISTS)
--
-- Usage: sqlite3 .planning/seo-audit.db < scripts/migrate-v4.sql

-- ============================================================================
-- VERSION CHECK
-- ============================================================================

-- Note: This script is idempotent - safe to run multiple times.
-- All statements use IF NOT EXISTS, INSERT OR IGNORE, or INSERT OR REPLACE.

-- ============================================================================
-- LINK ANALYSIS TABLES
-- ============================================================================

-- Page content analysis (from RANKV9 or similar tools)
CREATE TABLE IF NOT EXISTS page_analysis (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  url TEXT NOT NULL UNIQUE,
  source_file TEXT,                    -- e.g., 'web-design-mistakes-woodford-en.md'
  page_title TEXT,
  page_description TEXT,
  primary_topic TEXT,                  -- e.g., 'Web Design', 'Local SEO'
  content_type TEXT,                   -- e.g., 'Blog Post', 'Service Page'
  page_summary TEXT,                   -- AI-generated summary
  word_count INTEGER,
  out_links_count INTEGER DEFAULT 0,
  in_links_count INTEGER DEFAULT 0,
  session_id TEXT,                     -- Analysis session identifier
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  last_indexed TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Target keywords per page (multiple keywords possible)
CREATE TABLE IF NOT EXISTS page_keywords (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  page_id INTEGER NOT NULL,
  keyword TEXT NOT NULL,
  is_primary BOOLEAN DEFAULT 0,        -- Primary target keyword
  source TEXT,                         -- 'csv_import', 'frontmatter', 'gsc', 'manual'
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (page_id) REFERENCES page_analysis(id) ON DELETE CASCADE,
  UNIQUE(page_id, keyword)
);

-- Internal link graph
CREATE TABLE IF NOT EXISTS internal_links (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  source_page_id INTEGER NOT NULL,
  target_page_id INTEGER NOT NULL,
  anchor_text TEXT,                    -- If available
  link_context TEXT,                   -- Surrounding text (optional)
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (source_page_id) REFERENCES page_analysis(id) ON DELETE CASCADE,
  FOREIGN KEY (target_page_id) REFERENCES page_analysis(id) ON DELETE CASCADE,
  UNIQUE(source_page_id, target_page_id)
);

-- Link data import sessions
CREATE TABLE IF NOT EXISTS link_import_sessions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  session_id TEXT NOT NULL UNIQUE,
  source_file TEXT,                    -- Original CSV filename
  source_tool TEXT,                    -- 'rankv9', 'screaming_frog', 'manual'
  pages_imported INTEGER DEFAULT 0,
  links_imported INTEGER DEFAULT 0,
  keywords_imported INTEGER DEFAULT 0,
  imported_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================================
-- INDEXES
-- ============================================================================

CREATE INDEX IF NOT EXISTS idx_page_analysis_url ON page_analysis(url);
CREATE INDEX IF NOT EXISTS idx_page_analysis_source_file ON page_analysis(source_file);
CREATE INDEX IF NOT EXISTS idx_page_analysis_topic ON page_analysis(primary_topic);
CREATE INDEX IF NOT EXISTS idx_page_analysis_type ON page_analysis(content_type);
CREATE INDEX IF NOT EXISTS idx_page_keywords_page ON page_keywords(page_id);
CREATE INDEX IF NOT EXISTS idx_page_keywords_keyword ON page_keywords(keyword);
CREATE INDEX IF NOT EXISTS idx_page_keywords_primary ON page_keywords(is_primary);
CREATE INDEX IF NOT EXISTS idx_internal_links_source ON internal_links(source_page_id);
CREATE INDEX IF NOT EXISTS idx_internal_links_target ON internal_links(target_page_id);

-- ============================================================================
-- VIEWS
-- ============================================================================

-- Drop views first (in case schema changed)
DROP VIEW IF EXISTS page_link_summary;
DROP VIEW IF EXISTS orphan_pages;
DROP VIEW IF EXISTS hub_pages;
DROP VIEW IF EXISTS link_opportunities;

-- Page with link counts and keywords
CREATE VIEW IF NOT EXISTS page_link_summary AS
SELECT
  pa.id,
  pa.url,
  pa.source_file,
  pa.page_title,
  pa.primary_topic,
  pa.content_type,
  pa.in_links_count,
  pa.out_links_count,
  (SELECT GROUP_CONCAT(pk.keyword, ', ')
   FROM page_keywords pk
   WHERE pk.page_id = pa.id AND pk.is_primary = 1) as primary_keywords,
  (SELECT COUNT(*) FROM page_keywords pk WHERE pk.page_id = pa.id) as total_keywords,
  pa.updated_at
FROM page_analysis pa
ORDER BY pa.in_links_count DESC;

-- Orphan pages (no internal links pointing to them)
CREATE VIEW IF NOT EXISTS orphan_pages AS
SELECT
  pa.url,
  pa.page_title,
  pa.content_type,
  pa.out_links_count,
  pa.updated_at
FROM page_analysis pa
WHERE pa.in_links_count = 0
  AND pa.content_type != 'Homepage'
ORDER BY pa.updated_at DESC;

-- Hub pages (high outbound links)
CREATE VIEW IF NOT EXISTS hub_pages AS
SELECT
  pa.url,
  pa.page_title,
  pa.content_type,
  pa.out_links_count,
  pa.in_links_count,
  pa.out_links_count + pa.in_links_count as total_connections
FROM page_analysis pa
WHERE pa.out_links_count >= 5
ORDER BY pa.out_links_count DESC;

-- Pages that could receive more internal links
CREATE VIEW IF NOT EXISTS link_opportunities AS
SELECT
  pa.url,
  pa.page_title,
  pa.primary_topic,
  pa.in_links_count,
  (SELECT COUNT(*)
   FROM page_analysis pa2
   WHERE pa2.primary_topic = pa.primary_topic
     AND pa2.id != pa.id) as same_topic_pages,
  (SELECT COUNT(*)
   FROM internal_links il
   WHERE il.target_page_id = pa.id) as actual_inbound
FROM page_analysis pa
WHERE pa.in_links_count < 3
  AND pa.content_type = 'Blog Post'
ORDER BY pa.in_links_count ASC;

-- ============================================================================
-- RECORD MIGRATION
-- ============================================================================

INSERT OR REPLACE INTO schema_version (version, description)
VALUES (4, 'Link analysis tables and content metadata');

-- Output success message
SELECT 'Migration to v4 complete. Schema version: 4' as status;
