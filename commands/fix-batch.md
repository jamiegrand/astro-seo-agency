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

---

## Step 2: Load Issue Queue

### From Issue Tracker

Calculate impact scores and sort:

```
Impact Score = (Affected Page Sessions × Severity) + (GSC Impressions × 0.1)
```

### Build Queue

```markdown
### 📋 Issue Queue (Top $1)

| # | Issue | Priority | Impact | Est. |
|---|-------|----------|--------|------|
| 1 | #XX: [Title] | High | XXX | 10m |
| 2 | #XX: [Title] | High | XXX | 15m |
| 3 | #XX: [Title] | Medium | XXX | 10m |
| 4 | #XX: [Title] | Medium | XXX | 20m |
| 5 | #XX: [Title] | Medium | XXX | 10m |

**Total Estimated Time:** ~65 minutes

---

**Start batch?** (yes/no/adjust)
- "yes" - Begin fixing all $1 issues
- "no" - Cancel
- "adjust" - Modify the queue
- "skip #XX" - Remove specific issue from queue
```

Wait for confirmation before proceeding.

---

## Step 3: Execute Batch

### For Each Issue in Queue:

```markdown
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## [1/$1] Issue #XX: [Title]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

#### 3.1 Quick Context Load
- Read affected files (minimal context)
- Identify the specific change needed
- NO lengthy analysis - batch mode is fast

#### 3.2 Implement Fix
- Make the change
- Keep it focused and minimal
- Match existing patterns

#### 3.3 Quick Verify

```bash
npm run astro check
```

If TypeScript fails:
- Attempt auto-fix (once)
- If still failing: **mark as skipped**, continue to next

#### 3.4 Commit

```bash
git add [specific files]
git commit -m "fix([scope]): [description]

Fixes: #[issue-number]
Batch: [N] of [Total]"
```

#### 3.5 Log Result

```markdown
✅ #XX: [Title] - Fixed in [X]s
   Files: [list]
   Commit: [short hash]
```

### Continue to Next Issue

No pause, no confirmation - move directly to next issue.

---

## Step 4: Handle Failures

### On TypeScript Error (Auto-Recoverable)

```markdown
⚠️ TypeScript error on #XX

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

**Batch paused.** Options:
1. "fix" - Let me fix the build error, then continue
2. "rollback" - Revert last commit, skip this issue
3. "stop" - End batch here (X issues completed)
```

### On Conflict/Complex Issue

```markdown
⏭️ Skipping #XX - Requires manual review

**Reason:** [Too complex for batch / Needs clarification / etc.]

Added to "manual review" list. Continuing...
```

---

## Step 5: Final Build Verification

After all issues processed:

```bash
npm run build
```

Must pass before completing batch.

---

## Step 6: Batch Summary

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

| Issue | Time | Commit |
|-------|------|--------|
| #XX: [Title] | Xs | `abc123` |
| #XX: [Title] | Xs | `def456` |
| #XX: [Title] | Xs | `ghi789` |

### Skipped Issues (Need Manual Review)

| Issue | Reason |
|-------|--------|
| #XX: [Title] | [reason] |

### Session Stats

| Metric | Value |
|--------|-------|
| Total Time | X minutes |
| Avg per Issue | X seconds |
| Commits Made | X |
| Files Changed | X |

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

## Step 7: Update Tracker

For each fixed issue, update tracker:
- Mark as complete
- Add commit reference
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

---

## Comparison: `/fix-next` vs `/fix-batch`

| Feature | `/fix-next` | `/fix-batch` |
|---------|-------------|--------------|
| Issues per run | 1 | 5+ |
| Confirmation | After each step | Only at start |
| Context depth | Full analysis | Quick scan |
| Best for | Complex issues | Similar/simple issues |
| Speed | ~15 min/issue | ~3-5 min/issue |
