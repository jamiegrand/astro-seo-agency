---
description: Initialize work session with data-driven priorities
---

# Session Start

## Step 1: Load Project Context

Read these files in order:
1. `CLAUDE.md` - Project configuration
2. `.planning/HANDOFF.md` - If exists, offer to resume
3. `AI-INFO.md` - Architecture reference (if exists)

If HANDOFF.md exists:
```
Found saved session from [DATE].
Resume where you left off? (yes/no)
→ If yes: Run /resume instead
→ If no: Archive handoff, start fresh
```

## Step 2: Query Analytics (If Configured)

### Google Analytics (Last 7 Days)
```
Metrics needed:
- Total sessions + trend vs previous 7 days
- Total users + trend
- Bounce rate + trend
- Top 10 pages by sessions
- Pages with bounce rate > 70%
```

### Google Search Console (Last 7 Days)
```
Metrics needed:
- Total impressions, clicks, avg CTR, avg position
- Top 10 queries by impressions
- Quick wins: position 4-15, impressions > 100, CTR < 3%
- Any queries with position drop > 3 vs previous period
```

## Step 3: Check Issue Tracker

### If GitHub Issues configured:
```
Query open issues with labels:
- priority:critical (count)
- priority:high (count)  
- priority:medium (count)

Get details of top 5 by priority.
```

### If Markdown Tracker:
```
Read AUDIT_TRACKER.md (or similar)
Count incomplete issues by phase
List next 5 issues in current phase
```

## Step 4: Calculate Priority Scores

For each open issue:
```
If issue affects specific pages:
  Impact = (Page Monthly Sessions × Severity) + (Page GSC Impressions × 0.1)
  
If issue is site-wide:
  Impact = (Total Monthly Sessions × Severity × 0.5)
  
If SEO-related:
  Add bonus: GSC Impressions for affected queries × 0.2
```

## Step 5: Detect Quick Wins

Find issues that are:
- High impact (score > 50)
- Low effort (estimated < 30 min)
- No dependencies

## Step 6: Generate Session Report

```markdown
## 🚀 Session Start: [DATE]

### 📊 Traffic Overview (7 days)
| Metric | Value | vs Last Week |
|--------|-------|--------------|
| Sessions | X | ↑/↓ X% |
| Users | X | ↑/↓ X% |
| Bounce Rate | X% | ↑/↓ X% |
| Avg Position | X.X | ↑/↓ X |

### 🎯 Quick Wins from GSC
Keywords you almost rank for:
1. "[query]" - Pos X.X, X impressions → Optimize [page]
2. "[query]" - Pos X.X, X impressions → Optimize [page]

### 🔧 Today's Priorities (by Impact Score)
| # | Task | Impact | Est. | Type |
|---|------|--------|------|------|
| 1 | [Task] | X | Xh | [SEO/Bug/Feature] |
| 2 | [Task] | X | Xh | [SEO/Bug/Feature] |
| 3 | [Task] | X | Xh | [SEO/Bug/Feature] |

### ⚡ Quick Wins Available
- [ ] [Task] - 15 min - Impact: X
- [ ] [Task] - 20 min - Impact: X

### ⚠️ Attention Needed
- [Any traffic anomalies]
- [Declining rankings]
- [Build/deploy issues]

---

### 💡 Recommended Focus

Based on [time available / priorities], I recommend:

**Option A (2 hours):** Fix issues #X, #Y, #Z
Combined impact: X monthly sessions improved

**Option B (Quick wins):** Complete all quick wins
Time: ~45 min, Impact: X sessions

**Option C (Feature work):** Start on [pending feature]
Use: `/feature "[description]"`

---

Ready to work? Commands:
- `/fix-next` - Start on #1 priority
- `/seo-wins` - Deep dive into GSC opportunities
- `/feature "desc"` - Build something new
```

## Step 7: Set Session State

Create/update `.planning/SESSION.md`:
```markdown
# Active Session
Started: [TIMESTAMP]
Focus: [Recommended focus from above]
Completed: []
```
