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
- Type of change (SEO, bug, feature, etc.)
```

### If Page Path Provided
```
Find recent changes to $1
Check git log for the page
Determine change date
```

### If Neither
```markdown
## What Would You Like to Measure?

**Recent Completed Issues:**
| # | Title | Completed | Days Ago |
|---|-------|-----------|----------|
| X | [Title] | [Date] | X |
| X | [Title] | [Date] | X |
| X | [Title] | [Date] | X |

**Recently Modified Pages:**
| Page | Last Modified | Changes |
|------|---------------|---------|
| /path/ | [Date] | [Description] |

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

## Step 3: Query Analytics Data

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

## Step 4: Calculate Changes

```python
def calculate_change(before, after):
    if before == 0:
        return "N/A (no baseline)"
    change = ((after - before) / before) * 100
    return f"+{change:.1f}%" if change > 0 else f"{change:.1f}%"
```

---

## Step 5: Assess Statistical Significance

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

## Step 6: Generate Impact Report

```markdown
## 📊 Impact Report

### Change Details

| Field | Value |
|-------|-------|
| Issue/Change | #$1 - [Title] |
| Type | [SEO/Bug/Feature/Performance] |
| Implemented | [Date] |
| Days Measured | [X] |
| Pages Affected | [X] |

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
| [query] | X.X | X.X | ↓ X |

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

### 📝 Update Tracker

Add this measurement to the issue record:

```markdown
**Impact Measured** ([Date], [X]-day comparison)
- Sessions: [Before] → [After] (+X%)
- Bounce: [Before] → [After] (-X%)
- GSC Clicks: [Before] → [After] (+X%)
- GSC Position: [Before] → [After] (-X.X)
- Assessment: 🟢 POSITIVE
- Confidence: [High/Medium/Low]
```

---

### 🔄 Next Steps

**Based on this data:**

[If positive:]
1. ✅ Document this as a successful pattern
2. 🔄 Apply similar changes to related pages
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

## Step 7: Handle Negative Results

```markdown
## ⚠️ Negative Impact Detected

The change appears to have had a negative effect on [metrics].

### Investigation

**Potential Causes:**
1. [Hypothesis 1]
2. [Hypothesis 2]
3. [External factor]

### Recommended Actions

| Option | Description | Risk |
|--------|-------------|------|
| **Rollback** | Revert the change | Low - returns to known state |
| **Iterate** | Modify the implementation | Medium - may improve or worsen |
| **Wait** | Collect more data | Low - may recover naturally |

### Rollback Instructions

```bash
# Find the commit
git log --oneline | grep "[issue reference]"

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

## Step 8: Aggregate View (Optional)

```markdown
## 📈 Cumulative Impact (All Measured Changes)

### Last 30 Days

| Category | Changes | Avg Impact | Total Sessions |
|----------|---------|------------|----------------|
| SEO | X | +X% | +X sessions |
| Bug Fixes | X | +X% | +X sessions |
| Features | X | +X% | +X sessions |
| Performance | X | +X% | +X sessions |

**Total Estimated Monthly Impact:** +[X] sessions

### Top Performing Changes

| Change | Impact | ROI |
|--------|--------|-----|
| [Change 1] | +X% | High |
| [Change 2] | +X% | High |
| [Change 3] | +X% | Medium |

### Lessons Learned

- [Pattern that works]
- [Pattern that doesn't work]
- [Recommendation for future]
```
