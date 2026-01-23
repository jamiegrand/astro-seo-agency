---
description: View audit score history and trends for a page
argument-hint: "[page-path]"
---

# Content History - Audit Trends

View historical audit data for a page to track improvements over time, correlate with GSC performance changes, and measure the impact of optimizations.

---

## Prerequisites

- Page path or URL
- SQLite database with previous audits (`.planning/seo-audit.db`)

---

## Step 1: Query Audit History

```sql
SELECT
  created_at,
  audit_type,
  overall_score,
  onpage_score,
  eeat_score,
  content_score,
  ai_overview_score,
  linking_score,
  multimedia_score
FROM audits
WHERE page_path = '[page-path]'
ORDER BY created_at DESC
LIMIT 20;
```

---

## Step 2: Display History

```markdown
## 📈 Audit History: [page-path]

**Total Audits:** X
**First Audit:** [date]
**Latest Audit:** [date]

---

### Score Timeline

| Date | Type | Score | Change | On-Page | E-E-A-T | Content | AI | Links | Media |
|------|------|-------|--------|---------|---------|---------|----|----|-----|
| [date] | full | 78 | - | 16 | 18 | 16 | 12 | 8 | 8 |
| [date] | full | 72 | +6 | 15 | 16 | 14 | 12 | 7 | 8 |
| [date] | quick | 65 | +7 | - | - | - | - | - | - |
| [date] | full | 58 | +7 | 12 | 14 | 12 | 8 | 6 | 6 |

---

### Score Trend

```
100 |
 90 |
 80 |     ●───────●
 70 |   ●
 60 | ●
 50 |
    +──────────────────
     Jan  Feb  Mar  Apr
```

**Trend:** ↑ Improving (+20 points over 4 audits)
```

---

## Step 3: Category Breakdown Over Time

```markdown
### Category Trends

#### On-Page SEO (0-20)
```
20 |         ●───●
15 |     ●───●
12 | ●───●
   +──────────────
    Jan Feb Mar Apr
```
**Trend:** ↑ +4 points (major title/meta improvements)

#### E-E-A-T (0-25)
```
25 |
20 |         ●───●
16 |     ●───●
14 | ●───●
   +──────────────
    Jan Feb Mar Apr
```
**Trend:** ↑ +4 points (added author byline)

#### Content Quality (0-20)
```
20 |             ●
16 |         ●───●
12 | ●───●───●
   +──────────────
    Jan Feb Mar Apr
```
**Trend:** ↑ +4 points (expanded content)
```

---

## Step 4: Correlate with GSC Performance

If GSC snapshots are available:

```markdown
### 📊 GSC Performance Correlation

| Period | Audit Score | Clicks | Impressions | Position |
|--------|-------------|--------|-------------|----------|
| Jan | 58 | 45 | 800 | 12.3 |
| Feb | 65 | 52 | 950 | 10.1 |
| Mar | 72 | 78 | 1200 | 7.8 |
| Apr | 78 | 120 | 1500 | 5.2 |

**Correlation Analysis:**
- Score improved: +20 points (34%)
- Clicks improved: +75 (167%)
- Position improved: +7.1 positions

**Insight:** Content improvements correlated with significant ranking gains.
```

---

## Step 5: Identify What Changed

```markdown
### 🔍 Change Analysis

**Between Jan (58) → Apr (78):**

| Change Made | Score Impact | GSC Impact |
|-------------|--------------|------------|
| Added author byline | +4 E-E-A-T | +0.5 positions |
| Rewrote title/meta | +4 On-Page | +15 clicks (CTR) |
| Added 800 words | +4 Content | +2 positions |
| Added internal links | +2 Links | +200 impressions |
| Added FAQ section | +4 AI Overview | Unknown |

**Most Impactful Changes:**
1. Content expansion (+800 words) → Position improvement
2. Title/meta optimization → CTR improvement
3. Author byline → Trust signals
```

---

## Step 6: Show Issue Resolution

```markdown
### ✅ Issues Fixed Over Time

| Issue | First Flagged | Fixed Date | Impact |
|-------|---------------|------------|--------|
| Missing meta description | Jan 15 | Jan 22 | +15% CTR |
| No author byline | Jan 15 | Feb 10 | +4 E-E-A-T |
| Thin content (<1000 words) | Jan 15 | Mar 05 | +2 positions |
| Missing internal links | Feb 20 | Mar 15 | +200 impressions |

### ⚠️ Recurring Issues

| Issue | Times Flagged | Status |
|-------|---------------|--------|
| Images missing alt text | 3 | Still open |
| No FAQ section | 2 | Fixed in Apr |
```

---

## Step 7: Compare to Site Average

```markdown
### 📊 Comparison to Site Average

| Metric | This Page | Site Average | Status |
|--------|-----------|--------------|--------|
| Current Score | 78 | 65 | Above avg |
| Score Growth | +34% | +12% | Outperforming |
| Time to 70+ | 2 months | 4 months | Fast improvement |

**Ranking:** #3 of 25 blog posts (by current score)
```

---

## Step 8: Predictions & Recommendations

```markdown
### 🎯 Next Steps

Based on historical trends and current gaps:

**To reach 85/100 (Excellent):**
1. Add original images (+2 Multimedia) - Est. +3 points
2. Add comparison table (+2 AI Overview) - Est. +2 points
3. Add 2 more external citations (+2 Authority) - Est. +2 points

**Projected Impact:**
- Score: 78 → 85
- Position: 5.2 → ~3.5 (based on correlation)
- Clicks: +50-80/month

**Timeline:**
- Implement in 2 weeks
- Expect ranking impact in 4-6 weeks
```

---

## Output Format

```markdown
## 📈 Content History Report

**Page:** `[path]`
**URL:** /[url]
**Generated:** [date]

---

### Summary

| Metric | Value |
|--------|-------|
| First Audited | [date] |
| Total Audits | X |
| Starting Score | X |
| Current Score | X |
| Improvement | +X points (+X%) |

### Score Progression
[Visual timeline]

### Key Improvements Made
[List of changes and their impact]

### Remaining Issues
[List of unfixed issues]

### Next Actions
[Recommendations to continue improvement]
```

---

## Example Usage

```bash
# View history for a blog post
/content-history /blog/seo-guide

# View history by file path
/content-history src/content/blog/seo-guide.md
```

---

## No History Available

If no previous audits exist:

```markdown
### 📈 Content History: [page-path]

**No audit history found for this page.**

This is the first time this page is being tracked.

**To build history:**
1. Run `/content-audit [page]` to create first audit
2. Make improvements based on recommendations
3. Re-run audit in 2-4 weeks
4. Use `/content-history` to track progress

**Recommended cadence:**
- High-priority pages: Audit monthly
- Standard pages: Audit quarterly
- Low-traffic pages: Audit biannually
```
