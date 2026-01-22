---
description: Find content opportunities from GSC data and generate briefs
---

# Content Gap Finder

Analyzes Google Search Console data to identify high-impression queries without dedicated content, then generates content briefs for the best opportunities.

## Prerequisites

- Google Search Console MCP configured (recommended)
- astro-mcp for project structure awareness
- Astro Docs MCP for content collection best practices

---

## Step 1: Analyze Current Content Structure

**Query astro-mcp for existing content:**

```markdown
### 📁 Current Content Inventory

#### Content Collections
| Collection | Location | Count | Schema Fields |
|------------|----------|-------|---------------|
| blog | src/content/blog/ | X | title, description, pubDate, ... |
| products | src/content/products/ | X | name, price, ... |

#### Static Pages
| Path | Source File | Purpose |
|------|-------------|---------|
| / | src/pages/index.astro | Homepage |
| /about | src/pages/about.astro | About page |

#### Dynamic Routes
| Pattern | Source | Generates |
|---------|--------|-----------|
| /blog/[slug] | src/pages/blog/[slug].astro | Blog posts |
| /products/[id] | src/pages/products/[id].astro | Product pages |

**Total Indexable URLs:** X
```

---

## Step 2: Query GSC for Content Gaps

### GSC Query Parameters
```
Dimensions: query
Metrics: clicks, impressions, ctr, position
Filter: impressions > 100
Sort: impressions DESC
Rows: 500
Period: Last 90 days
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

## MCP Usage Summary

| Step | GSC MCP | astro-mcp | Astro Docs |
|------|---------|-----------|------------|
| Inventory | - | Content structure | Collection patterns |
| Gap Query | Search analytics | - | - |
| Scoring | Impressions, position | Route mapping | - |
| Brief | Query data | Schema fields | Frontmatter best practices |
| Create | - | Collection schema | Content collection API |
| Verify | - | Build status | - |

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
