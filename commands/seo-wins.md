---
description: Find SEO quick wins from Google Search Console data
---

# SEO Quick Wins Finder

## Prerequisites

Requires Google Search Console MCP to be configured.
If not available, will provide guidance on manual GSC analysis.

---

## Step 0: Check Project Index

**Query the project index for fast route-to-file mapping:**

```sql
-- Check index status
SELECT * FROM index_status WHERE phase = 'routes';

-- Check route count
SELECT COUNT(*) as route_count FROM routes;
```

### Index Status Display

```markdown
### 📊 Project Index Status

| Phase | Status | Items |
|-------|--------|-------|
| Routes | ✅/🔄/❌ | X routes indexed |

**Data Source:** [Database / MCP / File scan]
```

**If routes not indexed:**
```markdown
⚠️ **Routes not indexed**

URL-to-file mapping will be slower without index.
Run `/index run routes` for faster lookups.

Proceeding with MCP fallback...
```

---

## Step 1: Query Project Structure

**First, understand the content structure to map queries to files:**

### Priority 1: Query Database (Fast)

```sql
-- Get route summary from index
SELECT
  route_type,
  COUNT(*) as count
FROM routes
GROUP BY route_type;

-- Get content sources with file mappings
SELECT
  route_pattern,
  route_type,
  source_file
FROM routes
ORDER BY route_type, route_pattern;

-- Get collection locations
SELECT name, location, item_count
FROM collections;
```

**If database has routes:**

```markdown
### 📁 Project Structure (from index)

**Data Source:** Project Index ✅

#### Content Sources
| Type | Location | Routes | Items |
|------|----------|--------|-------|
| Blog | src/content/blog/ | /blog/[slug] | X |
| Products | src/data/products.js | /products/[id] | X |
| Services | src/data/services.js | /services/[slug] | X |
| Pages | src/pages/ | Various | X |

#### Total Indexable Routes
| Type | Count |
|------|-------|
| Static | X |
| Dynamic | X |
| API | X |
| **Total** | **X** |
```

### Priority 2: MCP Fallback

If routes not indexed, fall back to astro-mcp:

```markdown
### 📁 Project Structure (via astro-mcp)

**Note:** Routes not indexed. Run `/index run routes` for faster queries.

[Query list-astro-routes]
```

---

## Step 2: Query GSC Data

### Request Data (Last 28 Days)
```
Dimensions: query, page
Metrics: clicks, impressions, ctr, position
Filter: impressions > 50
Rows: 1000
```

### If GSC Not Configured
```markdown
## GSC Not Connected

To use this command fully, configure the GSC MCP server.

**In the meantime, I can:**
1. Analyze your content for SEO issues
2. Check schema markup
3. Review internal linking using route data
4. Audit meta tags across all routes

Would you like me to do a content-based SEO audit instead?
```

---

## Step 3: Map Queries to Content Files

**Use project index for fast URL-to-file mapping:**

### Priority 1: Query Database

```sql
-- Map GSC URLs to source files
SELECT
  r.route_pattern,
  r.source_file,
  r.route_type,
  ce.title,
  ce.file_path as content_file
FROM routes r
LEFT JOIN collection_entries ce ON r.route_pattern LIKE '%' || ce.slug || '%'
WHERE r.route_pattern IN ([GSC URLs]);

-- For dynamic routes, match by slug pattern
SELECT
  ce.slug,
  ce.file_path,
  ce.title,
  c.name as collection
FROM collection_entries ce
JOIN collections c ON ce.collection_id = c.id
WHERE ce.slug = '[extracted-slug]';
```

**If database has mappings:**

```markdown
### 🗺️ Query to File Mapping (from index)

**Data Source:** Project Index ✅

| URL | Query | Source File | Type |
|-----|-------|-------------|------|
| /blog/seo-tips | "seo tips" | src/content/blog/seo-tips.md | Collection |
| /products/widget | "widget" | src/data/products.js → widget | Data |
| /services/consulting | "consulting" | src/pages/services/consulting.astro | Page |

This mapping helps identify exactly which file to edit for each optimization.
```

### Priority 2: MCP Fallback

If routes not in database, fall back to astro-mcp route data.

---

## Step 4: Categorize Opportunities

### Category A: "Almost There" 🎯
**Criteria:** Position 4-10, CTR < 5%, Impressions > 200

