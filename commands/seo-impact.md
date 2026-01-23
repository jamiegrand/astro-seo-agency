---
argument-hint: "[issue-number or page-path]"
description: Measure before/after impact of changes
---

# Impact Measurement: $1

## Step 1: Identify What to Measure

### If Issue Number Provided
```
Read issue #$1 from tracker
Extract:
- Completion date
- Affected pages
- Affected files (source locations)
- Type of change (SEO, bug, feature, Astro, etc.)
```

### If Page Path Provided
```
Find recent changes to $1
Use astro-mcp to map URL to source file
Check git log for the source file
Determine change date
```

### Map URL to Source File (via astro-mcp)

```markdown
### 🗺️ URL to Source Mapping

| URL | Source File | Type |
|-----|-------------|------|
| $1 | [file path] | [collection/data/page] |

**Git History for Source:**
```
[git log for source file]
```
```

### If Neither Provided
```markdown
## What Would You Like to Measure?

**Recent Completed Issues:**
| # | Title | Completed | Days Ago | Files Changed |
|---|-------|-----------|----------|---------------|
| X | [Title] | [Date] | X | [files] |
| X | [Title] | [Date] | X | [files] |

**Recently Modified Content (via astro-mcp + git):**
| Page | Source File | Last Modified | Changes |
|------|-------------|---------------|---------|
| /path/ | src/content/... | [Date] | [Description] |
| /path/ | src/data/... | [Date] | [Description] |

Select an issue number or page path to measure.
```

---

## Step 2: Determine Measurement Periods

```
Change Date: [DATE]
Days Since Change: [X]

Before Period: [DATE - 30 days] to [DATE - 1 day]
After Period: [DATE + 1 day] to [Today or DATE + 30 days]
```

### Validity Check

```markdown
### ⏰ Measurement Timing

| Check | Status |
|-------|--------|
| Days since change | X days |
| Minimum recommended | 14 days |
| Optimal measurement | 30 days |

[If < 14 days:]
⚠️ **Early Measurement Warning**

Only [X] days have passed since this change. Results may not be statistically significant.

**Options:**
1. **Proceed anyway** - See preliminary data
2. **Wait** - Come back in [14-X] days
3. **Set reminder** - I'll note to measure on [date]

What would you like to do?
```

---

## Step 3: Gather Change Context (via astro-mcp)

```markdown
### 📝 Change Details

**Issue/Change:** $1
**Completion Date:** [date]
**Type:** [SEO/Content/Astro/Bug/Feature]

#### Files Changed
| File | Change Type | Description |
|------|-------------|-------------|
| [src/content/...] | Modified | Updated title/meta |
| [src/data/...] | Modified | Added description |
| [src/pages/...] | Created | New page |

#### Routes Affected
| Route | Type | Sessions/Month |
|-------|------|----------------|
| /[path]/ | [static/dynamic] | X |

#### Change Summary
[What was changed and why]
```

---

## Step 4: Query Analytics Data

### Google Analytics

**Before Period:**
```
Metrics for affected pages:
- Sessions
- Users
- Bounce rate
- Avg. session duration
- Conversions (if tracked)
```

**After Period:**
```
Same metrics for comparison
```

### Google Search Console (For SEO Changes)

**Before Period:**
```
- Impressions
- Clicks
- CTR
- Average position
```

**After Period:**
```
Same metrics for comparison
```

---

## Step 5: Calculate Changes

```python
def calculate_change(before, after):
    if before == 0:
        return "N/A (no baseline)"
    change = ((after - before) / before) * 100
    return f"+{change:.1f}%" if change > 0 else f"{change:.1f}%"
```

---

## Step 6: Assess Statistical Significance

```markdown
### Statistical Context

| Factor | Value | Assessment |
|--------|-------|------------|
| Sample size (before) | X sessions | [Sufficient/Limited] |
| Sample size (after) | X sessions | [Sufficient/Limited] |
| Measurement period | X days | [Sufficient/Too short] |
| Site-wide trend | +/-X% | [Normalized in calculations] |

**Confidence Level:** [High/Medium/Low]

[If low confidence:]
⚠️ Results should be interpreted with caution due to [reason].
```

---

## Step 7: Generate Impact Report

```markdown
## 📊 Impact Report

### Change Details

| Field | Value |
|-------|-------|
| Issue/Change | #$1 - [Title] |
| Type | [SEO/Bug/Feature/Astro] |
| Implemented | [Date] |
| Days Measured | [X] |
| Pages Affected | [X] |

#### Source Files Changed
| File | Change |
|------|--------|
| `[path]` | [description] |

---

### 📈 Traffic Impact (Google Analytics)

| Metric | Before | After | Change | Assessment |
|--------|--------|-------|--------|------------|
| Sessions | X | X | +X% | ✅ Positive |
| Users | X | X | +X% | ✅ Positive |
| Bounce Rate | X% | X% | -X% | ✅ Improved |
| Avg Duration | X:XX | X:XX | +X% | ✅ Improved |
| Pageviews | X | X | +X% | ✅ Positive |

**Traffic Verdict:** 🟢 POSITIVE / 🟡 NEUTRAL / 🔴 NEGATIVE

#### Visualization
```
Sessions:  Before [████████░░] X
           After  [██████████████] X  (+X%)

