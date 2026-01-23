---
description: Manage project indexing for AI-INFO.md generation
argument-hint: "[status|run|resume|reset|refresh|links]"
---

# Project Index Management

Manages the staged indexing system that powers AI-INFO.md and database-backed commands.

## Prerequisites

- SQLite database at `.planning/seo-audit.db`
- Project with valid `package.json` and Astro configuration

---

## Command Variants

### `/index` or `/index status`
Show current index status and freshness.

### `/index run`
Start or continue full indexing (all phases).

### `/index run [phase]`
Run a specific phase: `quick_scan`, `collections`, `routes`, `data_files`, `components`

### `/index resume`
Resume interrupted indexing from last checkpoint.

### `/index reset`
Clear all indexed data and start fresh.

### `/index refresh [collection]`
Re-index a specific content collection.

### `/index links` or `/index links --full`
Build internal link graph and extract keywords from content. See `commands/index-links.md` for details.

**Options:**
- `--full` - Full re-index (clear existing link data)
- `--collection blog` - Only index a specific collection
- `--dry-run` - Preview without writing to database

---

## Step 1: Check Database Availability

```bash
# Check if database exists
if [ -f ".planning/seo-audit.db" ]; then
  # Get schema version
  sqlite3 .planning/seo-audit.db "SELECT version FROM schema_version ORDER BY version DESC LIMIT 1;"
fi
```

**If database missing:**
```markdown
⚠️ **Database Not Found**

The project index database doesn't exist yet.

**To initialize:**
1. Run the installer: `bash install.sh` (if running locally)
2. Or create manually: `sqlite3 .planning/seo-audit.db < scripts/init-db.sql`

After initialization, run `/index run` to start indexing.
```

**If schema outdated (< v3):**
```markdown
⚠️ **Database Schema Outdated**

Current schema version: X
Required version: 3

**To migrate:**
```bash
sqlite3 .planning/seo-audit.db < scripts/migrate-v3.sql
```

Then run `/index run` to populate new tables.
```

---

## Step 2: Show Index Status

Query the `index_status` view:

```sql
SELECT phase, status, processed, total, percent_complete, updated_at
FROM index_status;
```

**Display format:**

```markdown
## 📊 Project Index Status

| Phase | Status | Progress | Last Updated |
|-------|--------|----------|--------------|
| Quick Scan | ✅ Complete | 100% | 2024-01-15 10:30 |
| Collections | 🔄 In Progress | 45% (90/200) | 2024-01-15 10:32 |
| Routes | ⏳ Pending | 0% | - |
| Data Files | ⏳ Pending | 0% | - |
| Components | ⏳ Pending | 0% | - |

**Overall:** 29% indexed

### Project Summary (from indexed data)
| Metric | Value |
|--------|-------|
| Collections | 3 |
| Collection Items | ~200 (indexing) |
| Routes | Not yet indexed |
| Components | Not yet indexed |

### Last Index Run
- **Started:** 2024-01-15 10:30:00
- **Trigger:** /start command
- **Duration:** In progress...
```

---

## Step 3: Execute Indexing (if `/index run`)

### Phase 1: Quick Scan (BLOCKING - must complete)

**Purpose:** Get counts and basic config without reading file contents.

```markdown
### Phase 1: Quick Scan

⏳ Scanning project structure...

1. Reading package.json...
2. Reading astro.config.mjs...
3. Counting src/content/*...
4. Counting src/pages/*...
5. Counting src/components/*...
6. Counting src/data/*...

✅ Quick scan complete (2.1s)
```

**Data to extract and store in `project_config`:**

| Key | Source | How to Get |
|-----|--------|------------|
| `name` | package.json | `grep '"name"'` |
| `astro_version` | package.json | `grep '"astro"'` |
| `output_mode` | astro.config.mjs | Look for `output:` |
| `site_url` | astro.config.mjs | Look for `site:` |
| `total_collections` | File count | `ls src/content/ \| wc -l` |
| `total_pages` | File count | `find src/pages -name "*.astro" \| wc -l` |
| `total_components` | File count | `find src/components -name "*.astro" -o -name "*.tsx" \| wc -l` |
| `total_data_files` | File count | `ls src/data/*.{js,ts,json} 2>/dev/null \| wc -l` |

**Store counts in index_progress for other phases:**

```sql
UPDATE index_progress SET total_items = X WHERE phase = 'collections';
UPDATE index_progress SET total_items = X WHERE phase = 'routes';
-- etc.
```

**Mark phase complete:**

