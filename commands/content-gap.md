---
description: Find content opportunities from GSC data and generate briefs
---

# Content Gap Finder

Analyzes Google Search Console data to identify high-impression queries without dedicated content, then generates content briefs for the best opportunities.

## Prerequisites

- Google Search Console MCP configured (recommended)
- Project index for fast content lookup (run `/index` if not available)
- Astro Docs MCP for content collection best practices

---

## Step 0: Check Project Index

**Query the project index for fast content inventory:**

```sql
-- Check index status
SELECT * FROM index_status WHERE phase IN ('collections', 'routes');

-- Get content counts
SELECT * FROM project_summary;
```

### Index Status Display

```markdown
### 📊 Project Index Status

| Phase | Status | Items |
|-------|--------|-------|
| Collections | ✅/🔄/❌ | X items |
| Routes | ✅/🔄/❌ | X routes |

**Data Source:** [Database / MCP / File scan]
```

**If collections not indexed:**
```markdown
⚠️ **Content inventory not indexed**

Content gap analysis works best with a complete index.
Run `/index run collections routes` for comprehensive analysis.

Proceeding with available data...
```

---

## Configuration

### Language/Region Selection

**Default:** Analyze all languages combined

**To focus on a specific language/region, specify:**
- `/content-gap en` - English (US)
- `/content-gap de` - German
- `/content-gap fr` - French
- `/content-gap es` - Spanish
- `/content-gap` - All languages (default)

**Multi-region sites:** Always specify a language to avoid mixing content gaps across languages. Each language should have its own content strategy.

| Parameter | GSC Filter | Use When |
|-----------|------------|----------|
| `en` | country = USA, GBR, AUS, CAN | English content |
| `de` | country = DEU, AUT, CHE | German content |
| `fr` | country = FRA, BEL, CHE, CAN | French content |
| `es` | country = ESP, MEX, ARG | Spanish content |
| `[country code]` | Specific country | Single market focus |

---

## Large Site Safeguards

**Site Size Thresholds:**
| Size | Content Items | Strategy |
|------|---------------|----------|
| Small | < 100 | Full inventory listing |
| Medium | 100-500 | Summarize + top 20 per collection |
| Large | 500-2000 | Counts only + sample 10 per collection |
| Very Large | > 2000 | Counts only + focus on specific collection |

**For large sites, ask the user:**
> "Your site has X content items. Would you like to:
> 1. Focus on a specific collection (e.g., blog, products)
> 2. Analyze only recent content (last 6 months)
> 3. Proceed with sampling (may miss some gaps)"

---

## Step 1: Analyze Current Content Structure

### Priority 1: Query Database (Fast)

```sql
-- Get site size from project index
SELECT
  (SELECT COUNT(*) FROM collection_entries WHERE draft = 0) as total_content,
  (SELECT COUNT(*) FROM routes) as total_routes,
  (SELECT COUNT(*) FROM collections) as collection_count;

-- Get collection summary
SELECT
  c.name,
  c.location,
  c.item_count,
  c.schema_fields
FROM collections c
ORDER BY c.item_count DESC;

-- Get route summary
SELECT
  route_type,
  COUNT(*) as count
FROM routes
GROUP BY route_type;
```

**If database has data:**

```markdown
### 📊 Site Size Assessment (from index)

**Data Source:** Project Index ✅

| Collection | Count | Last Indexed |
|------------|-------|--------------|
| blog | X | [date] |
| products | X | [date] |
| **Total** | **X** | - |

| Route Type | Count |
|------------|-------|
| Static | X |
| Dynamic | X |
| API | X |
```

**Apply size-appropriate strategy:**

- **< 100 items:** Show full inventory below
- **100-500 items:** Show counts + 20 most recent per collection
- **> 500 items:** Show counts only, ask user which collection to focus on

### Priority 2: MCP Fallback (If DB Empty)

If index incomplete, fall back to astro-mcp:

```markdown
### 📊 Site Size Assessment (via astro-mcp)

**Note:** Project not fully indexed. Run `/index run` for faster queries.

[Query astro-mcp for content structure]
```

### Content Inventory Display

```markdown
### 📁 Current Content Inventory

**Analysis scope:** [All content / Blog collection only / etc.]
**Data Source:** [Database / MCP / File scan]

#### Content Collections (from database)
```sql
SELECT
  ce.slug,
  ce.title,
  ce.file_path,
  ce.publish_date
