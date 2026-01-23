---
description: Analyze content performance and ROI
---

# Content ROI Analysis

## Step 0: Check Project Index

**Query the project index for fast content inventory:**

```sql
-- Check index status
SELECT * FROM index_status;

-- Get content overview
SELECT * FROM project_summary;
```

### Index Status Display

```markdown
### 📊 Project Index Status

| Phase | Status | Items |
|-------|--------|-------|
| Collections | ✅/🔄/❌ | X items |
| Routes | ✅/🔄/❌ | X routes |
| Data Files | ✅/🔄/❌ | X files |

**Data Source:** [Database / MCP / File scan]
```

**If index incomplete:**
```markdown
⚠️ **Content inventory incomplete**

ROI analysis works best with complete content index.
Run `/index run` for comprehensive analysis.

Proceeding with available data...
```

---

## Step 1: Discover Content Structure

**First, query the project to understand where content lives:**

### Priority 1: Query Database (Fast)

```sql
-- Get project configuration
SELECT key, value FROM project_config
WHERE key IN ('name', 'astro_version', 'output_mode', 'site_url');

-- Get all collections with item counts
SELECT
  name,
  location,
  item_count,
  schema_fields,
  last_indexed
FROM collections
ORDER BY item_count DESC;

-- Get routes by type
SELECT
  route_pattern,
  route_type,
  source_file,
  generates_count
FROM routes
ORDER BY route_type, route_pattern;

-- Get data files
SELECT
  file_path,
  export_name,
  item_count
FROM data_files;
```

**If database has data:**

```markdown
## 📁 Content Structure Discovery (from index)

**Data Source:** Project Index ✅

### Project Configuration
| Setting | Value |
|---------|-------|
| Content Directory | src/content/ |
| Pages Directory | src/pages/ |
| Collections | [count from DB] |
| Data Files | [count from DB] |

### Content Routes Found

| Route Pattern | Type | Source | Count |
|---------------|------|--------|-------|
| /blog/[slug] | Content Collection | src/content/blog/ | X posts |
| /products/[id] | Data-driven | src/data/products.js | X items |
| /services/[slug] | Static pages | src/pages/services/ | X pages |
```

### Priority 2: MCP Fallback

If index incomplete, fall back to astro-mcp:

```markdown
## 📁 Content Structure Discovery (via astro-mcp)

**Note:** Project not fully indexed. Run `/index run` for faster queries.

[Query get-astro-config and list-astro-routes]
```

### Search Astro Docs for Content Patterns

Use `search_astro_docs` for "content collections":

```markdown
### Astro Content Best Practices
- Collections location: src/content/[collection]/
- Schema definition: src/content/config.ts
- Querying: getCollection() and getEntry()
- Images: Can be colocated or in src/assets/
```

---

## Step 2: Inventory All Content

Based on discovered structure, query content from database:

### Priority 1: Query Database

```sql
-- Get all collection entries with details
SELECT
  ce.slug,
  ce.title,
  ce.file_path,
  ce.publish_date,
  ce.word_count,
  ce.draft,
  c.name as collection_name,
  c.location
FROM collection_entries ce
JOIN collections c ON ce.collection_id = c.id
WHERE ce.draft = 0
ORDER BY ce.publish_date DESC;

-- Collection health metrics
SELECT
  c.name,
  c.item_count as total,
  SUM(CASE WHEN ce.word_count > 0 THEN 1 ELSE 0 END) as with_word_count,
  SUM(CASE WHEN ce.description IS NOT NULL THEN 1 ELSE 0 END) as with_description,
  SUM(CASE WHEN ce.draft = 1 THEN 1 ELSE 0 END) as drafts
FROM collections c
LEFT JOIN collection_entries ce ON c.id = ce.collection_id
GROUP BY c.id;
```

### Content Collections (from database)

```markdown
### 📚 Content Collections

**Data Source:** Project Index ✅

| Collection | Location | Items | Schema |
|------------|----------|-------|--------|
| blog | src/content/blog/ | X | ✅ Defined |
| docs | src/content/docs/ | X | ✅ Defined |
| [other] | src/content/[name]/ | X | ✅/❌ |

#### Blog Posts (from collection_entries)
| Slug | Title | Published | Words | File |
|------|-------|-----------|-------|------|
| [slug] | [title] | [date] | X | src/content/blog/[slug].md |

#### Collection Health (from database)
| Metric | Value | Status |
|--------|-------|--------|
| Total items | X | - |
| With word count | X (Y%) | ✅/⚠️ |
| With description | X (Y%) | ✅/⚠️ |
| Draft status | X drafts | - |
```

### Data-Driven Pages

```markdown
### 📊 Data-Driven Content

| Data File | Location | Items | Generates |
|-----------|----------|-------|-----------|
| products.js | src/data/ | X | /products/[slug] |
| services.js | src/data/ | X | /services/[slug] |
| locations.js | src/data/ | X | /locations/[city] |

#### Products
| Slug | Name | Has Image | Has Description |
|------|------|-----------|-----------------|
| [slug] | [name] | ✅/❌ | ✅/❌ |
```

### Static Pages

