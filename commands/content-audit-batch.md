---
description: Batch audit multiple pages with priority ranking
argument-hint: "[collection|pages] [--limit N]"
---

# Batch Content Audit

Audit multiple pages at once and rank them by priority. Useful for quarterly content reviews or auditing an entire content collection.

---

## Prerequisites

**Required:**
- Content collection name OR list of page paths

**Optional:**
- GSC MCP for performance-based prioritization
- DataForSEO for keyword difficulty data

---

## Parameters

| Parameter | Default | Description |
|-----------|---------|-------------|
| Collection | - | Astro content collection name (e.g., `blog`) |
| `--limit` | 20 | Maximum pages to audit |
| `--sort` | `priority` | Sort by: priority, score, impressions, date |
| `--min-score` | 0 | Only show pages below this score |

---

## Step 1: Gather Pages to Audit

### Option A: By Content Collection

```markdown
### 📁 Collection: blog

**Location:** `src/content/blog/`
**Total Pages:** X

| # | File | URL | Published |
|---|------|-----|-----------|
| 1 | seo-guide.md | /blog/seo-guide | 2024-01-15 |
| 2 | content-tips.md | /blog/content-tips | 2024-02-20 |
| 3 | ... | ... | ... |

**Limiting to first [limit] pages.**
```

### Option B: By Page List

```markdown
### 📄 Pages to Audit

| # | Path | URL |
|---|------|-----|
| 1 | src/content/blog/seo-guide.md | /blog/seo-guide |
| 2 | src/pages/services.astro | /services |
| 3 | src/data/products.js → widget | /products/widget |
```

---

## Step 2: Run Quick Audit on Each Page

For each page, run the 10-point quick audit:

```markdown
### ⏳ Auditing Pages...

[1/X] /blog/seo-guide... ✓ Score: 7/10
[2/X] /blog/content-tips... ✓ Score: 5/10
[3/X] /blog/keyword-research... ✓ Score: 8/10
[4/X] /services... ✓ Score: 6/10
...

**Completed:** X pages audited
**Average Score:** X.X/10
```

---

## Step 3: Enrich with GSC Data (If Available)

```markdown
### 📊 Adding GSC Performance Data

| Page | Clicks | Impressions | CTR | Position |
|------|--------|-------------|-----|----------|
| /blog/seo-guide | 150 | 3000 | 5.0% | 4.2 |
| /blog/content-tips | 45 | 2500 | 1.8% | 8.5 |
| /services | 200 | 1500 | 13.3% | 2.1 |
```

---

## Step 4: Calculate Priority Score

Priority considers both audit quality AND business impact:

```markdown
### 🎯 Priority Calculation

**Formula:**
Priority = (10 - Audit Score) × Impact Multiplier

**Impact Multiplier:**
- High impressions (>1000): 2.0x
- Medium impressions (100-1000): 1.5x
- Low impressions (<100): 1.0x
- Position 4-10 bonus: +1.0x
- CTR below expected: +0.5x

**Example:**
- Page: /blog/content-tips
- Audit Score: 5/10 → Improvement potential: 5
- Impressions: 2500 → Multiplier: 2.0x
- Position: 8.5 → Bonus: +1.0x
- Priority: 5 × 2.0 + 1.0 = **11.0**
```

---

## Step 5: Generate Priority Matrix