FROM collection_entries ce
JOIN collections c ON ce.collection_id = c.id
WHERE c.name = '[collection]'
ORDER BY ce.publish_date DESC
LIMIT 20;
```

| Collection | Location | Count | Schema Fields |
|------------|----------|-------|---------------|
| blog | src/content/blog/ | X | title, description, pubDate, ... |
| products | src/content/products/ | X | name, price, ... |

#### Routes (from database)
```sql
SELECT route_pattern, route_type, source_file
FROM routes
WHERE route_type IN ('static', 'dynamic')
ORDER BY route_type, route_pattern
LIMIT 50;
```

| Pattern | Type | Source |
|---------|------|--------|
| /blog/[slug] | dynamic | src/pages/blog/[slug].astro |
| /products/[id] | dynamic | src/pages/products/[id].astro |

**Total Indexable URLs:** X
**Showing:** X of X items (limited for performance)
```

---

## Step 2: Query GSC for Content Gaps

### GSC Query Parameters
```
Dimensions: query
Metrics: clicks, impressions, ctr, position
Sort: impressions DESC
Period: Last 90 days

# Limits (DO NOT EXCEED)
Rows: 500 (max)

# Impression threshold (adjust for site size)
Small sites (<1000 monthly clicks): impressions > 50
Medium sites: impressions > 100
Large sites (>10000 monthly clicks): impressions > 500

# Language/Region filter (if specified)
Filter dimension: country
Filter operator: equals
Filter expression: [COUNTRY_CODE from configuration]
```

### Language-Specific Query

**If language parameter provided:**
```
Use get_advanced_search_analytics with:
- filter_dimension: "country"
- filter_operator: "equals"
- filter_expression: "[country code]"

For multi-country languages (e.g., English):
Run separate queries for each country, then combine results
```

**If no language specified on multi-language site:**
```markdown
⚠️ **Multi-Language Site Detected**

Your site appears to serve multiple languages/regions.
Analyzing all languages together may mix content gaps.

**Detected languages:** [from URL patterns or GSC data]

Please specify a language to focus on:
- `/content-gap en` for English
- `/content-gap de` for German
- Or continue with all languages combined (not recommended)
```

### If GSC Not Configured
```markdown
## GSC Not Connected

To find data-driven content gaps, configure the GSC MCP server.

**Alternative: Competitor-Based Gap Analysis**

I can analyze your content against common topics in your niche using:
1. Your existing content structure
2. Brave Search for competitor content
3. Astro docs for content collection patterns

Would you like a competitor-based content gap analysis instead?
```

---

## Step 3: Identify Content Gap Types

### Type A: High Impressions, No Dedicated Page
**Criteria:** Impressions > 500, no URL exactly targeting this query

These are your biggest opportunities - people are searching, Google shows you, but you don't have focused content.

### Type B: Ranking with Wrong Page
**Criteria:** Impressions > 200, ranking page doesn't match search intent

Google is showing a generic page for a specific query. A dedicated page would rank better.

### Type C: Informational Queries (You Rank Commercial)
**Criteria:** Query indicates informational intent ("how to", "what is", "guide"), but ranking page is product/service

Create educational content that can link to commercial pages.

### Type D: Long-Tail Clusters
**Criteria:** Multiple related queries (3+) with combined impressions > 1000

Multiple queries that could be answered by one comprehensive piece.

---

## Step 4: Score and Prioritize Opportunities

### Opportunity Score Formula
```
Score = (Impressions × Intent Match × Competition Factor) / Effort

Where:
- Impressions: Monthly GSC impressions
- Intent Match: 1.5 (perfect match), 1.0 (good), 0.5 (partial)
- Competition Factor: Based on current position (higher position = lower competition)
- Effort: 1 (blog post), 2 (landing page), 3 (comprehensive guide)
```

### Priority Matrix
```markdown
| Priority | Score | Action |
|----------|-------|--------|
| P1 - Create Now | >1000 | High impressions, clear intent, low effort |
| P2 - Plan Soon | 500-1000 | Good opportunity, moderate effort |
| P3 - Backlog | 100-500 | Worth doing when resources allow |
| P4 - Monitor | <100 | Track for growth, don't create yet |
```

---

## Step 5: Generate Content Briefs

For each P1 and P2 opportunity:

```markdown
## 📝 Content Brief: "[Primary Query]"

### Overview

| Attribute | Value |
|-----------|-------|
| Primary Keyword | [query] |
| Target Language/Region | [Language code or "All"] |
| Monthly Impressions | X |
| Current Position | X.X (with /wrong-page/) |
| Search Intent | Informational / Commercial / Transactional |
| Content Type | Blog Post / Landing Page / Guide |
| Priority Score | X |
| Estimated Impact | +X clicks/month |

---

### Target Keywords

| Keyword | Impressions | Position | Include In |
|---------|-------------|----------|------------|
| [primary] | X | X.X | Title, H1, First paragraph |
| [secondary] | X | X.X | H2, Body |
| [related] | X | X.X | H2, Body |

---

### Search Intent Analysis

**What the searcher wants:**
[Analysis of what someone searching this query is looking for]

**Current SERP features:**
- [ ] Featured snippet opportunity
- [ ] People Also Ask questions
- [ ] Video results
- [ ] Local pack

---

### Recommended Structure

**Content Type:** [Blog Post / Landing Page / etc.]

**Title Options:**
1. `[Title option 1 - <60 chars]`
2. `[Title option 2 - <60 chars]`

**Meta Description:**
`[Compelling meta description with CTA - <155 chars]`

**Outline:**

```markdown
# [H1 - Include primary keyword]