```sql
UPDATE index_progress
SET status = 'completed',
    completed_at = CURRENT_TIMESTAMP,
    processed_items = 1,
    total_items = 1
WHERE phase = 'quick_scan';
```

### Phase 2: Collections (CHUNKED - 50 items at a time)

**Purpose:** Index content collection entries with frontmatter.

```markdown
### Phase 2: Collections

Found 3 collections with ~200 total items.

Processing in chunks of 50...

**Collection: blog** (120 items)
- Chunk 1/3: Processing items 1-50... ✅
- Chunk 2/3: Processing items 51-100... ✅
- Chunk 3/3: Processing items 101-120... ✅

**Collection: products** (60 items)
- Chunk 1/2: Processing items 1-50... ✅
- Chunk 2/2: Processing items 51-60... ✅

**Collection: docs** (20 items)
- Processing items 1-20... ✅

✅ Collections phase complete (45.2s)
```

**For each collection:**

1. Detect collection directory: `src/content/[name]/`
2. Read schema from `src/content/config.ts` if exists
3. Insert into `collections` table

**For each entry in collection:**

1. Read file
2. Parse frontmatter (YAML between `---` markers)
3. Count words in content
4. Get file modification time
5. Insert into `collection_entries` table

**Progress tracking:**

```sql
-- After each chunk
UPDATE index_progress
SET processed_items = X,
    last_processed_path = 'src/content/blog/latest-post.md',
    updated_at = CURRENT_TIMESTAMP
WHERE phase = 'collections';
```

### Phase 3: Routes (CHUNKED - 50 items at a time)

**Purpose:** Map all routes to source files.

**Detection methods (in priority order):**

1. **astro-mcp** (if dev server running): `list-astro-routes`
2. **File scan fallback:** Scan `src/pages/` directory

**For each route:**

```sql
INSERT OR REPLACE INTO routes (route_pattern, route_type, source_file, ...)
VALUES ('/blog/[slug]', 'dynamic', 'src/pages/blog/[slug].astro', ...);
```

**Route type detection:**
- Static: No `[brackets]` in path
- Dynamic: Has `[param]` or `[...spread]`
- API: In `src/pages/api/` or has `.ts`/`.js` extension

### Phase 4: Data Files (CHUNKED - 20 items at a time)

**Purpose:** Analyze data files that generate routes.

**For each file in `src/data/`:**

1. Detect export type (array, object, function)
2. If array, count items
3. Sample first item structure for schema
4. Detect if used in dynamic routes

### Phase 5: Components (CHUNKED - 100 items at a time)

**Purpose:** Build component inventory.

**For each component:**

1. Detect type from extension (.astro, .tsx, .vue, etc.)
2. Check for client directives (`client:load`, `client:idle`, etc.)
3. Extract prop types if TypeScript
4. Store in `components` table

---

## Step 4: Handle Large Sites

**Check total items before starting:**

```sql
SELECT
  (SELECT value FROM project_config WHERE key = 'total_collection_items') as items;
```

**Thresholds:**

| Items | Strategy |
|-------|----------|
| < 500 | Full index, no prompts |
| 500-2000 | Show progress, continue |
| > 2000 | Prompt user for strategy |

**Large site prompt:**

```markdown
### 📦 Large Project Detected

Your project has approximately **X** content items.

Full indexing may take several minutes.

**Options:**

1. **Priority collections only**
   Index only the collections you specify

2. **Recent content only**
   Index content from the last 6 months

3. **Full index (background)**
   Index everything, continue in background

4. **Quick scan only**
   Skip detailed indexing, use counts only

Which approach? (1/2/3/4)
```

**If user selects option 1:**
```markdown
Which collections should I prioritize?

Available collections:
- blog (1200 items)
- products (800 items)
- docs (400 items)

Enter collection names (comma-separated):
```

---

## Step 5: Resume Interrupted Indexing

When `/index resume` is called:

```sql
SELECT phase, status, last_processed_path, processed_items, total_items
FROM index_progress
WHERE status = 'in_progress';
```

**If found:**

```markdown
### Resuming Indexing

Found interrupted indexing:

| Phase | Progress | Last Item |
|-------|----------|-----------|
| collections | 45% (90/200) | src/content/blog/post-90.md |

Resuming from last checkpoint...

- Skipping already processed items
- Continuing with: src/content/blog/post-91.md
```

**Resume logic:**

```sql
-- Get entries to process (after last_processed_path)
SELECT * FROM collection_entries
WHERE file_path > 'src/content/blog/post-90.md'
ORDER BY file_path
LIMIT 50;
```

