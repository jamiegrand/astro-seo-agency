-- Migration Script: v2 -> v3
-- Adds project metadata tables and staged indexing support
-- Safe to run multiple times (uses IF NOT EXISTS)
--
-- Usage: sqlite3 .planning/seo-audit.db < scripts/migrate-v3.sql

-- ============================================================================
-- SCHEMA VERSION TABLE
-- ============================================================================

CREATE TABLE IF NOT EXISTS schema_version (
  version INTEGER PRIMARY KEY,
  applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  description TEXT
);

-- Check if already migrated
SELECT CASE
  WHEN EXISTS (SELECT 1 FROM schema_version WHERE version >= 3)
  THEN RAISE(IGNORE)
END;

-- ============================================================================
-- PROJECT METADATA TABLES
-- ============================================================================

-- Project configuration (key-value store)
CREATE TABLE IF NOT EXISTS project_config (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  key TEXT NOT NULL UNIQUE,
  value TEXT,
  value_type TEXT CHECK(value_type IN ('string', 'number', 'boolean', 'json')),
  source TEXT,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Routes (pages, dynamic routes, API endpoints)
CREATE TABLE IF NOT EXISTS routes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  route_pattern TEXT NOT NULL UNIQUE,
  route_type TEXT CHECK(route_type IN ('static', 'dynamic', 'api')),
  source_file TEXT NOT NULL,
  generates_count INTEGER DEFAULT 1,
  has_prerender BOOLEAN,
  params TEXT,
  last_indexed TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  metadata TEXT
);

-- Content collections
CREATE TABLE IF NOT EXISTS collections (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL UNIQUE,
  location TEXT NOT NULL,
  collection_type TEXT DEFAULT 'content',
  schema_fields TEXT,
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
  frontmatter TEXT,
  word_count INTEGER,
  last_modified TIMESTAMP,
  last_indexed TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (collection_id) REFERENCES collections(id) ON DELETE CASCADE,
  UNIQUE(collection_id, slug)
);

-- Data files
CREATE TABLE IF NOT EXISTS data_files (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  file_path TEXT NOT NULL UNIQUE,
  file_type TEXT,
  export_name TEXT,
  export_type TEXT,
  item_count INTEGER,
  schema_sample TEXT,
  generates_routes TEXT,
  last_indexed TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Components inventory
CREATE TABLE IF NOT EXISTS components (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  file_path TEXT NOT NULL UNIQUE,
  component_name TEXT,
  component_type TEXT CHECK(component_type IN ('astro', 'react', 'vue', 'svelte', 'solid', 'preact', 'lit', 'other')),
  props TEXT,
  uses_client_directive BOOLEAN DEFAULT 0,
  client_directive TEXT,
  imports TEXT,
  last_indexed TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Layout files
CREATE TABLE IF NOT EXISTS layouts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  file_path TEXT NOT NULL UNIQUE,
  layout_name TEXT,
  slots TEXT,
  props TEXT,
  used_by_count INTEGER DEFAULT 0,
  last_indexed TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Astro integrations
CREATE TABLE IF NOT EXISTS integrations (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL UNIQUE,
  package_name TEXT,
  version TEXT,
  is_official BOOLEAN,
  config TEXT,
  last_indexed TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Index progress tracking
CREATE TABLE IF NOT EXISTS index_progress (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  phase TEXT NOT NULL UNIQUE,
  status TEXT CHECK(status IN ('pending', 'in_progress', 'completed', 'failed')) DEFAULT 'pending',
  total_items INTEGER DEFAULT 0,
  processed_items INTEGER DEFAULT 0,
  last_processed_path TEXT,
  chunk_size INTEGER DEFAULT 50,
  started_at TIMESTAMP,
  completed_at TIMESTAMP,
  error_message TEXT,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Initialize index phases
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
  trigger TEXT,
  phases_requested TEXT,
  phases_completed TEXT,
  started_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  completed_at TIMESTAMP,
  total_duration_ms INTEGER,
  items_indexed INTEGER DEFAULT 0,
  errors TEXT
);

-- ============================================================================
-- INDEXES
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
-- VIEWS
-- ============================================================================

-- Drop views first (in case schema changed)
DROP VIEW IF EXISTS project_summary;
DROP VIEW IF EXISTS content_overview;
DROP VIEW IF EXISTS index_status;
DROP VIEW IF EXISTS component_summary;
DROP VIEW IF EXISTS routes_summary;

-- Project summary view
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

-- Index status view
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

-- ============================================================================
-- RECORD MIGRATION
-- ============================================================================

INSERT OR REPLACE INTO schema_version (version, description)
VALUES (3, 'Project metadata and staged indexing');

-- Output success message
SELECT 'Migration to v3 complete. Schema version: 3' as status;