[Introduction - Hook + what they'll learn + include primary keyword naturally]

## [H2 - Address main question/topic]
[Section covering the primary intent]

## [H2 - Secondary keyword topic]
[Expand on related aspect]

## [H2 - Common questions / How to]
[Address "People Also Ask" style questions]

## [H2 - Next steps / CTA]
[Link to related products/services]
```

**Word Count Target:** X words (based on competing content)

---

### Internal Linking Strategy

**Link TO this new content from:**
| Page | Traffic | Anchor Text | Location |
|------|---------|-------------|----------|
| /[high-traffic-page]/ | X/month | [anchor] | In [section] |
| /[related-page]/ | X/month | [anchor] | In [section] |

**Link FROM this content to:**
| Target Page | Anchor Text | Purpose |
|-------------|-------------|---------|
| /products/[related]/ | [anchor] | Commercial conversion |
| /blog/[related]/ | [anchor] | Topic cluster |

---

### Content Collection Setup

**File Location:** `src/content/blog/[suggested-slug].md`

**Frontmatter Template:**
```yaml
---
title: "[Title]"
description: "[Meta description]"
pubDate: YYYY-MM-DD
author: "[Author]"
image:
  url: "/images/blog/[slug].jpg"
  alt: "[Alt text with keyword]"
tags: ["[tag1]", "[tag2]"]
---
```

**Based on your schema** (from astro-mcp):
[Adapt frontmatter to match existing content collection schema]

---

### Competitive Analysis

**Top 3 Ranking Pages:**
1. [competitor1.com/page] - X words, [key differentiator]
2. [competitor2.com/page] - X words, [key differentiator]
3. [competitor3.com/page] - X words, [key differentiator]

**Content Gaps in Competitors:**
- [ ] [Topic not covered well]
- [ ] [Angle you can take]
- [ ] [Unique value you can add]

---

### Success Metrics

| Metric | Target | Timeframe |
|--------|--------|-----------|
| Indexed | Yes | 1 week |
| Position | <20 | 1 month |
| Position | <10 | 3 months |
| Clicks | X/month | 3 months |

**Track with:** `/impact /blog/[slug]` after 14+ days
```

---

## Step 6: Present Content Gap Report

```markdown
## 📊 Content Gap Analysis Report

**Generated:** [Date]
**Data Period:** Last 90 days
**Language/Region:** [Selected language or "All"]
**Content Scope:** [All collections / Blog only / etc.]
**Gaps Identified:** X
**Total Opportunity:** +X impressions/month → ~X clicks/month

---

### 🎯 Executive Summary

| Priority | Opportunities | Est. Monthly Clicks | Content Effort |
|----------|---------------|---------------------|----------------|
| P1 - Create Now | X | +X | X hours |
| P2 - Plan Soon | X | +X | X hours |
| P3 - Backlog | X | +X | X hours |
| **Total** | **X** | **+X** | **X hours** |

---

### 🏆 Top 5 Content Opportunities

#### 1. "[Query]" - Priority Score: X

| Metric | Value |
|--------|-------|
| Impressions | X |
| Current Ranking | #X with /wrong-page/ |
| Intent | [Informational/Commercial] |
| Recommended | Blog Post |
| Est. Impact | +X clicks/month |

**Why This Matters:**
[Brief explanation of the opportunity]

**Quick Brief:**
- Title: `[Suggested title]`
- Type: Blog post in `src/content/blog/`
- Word count: ~X words
- Key angle: [Differentiator]

[Continue for top 5...]

---

### 📁 Content Calendar Suggestion

| Week | Content | Priority | Est. Hours |
|------|---------|----------|------------|
| 1 | [Title 1] | P1 | X |
| 2 | [Title 2] | P1 | X |
| 3 | [Title 3] | P2 | X |
| 4 | [Title 4] | P2 | X |

---

### 🔗 Topic Clusters Identified

**Cluster: [Topic]**
```
[Hub Page] (create or exists)
├── [Supporting Article 1] (exists: /blog/...)
├── [Supporting Article 2] (GAP - create)
├── [Supporting Article 3] (GAP - create)
└── [Supporting Article 4] (exists: /blog/...)
```

---

### ⚡ Quick Wins (Can Create Today)

These are short-form content pieces that address specific queries:

| Query | Type | Est. Time | Template |
|-------|------|-----------|----------|
| [query] | FAQ section | 30 min | Add to existing page |
| [query] | Short blog | 1 hour | Blog post |

---

## Next Steps

**Options:**

1. **"Brief [number]"** - Get full content brief for opportunity #X
2. **"Brief all P1"** - Get briefs for all P1 opportunities
3. **"Create [number]"** - I'll write the content for opportunity #X
4. **"Calendar"** - Export content calendar
5. **"Add to tracker"** - Create issues for each opportunity
6. **"Language [code]"** - Re-run analysis for different language (e.g., "Language de")
7. **"Collection [name]"** - Focus on specific content collection

What would you like to do?
```

---

## Step 7: Full Brief Generation

When user requests a specific brief:

```markdown
## Full Content Brief: "[Query]"

[Generate comprehensive brief using template from Step 5]

---

### Ready to Write?

**Options:**
1. **"Write it"** - I'll draft the full content
2. **"Outline only"** - Just the detailed outline
3. **"Export"** - Save brief to .planning/briefs/[slug].md
4. **"Back"** - Return to gap report

```

---

## Step 8: Content Creation (If Requested)

When user says "Write it" or "Create [number]":

```markdown
## Creating Content: "[Title]"

### Pre-Flight Check

- [ ] Content collection schema understood (via astro-mcp)
- [ ] Existing content reviewed for overlap
- [ ] Internal link targets identified
- [ ] Image requirements noted

### Writing Content...

**File:** `src/content/blog/[slug].md`

---
[Generated frontmatter matching schema]
---

[Generated content following the brief structure]

---

### Post-Creation Checklist

- [ ] Frontmatter valid for collection schema
- [ ] All links working
- [ ] Images referenced exist (or noted to create)
- [ ] Meta description < 155 chars
- [ ] Title < 60 chars

### Build Verification

Running `npm run build` to verify...

### Add Internal Links?

I found these opportunities to link to the new content:

| File | Add Link | Anchor Text |
|------|----------|-------------|
| src/pages/index.astro | In [section] | [anchor] |
| src/content/blog/[related].md | In [paragraph] | [anchor] |

Add these links? (yes/no/select)
```

---

## Data Source Priority

| Step | Priority 1: Database | Priority 2: MCP | Priority 3: File Scan |
|------|---------------------|-----------------|----------------------|
| Inventory | `collections`, `collection_entries`, `routes` tables | astro-mcp | Glob patterns |
| URL Mapping | `routes.route_pattern` → `routes.source_file` | list-astro-routes | File structure |
| Schema | `collections.schema_fields` | get-astro-config | Parse config.ts |

## MCP Usage Summary

| Step | Database | GSC MCP | astro-mcp | Astro Docs |
|------|----------|---------|-----------|------------|
| Inventory | ✅ Primary | - | Fallback | Collection patterns |
| Gap Query | - | Search analytics | - | - |
| Scoring | Route mapping | Impressions, position | Fallback | - |
| Brief | Collection schema | Query data | Fallback | Frontmatter best practices |
| Create | - | - | Collection schema | Content collection API |
| Verify | - | - | Build status | - |

---

## Fallback: No GSC Available

If GSC is not configured, offer alternative analysis:

```markdown
## Content Gap Analysis (Without GSC)

Since GSC isn't configured, I'll analyze gaps using:

### 1. Competitor Content Analysis
Using Brave Search to find what competitors cover that you don't.

### 2. Internal Gap Analysis
Comparing your sitemap/routes against common topic patterns.

### 3. Content Freshness Check
Finding outdated content that needs updating.

### 4. Topic Cluster Gaps
Analyzing your existing content for missing supporting articles.

**Proceed with competitor-based analysis?**
```
