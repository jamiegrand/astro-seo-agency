---
argument-hint: "[count]"
description: Fix multiple issues in sequence without stopping
---

# Fix Batch Issues

Fix multiple issues in one session without confirmation prompts between each.

**Default:** 5 issues
**Usage:** `/fix-batch` or `/fix-batch 10`

---

## Step 1: Setup Batch

```markdown
## 🚀 Batch Fix Mode

**Target:** $1 issues (default: 5)
**Mode:** Continuous (stops only on errors)

### Pre-flight Checks
- [ ] Git status clean
- [ ] Build passing
- [ ] Issues identified
- [ ] Astro MCP available (optional but recommended)
```

### Verify Clean State

```bash
git status --porcelain
```

If dirty:
```markdown
⚠️ **Uncommitted changes detected**

Batch mode requires a clean git state. Options:
1. Commit current changes first
2. Stash changes: `git stash`
3. Abort batch

Please resolve before continuing.
```

### Verify Build

```bash
npm run build
```

If failing, stop and fix build first.

### Check Astro MCP Availability (NEW)

```markdown
### 🔌 MCP Status

| Server | Status |
|--------|--------|
| Astro Docs MCP | ✅/❌ |
| astro-mcp (project) | ✅/❌ |

[If available:]
✅ Will consult Astro docs for best practices during fixes

[If not available:]
ℹ️ Continuing without MCP - using training knowledge only
```

---

## Step 2: Load Issue Queue

### From Issue Tracker

Calculate impact scores and sort:

```
Impact Score = (Affected Page Sessions × Severity) + (GSC Impressions × 0.1)
```

### Categorize by Type (NEW)

```markdown
### Issue Categories

| Type | Count | MCP Helpful |
|------|-------|-------------|
| Astro/Code | X | ✅ Will consult docs |
| SEO/Meta | X | ✅ Will consult docs |
| Content | X | - |
| Styling | X | - |
```

### Build Queue

```markdown
### 📋 Issue Queue (Top $1)

| # | Issue | Priority | Impact | Est. | Type |
|---|-------|----------|--------|------|------|
| 1 | #XX: [Title] | High | XXX | 10m | Astro |
| 2 | #XX: [Title] | High | XXX | 15m | SEO |
| 3 | #XX: [Title] | Medium | XXX | 10m | Content |
| 4 | #XX: [Title] | Medium | XXX | 20m | Astro |
| 5 | #XX: [Title] | Medium | XXX | 10m | Styling |

**Total Estimated Time:** ~65 minutes
**Astro-related issues:** X (will consult docs)

---

**Start batch?** (yes/no/adjust)
- "yes" - Begin fixing all $1 issues
- "no" - Cancel
- "adjust" - Modify the queue
- "skip #XX" - Remove specific issue from queue
```

Wait for confirmation before proceeding.

---

## Step 3: Pre-Batch Astro Docs Lookup (NEW)

**For efficiency, batch-query common topics before starting:**

```markdown
### 📚 Pre-Loading Astro Guidance

Based on issue types in queue, searching:
- [x] "astro image optimization" (for issues #X, #Y)
- [x] "astro meta tags seo" (for issue #Z)
- [x] "astro content collections" (for issue #W)

**Cached for batch use:**
- Image pattern: Use `<Image>` from `astro:assets`
- Meta pattern: Use `<meta>` in Layout head
- Content pattern: Use `getCollection()` API
```

This prevents repeated doc lookups during batch execution.

---

## Step 4: Execute Batch

### For Each Issue in Queue:

```markdown
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## [1/$1] Issue #XX: [Title]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

#### 4.1 Quick Context Load
- Read affected files (minimal context)
- Identify the specific change needed
- **Check pre-loaded Astro guidance if applicable**
- NO lengthy analysis - batch mode is fast

#### 4.2 Astro Docs Check (Quick)

For Astro-related issues only:
```markdown
**Astro Pattern:** [from pre-loaded or quick search]
```

#### 4.3 Implement Fix
- Make the change
- Keep it focused and minimal
- **Use verified Astro patterns from docs**
- Match existing patterns

#### 4.4 Quick Verify

```bash
npm run astro check
```

If TypeScript fails:
- Attempt auto-fix (once)
- **Quick doc search if Astro-related error**
- If still failing: **mark as skipped**, continue to next

#### 4.5 Commit

```bash
git add [specific files]
git commit -m "fix([scope]): [description]

Fixes: #[issue-number]
Batch: [N] of [Total]"
```

#### 4.6 Log Result

```markdown
✅ #XX: [Title] - Fixed in [X]s
   Files: [list]
   Commit: [short hash]
   Astro docs: [used/not needed]