These are on page 1 but not getting clicks. Title/meta optimization can dramatically increase CTR.

### Category B: "Low Hanging Fruit" 🍎
**Criteria:** Position 11-20, Impressions > 500

You're on page 2. A small ranking boost = massive traffic increase.

### Category C: "Content Gaps" 📝
**Criteria:** High impressions (>1000), Position 15-30, no dedicated page

You're ranking with non-optimized content. A dedicated page could dominate.

### Category D: "Declining Winners" 📉
**Criteria:** Position increased by >3 vs previous period, was getting >100 clicks

Something changed. Investigate and recover.

---

## Step 5: Analyze Each Opportunity

For top 5 opportunities in each category:

### Current State with File Location
```markdown
| Query | Position | Impressions | Clicks | CTR | Page | Source File |
|-------|----------|-------------|--------|-----|------|-------------|
| [query] | X.X | X | X | X% | /path/ | src/content/... |
```

### Page Analysis

Read the source file and check:
- Title tag (from frontmatter or component)
- Meta description
- H1 heading
- Content relevance to query
- Word count
- Internal links TO this page
- Schema markup

### Astro-Specific SEO Check (NEW)

Search Astro docs for SEO best practices:
```markdown
**Astro SEO Guidance:**
- Use `<title>` in layout or per-page
- Meta description in frontmatter or component
- Consider @astrojs/sitemap for XML sitemap
- Use canonical URLs via Astro.url
```

---

## Step 6: Generate Recommendations

```markdown
## 🎯 SEO Quick Wins Report

**Generated:** [Date]
**Data Period:** Last 28 days
**Opportunities Found:** [X]
**Estimated Traffic Potential:** +[X] clicks/month

---

### 📊 Summary by Category

| Category | Count | Est. Impact | Effort |
|----------|-------|-------------|--------|
| 🎯 Almost There | X | +X clicks | Low |
| 🍎 Low Hanging | X | +X clicks | Medium |
| 📝 Content Gaps | X | +X clicks | High |
| 📉 Declining | X | -X to recover | Medium |

---

### 🎯 Category A: Almost There (Page 1, Low CTR)

These pages rank well but don't get clicks. Fix titles and meta descriptions.

#### 1. "[Query]"

| Metric | Value |
|--------|-------|
| Position | X.X |
| Impressions | X |
| Clicks | X |
| CTR | X% (should be ~5-10%) |
| Page | /path/ |
| **Source File** | `src/content/blog/[slug].md` |

**Current Title:** 
`[current title]`

**Suggested Title:**
`[optimized title with query, <60 chars]`

**Current Meta:**
`[current meta description]`

**Suggested Meta:**
`[optimized meta with query and CTA, <155 chars]`

**How to Fix:**
```markdown
# Edit: src/content/blog/[slug].md

---
title: "[new title]"
description: "[new meta description]"
---
```

**Additional Recommendations:**
- Add internal links from: [high-traffic pages]
- Consider adding schema markup (see Astro docs)

**Estimated Impact:** +[X] clicks/month
**Effort:** ~15 minutes

---

### 🍎 Category B: Low Hanging Fruit (Page 2)

These pages are close to page 1. Small improvements = big traffic gains.

#### 1. "[Query]"

| Metric | Value |
|--------|-------|
| Position | X.X (need <10) |
| Impressions | X |
| Page | /path/ |
| **Source File** | `src/data/products.js` → [item] |

**Ranking Gap Analysis:**
- Current position: X.X
- Target position: <10 (page 1)
- Needed improvement: X positions

**Recommendations:**

1. **Add internal links** from these high-traffic pages:
   - /[page1]/ (X sessions/month) → Add link in `src/pages/[page1].astro`
   - /[page2]/ (X sessions/month) → Add link in `src/content/blog/[page2].md`
   
2. **Expand content:**
   - Current word count: X
   - Edit file: `[source file path]`
   - Add section about: [subtopic]

3. **Improve on-page SEO:**
   - [Specific recommendation with file location]

**Estimated Impact:** +[X] clicks/month
**Effort:** ~1 hour

---

### 📝 Category C: Content Gaps

You're getting impressions for queries without dedicated pages.

#### 1. "[Query]" - No Dedicated Page

| Metric | Value |
|--------|-------|
| Impressions | X |
| Current Position | X (ranking with /wrong-page/) |
| Search Intent | [Informational/Transactional/etc] |

**Currently Ranking:** /[wrong-page]/
**Source:** `[file path]`
**Problem:** Page doesn't target this query specifically

**Recommendation: Create Dedicated Page**

Based on your project structure (via astro-mcp):

```markdown
**Best Location:** src/content/blog/[suggested-slug].md

