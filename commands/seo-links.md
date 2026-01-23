---
description: Analyze internal linking structure and find opportunities
argument-hint: "[orphans|hubs|opportunities|graph|page-url]"
---

# Internal Link Analysis

Analyzes the internal linking structure using data imported via `/import-linkdata`. Identifies orphan pages, hub pages, and linking opportunities.

---

## Prerequisites

- Link data imported via `/import-linkdata`
- Database at `.planning/seo-audit.db` (schema v4+)

---

## Command Variants

### `/seo links` or `/seo links summary`
Show overall link structure summary.

### `/seo links orphans`
List pages with no internal links pointing to them.

### `/seo links hubs`
List pages with the most outbound links (content hubs).

### `/seo links opportunities`
Find pages that should receive more internal links.

### `/seo links [page-url]`
Show link profile for a specific page.

---

## Step 1: Check Data Availability

```sql
SELECT COUNT(*) as pages FROM page_analysis;
SELECT COUNT(*) as links FROM internal_links;
SELECT MAX(imported_at) as last_import FROM link_import_sessions;
```

**If no data:**
```markdown
⚠️ **No Link Data Found**

Import link analysis data first:

```bash
/import-linkdata [csv-path]
```

Supported formats: RANKV9, Screaming Frog, custom CSV.
```

---

## Step 2: Summary View (default)

```sql
-- Overall stats
SELECT
  (SELECT COUNT(*) FROM page_analysis) as total_pages,
  (SELECT COUNT(*) FROM internal_links) as total_links,
  (SELECT AVG(in_links_count) FROM page_analysis) as avg_inbound,
  (SELECT AVG(out_links_count) FROM page_analysis) as avg_outbound,
  (SELECT COUNT(*) FROM page_analysis WHERE in_links_count = 0) as orphan_count,
  (SELECT COUNT(*) FROM page_analysis WHERE out_links_count >= 5) as hub_count;
```

```markdown
## 🔗 Internal Link Analysis

**Last Import:** [date] from [source]

### Overview

| Metric | Value |
|--------|-------|
| Total Pages | X |
| Total Internal Links | X |
| Avg Inbound Links | X.X |
| Avg Outbound Links | X.X |

### Health Indicators

| Status | Count | Recommendation |
|--------|-------|----------------|
| 🔴 Orphan Pages | X | Need internal links |
| 🟡 Low Links (<3) | X | Could use more links |
| 🟢 Well-linked (3+) | X | Good coverage |
| ⭐ Hub Pages (5+) | X | Content pillars |

### Top 5 Most Linked Pages

| Page | Inbound | Topic |
|------|---------|-------|
| [url] | X | [topic] |
| [url] | X | [topic] |
| ... | ... | ... |

### Link Distribution by Topic

| Topic | Pages | Avg Links | Orphans |
|-------|-------|-----------|---------|
| [topic] | X | X.X | X |
| [topic] | X | X.X | X |
| ... | ... | ... | ... |
```

---

## Step 3: Orphan Pages View

```sql
SELECT * FROM orphan_pages;
```

```markdown
## 🔴 Orphan Pages (No Inbound Links)

These pages have no internal links pointing to them. Search engines may have difficulty finding them.

| Page | Title | Type | Outbound | Last Updated |
|------|-------|------|----------|--------------|
| [url] | [title] | Blog Post | X | [date] |
| [url] | [title] | Service | X | [date] |
| ... | ... | ... | ... | ... |

**Total Orphans:** X pages

### Quick Fixes

For each orphan, find related pages to link from:

#### 1. [orphan-url]
**Topic:** [topic]
**Could link from:**
- /blog/related-post-1 (same topic)
- /blog/related-post-2 (mentions similar keywords)
- /services/parent-service (parent category)

[Repeat for top 5 orphans]

---

### Actions

1. **"Fix orphan [url]"** - Add internal links to this page
2. **"Export orphans"** - Save list to CSV
3. **"Bulk fix"** - Generate linking plan for all orphans
```

