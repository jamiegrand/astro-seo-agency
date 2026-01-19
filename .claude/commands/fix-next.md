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

---

## Step 2: Load Issue Context

For the selected issue, gather:

```markdown
## Selected Issue

**ID:** #[number]
**Title:** [title]
**Priority:** [Critical/High/Medium/Low]
**Impact Score:** [calculated]
**Type:** [SEO/Bug/Feature/A11y/Perf/Astro]
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

---

## Step 3: Consult Astro Documentation (NEW)

**Before any implementation, always search the Astro Docs MCP for relevant guidance.**

### Determine Search Queries

Based on the issue type, search for:

| Issue Type | Search Queries |
|------------|----------------|
| Component issue | "astro components [specific topic]" |
| Routing issue | "astro routing [specific topic]" |
| Image issue | "astro image optimization" |
| Content issue | "astro content collections" |
| SSR issue | "astro server-side rendering" |
| Performance | "astro performance optimization" |
| SEO | "astro seo meta tags" |
| Build error | "astro [error message]" |

### Search Results Template

```markdown
## 📚 Astro Docs Consultation

**Searched:** "[query]"

### Current Best Practice (Astro [version])
[Relevant documentation excerpt]

### Recommended Pattern
```astro
[Code example from docs]
```

### Common Pitfalls
- [Pitfall 1 from docs]
- [Pitfall 2 from docs]

### Related Documentation
- [Link/topic 1]
- [Link/topic 2]
```

---

## Step 4: Query Project State (via astro-mcp)

If the dev server is running, gather project context:

### Get Affected Routes

Use `list-astro-routes` to understand scope:

```markdown
### 🗺️ Affected Routes

| Route | Type | File | Impact |
|-------|------|------|--------|
| /blog/[slug] | dynamic | src/pages/blog/[slug].astro | 15 pages |
| /products | static | src/pages/products/index.astro | 1 page |
```

### Get Project Config

Use `get-astro-config` to understand constraints:

```markdown
### ⚙️ Relevant Configuration

| Setting | Value | Affects Fix |
|---------|-------|-------------|
| Output mode | static | No SSR APIs available |
| Image service | sharp | Can use all transforms |
| TypeScript | strict | Must satisfy types |
```

### Check Integration Compatibility

Use `get-integration-docs` for any relevant integrations:

```markdown
### 🔌 Related Integrations

**@astrojs/image** (if image issue)
- Current config: [settings]
- Relevant options: [options]
```

---

## Step 5: Read Architecture Context

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

---

## Step 6: Plan Implementation

```markdown
## Implementation Plan: [Issue Title]

