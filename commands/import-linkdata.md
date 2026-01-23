---
description: Import link analysis data from CSV (RANKV9, Screaming Frog, etc.)
argument-hint: "[csv-path] [--source tool-name]"
---

# Import Link Data

Imports internal linking data, target keywords, and content metadata from CSV files into the database. This data powers automatic keyword detection in `/audit content` and internal linking analysis.

---

## Prerequisites

- SQLite database at `.planning/seo-audit.db` (schema v4+)
- CSV file with link analysis data

**Supported CSV formats:**
- RANKV9 LinkData export
- Screaming Frog internal links export
- Custom CSV (see schema below)

---

## Step 1: Verify Database Schema

```sql
-- Check schema version
SELECT version FROM schema_version ORDER BY version DESC LIMIT 1;
```

**If version < 4:**
```markdown
⚠️ **Database Schema Outdated**

Current version: [X]
Required version: 4

**To migrate:**
```bash
sqlite3 .planning/seo-audit.db < scripts/migrate-v4.sql
```

Then re-run this command.
```

---

## Step 2: Detect CSV Format

Read the CSV header and detect the format:

### RANKV9 Format
Expected columns:
- `id`, `url`, `out_links`, `in_links`, `linked_from`, `page_title`
- `page_description`, `primary_topic`, `content_type`, `key_keywords`
- `session_id`, `page_summary`, `filename`, `linked_to`
- `createdAt`, `updatedAt`

### Screaming Frog Format
Expected columns:
- `Source`, `Destination`, `Anchor`, `Status Code`

### Custom Format
Minimum required columns:
- `url` (required)
- `title` or `page_title`
- At least one of: `keywords`, `key_keywords`, `target_keyword`

```markdown
### 📄 CSV Format Detection

**File:** `[csv-path]`
**Rows:** X
**Columns:** X

**Detected Format:** [RANKV9 / Screaming Frog / Custom]

**Columns Found:**
| Column | Mapped To | Status |
|--------|-----------|--------|
| url | page_analysis.url | ✅ |
| page_title | page_analysis.page_title | ✅ |
| key_keywords | page_keywords | ✅ |
| linked_from | internal_links (inbound) | ✅ |
| linked_to | internal_links (outbound) | ✅ |
| ... | ... | ... |
```

---

## Step 3: Preview Import

Show what will be imported before committing:

```markdown
### 📊 Import Preview

**Pages to import:** X
**Keywords to extract:** ~X
**Internal links to map:** ~X

**Sample Data (first 5 rows):**

| URL | Title | Topic | Keywords |
|-----|-------|-------|----------|
| /blog/example-1 | Example Post 1 | Web Design | keyword1, keyword2 |
| /blog/example-2 | Example Post 2 | SEO | keyword3, keyword4 |
| ... | ... | ... | ... |

**Link Graph Sample:**
- `/blog/example-1` → links to 5 pages, linked from 3 pages
- `/blog/example-2` → links to 8 pages, linked from 12 pages

**Proceed with import?** (yes/no)
```

---

## Step 4: Execute Import

### 4a: Create Import Session

```sql
INSERT INTO link_import_sessions (session_id, source_file, source_tool)
VALUES ('[uuid]', '[filename]', '[detected-tool]');
```

### 4b: Import Pages (page_analysis)

For each row in CSV:

```sql
INSERT OR REPLACE INTO page_analysis (
  url,
  source_file,
  page_title,
  page_description,
  primary_topic,
  content_type,
  page_summary,
  out_links_count,
  in_links_count,
  session_id,
  created_at,
  updated_at,
  last_indexed
) VALUES (
  '[url]',
  '[filename]',
  '[page_title]',
  '[page_description]',
  '[primary_topic]',
  '[content_type]',
  '[page_summary]',
  [out_links],
  [in_links],
  '[session_id]',
  '[createdAt]',
  '[updatedAt]',
  CURRENT_TIMESTAMP
);
```

### 4c: Import Keywords (page_keywords)

Parse `key_keywords` field (comma-separated) and insert:

```sql
-- First keyword is primary
INSERT OR IGNORE INTO page_keywords (page_id, keyword, is_primary, source)
VALUES (
  (SELECT id FROM page_analysis WHERE url = '[url]'),
  '[keyword]',
  [1 if first else 0],
  'csv_import'
);
```

