---
description: View and manage cached keyword research data
argument-hint: "[list|search|refresh|clear] [keyword]"
---

# Keyword Cache Management

View and manage cached keyword research data from DataForSEO. Caching avoids repeated API calls and tracks keyword data over time.

---

## Prerequisites

- SQLite database (`.planning/seo-audit.db`)
- DataForSEO MCP (for refresh operations)

---

## Actions

| Action | Description | Example |
|--------|-------------|---------|
| `list` | Show all cached keywords | `/keyword-cache list` |
| `search` | Find specific keyword data | `/keyword-cache search "seo tips"` |
| `refresh` | Update keyword from DataForSEO | `/keyword-cache refresh "seo tips"` |
| `clear` | Remove stale cache entries | `/keyword-cache clear` |

---

## Action: List

Show all cached keywords with their data:

```markdown
## 🔑 Keyword Cache

**Total Keywords:** X
**Fresh (<7 days):** X
**Aging (7-30 days):** X
**Stale (>30 days):** X

---

### Cached Keywords

| Keyword | Volume | Difficulty | CPC | Last Updated | Status |
|---------|--------|------------|-----|--------------|--------|
| seo guide 2025 | 2,400 | 45 | $3.20 | 2 days ago | 🟢 Fresh |
| content marketing | 8,100 | 62 | $5.50 | 15 days ago | 🟡 Aging |
| keyword research | 5,400 | 55 | $4.10 | 45 days ago | 🔴 Stale |

---

### Cache Statistics

| Metric | Value |
|--------|-------|
| Total API calls saved | ~X (based on cache hits) |
| Oldest entry | [keyword] ([X] days ago) |
| Most queried | [keyword] (X lookups) |
| Average age | X days |
```

---

## Action: Search

Find data for a specific keyword:

```markdown
## 🔍 Keyword: "[keyword]"

### Overview

| Metric | Value |
|--------|-------|
| Search Volume | X/month |
| Keyword Difficulty | X/100 |
| CPC | $X.XX |
| Competition | [Low/Medium/High] |
| Last Updated | [date] ([X] days ago) |
| Cache Status | [Fresh/Aging/Stale] |

---

### SERP Features

| Feature | Present |
|---------|---------|
| Featured Snippet | ✅/❌ |
| People Also Ask | ✅/❌ |
| Image Pack | ✅/❌ |
| Video Results | ✅/❌ |
| Local Pack | ✅/❌ |
| Knowledge Panel | ✅/❌ |

---

### People Also Ask (X questions)

1. [Question 1]
2. [Question 2]
3. [Question 3]
4. [Question 4]
5. [Question 5]

---

### Related Keywords (X found)

| Keyword | Volume | Difficulty | Relevance |
|---------|--------|------------|-----------|
| [related 1] | X | X | High |
| [related 2] | X | X | High |
| [related 3] | X | X | Medium |
| [related 4] | X | X | Medium |
| [related 5] | X | X | Low |

---

### Usage History

This keyword was used in audits for:
- `/blog/seo-guide` (Jan 15, 2025)
- `/blog/seo-tips` (Feb 20, 2025)
```

---

## Action: Refresh

Update keyword data from DataForSEO API:

```markdown
## 🔄 Refreshing: "[keyword]"

### Previous Data (from [X] days ago)
| Metric | Old Value |
|--------|-----------|
| Volume | X |
| Difficulty | X |
| CPC | $X.XX |

### Querying DataForSEO...

### New Data
| Metric | New Value | Change |
|--------|-----------|--------|
| Volume | X | [+/-X%] |
| Difficulty | X | [+/-X] |
| CPC | $X.XX | [+/-$X.XX] |

### What Changed
- Search volume [increased/decreased] by X%
- Difficulty [increased/decreased] by X points
- [X] new PAA questions found
- [X] new related keywords found

### Cache Updated
- Previous: [old date]
- Current: [new date]
- Next refresh recommended: [date + 30 days]
```

If DataForSEO not configured:

```markdown
## 🔄 Refresh: "[keyword]"

**DataForSEO MCP not configured.**

To enable keyword refresh:
1. Get DataForSEO credentials at https://dataforseo.com/
2. Add to .env:
   ```
   DATAFORSEO_USERNAME=your_username
   DATAFORSEO_PASSWORD=your_password
   ```
3. Restart Claude Code
4. Try refresh again

**Current cached data (may be stale):**
[Show cached data if available]
```

---

## Action: Clear

Remove stale cache entries:

```markdown
## 🧹 Cache Cleanup

### Before Cleanup
| Status | Count |
|--------|-------|
| Fresh (<7 days) | X |
| Aging (7-30 days) | X |
| Stale (>30 days) | X |
| **Total** | X |

### Cleanup Options

1. **"Clear stale"** - Remove entries older than 30 days
2. **"Clear all"** - Remove all cached keywords
3. **"Clear [keyword]"** - Remove specific keyword
4. **"Cancel"** - Keep cache as-is

### After Cleanup (if stale cleared)
| Status | Count | Removed |
|--------|-------|---------|
| Fresh | X | 0 |
| Aging | X | 0 |
| Stale | 0 | -X |
| **Total** | X | -X |

**Space saved:** ~X KB
**API calls that will be needed:** X (on next audit of affected pages)
```

---

## Keyword Not Found

```markdown
## 🔍 Keyword: "[keyword]"

**Not found in cache.**

### Options

1. **"Add from audit"** - Run `/content-audit [page] "[keyword]"` to fetch and cache
2. **"Add manually"** - Fetch from DataForSEO now (requires MCP)
3. **"Skip"** - Don't add to cache

### Add Manually?

Would you like me to query DataForSEO for "[keyword]" now?
- This will make one API call
- Data will be cached for 30 days
- Includes volume, difficulty, PAA, related keywords
```

---

## Database Schema Reference

```sql
-- Keywords table
CREATE TABLE keywords (
  id INTEGER PRIMARY KEY,
  keyword TEXT NOT NULL UNIQUE,
  search_volume INTEGER,
  difficulty INTEGER,
  cpc REAL,
  competition_level TEXT,
  serp_features TEXT, -- JSON
  last_updated TIMESTAMP
);

-- PAA questions
CREATE TABLE paa_questions (
  id INTEGER PRIMARY KEY,
  keyword_id INTEGER,
  question TEXT,
  FOREIGN KEY (keyword_id) REFERENCES keywords(id)
);

-- Related keywords
CREATE TABLE related_keywords (
  id INTEGER PRIMARY KEY,
  keyword_id INTEGER,
  related_keyword TEXT,
  search_volume INTEGER,
  difficulty INTEGER,
  relevance_score REAL,
  FOREIGN KEY (keyword_id) REFERENCES keywords(id)
);
```

---

## Example Usage

```bash
# List all cached keywords
/keyword-cache list

# Search for specific keyword
/keyword-cache search "content marketing"

# Refresh stale keyword data
/keyword-cache refresh "seo tips"

# Clear old entries
/keyword-cache clear
```

---

## Caching Best Practices

| Scenario | Recommendation |
|----------|----------------|
| Running content audit | Cache auto-populated |
| Keyword data > 30 days old | Refresh before audit |
| Seasonal keywords | Refresh monthly |
| Evergreen keywords | Refresh quarterly |
| Before major content push | Refresh all target keywords |

**Note:** DataForSEO charges per API call. Caching helps reduce costs by reusing data for 30 days.