---

## Step 4: Hub Pages View

```sql
SELECT * FROM hub_pages LIMIT 20;
```

```markdown
## ⭐ Hub Pages (High Connectivity)

These pages link to many others - they're your content pillars.

| Page | Title | Outbound | Inbound | Total |
|------|-------|----------|---------|-------|
| [url] | [title] | X | X | X |
| [url] | [title] | X | X | X |
| ... | ... | ... | ... | ... |

### Hub Analysis

**Strongest Hubs:**
1. **[url]** - Links to X pages, covers [topics]
2. **[url]** - Links to X pages, covers [topics]

**Hub Gaps:**
These topics lack a hub page:
- [topic] - X pages, no clear pillar
- [topic] - X pages, no clear pillar

### Recommendations

1. **Strengthen existing hubs** - Ensure all related content links back to hub
2. **Create missing hubs** - Build pillar content for orphaned topics
3. **Cross-link hubs** - Connect related pillar pages
```

---

## Step 5: Link Opportunities View

```sql
SELECT * FROM link_opportunities;
```

```markdown
## 💡 Link Opportunities

Pages that could benefit from more internal links.

### Under-Linked Blog Posts

| Page | Topic | Current Links | Same-Topic Pages | Opportunity |
|------|-------|---------------|------------------|-------------|
| [url] | [topic] | X | X | +X potential |
| [url] | [topic] | X | X | +X potential |
| ... | ... | ... | ... | ... |

### Suggested Links

#### [under-linked-url]
**Current inbound:** X
**Topic:** [topic]

**Add links from:**
| Source Page | Why | Anchor Text Suggestion |
|-------------|-----|------------------------|
| [source-url] | Same topic | "[anchor]" |
| [source-url] | Mentions keyword | "[anchor]" |
| [source-url] | Related service | "[anchor]" |

[Repeat for top 5]

---

### Actions

1. **"Add link [source] → [target]"** - Insert internal link
2. **"Generate linking plan"** - Create full internal linking strategy
3. **"Export opportunities"** - Save to CSV for manual review
```

---

## Step 6: Single Page View

When a specific URL is provided:

```sql
SELECT * FROM page_link_summary WHERE url LIKE '%[slug]%';

-- Inbound links
SELECT pa.url, pa.page_title
FROM internal_links il
JOIN page_analysis pa ON il.source_page_id = pa.id
WHERE il.target_page_id = (SELECT id FROM page_analysis WHERE url LIKE '%[slug]%');

-- Outbound links
SELECT pa.url, pa.page_title
FROM internal_links il
JOIN page_analysis pa ON il.target_page_id = pa.id
WHERE il.source_page_id = (SELECT id FROM page_analysis WHERE url LIKE '%[slug]%');
```

```markdown
## 🔗 Link Profile: [url]

### Page Info

| Field | Value |
|-------|-------|
| Title | [title] |
| Topic | [topic] |
| Type | [content_type] |
| Keywords | [keywords] |

### Link Summary

| Direction | Count |
|-----------|-------|
| Inbound (links TO this page) | X |
| Outbound (links FROM this page) | X |

### Inbound Links (X)

| From | Title |
|------|-------|
| [url] | [title] |
| [url] | [title] |
| ... | ... |

### Outbound Links (X)

| To | Title |
|----|-------|
| [url] | [title] |
| [url] | [title] |
| ... | ... |

### Opportunities

**Pages that should link here (same topic, no link):**
| Page | Why |
|------|-----|
| [url] | Same topic: [topic] |
| [url] | Mentions: [keyword] |

**Pages this should link to (related, no link):**
| Page | Why |
|------|-----|
| [url] | Related topic |
| [url] | Follow-up content |
```

---

## Example Usage

```bash
# Overall summary
/seo links

# Find orphan pages
/seo links orphans

# Find hub pages
/seo links hubs

# Find linking opportunities
/seo links opportunities

# Check specific page
/seo links /blog/web-design-mistakes-woodford
```