Bounce:    Before [████████░░] X%
           After  [██████░░░░] X%  (-X% ✅)
```

---

### 🔍 SEO Impact (Google Search Console)

| Metric | Before | After | Change | Assessment |
|--------|--------|-------|--------|------------|
| Impressions | X | X | +X% | ✅ More visible |
| Clicks | X | X | +X% | ✅ More traffic |
| CTR | X% | X% | +X% | ✅ Better CTR |
| Avg Position | X.X | X.X | -X.X | ✅ Ranking up |

**SEO Verdict:** 🟢 POSITIVE / 🟡 NEUTRAL / 🔴 NEGATIVE

#### Top Queries Affected

| Query | Pos Before | Pos After | Change |
|-------|------------|-----------|--------|
| [query] | X.X | X.X | ↑ X |
| [query] | X.X | X.X | ↑ X |

---

### 🌐 Context & Normalization

**Site-Wide Trends (Same Period):**
| Metric | Site Change | Page Change | Normalized |
|--------|-------------|-------------|------------|
| Sessions | +X% | +X% | +X% |
| Bounce | -X% | -X% | -X% |

*Normalized = Page change adjusted for site-wide trends*

**External Factors:**
- [ ] Seasonality: [Normal/High/Low season]
- [ ] Holidays: [None/Affected by X]
- [ ] Marketing: [No campaigns/Campaign running]
- [ ] Algorithm: [No known updates/Possible update]

---

### 🎯 Overall Assessment

## Impact: 🟢 POSITIVE

**Summary:**
[One paragraph explaining the overall impact of the change]

**Key Wins:**
- [Win 1]
- [Win 2]

**Concerns:**
- [Any negative metrics or caveats]

---

### 📊 ROI Calculation

**Time Invested:** [X] hours
**Monthly Traffic Change:** +[X] sessions

**Annualized Impact:**
- Additional sessions/year: +[X × 12]
- If conversion rate is 2%: +[X] conversions/year
- If average order value is $Y: +$[Z] revenue potential

**Verdict:** [Worth it / Marginal / Not worth it]

---

### 📝 Update Records

**Add to Issue Tracker:**
```markdown
**Impact Measured** ([Date], [X]-day comparison)
- Sessions: [Before] → [After] (+X%)
- Bounce: [Before] → [After] (-X%)
- GSC Clicks: [Before] → [After] (+X%)
- GSC Position: [Before] → [After] (-X.X)
- Assessment: 🟢 POSITIVE
- Confidence: [High/Medium/Low]
```

**Files Reference:**
| File | Impact |
|------|--------|
| `[path]` | [measured impact] |

---

### 🔄 Next Steps

**Based on this data:**

[If positive:]
1. ✅ Document this as a successful pattern
2. 🔄 Apply similar changes to related content:
   - `[similar file 1]`
   - `[similar file 2]`
3. 📅 Re-measure in 30 more days for long-term trend

[If neutral:]
1. 🔍 Investigate why impact was limited
2. 🧪 Consider A/B testing alternative approaches
3. ⏳ Allow more time before final judgment

[If negative:]
1. 🔴 Investigate root cause
2. ↩️ Consider rollback: `git revert [commit]`
3. 🔧 Try alternative approach
```

---

## Step 8: Handle Negative Results

```markdown
## ⚠️ Negative Impact Detected

The change appears to have had a negative effect on [metrics].

### Investigation

**File Changed:** `[path from astro-mcp]`

**Potential Causes:**
1. [Hypothesis 1]
2. [Hypothesis 2]
3. [External factor]

### Astro-Specific Check
[If Astro-related change, search docs for issues]

**Astro Docs says:**
[Relevant guidance if applicable]

### Recommended Actions

| Option | Description | Risk |
|--------|-------------|------|
| **Rollback** | Revert the change | Low |
| **Iterate** | Modify the implementation | Medium |
| **Wait** | Collect more data | Low |

### Rollback Instructions

```bash
# Find the commit that changed [file]
git log --oneline [file path]

# Revert it
git revert [commit-hash]

# Verify build
npm run build

# Deploy
[deployment command]
```

What would you like to do?
```

---

## Step 9: Find Similar Content to Optimize

If impact was positive, suggest applying same changes elsewhere:

```markdown
## 🎯 Apply Winning Pattern

This change worked! Here are similar files that could benefit:

### Similar Content (via astro-mcp)

| File | Current State | Potential |
|------|---------------|-----------|
| `src/content/blog/[similar1].md` | Missing meta | +X clicks |
| `src/content/blog/[similar2].md` | Weak title | +X clicks |
| `src/data/products.js` → [item] | No description | +X clicks |

**Apply pattern to these?**
- "Apply all" - Update all similar files
- "Apply [file]" - Update specific file
- "Show details" - See current vs suggested for each
```

---

## MCP Usage Summary

| Step | Astro Docs MCP | astro-mcp |
|------|----------------|-----------|
| Identify | - | Map URL to source file |
| Context | - | List affected routes/files |
| Analysis | - | - |
| Negative results | Check for issues | - |
| Apply pattern | - | Find similar content |
