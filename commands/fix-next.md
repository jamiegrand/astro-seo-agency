---
description: Automatically fix the highest-priority issue
---

# Fix Next Priority Issue

## Step 1: Identify Highest Priority

### From Analytics Data (If Available)
Calculate impact scores for all open issues:

```
Impact Score = (Affected Page Sessions × Severity) + (GSC Impressions × 0.1)

Severity multipliers:
- Critical (breaks functionality): 10
- High (major UX/SEO issue): 7
- Medium (noticeable issue): 4
- Low (minor improvement): 2
```

### From Issue Tracker

**If GitHub Issues:**
```
Query: is:open sort:priority
Labels to check: priority:critical, priority:high, priority:medium
```

**If Markdown Tracker:**
```
Read AUDIT_TRACKER.md
Find first incomplete issue in current phase
```

### Selection Logic
```
1. Any critical issues? → Fix first critical
2. Any high + quick win (< 30 min)? → Fix quick win
3. Highest impact score → Fix that
```

## Step 2: Load Issue Context

For the selected issue, gather:

```markdown
## Selected Issue

**ID:** #[number]
**Title:** [title]
**Priority:** [Critical/High/Medium/Low]
**Impact Score:** [calculated]
**Type:** [SEO/Bug/Feature/A11y/Perf]
**Estimated Time:** [X] minutes

### Description
[Full issue description]

### Affected Files
- [file1]
- [file2]

### Affected Pages
- [URL1] - [X sessions/month]
- [URL2] - [X sessions/month]
```

## Step 3: Read Architecture Context

1. **Read AI-INFO.md** for:
   - Relevant architecture section
   - Technology constraints
   - Coding patterns to follow

2. **Read affected files** completely:
   - Understand current implementation
   - Note patterns to preserve
   - Identify dependencies

3. **Read similar files** if creating new code:
   - Find reference implementations
   - Copy patterns exactly

## Step 4: Plan Implementation

```markdown
## Implementation Plan: [Issue Title]

### Summary
[One sentence: what we're fixing and why]

### Root Cause
[Why this issue exists]

### Solution
[How we'll fix it]

### Files to Modify
| File | Change Type | Description |
|------|-------------|-------------|
| [path] | Modify | [what changes] |
| [path] | Create | [new file purpose] |

### Steps
1. [First change]
2. [Second change]
3. [Verification step]

### Risk Assessment
- **Risk Level:** Low/Medium/High
- **Potential Side Effects:** [list or "None expected"]
- **Rollback Plan:** `git revert HEAD`

### Estimated Time
[X] minutes

---

**Proceed with implementation?** (yes/no/modify)
```

Wait for confirmation before proceeding.

## Step 5: Implement Fix

### 5.1 Pre-Implementation Snapshot
```bash
git status  # Ensure clean state
```

### 5.2 Make Changes

For each file:
1. Read the file completely
2. Make the specific change
3. Preserve all existing patterns
4. Add comments if logic is complex

**Implementation Rules:**
- Match existing code style exactly
- Don't "improve" unrelated code
- Keep changes minimal and focused
- Test each change mentally before applying

### 5.3 Quality Gate

```bash
# Must pass before continuing
npm run astro check
```

If TypeScript errors:
```markdown
⚠️ **TypeScript Error**

```
[error output]
```

**Diagnosing...**
[explanation of error]

**Fix:**
[what needs to change]

Applying fix...
```

Then re-run check.

### 5.4 Build Verification

```bash
npm run build
```

If build fails:
- Read error carefully
- Diagnose root cause
- Fix and rebuild
- Only proceed when passing

## Step 6: Verify Fix

```markdown
## Verification Checklist

### Automated
- [x] TypeScript compiles
- [x] Build succeeds

### Manual Verification
Please verify:
1. Run `npm run dev`
2. Visit: [affected URLs]
3. Check: [specific things to verify]

**Test Steps:**
1. [Step 1]
2. [Step 2]
3. [Expected result]

### Regression Check
- [ ] Related pages still work
- [ ] No console errors
- [ ] No visual regressions
```

## Step 7: Commit Changes

```bash
git add [specific files only]
git commit -m "[type]([scope]): [description]

[body explaining what and why]

Fixes: #[issue-number]
Impact: [X sessions/month affected]"
```

**Commit Message Format:**
```
fix(seo): add missing alt text to product images

- Added alt attributes to all ProductCard images
- Alt text now uses product name and category
- Improves accessibility and SEO

Fixes: #15
Impact: 2,400 sessions/month on product pages
```

## Step 8: Update Tracker

### If GitHub Issues:
```
Add comment:
"Fixed in commit [hash]. 

Changes made:
- [change 1]
- [change 2]

Verified: Build passes, tested locally."

Close issue with label: completed
```

### If Markdown Tracker:
```markdown
### [✅] Issue #[X]: [Title]
- **Status:** Complete
- **Solution:** [What was done]
- **Files Modified:** [List]
- **Commit:** [hash]
- **Completed:** [Date]
- **Measure Impact:** /impact [X] in 14 days
```

## Step 9: Report Completion

```markdown
## ✅ Issue Fixed: [Title]

### Summary
[One sentence describing what was fixed]

### Changes Made
| File | Change |
|------|--------|
| [file] | [description] |

### Verification
- [x] TypeScript: Pass
- [x] Build: Pass
- [x] Manual test: [result]

### Commit
`[hash]` - [message]

### Impact Tracking
This fix affects [X] sessions/month.
Run `/impact [issue-number]` in 14 days to measure effect.

---

### What's Next?

| Priority | Task | Impact | Command |
|----------|------|--------|---------|
| 1 | [Next issue] | [score] | `/fix-next` |
| 2 | [Following] | [score] | - |
| 3 | [Following] | [score] | - |

**Continue?**
- `/fix-next` - Fix the next priority
- `/start` - Refresh priorities
- `/pause` - Save and exit
- `/status` - See full status
```

## Step 10: Self-Annealing

If the fix revealed something new:

```markdown
## 💡 Learning Captured

During this fix, I discovered:
- [Insight about the codebase]
- [Pattern that should be documented]
- [Potential future issue]

**Updating documentation...**
[If appropriate, update AI-INFO.md or create new issue]
```

---

## Error Recovery

### If Implementation Fails

```markdown
## ❌ Implementation Issue

**Problem:** [Description]

**Options:**
1. **Retry** - Try a different approach
2. **Skip** - Move to next issue, come back later
3. **Escalate** - Need human input

What would you like to do?
```

### If Verification Fails

```markdown
## ⚠️ Verification Failed

**Expected:** [What should happen]
**Actual:** [What happened]

**Diagnosis:**
[What might be wrong]

**Options:**
1. **Debug** - Investigate further
2. **Rollback** - `git checkout -- [files]`
3. **Partial commit** - Commit working parts only
```

### If Build Breaks

```bash
# Rollback changes
git checkout -- .

# Report
```

```markdown
## 🔴 Build Broken - Rolled Back

The changes caused build failures that couldn't be resolved.

**Error:**
```
[error output]
```

**Analysis:**
[Why it failed]

**Recommendation:**
[What to do instead]

This issue may need:
- [ ] More investigation
- [ ] Different approach
- [ ] Human input

Moving to next issue...
```