### 4d: Import Internal Links (internal_links)

Parse `linked_from` and `linked_to` fields:

```sql
-- For each link in linked_to
INSERT OR IGNORE INTO internal_links (source_page_id, target_page_id)
SELECT
  (SELECT id FROM page_analysis WHERE url = '[source_url]'),
  (SELECT id FROM page_analysis WHERE url = '[target_url]')
WHERE EXISTS (SELECT 1 FROM page_analysis WHERE url = '[target_url]');
```

### 4e: Update Session Stats

```sql
UPDATE link_import_sessions
SET
  pages_imported = (SELECT COUNT(*) FROM page_analysis WHERE session_id = '[session_id]'),
  links_imported = (SELECT COUNT(*) FROM internal_links il
                    JOIN page_analysis pa ON il.source_page_id = pa.id
                    WHERE pa.session_id = '[session_id]'),
  keywords_imported = (SELECT COUNT(*) FROM page_keywords pk
                       JOIN page_analysis pa ON pk.page_id = pa.id
                       WHERE pa.session_id = '[session_id]')
WHERE session_id = '[session_id]';
```

---

## Step 5: Generate Report

```markdown
## ✅ Import Complete

**Session:** [session_id]
**Source:** [filename]
**Tool:** [detected-tool]

### Import Summary

| Metric | Count |
|--------|-------|
| Pages imported | X |
| Keywords extracted | X |
| Internal links mapped | X |
| Import duration | X.Xs |

### Data Quality

| Check | Status |
|-------|--------|
| All URLs resolved | ✅ X/X |
| Keywords parsed | ✅ X pages with keywords |
| Links mapped | ✅ X links (Y orphaned) |

### Link Graph Stats

| Metric | Value |
|--------|-------|
| Orphan pages (0 inbound) | X |
| Hub pages (5+ outbound) | X |
| Avg links per page | X.X |
| Most linked page | [url] (X links) |

---

### 🔗 Quick Actions

1. **"Show orphans"** - List pages with no internal links
2. **"Show hubs"** - List pages with most connections
3. **"Audit [url]"** - Run content audit (keywords auto-detected!)
4. **"Link opportunities"** - Find pages needing more internal links
```

---

## Step 6: Verify Integration

Show how this data will be used:

```markdown
### 🎯 How This Data Helps

**Content Audits:**
- `/audit content /blog/example` now auto-detects target keyword
- No need to specify keyword manually

**Internal Linking:**
- `/seo links` shows link graph analysis
- Identifies orphan pages and hub pages

**Content Strategy:**
- `/seo gaps` cross-references with GSC data
- Topic clustering from `primary_topic` field

**Example:**
```bash
# Before: had to specify keyword
/audit content /blog/web-design-mistakes-woodford "web designer woodford"

# After: keyword auto-detected from import
/audit content /blog/web-design-mistakes-woodford
# → Auto-detected: "Web Designer Woodford, Local SEO, Mobile-friendly design"
```
```

---

## CSV Schema Reference

### RANKV9 Format (Full)

```csv
id,url,out_links,in_links,linked_from,page_title,page_description,primary_topic,content_type,key_keywords,session_id,page_summary,filename,linked_to,createdAt,updatedAt
```

### Minimum Custom Format

```csv
url,title,keywords
/blog/example,Example Post,"keyword1, keyword2, keyword3"
```

### Extended Custom Format

```csv
url,title,description,topic,content_type,keywords,linked_from,linked_to
```

---

## Example Usage

```bash
# Import RANKV9 export
/import-linkdata ./exports/RANKV9_LinkData.csv

# Import with explicit tool
/import-linkdata ./exports/links.csv --source screaming_frog

# Import from uploads
/import-linkdata /mnt/user-data/uploads/-RANKV9-_LinkData.csv
```

---

## Troubleshooting

### "URL not found in database"
Some internal links point to pages not in the CSV. These are logged but skipped.

### "Duplicate URL"
The import uses `INSERT OR REPLACE` - existing pages are updated with new data.

### "Keywords not parsing"
Check the delimiter - expects comma-separated values in `key_keywords` field.
