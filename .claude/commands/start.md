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

---

## Step 2: Query Astro Project State (via astro-mcp)

If the dev server is running, query the astro-mcp integration:

### Get Project Configuration
Use `get-astro-config` tool:

```markdown
### ⚙️ Astro Project Status

| Setting | Value |
|---------|-------|
| Astro Version | [version] |
| Output Mode | [static/server/hybrid] |
| Site URL | [configured or not set] |
| Integrations | [count] active |

#### Active Integrations
| Integration | Status |
|-------------|--------|
| [name] | ✅ Configured |
| [name] | ✅ Configured |
```

### Get Route Summary
Use `list-astro-routes` tool:

```markdown
### 🗺️ Route Summary

| Type | Count |
|------|-------|
| Static Pages | X |
| Dynamic Routes | X |
| API Endpoints | X |
| **Total** | **X** |
```

### Check for Astro Issues
Search Astro docs for any deprecation warnings based on detected patterns:

```markdown
### ⚠️ Astro Best Practice Alerts

[If any found:]
1. **[Pattern]** - [Current recommendation from docs]
2. **[Pattern]** - [Current recommendation from docs]

[If none:]
✅ No deprecated patterns detected
```

---

## Step 3: Query Analytics (If Configured)

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

---

## Step 4: Check Issue Tracker

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

---

## Step 5: Calculate Priority Scores

For each open issue:
```
If issue affects specific pages:
  Impact = (Page Monthly Sessions × Severity) + (Page GSC Impressions × 0.1)
  
If issue is site-wide:
  Impact = (Total Monthly Sessions × Severity × 0.5)
  
If SEO-related:
  Add bonus: GSC Impressions for affected queries × 0.2

If Astro-specific (detected via astro-mcp):
  Add bonus: Affects X routes × 10
```

---

## Step 6: Detect Quick Wins

Find issues that are:
- High impact (score > 50)
- Low effort (estimated < 30 min)
- No dependencies

**Astro-Enhanced Quick Wins:**
- Deprecated API usage (from docs search)
- Missing image optimization (from config check)
- Unoptimized routes (from route analysis)

---

## Step 7: Generate Session Report

```markdown
## 🚀 Session Start: [DATE]

### ⚙️ Project Health
| Check | Status |
|-------|--------|
| Astro Version | [version] ✅/⚠️ |
| Output Mode | [static/server/hybrid] |
| Integrations | [X] active |
| Routes | [X] total |
| Dev Server | 🟢 Running / 🔴 Stopped |

[If Astro issues detected:]
### ⚠️ Astro Alerts
- [Alert with recommendation from docs]

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
| 1 | [Task] | X | Xh | [SEO/Bug/Feature/Astro] |
| 2 | [Task] | X | Xh | [SEO/Bug/Feature/Astro] |
| 3 | [Task] | X | Xh | [SEO/Bug/Feature/Astro] |

### ⚡ Quick Wins Available
- [ ] [Task] - 15 min - Impact: X
- [ ] [Task] - 20 min - Impact: X

### ⚠️ Attention Needed
- [Any traffic anomalies]
- [Declining rankings]
- [Build/deploy issues]
- [Astro deprecation warnings]

---

### 💡 Recommended Focus

Based on [time available / priorities], I recommend:

**Option A (2 hours):** Fix issues #X, #Y, #Z
Combined impact: X monthly sessions improved

**Option B (Quick wins):** Complete all quick wins
Time: ~45 min, Impact: X sessions

**Option C (Feature work):** Start on [pending feature]
Use: `/feature "[description]"`

**Option D (Astro updates):** Address Astro alerts
Use: `/fix-next` (will auto-consult Astro docs)

---

Ready to work? Commands:
- `/fix-next` - Start on #1 priority (with Astro docs consultation)
- `/seo-wins` - Deep dive into GSC opportunities
- `/feature "desc"` - Build something new
- `/astro-check` - Full Astro project report
```

---

## Step 8: Set Session State

Create/update `.planning/SESSION.md`:
```markdown
# Active Session
Started: [TIMESTAMP]
Focus: [Recommended focus from above]
Completed: []
Astro MCP: [Active/Inactive]
Astro Version: [version]
```

---

## MCP Integration Notes

### If astro-mcp is not available:

```markdown
### ℹ️ Astro MCP Not Active

The dev server isn't running, so I can't query project state directly.

To enable:
1. Run `npm run dev` in another terminal
2. Run `/start` again

Or continue without it - analytics and issue tracking still work.
```

### If Astro Docs MCP is available:

Always search for any Astro-specific warnings or updates that might affect the project:

```
Search: "breaking changes astro [detected version]"
Search: "deprecated [detected pattern]"
```