**Create File:**
---
title: "[Title targeting query]"
description: "[Meta description]"
pubDate: [date]
---

# [H1 targeting query]

[Content outline...]
```

**Or if product/service:**
```javascript
// Add to src/data/products.js
{
  id: "[slug]",
  name: "[Name]",
  description: "[Description targeting query]",
  // ... other fields matching your schema
}
```

**Internal Links From:**
- /[high-traffic-page-1]/ → Edit `[file path]`
- /[high-traffic-page-2]/ → Edit `[file path]`

**Estimated Impact:** +[X] clicks/month
**Effort:** ~2-3 hours

---

### 📉 Category D: Declining Queries

These were performing well but have dropped.

#### 1. "[Query]" - Position Dropped X → Y

| Metric | Current | Previous | Change |
|--------|---------|----------|--------|
| Position | Y | X | ⬇️ +Z |
| Clicks | X | X | ⬇️ -X% |

**Source File:** `[file path]`

**Potential Causes:**
- [ ] Content became outdated
- [ ] Competitor published better content
- [ ] Technical issue (check indexing)

**Recovery Recommendations:**
1. Update content in `[file path]`
2. Refresh publish date (if using pubDate)
3. Add new internal links

---

## 🚀 Action Plan

### This Week (Quick Wins - 2 hours total)

| Task | File to Edit | Impact | Time |
|------|--------------|--------|------|
| Update title/meta | `src/content/blog/[slug].md` | +X clicks | 15m |
| Update title/meta | `src/data/products.js` | +X clicks | 15m |
| Add internal links | `src/pages/index.astro` | +X clicks | 30m |

**Total estimated impact:** +[X] clicks/month

### Next Week (Medium Effort - 4 hours)

| Task | Location | Impact | Time |
|------|----------|--------|------|
| Create new page | `src/content/blog/` | +X clicks | 2h |
| Expand content | `[file path]` | +X clicks | 1h |
| Fix declining | `[file path]` | +X clicks | 1h |

---

## 📋 Add to Tracker?

Would you like me to add these as issues?

**Options:**
1. **"Add all"** - Create issues with file locations
2. **"Add quick wins"** - Just Category A items
3. **"Add [number]"** - Specific items only
4. **"No"** - Just keep this report

Issues will include:
- Priority based on impact
- Labels: `seo`, `quick-win`
- **Exact file paths to edit**
- Suggested changes
```

---

## Step 7: Implementation Support

If user wants to implement immediately:

```markdown
## Let's Implement: [Selected Item]

### Source File
`[file path from astro-mcp mapping]`

### Current Content
[Read and display relevant section]

### Proposed Changes

**For Content Collection (Markdown):**
```markdown
---
title: "[new title]"
description: "[new description]"
---
```

**For Data File (JS):**
```javascript
{
  // Updated fields
  title: "[new title]",
  description: "[new description]",
}
```

**For Astro Component:**
```astro
<title>[new title]</title>
<meta name="description" content="[new description]" />
```

Apply these changes? (yes/no)
```

---

## Data Source Priority

| Step | Priority 1: Database | Priority 2: MCP | Priority 3: File Scan |
|------|---------------------|-----------------|----------------------|
| Structure | `routes`, `collections` tables | astro-mcp | Glob patterns |
| URL Mapping | `routes.route_pattern` → `source_file` | list-astro-routes | File structure |
| Content Files | `collection_entries.file_path` | get-astro-config | Glob src/content |

## MCP Usage Summary

| Step | Database | Astro Docs MCP | astro-mcp |
|------|----------|----------------|-----------|
| Structure | ✅ Primary | - | Fallback |
| Mapping | ✅ Primary | - | Fallback |
| Analysis | - | SEO best practices | - |
| Recommendations | File paths | Meta tag patterns | Fallback |
| Implementation | - | - | Verify route after changes |