```markdown
## 📋 Batch Audit Results

**Collection:** [name]
**Pages Audited:** X
**Date:** [date]

---

### Priority Matrix

| Priority | Page | Score | Impressions | Position | Issue | Effort |
|----------|------|-------|-------------|----------|-------|--------|
| 🔴 1 | /blog/content-tips | 5/10 | 2,500 | 8.5 | Low CTR, thin content | Medium |
| 🔴 2 | /blog/old-post | 4/10 | 1,800 | 12.3 | Outdated, no author | High |
| 🟡 3 | /services | 6/10 | 1,500 | 2.1 | Missing E-E-A-T | Low |
| 🟡 4 | /blog/seo-guide | 7/10 | 3,000 | 4.2 | Minor fixes | Low |
| 🟢 5 | /blog/keyword-research | 8/10 | 800 | 3.5 | Good shape | - |

**Legend:**
- 🔴 Critical (score ≤5 AND high impressions)
- 🟡 Important (score ≤7 OR opportunity)
- 🟢 Good (score ≥8)

---

### Score Distribution

| Score Range | Count | % of Total |
|-------------|-------|------------|
| 9-10 (Excellent) | X | X% |
| 7-8 (Good) | X | X% |
| 5-6 (Fair) | X | X% |
| 3-4 (Poor) | X | X% |
| 0-2 (Critical) | X | X% |

---

### Quick Stats

| Metric | Value |
|--------|-------|
| Average Score | X.X/10 |
| Lowest Score | X/10 ([page]) |
| Highest Score | X/10 ([page]) |
| Pages Needing Work (≤6) | X |
| Potential Traffic Gain | +X clicks/month |
```

---

## Step 6: Issue Summary

```markdown
### 📊 Common Issues Across All Pages

| Issue | Count | Pages Affected |
|-------|-------|----------------|
| Missing author byline | X | 40% |
| No internal links | X | 35% |
| Title too long | X | 25% |
| Missing meta description | X | 20% |
| No alt text on images | X | 15% |

**Systemic Issues to Address:**
1. **Author bylines** - Add to [X] pages, consider layout component update
2. **Internal linking** - Build topic clusters, add related posts component
3. **Meta descriptions** - Generate from content if missing
```

---

## Step 7: Recommended Action Plan

```markdown
### 🚀 Recommended Action Plan

#### This Week (Quick Wins)
Pages that just need title/meta fixes:

| Page | Fix | Est. Time |
|------|-----|-----------|
| /blog/[slug] | Update title | 10 min |
| /blog/[slug] | Add meta description | 10 min |

#### Next 2 Weeks (Medium Effort)
Pages with content gaps:

| Page | Actions Needed | Est. Time |
|------|----------------|-----------|
| /blog/content-tips | Add 500 words, include FAQ | 2 hours |
| /services | Add author, testimonials | 1 hour |

#### This Month (Major Updates)
Pages needing significant refresh:

| Page | Actions Needed | Est. Time |
|------|----------------|-----------|
| /blog/old-post | Full rewrite, new research | 4 hours |
```

---

## Step 8: Save Batch Results

Store all audits in database:

```sql
-- Insert each audit
INSERT INTO audits (page_path, audit_type, overall_score, ...)
VALUES
  ('/blog/seo-guide', 'batch', 70, ...),
  ('/blog/content-tips', 'batch', 50, ...),
  ...;

-- Update content inventory
INSERT OR REPLACE INTO content_inventory (
  page_path, content_type, collection_name, last_audited, latest_score
) VALUES ...;
```

---

## Step 9: Offer Actions

```markdown
### What would you like to do?

1. **"Full audit [page]"** - Deep dive on top priority page
2. **"Fix quick wins"** - Apply title/meta fixes across pages
3. **"Export report"** - Save to .planning/batch-audit-[date].md
4. **"Compare to last batch"** - Show score changes since last audit
5. **"Focus on [issue]"** - Fix specific issue across all pages
```

---

## Example Usage

```bash
# Audit entire blog collection
/content-audit-batch blog

# Audit with limit
/content-audit-batch blog --limit 10

# Audit specific pages
/content-audit-batch "/blog/post-1, /blog/post-2, /services"

# Only show pages needing work
/content-audit-batch blog --min-score 6

# Sort by impressions (highest opportunity first)
/content-audit-batch blog --sort impressions
```

---

## Quarterly Review Workflow

```markdown
### Quarterly Content Audit Process

1. **Week 1:** Run `/content-audit-batch [collection]` for all collections
2. **Week 2:** Full audit on top 5 priority pages
3. **Week 3:** Implement fixes on priority pages
4. **Week 4:** Fix systemic issues (missing bylines, etc.)
5. **Month 2:** Monitor GSC for improvements
6. **Month 3:** Re-audit improved pages, celebrate wins
```
