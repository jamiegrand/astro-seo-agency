---
description: Find SEO quick wins from Google Search Console data
---

# SEO Quick Wins Finder

## Prerequisites

Requires Google Search Console MCP to be configured.
If not available, will provide guidance on manual GSC analysis.

---

## Step 1: Query GSC Data

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

To use this command fully, configure the GSC MCP server:

```bash
claude mcp add gsc -- npx -y mcp-server-gsc
```

**In the meantime, I can:**
1. Analyze your content for SEO issues
2. Check schema markup
3. Review internal linking
4. Audit meta tags

Would you like me to do a content-based SEO audit instead?
```

---

## Step 2: Categorize Opportunities

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

## Step 3: Analyze Each Opportunity

For top 5 opportunities in each category:

### Current State
```markdown
| Query | Position | Impressions | Clicks | CTR | Page |
|-------|----------|-------------|--------|-----|------|
| [query] | X.X | X | X | X% | /path/ |
```

### Page Analysis

Read the current page and check:
- Title tag (current vs optimal)
- Meta description (current vs optimal)
- H1 heading
- Content relevance to query
- Word count
- Internal links TO this page
- Schema markup

### Competitor Context (If Brave Search Available)
```
Search: [query]
Analyze: What's ranking #1-3?
Compare: What are they doing differently?
```

---

## Step 4: Generate Recommendations

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

**Current Title:** 
`[current title]`

**Suggested Title:**
`[optimized title with query, <60 chars]`

**Current Meta:**
`[current meta description]`

**Suggested Meta:**
`[optimized meta with query and CTA, <155 chars]`

**Additional Recommendations:**
- [Add query to H1 if not present]
- [Add internal links from high-traffic pages]
- [Update content to better match intent]

**Estimated Impact:** +[X] clicks/month
**Effort:** ~15 minutes

---

#### 2. "[Query]"
[Repeat format]

---

### 🍎 Category B: Low Hanging Fruit (Page 2)

These pages are close to page 1. Small improvements = big traffic gains.

#### 1. "[Query]"

| Metric | Value |
|--------|-------|
| Position | X.X (need <10) |
| Impressions | X |
| Clicks | X |
| Page | /path/ |

**Ranking Gap Analysis:**
- Current position: X.X
- Target position: <10 (page 1)
- Needed improvement: X positions

**Recommendations:**
1. **Add internal links** from these high-traffic pages:
   - /[page1]/ (X sessions/month)
   - /[page2]/ (X sessions/month)
   
2. **Expand content:**
   - Current word count: X
   - Add section about: [subtopic]
   - Target word count: X

3. **Improve on-page SEO:**
   - [Specific recommendation]

**Estimated Impact:** +[X] clicks/month (position 15→8 = ~5x traffic)
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
**Problem:** Page doesn't target this query specifically

**Recommendation: Create Dedicated Page**

```markdown
**Suggested URL:** /[suggested-slug]/
**Suggested Title:** [Title targeting query]
**Suggested H1:** [H1 targeting query]

**Content Outline:**
1. [Section 1 - address primary intent]
2. [Section 2 - supporting information]
3. [Section 3 - related topics]
4. [FAQ section]
5. [CTA]

**Internal Links From:**
- /[high-traffic-page-1]/
- /[high-traffic-page-2]/

**Schema Markup:**
- [Appropriate schema type]
```

**Estimated Impact:** +[X] clicks/month
**Effort:** ~2-3 hours

---

### 📉 Category D: Declining Queries

These were performing well but have dropped. Investigate and recover.

#### 1. "[Query]" - Position Dropped X → Y

| Metric | Current | Previous | Change |
|--------|---------|----------|--------|
| Position | Y | X | ⬇️ +Z |
| Clicks | X | X | ⬇️ -X% |
| Impressions | X | X | [trend] |

**Potential Causes:**
- [ ] Content became outdated
- [ ] Competitor published better content
- [ ] Technical issue (check indexing)
- [ ] Algorithm update impact

**Investigation Steps:**
1. Check page in Google Search Console for issues
2. Search query manually - what's now ranking above you?
3. Check if content is still accurate/relevant

**Recovery Recommendations:**
- [Specific recommendations based on analysis]

---

## 🚀 Action Plan

### This Week (Quick Wins - 2 hours total)

| Task | Query | Impact | Time |
|------|-------|--------|------|
| Update title/meta | [query 1] | +X clicks | 15m |
| Update title/meta | [query 2] | +X clicks | 15m |
| Add internal links | [page] | +X clicks | 30m |
| [Task] | [query] | +X clicks | Xm |

**Total estimated impact:** +[X] clicks/month

### Next Week (Medium Effort - 4 hours)

| Task | Impact | Time |
|------|--------|------|
| Create new page for [gap] | +X clicks | 2h |
| Expand content on [page] | +X clicks | 1h |
| Fix declining [query] | +X clicks | 1h |

### Ongoing

- Monitor position changes weekly
- Update content quarterly
- Build internal links continuously

---

## 📋 Add to Tracker?

Would you like me to add these as issues?

**Options:**
1. **"Add all"** - Create issues for all opportunities
2. **"Add quick wins"** - Just Category A items
3. **"Add [number]"** - Specific items only
4. **"No"** - Just keep this report

Issues will be created with:
- Priority based on impact
- Labels: `seo`, `quick-win`
- Linked pages and queries
```

---

## Step 5: Implementation Support

If user wants to implement immediately:

```markdown
## Let's Implement: [Selected Item]

### Current File
Reading [file path]...

### Proposed Changes

**Title Tag:**
```html
<!-- Before -->
<title>[current]</title>

<!-- After -->
<title>[new]</title>
```

**Meta Description:**
```html
<!-- Before -->
<meta name="description" content="[current]">

<!-- After -->
<meta name="description" content="[new]">
```

Apply these changes? (yes/no)
```
