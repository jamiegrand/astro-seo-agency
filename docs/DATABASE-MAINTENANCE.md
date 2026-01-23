# Database Maintenance Guide

This guide explains how to set up and maintain the SEO audit database for new projects.

## Quick Start (New Project)

```bash
# 1. Initialize database with all tables
./scripts/setup-db.sh init

# 2. Index your content to build link graph
./scripts/setup-db.sh index

# 3. Verify everything is working
./scripts/setup-db.sh status
```

## Files Overview

| File | Purpose |
|------|---------|
| `scripts/setup-db.sh` | Main setup/maintenance script |
| `scripts/init-db.sql` | Base schema (v3) |
| `scripts/migrate-v4.sql` | Link analysis tables |
| `scripts/index-links.js` | Node.js link indexer |
| `commands/index-links.md` | Claude command for indexing |
| `commands/import-linkdata.md` | Import external CSV data |
| `commands/seo-links.md` | Link analysis command |

## Database Schema

### Core Tables (v3)
- `audits` - Audit results history
- `keywords` - Cached keyword research
- `gsc_snapshots` - GSC performance data
- `routes`, `collections`, `components` - Project index

### Link Tables (v4)
- `page_analysis` - Page metadata and summaries
- `page_keywords` - Target keywords per page
- `internal_links` - Link graph between pages
- `link_import_sessions` - Import tracking

## Maintenance Commands

### Check Status
```bash
./scripts/setup-db.sh status
```

Shows:
- Schema version
- Table counts
- Migration status

### Run Migrations
```bash
./scripts/setup-db.sh migrate
```

Applies any pending schema updates.

### Re-index Links
```bash
# Incremental (new/changed only)
./scripts/setup-db.sh index

# Full re-index
./scripts/setup-db.sh index --full

# Specific collection
./scripts/setup-db.sh index --collection blog
```

### Backup Database
```bash
./scripts/setup-db.sh backup
```

Creates timestamped backup in `.planning/backups/`

### Reset Everything
```bash
./scripts/setup-db.sh reset
```

⚠️ Deletes all data and reinitializes.

## Data Sources

The database can be populated from multiple sources:

### 1. Project Scan (Automatic)
```bash
./scripts/setup-db.sh index
# or
node scripts/index-links.js
```

Extracts from your Markdown files:
- Internal links from content
- Keywords from frontmatter
- Page metadata

### 2. External CSV Import
```bash
/import-linkdata ./exports/RANKV9_LinkData.csv
```

Imports from tools like:
- RANKV9 (full featured)
- Screaming Frog
- Custom CSV

### 3. GSC Data (via MCP)
Automatically populated when running audits with GSC MCP configured.

### 4. Manual Entry
```sql
INSERT INTO page_keywords (page_id, keyword, is_primary, source)
VALUES (1, 'target keyword', 1, 'manual');
```

## Integration with Audits

Once the database is populated:

```bash
# Keywords are auto-detected - no need to specify!
/audit content /blog/my-post

# Instead of:
/audit content /blog/my-post "my target keyword"
```

## Automation Options

### npm Scripts
```json
{
  "scripts": {
    "db:init": "./scripts/setup-db.sh init",
    "db:index": "./scripts/setup-db.sh index",
    "db:status": "./scripts/setup-db.sh status"
  }
}
```

### Git Hooks
```bash
# .husky/post-merge
./scripts/setup-db.sh index
```

### CI/CD
```yaml
- name: Setup SEO Database
  run: |
    ./scripts/setup-db.sh init
    ./scripts/setup-db.sh index --full
```

## Troubleshooting

### "sqlite3 not found"
```bash
# macOS
brew install sqlite3

# Ubuntu/Debian
sudo apt install sqlite3

# Windows
# Download from https://sqlite.org/download.html
```

### "Database schema outdated"
```bash
./scripts/setup-db.sh migrate
```

### "No keywords detected"
Ensure your frontmatter includes one of:
- `seoKeyword: "..."`
- `targetKeyword: "..."`
- `keywords: ["...", "..."]`
- `tags: ["...", "..."]`

### "Links not being found"
The indexer looks for:
- `[text](url)` Markdown links
- `href="url"` HTML attributes

Ensure links use relative paths starting with `/`.