### Summary
[One sentence: what we're fixing and why]

### Astro Docs Guidance
[Key recommendation from docs consultation]

### Root Cause
[Why this issue exists]

### Solution
[How we'll fix it, following Astro best practices]

### Files to Modify
| File | Change Type | Description |
|------|-------------|-------------|
| [path] | Modify | [what changes] |
| [path] | Create | [new file purpose] |

### Routes Affected
| Route | Pages | Verification |
|-------|-------|--------------|
| [route] | [count] | [how to verify] |

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

---

## Step 7: Implement Fix

### 7.1 Pre-Implementation Snapshot
```bash
git status  # Ensure clean state
```

### 7.2 Make Changes

For each file:
1. Read the file completely
2. Make the specific change
3. **Follow patterns from Astro docs consultation**
4. Preserve all existing patterns
5. Add comments if logic is complex

**Implementation Rules:**
- Match existing code style exactly
- Don't "improve" unrelated code
- Keep changes minimal and focused
- **Use current Astro APIs from docs, not training data**
- Test each change mentally before applying

### 7.3 Quality Gate

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

**Consulting Astro Docs for solution...**
[Search for error message]

**Fix based on docs:**
[Solution from documentation]

Applying fix...
```

Then re-run check.

### 7.4 Build Verification

```bash
npm run build
```

If build fails:
- **Search Astro docs for the error**
- Read error carefully
- Diagnose root cause
- Fix and rebuild
- Only proceed when passing

---

## Step 8: Verify Fix

### Automated Verification
```markdown
## Verification Checklist

### Automated
- [x] TypeScript compiles
- [x] Build succeeds

### Route Verification (via astro-mcp)
[Query list-astro-routes to verify affected routes still exist]
- [x] All affected routes present
- [x] No new route conflicts
```

### Manual Verification
```markdown
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

---

## Step 9: Commit Changes

```bash
git add [specific files only]
git commit -m "[type]([scope]): [description]

[body explaining what and why]

Astro docs consulted: [topic searched]
Fixes: #[issue-number]
Impact: [X sessions/month affected]"
```

**Commit Message Format:**
```
fix(seo): add missing alt text to product images

- Added alt attributes to all ProductCard images
- Alt text now uses product name and category
- Follows Astro image optimization best practices

Astro docs: image optimization, astro:assets
Fixes: #15
Impact: 2,400 sessions/month on product pages
```

---

## Step 10: Update Tracker

### If GitHub Issues:
```
Add comment:
"Fixed in commit [hash]. 

Changes made:
- [change 1]
- [change 2]

Astro docs consulted for: [topic]
Verified: Build passes, tested locally."

Close issue with label: completed
```

### If Markdown Tracker:
```markdown
### [✅] Issue #[X]: [Title]
- **Status:** Complete
- **Solution:** [What was done]
- **Astro Guidance:** [What docs recommended]
- **Files Modified:** [List]
- **Commit:** [hash]
- **Completed:** [Date]
- **Measure Impact:** /impact [X] in 14 days
```

---

## Step 11: Report Completion

```markdown
## ✅ Issue Fixed: [Title]

### Summary
[One sentence describing what was fixed]

### Astro Docs Used
- Searched: "[query]"
- Key guidance: [main recommendation followed]

### Changes Made
| File | Change |
|------|--------|
| [file] | [description] |

### Verification
- [x] TypeScript: Pass
- [x] Build: Pass
- [x] Routes: Verified via astro-mcp
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
- `/fix-next` - Fix the next priority (will consult Astro docs again)
- `/start` - Refresh priorities
- `/pause` - Save and exit
- `/status` - See full status
```

---

## Step 12: Self-Annealing

If the fix revealed something new:

```markdown
## 💡 Learning Captured

During this fix, I discovered:
- [Insight about the codebase]
- [Astro pattern that should be documented]
- [Potential future issue]

**Updating documentation...**
[If appropriate, update AI-INFO.md or create new issue]

**Astro docs insight:**
[If the docs revealed something important for this project]
```

---

## Error Recovery

### If Implementation Fails

```markdown
## ❌ Implementation Issue

**Problem:** [Description]

**Searching Astro Docs for alternative approach...**
[Search results]

**Options:**
1. **Retry** - Try approach from docs
2. **Skip** - Move to next issue, come back later
3. **Escalate** - Need human input

What would you like to do?
```

### If Verification Fails

```markdown
## ⚠️ Verification Failed

**Expected:** [What should happen]
**Actual:** [What happened]

**Consulting Astro Docs...**
[Search for the symptom]

**Possible cause from docs:**
[What documentation suggests]

**Options:**
1. **Debug** - Investigate with docs guidance
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

**Astro Docs Search:**
[What docs say about this error]

**Analysis:**
[Why it failed based on docs]

**Recommendation:**
[What to do instead, per docs]

This issue may need:
- [ ] More investigation
- [ ] Different approach (see docs)
- [ ] Human input

Moving to next issue...
```

---

## MCP Usage Summary

This command uses MCP servers at these steps:

| Step | Astro Docs MCP | astro-mcp |
|------|----------------|-----------|
| Load context | - | Get affected routes |
| Plan | Search best practices | Get project config |
| Implement | Verify current APIs | Check integration docs |
| Errors | Search for solutions | - |
| Verify | - | Confirm routes intact |