---

## Step 6: Reset Index

When `/index reset` is called:

```markdown
### ⚠️ Reset Project Index

This will delete all indexed project metadata:
- Routes
- Collection entries
- Components
- Data files

**This does NOT affect:**
- Audit history
- GSC snapshots
- Keyword cache

**Proceed?** (yes/no)
```

**If confirmed:**

```sql
-- Clear project metadata tables
DELETE FROM routes;
DELETE FROM collection_entries;
DELETE FROM collections;
DELETE FROM components;
DELETE FROM layouts;
DELETE FROM data_files;
DELETE FROM integrations;
DELETE FROM project_config;

-- Reset progress
UPDATE index_progress SET
  status = 'pending',
  total_items = 0,
  processed_items = 0,
  last_processed_path = NULL,
  started_at = NULL,
  completed_at = NULL,
  error_message = NULL;
```

```markdown
✅ Index reset complete.

Run `/index run` to re-index the project.
```

---

## Step 7: Refresh Specific Collection

When `/index refresh blog` is called:

```markdown
### Refreshing Collection: blog

Current status:
- Indexed items: 120
- Last indexed: 2024-01-10

Scanning for changes...

**Changes detected:**
- 3 new entries
- 2 modified entries
- 1 deleted entry

**Updating index...**

✅ Collection refreshed (6 items updated)
```

**Refresh logic:**

```sql
-- Get current entries from DB
SELECT slug, last_modified FROM collection_entries
WHERE collection_id = (SELECT id FROM collections WHERE name = 'blog');

-- Compare with filesystem
-- Add new, update modified, remove deleted
```

---

## Step 8: Generate AI-INFO.md (After Indexing)

After any indexing completes, offer to generate AI-INFO.md:

```markdown
### Generate AI-INFO.md?

Indexing complete. Generate updated AI-INFO.md from indexed data?

This will create/update AI-INFO.md with:
- Project configuration
- Content structure
- Route inventory
- Component summary

**Options:**
1. **Generate now** (recommended)
2. **Skip** (generate later with `/index generate-ai-info`)
```

**If yes, query database and generate:**

```sql
-- Get all data for AI-INFO.md
SELECT * FROM project_summary;
SELECT * FROM content_overview;
SELECT * FROM component_summary;
SELECT * FROM routes_summary;
```

Write to `AI-INFO.md` using template (see templates/AI-INFO.md.template).

---

## Error Handling

### Database Locked

```markdown
⚠️ **Database Locked**

Another process is using the database.

**Options:**
1. Wait and retry
2. Force unlock (may lose data)
3. Cancel

Choose: (1/2/3)
```

### Indexing Errors

Store errors in `index_progress.error_message` and continue:

```sql
UPDATE index_progress
SET error_message = 'Failed to parse src/content/blog/broken.md: Invalid frontmatter'
WHERE phase = 'collections';
```

```markdown
⚠️ **Indexing completed with errors**

| Phase | Errors |
|-------|--------|
| Collections | 2 items failed |

**Failed items:**
1. src/content/blog/broken.md - Invalid frontmatter
2. src/content/blog/missing.md - File not found

These items were skipped. Fix the issues and run `/index refresh blog` to retry.
```

---

## Index Run Logging

Every index run is logged for debugging:

```sql
INSERT INTO index_runs (run_type, trigger, phases_requested, started_at)
VALUES ('full', 'manual', '["quick_scan","collections","routes","data_files","components"]', CURRENT_TIMESTAMP);
```

View recent runs:

```sql
SELECT run_type, trigger, started_at, completed_at, items_indexed
FROM index_runs
ORDER BY started_at DESC
LIMIT 5;
```

---

## MCP Integration

### If astro-mcp Available (dev server running)

Use MCP tools for faster, more accurate data:

| Data | MCP Tool | Fallback |
|------|----------|----------|
| Routes | `list-astro-routes` | File scan |
| Config | `get-astro-config` | Parse astro.config.mjs |
| Integrations | `get-astro-config` | Parse package.json |

### Check MCP Availability

```markdown
### MCP Status

| Server | Status | Used For |
|--------|--------|----------|
| astro-mcp | 🟢 Available | Routes, config |
| Astro Docs | 🟢 Available | Best practices |

Using MCP for faster indexing.
```

Or:

```markdown
### MCP Status

| Server | Status | Fallback |
|--------|--------|----------|
| astro-mcp | 🔴 Unavailable | File scanning |

**Tip:** Run `npm run dev` for faster indexing via astro-mcp.
```
