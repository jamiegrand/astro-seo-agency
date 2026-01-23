-- SEO Audit Database Schema
-- Location: .planning/seo-audit.db
-- Initialize with: sqlite3 .planning/seo-audit.db < scripts/init-db.sql

-- Audit results over time
CREATE TABLE IF NOT EXISTS audits (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  page_path TEXT NOT NULL,
  url TEXT,
  target_keyword TEXT,
  audit_type TEXT CHECK(audit_type IN ('full', 'quick', 'eeat', 'batch')),
  overall_score INTEGER CHECK(overall_score >= 0 AND overall_score <= 100),
  onpage_score INTEGER CHECK(onpage_score >= 0 AND onpage_score <= 20),
  eeat_score INTEGER CHECK(eeat_score >= 0 AND eeat_score <= 25),
  content_score INTEGER CHECK(content_score >= 0 AND content_score <= 20),
  ai_overview_score INTEGER CHECK(ai_overview_score >= 0 AND ai_overview_score <= 15),
  linking_score INTEGER CHECK(linking_score >= 0 AND linking_score <= 10),
  multimedia_score INTEGER CHECK(multimedia_score >= 0 AND multimedia_score <= 10),
  findings TEXT, -- JSON object with detailed findings
  recommendations TEXT, -- JSON array of recommendations
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Keyword research data (from DataForSEO)
CREATE TABLE IF NOT EXISTS keywords (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  keyword TEXT NOT NULL UNIQUE,
  search_volume INTEGER,
  difficulty INTEGER CHECK(difficulty >= 0 AND difficulty <= 100),
  cpc REAL,
  competition_level TEXT,
  serp_features TEXT, -- JSON array of SERP features
  last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- People Also Ask questions
CREATE TABLE IF NOT EXISTS paa_questions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  keyword_id INTEGER NOT NULL,
  question TEXT NOT NULL,
  answer_snippet TEXT,
  source_url TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (keyword_id) REFERENCES keywords(id) ON DELETE CASCADE
);

-- Related keywords
CREATE TABLE IF NOT EXISTS related_keywords (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  keyword_id INTEGER NOT NULL,
  related_keyword TEXT NOT NULL,
  search_volume INTEGER,
  difficulty INTEGER,
  relevance_score REAL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (keyword_id) REFERENCES keywords(id) ON DELETE CASCADE
);

-- Competitor analysis snapshots
CREATE TABLE IF NOT EXISTS competitor_snapshots (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  audit_id INTEGER,
  competitor_url TEXT NOT NULL,
  title TEXT,
  meta_description TEXT,
  word_count INTEGER,
  heading_structure TEXT, -- JSON: {h1: [...], h2: [...], h3: [...]}
  topics_covered TEXT, -- JSON array
  structural_elements TEXT, -- JSON: {tables: N, faqs: N, lists: N, images: N}
  internal_links_count INTEGER,
  external_links_count INTEGER,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (audit_id) REFERENCES audits(id) ON DELETE CASCADE
);

-- GSC performance snapshots
CREATE TABLE IF NOT EXISTS gsc_snapshots (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  page_path TEXT NOT NULL,
  url TEXT,
  query TEXT, -- The search query if tracking specific query performance
  clicks INTEGER,
  impressions INTEGER,
  ctr REAL,
  position REAL,
  period_start DATE NOT NULL,
  period_end DATE NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Audit issues tracking
CREATE TABLE IF NOT EXISTS audit_issues (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  audit_id INTEGER NOT NULL,
  category TEXT NOT NULL, -- 'onpage', 'eeat', 'content', 'ai_overview', 'linking', 'multimedia'
  severity TEXT CHECK(severity IN ('critical', 'high', 'medium', 'low')),
  issue TEXT NOT NULL,
  current_value TEXT,
  recommended_value TEXT,
  file_path TEXT,
  line_number INTEGER,
  fixed_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (audit_id) REFERENCES audits(id) ON DELETE CASCADE
);

-- Content inventory for tracking all auditable pages
CREATE TABLE IF NOT EXISTS content_inventory (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  page_path TEXT NOT NULL UNIQUE,
  url TEXT,
  content_type TEXT, -- 'blog', 'page', 'product', 'service', etc.
  collection_name TEXT, -- Astro content collection name
  title TEXT,
  word_count INTEGER,
  publish_date DATE,
  last_modified DATE,
  last_audited TIMESTAMP,
  latest_score INTEGER,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for common queries
CREATE INDEX IF NOT EXISTS idx_audits_page_path ON audits(page_path);
CREATE INDEX IF NOT EXISTS idx_audits_created_at ON audits(created_at);
CREATE INDEX IF NOT EXISTS idx_audits_overall_score ON audits(overall_score);
CREATE INDEX IF NOT EXISTS idx_keywords_keyword ON keywords(keyword);
CREATE INDEX IF NOT EXISTS idx_keywords_last_updated ON keywords(last_updated);
CREATE INDEX IF NOT EXISTS idx_gsc_snapshots_page_path ON gsc_snapshots(page_path);
CREATE INDEX IF NOT EXISTS idx_gsc_snapshots_period ON gsc_snapshots(period_start, period_end);
CREATE INDEX IF NOT EXISTS idx_content_inventory_page_path ON content_inventory(page_path);
CREATE INDEX IF NOT EXISTS idx_audit_issues_audit_id ON audit_issues(audit_id);
CREATE INDEX IF NOT EXISTS idx_audit_issues_severity ON audit_issues(severity);

-- Views for common reports

-- Latest audit score per page
CREATE VIEW IF NOT EXISTS latest_audits AS
SELECT
  ci.page_path,
  ci.url,
  ci.content_type,
  ci.title,
  a.overall_score,
  a.audit_type,
  a.created_at as last_audit_date,
  ci.word_count,
  ci.publish_date
FROM content_inventory ci
LEFT JOIN audits a ON a.id = (
  SELECT id FROM audits
  WHERE page_path = ci.page_path
  ORDER BY created_at DESC
  LIMIT 1
);

-- Pages needing attention (low scores or stale audits)
CREATE VIEW IF NOT EXISTS pages_needing_attention AS
SELECT
  page_path,
  url,
  content_type,
  title,
  overall_score,
  last_audit_date,
  CASE
    WHEN overall_score < 40 THEN 'critical'
    WHEN overall_score < 60 THEN 'poor'
    WHEN overall_score < 75 THEN 'fair'
    WHEN last_audit_date < date('now', '-30 days') THEN 'stale'
    ELSE 'ok'
  END as status
FROM latest_audits
WHERE overall_score < 75
   OR last_audit_date < date('now', '-30 days')
   OR last_audit_date IS NULL
ORDER BY
  CASE
    WHEN overall_score IS NULL THEN 0
    ELSE overall_score
  END ASC;

-- Keyword cache status
CREATE VIEW IF NOT EXISTS keyword_cache_status AS
SELECT
  keyword,
  search_volume,
  difficulty,
  last_updated,
  CASE
    WHEN last_updated < datetime('now', '-30 days') THEN 'stale'
    WHEN last_updated < datetime('now', '-7 days') THEN 'aging'
    ELSE 'fresh'
  END as cache_status,
  (SELECT COUNT(*) FROM paa_questions WHERE keyword_id = keywords.id) as paa_count,
  (SELECT COUNT(*) FROM related_keywords WHERE keyword_id = keywords.id) as related_count
FROM keywords
ORDER BY last_updated DESC;

-- Score trends by page
CREATE VIEW IF NOT EXISTS score_trends AS
SELECT
  page_path,
  date(created_at) as audit_date,
  overall_score,
  LAG(overall_score) OVER (PARTITION BY page_path ORDER BY created_at) as previous_score,
  overall_score - LAG(overall_score) OVER (PARTITION BY page_path ORDER BY created_at) as score_change
FROM audits
ORDER BY page_path, created_at;

-- ============================================================================
-- PROJECT METADATA TABLES (v3.0)
-- For staged indexing and AI-INFO.md generation
-- ============================================================================

-- Schema version tracking
CREATE TABLE IF NOT EXISTS schema_version (
  version INTEGER PRIMARY KEY,
  applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  description TEXT
);

-- Insert initial version if not exists
INSERT OR IGNORE INTO schema_version (version, description) VALUES (3, 'Project metadata and staged indexing');

-- Project configuration (key-value store)
CREATE TABLE IF NOT EXISTS project_config (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  key TEXT NOT NULL UNIQUE,
  value TEXT,
  value_type TEXT CHECK(value_type IN ('string', 'number', 'boolean', 'json')),
  source TEXT, -- 'package.json', 'astro.config', 'env', 'mcp', 'quick_scan'
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Routes (pages, dynamic routes, API endpoints)
CREATE TABLE IF NOT EXISTS routes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  route_pattern TEXT NOT NULL UNIQUE, -- e.g., '/blog/[slug]', '/api/search'
  route_type TEXT CHECK(route_type IN ('static', 'dynamic', 'api')),
  source_file TEXT NOT NULL, -- e.g., 'src/pages/blog/[slug].astro'
  generates_count INTEGER DEFAULT 1, -- for dynamic routes, count of generated pages
  has_prerender BOOLEAN,
  params TEXT, -- JSON array of param names for dynamic routes
  last_indexed TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  metadata TEXT -- JSON: additional route metadata
);

-- Content collections
CREATE TABLE IF NOT EXISTS collections (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL UNIQUE, -- e.g., 'blog', 'docs', 'products'
  location TEXT NOT NULL, -- e.g., 'src/content/blog'
  collection_type TEXT DEFAULT 'content', -- 'content' or 'data'
  schema_fields TEXT, -- JSON array of field definitions
  item_count INTEGER DEFAULT 0,
  last_indexed TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Individual collection entries
CREATE TABLE IF NOT EXISTS collection_entries (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  collection_id INTEGER NOT NULL,
  slug TEXT NOT NULL,
  file_path TEXT NOT NULL,
  title TEXT,
  description TEXT,
  publish_date DATE,
  draft BOOLEAN DEFAULT 0,
  frontmatter TEXT, -- Full frontmatter as JSON
  word_count INTEGER,
  last_modified TIMESTAMP,
  last_indexed TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (collection_id) REFERENCES collections(id) ON DELETE CASCADE,
  UNIQUE(collection_id, slug)
);

-- Data files (src/data/*.js, *.ts, *.json)
CREATE TABLE IF NOT EXISTS data_files (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  file_path TEXT NOT NULL UNIQUE,
  file_type TEXT, -- 'js', 'ts', 'json'
  export_name TEXT, -- default export or named export
  export_type TEXT, -- 'array', 'object', 'function'
  item_count INTEGER,
  schema_sample TEXT, -- JSON sample of first item's structure
  generates_routes TEXT, -- JSON array of route patterns this data generates
  last_indexed TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Components inventory
CREATE TABLE IF NOT EXISTS components (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  file_path TEXT NOT NULL UNIQUE,
  component_name TEXT,
  component_type TEXT CHECK(component_type IN ('astro', 'react', 'vue', 'svelte', 'solid', 'preact', 'lit', 'other')),
  props TEXT, -- JSON array of prop names (if detectable)
  uses_client_directive BOOLEAN DEFAULT 0,
  client_directive TEXT, -- 'load', 'idle', 'visible', 'media', 'only'
  imports TEXT, -- JSON array of imports
  last_indexed TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Layout files
CREATE TABLE IF NOT EXISTS layouts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  file_path TEXT NOT NULL UNIQUE,
  layout_name TEXT,
  slots TEXT, -- JSON array of slot names
  props TEXT, -- JSON array of prop definitions
  used_by_count INTEGER DEFAULT 0,
  last_indexed TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Astro integrations
CREATE TABLE IF NOT EXISTS integrations (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL UNIQUE, -- e.g., '@astrojs/tailwind'
  package_name TEXT,
  version TEXT,
  is_official BOOLEAN, -- starts with @astrojs/
  config TEXT, -- JSON config if detectable
  last_indexed TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Index progress tracking (for resumable staged indexing)
CREATE TABLE IF NOT EXISTS index_progress (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  phase TEXT NOT NULL UNIQUE, -- 'quick_scan', 'collections', 'routes', 'data_files', 'components'
  status TEXT CHECK(status IN ('pending', 'in_progress', 'completed', 'failed')) DEFAULT 'pending',
  total_items INTEGER DEFAULT 0,
  processed_items INTEGER DEFAULT 0,
  last_processed_path TEXT, -- for resumability
  chunk_size INTEGER DEFAULT 50,
  started_at TIMESTAMP,
  completed_at TIMESTAMP,
  error_message TEXT,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Initialize default index phases
INSERT OR IGNORE INTO index_progress (phase, status, chunk_size) VALUES
  ('quick_scan', 'pending', 1),
  ('collections', 'pending', 50),
  ('routes', 'pending', 50),
  ('data_files', 'pending', 20),
  ('components', 'pending', 100);

-- Index run history
CREATE TABLE IF NOT EXISTS index_runs (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  run_type TEXT CHECK(run_type IN ('full', 'incremental', 'phase', 'refresh')),
  trigger TEXT, -- 'setup', 'manual', 'start', 'file_change'
  phases_requested TEXT, -- JSON array of phases to run
  phases_completed TEXT, -- JSON array of completed phases
  started_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  completed_at TIMESTAMP,
  total_duration_ms INTEGER,
  items_indexed INTEGER DEFAULT 0,
  errors TEXT -- JSON array of errors encountered
);

-- ============================================================================
-- INDEXES FOR NEW TABLES
-- ============================================================================

CREATE INDEX IF NOT EXISTS idx_routes_source_file ON routes(source_file);
CREATE INDEX IF NOT EXISTS idx_routes_route_type ON routes(route_type);
CREATE INDEX IF NOT EXISTS idx_collection_entries_collection ON collection_entries(collection_id);
CREATE INDEX IF NOT EXISTS idx_collection_entries_publish_date ON collection_entries(publish_date);
CREATE INDEX IF NOT EXISTS idx_collection_entries_draft ON collection_entries(draft);
CREATE INDEX IF NOT EXISTS idx_components_type ON components(component_type);
CREATE INDEX IF NOT EXISTS idx_components_client ON components(uses_client_directive);
CREATE INDEX IF NOT EXISTS idx_index_progress_status ON index_progress(status);
CREATE INDEX IF NOT EXISTS idx_index_runs_started ON index_runs(started_at);

-- ============================================================================
-- VIEWS FOR PROJECT METADATA
-- ============================================================================

-- Project summary view (for /start and /status)
CREATE VIEW IF NOT EXISTS project_summary AS
SELECT
  (SELECT value FROM project_config WHERE key = 'name') as project_name,
  (SELECT value FROM project_config WHERE key = 'astro_version') as astro_version,
  (SELECT value FROM project_config WHERE key = 'output_mode') as output_mode,
  (SELECT value FROM project_config WHERE key = 'site_url') as site_url,
  (SELECT COUNT(*) FROM routes WHERE route_type = 'static') as static_routes,
  (SELECT COUNT(*) FROM routes WHERE route_type = 'dynamic') as dynamic_routes,
  (SELECT COUNT(*) FROM routes WHERE route_type = 'api') as api_routes,
  (SELECT COUNT(*) FROM routes) as total_routes,
  (SELECT COUNT(*) FROM collections) as total_collections,
  (SELECT COALESCE(SUM(item_count), 0) FROM collections) as total_collection_items,
  (SELECT COUNT(*) FROM components) as total_components,
  (SELECT COUNT(*) FROM components WHERE uses_client_directive = 1) as interactive_components,
  (SELECT COUNT(*) FROM data_files) as total_data_files,
  (SELECT COUNT(*) FROM integrations) as total_integrations;

-- Content overview by collection
CREATE VIEW IF NOT EXISTS content_overview AS
SELECT
  c.name as collection_name,
  c.location,
  c.collection_type,
  c.item_count,
  c.last_indexed,
  (SELECT COUNT(*) FROM collection_entries ce WHERE ce.collection_id = c.id AND ce.draft = 0) as published_count,
  (SELECT COUNT(*) FROM collection_entries ce WHERE ce.collection_id = c.id AND ce.draft = 1) as draft_count,
  (SELECT MIN(ce.publish_date) FROM collection_entries ce WHERE ce.collection_id = c.id) as oldest_content,
  (SELECT MAX(ce.publish_date) FROM collection_entries ce WHERE ce.collection_id = c.id) as newest_content
FROM collections c
ORDER BY c.item_count DESC;

-- Index status view (for progress tracking)
CREATE VIEW IF NOT EXISTS index_status AS
SELECT
  phase,
  status,
  COALESCE(processed_items, 0) as processed,
  COALESCE(total_items, 0) as total,
  CASE
    WHEN total_items > 0 THEN ROUND(100.0 * processed_items / total_items, 1)
    WHEN status = 'completed' THEN 100.0
    ELSE 0
  END as percent_complete,
  last_processed_path,
  started_at,
  completed_at,
  error_message,
  updated_at
FROM index_progress
ORDER BY
  CASE phase
    WHEN 'quick_scan' THEN 1
    WHEN 'collections' THEN 2
    WHEN 'routes' THEN 3
    WHEN 'data_files' THEN 4
    WHEN 'components' THEN 5
  END;

-- Component types summary
CREATE VIEW IF NOT EXISTS component_summary AS
SELECT
  component_type,
  COUNT(*) as count,
  SUM(CASE WHEN uses_client_directive = 1 THEN 1 ELSE 0 END) as interactive_count
FROM components
GROUP BY component_type
ORDER BY count DESC;

-- Routes by type
CREATE VIEW IF NOT EXISTS routes_summary AS
SELECT
  route_type,
  COUNT(*) as count,
  GROUP_CONCAT(route_pattern, ', ') as patterns
FROM routes
GROUP BY route_type;