```markdown
### 📄 Static Pages

| Route | File | Last Modified |
|-------|------|---------------|
| / | src/pages/index.astro | [date] |
| /about | src/pages/about.astro | [date] |
| /contact | src/pages/contact.astro | [date] |
```

---

## Step 3: Query Performance Data

### Google Analytics (90 Days)

For each content URL discovered:
- Sessions
- Users
- Bounce rate
- Avg. session duration
- Pageviews
- Exit rate

### Google Search Console (90 Days)

For each content URL:
- Impressions
- Clicks
- CTR
- Average position
- Top queries driving traffic

---

## Step 4: Calculate Performance Scores

### Scoring Formula

```
Traffic Score = (Sessions / 90) × 10
  → Daily average, scaled

Engagement Score = ((100 - Bounce Rate) / 100) × (Duration / 180) × 10
  → Lower bounce + higher duration = better

SEO Score = (Impressions × CTR × 10) + ((30 - Position) × 2)
  → High impressions + good CTR + good position

Overall Score = (Traffic × 0.4) + (Engagement × 0.3) + (SEO × 0.3)
  → Weighted combination
```

---

## Step 5: Categorize Content

### ⭐ Top Performers
**Criteria:**
- Traffic Score > 70
- Engagement Score > 60
- SEO Score > 50

**Action:** Replicate format, update regularly, link FROM these pages.

### ✅ Solid Performers
**Criteria:**
- Traffic Score 40-70
- Engagement Score > 40
- Some SEO traction

**Action:** Optimize titles/metas, add internal links, consider expansion.

### 🔄 Update Candidates
**Criteria:**
- Low traffic BUT good engagement
- OR High impressions but low clicks
- OR Published > 12 months ago, still relevant

**Action:** Refresh content, update date, improve titles, promote internally.

### ❌ Underperformers
**Criteria:**
- Traffic Score < 20
- Engagement Score < 30
- No SEO traction

**Action:** Major rewrite, merge with better content, or redirect.

### 🗑️ Removal Candidates
**Criteria:**
- Zero sessions for 90+ days
- Outdated/irrelevant content
- Thin content (< 300 words) with no value

**Action:** 301 redirect to relevant page or remove.

---

## Step 6: Analyze Content Patterns

### By Content Type (from astro-mcp discovery)

```markdown
### Performance by Content Type

| Type | Source | Avg Score | Best Performer |
|------|--------|-----------|----------------|
| Blog Posts | src/content/blog/ | X | [title] |
| Products | src/data/products.js | X | [name] |
| Services | src/data/services.js | X | [name] |
| Locations | src/data/locations.js | X | [city] |
| Static Pages | src/pages/ | X | [page] |
```

### By Route Pattern

```markdown
### Performance by Route Pattern

| Pattern | Pages | Total Sessions | Avg Score |
|---------|-------|----------------|-----------|
| /blog/* | X | X | X |
| /products/* | X | X | X |
| /services/* | X | X | X |
| /[static] | X | X | X |
```

### Content Location Insights

```markdown
### 💡 Content Organization Insights

**What's Working:**
- Blog posts in src/content/blog/ average X sessions
- Products with images perform Y% better

**Potential Issues:**
- [X] items in [location] have no traffic
- Content in [location] missing from routes

**Astro-Specific Recommendations:**
[Search Astro docs for content optimization]
- Consider using Content Collections for [type]
- Image optimization available via astro:assets
```

---

## Step 7: Generate Report

