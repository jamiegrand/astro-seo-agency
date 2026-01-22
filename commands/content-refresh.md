---
description: Find declining pages that need content refresh via GSC data
argument-hint: "[--days 90] [--threshold 20]"
---

# Content Refresh Finder

Uses Google Search Console data to identify pages that need attention:
- **Declining pages** - Traffic dropped significantly
- **CTR opportunities** - High impressions, low clicks
- **Striking distance** - Position 4-10, could reach top 3

---

## Prerequisites

**Required:**
- GSC MCP configured and connected

**Optional:**
- ScraperAPI for competitor comparison
- DataForSEO for SERP feature analysis

---

## Parameters

| Parameter | Default | Description |
|-----------|---------|-------------|
| `--days` | 90 | Comparison period (days to look back) |
| `--threshold` | 20 | Minimum % decline to flag |
| `--min-impressions` | 100 | Minimum impressions to consider |

---

## Step 1: Query GSC Comparison Data

Compare current period to previous period:

```markdown
### 📊 Data Collection

**Periods:**
- Current: [date] to [date] (last 28 days)
- Previous: [date] to [date] (prior 28 days)

**Query Parameters:**
- Dimensions: page
- Metrics: clicks, impressions, ctr, position
- Filter: impressions > [min-impressions]
```

Using GSC MCP `compare_search_periods`:
- Get page-level metrics for both periods
- Calculate changes in clicks, impressions, CTR, position

---

## Step 2: Categorize Opportunities

### Category A: Declining Pages 📉

**Criteria:** Click drop > [threshold]% vs previous period

```markdown
### 📉 Declining Pages (Need Refresh)

Found X pages with significant traffic decline.

| Page | Clicks (Now) | Clicks (Prev) | Change | Position |
|------|--------------|---------------|--------|----------|
| /blog/[slug] | X | X | -X% | X.X |
| /[page] | X | X | -X% | X.X |
| /[page] | X | X | -X% | X.X |
```

### Category B: CTR Opportunities 👁️

**Criteria:** Impressions > 500, CTR < 2%

```markdown
### 👁️ CTR Opportunities (Title/Meta Fix)

High visibility, low clicks - title/meta optimization needed.

| Page | Impressions | CTR | Position | Expected CTR |
|------|-------------|-----|----------|--------------|
| /blog/[slug] | X | X% | X.X | ~X% |
| /[page] | X | X% | X.X | ~X% |

**Expected CTR by Position:**
- Position 1: 25-35%
- Position 2: 15-20%
- Position 3: 10-15%
- Position 4-10: 3-8%
```

### Category C: Striking Distance 🎯

**Criteria:** Position 4-10 with decent impressions

```markdown
### 🎯 Striking Distance (Almost Page 1 Top)

Small improvements could yield big traffic gains.

| Page | Position | Impressions | Clicks | Potential |
|------|----------|-------------|--------|-----------|
| /blog/[slug] | 5.2 | X | X | +X% clicks |
| /[page] | 7.8 | X | X | +X% clicks |

**Potential Calculation:**
- Current CTR at position 5: ~5%
- Target CTR at position 2: ~18%
- Potential increase: ~260%
```

---

## Step 3: Map to Source Files

For each identified page, map URL to source file:

```markdown
### 🗺️ Source File Mapping

| URL | Source File | Type | Last Modified |
|-----|-------------|------|---------------|
| /blog/[slug] | `src/content/blog/[slug].md` | Collection | [date] |
| /products/[id] | `src/data/products.js` → [id] | Data | [date] |
| /[page] | `src/pages/[page].astro` | Page | [date] |
```

---

## Step 4: Diagnose Each Page

For top candidates, provide quick diagnosis:

```markdown
### 🔍 Page Analysis

#### 1. /blog/[slug] (-45% clicks)

**Source:** `src/content/blog/[slug].md`

**Quick Diagnosis:**
| Check | Status |
|-------|--------|
| Last updated | X months ago ⚠️ |
| Word count | X words |
| Competitor avg | X words |
| Missing sections | [topics] |

**Likely Causes:**
- [ ] Content became outdated
- [ ] Competitors published better content
- [ ] Search intent shifted
- [ ] Technical issue (check indexing)

**Refresh Recommendations:**
1. Update statistics and examples to [current year]
2. Add section about [missing topic from competitors]
3. Update publish date after refresh
4. Add [X] more internal links

**Estimated Effort:** [Low/Medium/High]
**Estimated Impact:** Recover +X clicks/month
```

---

## Step 5: Competitor Comparison (Optional)

If ScraperAPI available, compare declining pages to current top rankers:

```markdown
### 🏆 Competitor Analysis: /blog/[slug]

**Your page vs top 3 currently ranking:**

| Metric | Your Page | Rank #1 | Rank #2 | Rank #3 |
|--------|-----------|---------|---------|---------|
| Word Count | X | X | X | X |
| Last Updated | [date] | [date] | [date] | [date] |
| H2 Sections | X | X | X | X |
| Images | X | X | X | X |
| FAQ Section | ❌ | ✅ | ✅ | ❌ |

**What changed in SERP:**
- New competitor [domain] appeared at #2
- Top result added comprehensive FAQ
- SERP now shows video carousel

**Gap to Close:**
1. Add FAQ section (competitors have it)
2. Increase word count by ~X words
3. Add [topic] section
```

---

## Step 6: Generate Priority Report

```markdown
## 📋 Content Refresh Report

**Generated:** [date]
**Period:** Last [X] days vs prior [X] days
**Threshold:** [X]% decline

---

### Summary

| Category | Count | Total Lost Clicks | Priority |
|----------|-------|-------------------|----------|
| 📉 Declining | X | -X clicks | High |
| 👁️ CTR Issues | X | ~X potential | Medium |
| 🎯 Striking Distance | X | ~X potential | Medium |

---

### Priority Refresh Queue

| Priority | Page | Issue | Source File | Est. Impact |
|----------|------|-------|-------------|-------------|
| 1 | /blog/[slug] | -45% clicks | `src/content/...` | +X clicks |
| 2 | /[page] | 1.2% CTR | `src/content/...` | +X clicks |
| 3 | /[page] | Pos 5.2 | `src/content/...` | +X clicks |

---

### Quick Wins (< 30 min each)

These pages just need title/meta updates:

| Page | Current Title | Suggested Title | CTR Potential |
|------|---------------|-----------------|---------------|
| /[page] | "[current]" | "[optimized]" | +X% |
| /[page] | "[current]" | "[optimized]" | +X% |

---

### Major Refreshes (1-2 hours each)

These pages need content updates:

| Page | Main Issue | Recommended Actions |
|------|------------|---------------------|
| /blog/[slug] | Outdated | Update stats, add FAQ, expand [section] |
| /[page] | Thin content | Add X words, cover [topics] |

```

---

## Step 7: Save GSC Snapshot

Store current performance for future comparison:

```sql
INSERT INTO gsc_snapshots (
  page_path, url, clicks, impressions, ctr, position,
  period_start, period_end
) VALUES (...);
```

---

## Step 8: Offer Actions

```markdown
### What would you like to do?

1. **"Audit [page]"** - Run full /content-audit on a specific page
2. **"Refresh [page]"** - Start editing a specific page
3. **"Apply quick wins"** - Update titles/metas for CTR pages
4. **"Export report"** - Save to .planning/refresh-[date].md
5. **"Schedule refresh"** - Add to content calendar
```

---

## Example Usage

```bash
# Default: 90 days, 20% threshold
/content-refresh

# Custom parameters
/content-refresh --days 60 --threshold 15

# Only declining pages with high impressions
/content-refresh --min-impressions 500
```

---

## Automation Suggestion

Run `/content-refresh` monthly as part of your content maintenance:

```markdown
### Monthly Content Maintenance

**Week 1:** Run /content-refresh to identify candidates
**Week 2:** Full audit on top 3 declining pages
**Week 3:** Implement refreshes
**Week 4:** Monitor for recovery in GSC
```