```

### Continue to Next Issue

No pause, no confirmation - move directly to next issue.

---

## Step 5: Handle Failures

### On TypeScript Error (Auto-Recoverable)

```markdown
⚠️ TypeScript error on #XX

[If Astro-related:]
Searching Astro docs for solution...
[Quick search result]

Attempting auto-fix...
[If fixed] ✅ Recovered, continuing
[If not]   ⏭️ Skipped #XX, continuing to next
```

### On Build Error (Stop Batch)

```markdown
🔴 Build failed after #XX

**Error:**
```
[error output]
```

[If Astro error:]
**Astro Docs says:**
[Quick search for error]

**Batch paused.** Options:
1. "fix" - Let me fix the build error, then continue
2. "rollback" - Revert last commit, skip this issue
3. "stop" - End batch here (X issues completed)
```

### On Conflict/Complex Issue

```markdown
⏭️ Skipping #XX - Requires manual review

**Reason:** [Too complex for batch / Needs clarification / Needs deeper Astro docs research]

Added to "manual review" list. Continuing...
```

---

## Step 6: Final Build Verification

After all issues processed:

```bash
npm run build
```

Must pass before completing batch.

### Route Verification (NEW - if astro-mcp available)

```markdown
### Route Check (via astro-mcp)

| Check | Status |
|-------|--------|
| All routes present | ✅ |
| No new conflicts | ✅ |
| Build output valid | ✅ |
```

---

## Step 7: Batch Summary

```markdown
## ✅ Batch Complete

### Results

| Status | Count |
|--------|-------|
| ✅ Fixed | X |
| ⏭️ Skipped | X |
| ❌ Failed | X |
| **Total** | $1 |

### Fixed Issues

| Issue | Time | Commit | Astro Docs |
|-------|------|--------|------------|
| #XX: [Title] | Xs | `abc123` | ✅ Used |
| #XX: [Title] | Xs | `def456` | - |
| #XX: [Title] | Xs | `ghi789` | ✅ Used |

### Skipped Issues (Need Manual Review)

| Issue | Reason | Suggestion |
|-------|--------|------------|
| #XX: [Title] | [reason] | Use `/fix-next` for deeper analysis |

### Session Stats

| Metric | Value |
|--------|-------|
| Total Time | X minutes |
| Avg per Issue | X seconds |
| Commits Made | X |
| Files Changed | X |
| Astro Docs Consulted | X times |

---

### 🎯 Next Steps

**Remaining issues:** X

Options:
- `/fix-batch` - Fix next batch
- `/fix-next` - Fix one issue manually (good for skipped items)
- `/status` - See full project status
- `/pause` - Save and exit

### Build Status
✅ Final build passing - Safe to deploy
```

---

## Step 8: Update Tracker

For each fixed issue, update tracker:
- Mark as complete
- Add commit reference
- Note if Astro docs were consulted
- Note batch completion

---

## Batch Modes

### Standard (Default)
```
/fix-batch
```
- Fixes 5 issues
- Skips on complexity
- Stops on build failure
- Consults Astro docs for relevant issues

### Extended
```
/fix-batch 10
```
- Fixes up to 10 issues
- Same rules apply

### Aggressive (Use Carefully)
```
/fix-batch all
```
- Attempts ALL open issues
- Will skip complex ones
- Good for clearing simple issues

---

## Safety Features

1. **Clean git required** - Won't start with uncommitted changes
2. **Build verification** - Checks build after each issue
3. **Auto-skip complex** - Doesn't get stuck on hard issues
4. **Atomic commits** - Each issue = one commit (easy rollback)
5. **Final build check** - Ensures everything works at end
6. **Astro docs pre-load** - Efficient batch lookup (NEW)
7. **Route verification** - Confirms no broken routes (NEW)

---

## MCP Usage in Batch Mode

| Step | Astro Docs MCP | astro-mcp |
|------|----------------|-----------|
| Setup | - | Check availability |
| Pre-load | Batch search common topics | - |
| Per issue | Quick pattern lookup | - |
| Errors | Search for solutions | - |
| Final | - | Verify routes |

**Efficiency:** Batch mode pre-loads common Astro patterns to avoid repeated lookups.

---

## Comparison: `/fix-next` vs `/fix-batch`

| Feature | `/fix-next` | `/fix-batch` |
|---------|-------------|--------------|
| Issues per run | 1 | 5+ |
| Confirmation | After each step | Only at start |
| Context depth | Full analysis | Quick scan |
| Astro docs | Deep search | Pre-loaded patterns |
| Best for | Complex issues | Similar/simple issues |
| Speed | ~10-15 min/issue | ~3-5 min/issue |