```markdown
## 📊 Content ROI Report

**Generated:** [Date]
**Analysis Period:** 90 days
**Content Analyzed:** [X] pieces

---

### Content Discovery Summary (via astro-mcp)

| Source | Location | Items | In Analytics |
|--------|----------|-------|--------------|
| Content Collections | src/content/ | X | X |
| Data Files | src/data/ | X | X |
| Static Pages | src/pages/ | X | X |
| **Total** | - | **X** | **X** |

---

### Executive Summary

| Metric | Value |
|--------|-------|
| Total Content Pieces | X |
| Total Sessions (90d) | X |
| Avg. Sessions per Content | X |
| Content Driving 80% Traffic | X pieces (Y%) |

### Performance Distribution

| Category | Count | % of Total | Traffic Share |
|----------|-------|------------|---------------|
| ⭐ Top Performers | X | X% | X% |
| ✅ Solid | X | X% | X% |
| 🔄 Update Needed | X | X% | X% |
| ❌ Underperforming | X | X% | X% |
| 🗑️ Remove | X | X% | X% |

---

### ⭐ Top Performers

These are your best content pieces. Replicate what works.

| Content | Location | Sessions | Bounce | Duration | Score |
|---------|----------|----------|--------|----------|-------|
| [Title](/url/) | src/content/blog/ | X | X% | X:XX | X |
| [Title](/url/) | src/data/products.js | X | X% | X:XX | X |

**Common Patterns:**
- Average length: X words
- Common topics: [topics]
- Format: [format type]
- Avg internal links: X
- Content source: [most common location]

**Recommendation:** Create more content like these. Link new content TO these pages.

---

### 🔄 High-Potential Updates

These have potential but need work.

| Content | Location | Issue | Potential | Effort |
|---------|----------|-------|-----------|--------|
| [Title](/url/) | src/content/blog/ | Low CTR | +X clicks | 30m |
| [Title](/url/) | src/data/products.js | Outdated | +X sessions | 2h |

#### 1. [Title] - Low CTR Despite Impressions

**Location:** `src/content/blog/[slug].md`

**Current Performance:**
- Impressions: X
- Clicks: X
- CTR: X% (should be ~3-5%)

**Fix:**
- Current title: "[title]"
- Suggested title: "[new title]"
- File to edit: `src/content/blog/[slug].md`

**Estimated Impact:** +X clicks/month

---

### ❌ Underperformers

These need significant work or removal.

| Content | Location | Sessions | Issue | Recommendation |
|---------|----------|----------|-------|----------------|
| [Title](/url/) | src/content/blog/ | X | No traffic | Merge with [other] |
| [Title](/url/) | src/pages/ | X | High bounce | Rewrite intro |

#### Merge Candidates

| Merge These | Location | Into | Combined Potential |
|-------------|----------|------|-------------------|
| [Post A] + [Post B] | src/content/blog/ | [New post] | X sessions |

#### Redirect Candidates

| Remove | Location | Redirect To | Reason |
|--------|----------|-------------|--------|
| /[old-url]/ | src/pages/old.astro | /[better-url]/ | [reason] |

---

### 📝 Content Gaps

Based on GSC data, you're getting impressions for topics without dedicated content:

| Query | Impressions | Current Page | Recommendation |
|-------|-------------|--------------|----------------|
| [query] | X | /[wrong-page]/ | Create in src/content/blog/ |
| [query] | X | None | Create new data item |

#### Suggested New Content

1. **"[Topic]"**
   - Search volume indicator: X impressions
   - Suggested location: `src/content/blog/[slug].md`
   - Template: Use existing blog post structure
   - Estimated effort: X hours

---

### 🏗️ Content Structure Recommendations

Based on Astro best practices (from docs):

| Current | Recommendation | Benefit |
|---------|----------------|---------|
| [pattern] | [better pattern] | [benefit] |

**Astro-Specific Suggestions:**
1. [Suggestion based on docs search]
2. [Suggestion based on project analysis]

---

### 📈 Content Strategy Recommendations

#### This Month
1. **Update [Post]** - Edit: `src/content/blog/[slug].md` - Impact: +X sessions
2. **Optimize titles for [Posts]** - Est: 1h - Impact: +X clicks
3. **Merge [Posts]** - Est: 1h - Impact: Cleanup + X sessions

#### Next Month
4. **Create [New Topic]** - Add to: `src/content/blog/` - Impact: +X sessions
5. **Expand [Post]** - Est: 2h - Impact: +X sessions

---

### 📋 Add to Tracker?

Create issues for:
- [ ] Content updates (X items) - with file locations
- [ ] New content to create (X items) - with suggested locations
- [ ] Redirects to set up (X items)
- [ ] Merges to perform (X items)

**Options:**
- **"Add all"** - Create all issues with file paths
- **"Add updates only"** - Just update tasks
- **"No"** - Keep report only
```

---

## Step 8: Implementation Support

If user wants to act immediately:

```markdown
## Quick Actions Available

### Content Updates
1. **"Update [title]"** - Opens file at [location]
2. **"Optimize titles"** - Batch update frontmatter

### New Content
3. **"Create [topic]"** - Scaffolds new content file
   - For blog: Creates `src/content/blog/[slug].md`
   - For product: Adds to `src/data/products.js`

### Structure Changes
4. **"Set up redirects"** - Configures in Astro config
5. **"Merge [posts]"** - Combines content files

What would you like to do?
```

### Create New Content Helper

```markdown
## Creating: [Topic]

**Based on project structure (via astro-mcp):**

Best location: `src/content/blog/`

**Template (matching existing posts):**
```markdown
---
title: "[Topic]"
description: "[Description targeting query]"
pubDate: [today's date]
---

# [Topic]

[Content here]
```

**File created:** `src/content/blog/[slug].md`

**Next steps:**
1. Edit the content
2. Add images to `src/assets/blog/`
3. Run `npm run dev` to preview
4. Verify route exists via `/astro-check routes blog`
```

---

## Data Source Priority

| Step | Priority 1: Database | Priority 2: MCP | Priority 3: File Scan |
|------|---------------------|-----------------|----------------------|
| Discovery | `project_config`, `collections`, `routes` | astro-mcp | Parse config files |
| Inventory | `collection_entries`, `data_files` | list-astro-routes | Glob patterns |
| File Mapping | `routes.source_file`, `collection_entries.file_path` | get-astro-config | File structure |

## MCP Usage Summary

| Step | Database | Astro Docs MCP | astro-mcp |
|------|----------|----------------|-----------|
| Discovery | ✅ Primary | Content collection patterns | Fallback |
| Inventory | ✅ Primary | - | Fallback |
| Analysis | - | - | Route-to-file mapping |
| Recommendations | File paths | Content best practices | Where to create/edit |
| Implementation | - | - | Verify new routes |
