---
description: Continue from saved session state
---

# Resume Session

## Step 1: Check for Handoff

Look for `.planning/HANDOFF.md`

### If Not Found
```markdown
## No Saved Session Found

No handoff document exists at `.planning/HANDOFF.md`.

Options:
1. **Start fresh:** Run `/start` for a new session
2. **Check archives:** Look in `.planning/archive/` for old handoffs
3. **Manual context:** Tell me what you were working on

What would you like to do?
```

### If Found
```markdown
## 📂 Found Saved Session

**Paused:** [timestamp from handoff]
**Duration since pause:** [calculated]

Loading context...
```

---

## Step 2: Load Handoff Context

Read `.planning/HANDOFF.md` and extract:
- What was being worked on
- Current progress
- What's next
- Open questions
- Technical state
- **Astro docs consulted (for continuity)**
- **Project state snapshot**

---

## Step 3: Verify Environment

### Check Git State
```bash
git status
git branch
```

Compare with handoff's recorded state:
- Same branch? ✅ / ⚠️
- Clean working directory? ✅ / ⚠️
- Any new commits since pause? ✅ / ⚠️

### Check Build
```bash
npm run build
```

If build fails:
```markdown
⚠️ **Build Issue Detected**

The project doesn't build cleanly. This might be due to:
- Changes made outside this session
- Dependency updates
- Uncommitted work from the pause

**Error:**
```
[build error output]
```

**Searching Astro Docs for solution...**
[Search result if Astro-related error]

Options:
1. **Fix now** - Let me diagnose and fix
2. **Ignore** - Continue anyway (risky)
3. **Reset** - Start fresh with `/start`
```

### Check astro-mcp Availability

```markdown
### 🔌 MCP Status

| Server | Status |
|--------|--------|
| Astro Docs MCP | ✅ / ❌ |
| astro-mcp | ✅ / ❌ |

[If astro-mcp unavailable:]
ℹ️ **Dev server not running**

Start with `npm run dev` for full project awareness.
Continuing with Astro Docs MCP only.
```

---

## Step 4: Compare Project State (via astro-mcp)

If dev server is running, compare current state to snapshot:

```markdown
### 📊 Project State Comparison

#### Configuration
| Setting | At Pause | Now | Changed |
|---------|----------|-----|---------|
| Astro Version | [ver] | [ver] | ✅/⚠️ |
| Output Mode | [mode] | [mode] | ✅/⚠️ |
| Integrations | [X] | [X] | ✅/⚠️ |

#### Routes
| Metric | At Pause | Now | Changed |
|--------|----------|-----|---------|
| Total | X | X | ✅/⚠️ |
| Static | X | X | ✅/⚠️ |
| Dynamic | X | X | ✅/⚠️ |

[If changes detected:]
⚠️ **Project Changed Since Pause**

Changes detected:
- [Change 1]
- [Change 2]

This might affect your previous work. Review changes?
```

---

## Step 5: Restore Context

### Read Required Files
Based on "What We Were Doing" in handoff:
1. Read the files mentioned as modified
2. Read related files for context
3. Read AI-INFO.md for architecture refresh

### Load Task State
If there was an active task/feature:
- Read `.planning/FEATURE-PLAN.md` if exists
- Determine current task number
- Load task-specific context

### Restore Astro Docs Context (NEW)

From handoff's "Astro Docs Reference" section:
```markdown
### 📚 Restoring Astro Docs Context

Previously researched topics:

#### [Topic 1]
**Finding:** [key point]
**Applied to:** [file/feature]

#### [Topic 2]
**Finding:** [key point]
**Applied to:** [file/feature]

These findings are still relevant for continuing your work.
```

---

## Step 6: Present Restoration Summary

```markdown
## ✅ Session Restored

### Context Loaded
- **Previous Session:** [date/time]
- **Time Since Pause:** [duration]
- **Your Focus Was:** [task/feature description]

---

### 📍 Where You Left Off

**Active Task:** [task name]
**Progress:** [X]% complete
**Current Step:** [specific step]

### Already Done
- [x] [Completed item 1]
- [x] [Completed item 2]
- [x] [Completed item 3]

### Up Next
1. **Immediate:** [next step to do right now]
2. **Then:** [following step]
3. **After that:** [subsequent step]

### Files to Continue Working On
| File | Task |
|------|------|
| `[path]` | [what to do] |
| `[path]` | [what to do] |

---

### 🔧 Environment Status

| Check | Status |
|-------|--------|
| Git branch | [branch] ✅ |
| Working directory | [clean/dirty] |
| Build | [pass/fail] |
| Dev server | [running/stopped] |
| astro-mcp | [available/unavailable] |
| Astro Docs MCP | [available/unavailable] |

---

### 📊 Project State

| Metric | At Pause | Now |
|--------|----------|-----|
| Routes | X | X |
| Integrations | X | X |
| Build | ✅ | ✅/❌ |

[If changed:]
⚠️ Some things changed - see comparison above.

---

### 📚 Astro Docs Context Restored

Topics from previous session:
- [Topic 1]: [key finding]
- [Topic 2]: [key finding]

Ready to continue using these patterns.

---

### ❓ Pending Questions

[If there were open questions in handoff:]
1. [Question 1] - Still need answer?
2. [Question 2] - Still need answer?

---

### 🚀 Ready to Continue

**Recommended next action:**
[Specific action based on where they left off]

**File to open:** `[path]`

Commands:
- **"continue"** - Pick up exactly where you left off
- **"/fix-next"** - Switch to highest priority issue instead
- **"/start"** - Get fresh priorities (ignores previous focus)
- **"/status"** - See full project status first
- **"/astro-check"** - Verify project state
```

---

## Step 7: Handle "Continue"

When user says "continue" or similar:

1. Re-read the specific files being worked on
2. Show the exact state of the code
3. Remind of what was being done
4. **Remind of relevant Astro docs findings**
5. Ask for confirmation before making changes

```markdown
## Continuing: [Task Name]

### Current State of `[filename]`
```[language]
[relevant code section]
```

### What We Were Doing
[Specific description of the change in progress]

### Astro Docs Guidance (from previous session)
[Relevant finding that applies]

### Next Change
I'm about to: [description of next edit]

Proceed? (yes/no)
```

---

## Step 8: Archive Old Handoff

Once successfully resumed:
- Move HANDOFF.md to `.planning/archive/HANDOFF-[timestamp].md`
- Create new SESSION.md for this session

```markdown
# Active Session
Resumed: [timestamp]
From handoff: [original pause timestamp]
Focus: [task/feature]
Completed: []
Astro Docs Context: [topics restored]
MCP Status: [availability]
```

---

## Step 9: Error Recovery

### If Context Seems Stale
```markdown
⚠️ **Context May Be Outdated**

The handoff is from [X days ago]. Things may have changed.

Recommend:
1. Run `/start` for fresh priorities
2. Run `/astro-check` to verify project state
3. Check for any new issues/changes
4. Then return to this task if still relevant
```

### If Files Changed
```markdown
⚠️ **Files Modified Since Pause**

These files changed outside the previous session:
- [file]: [X commits since]
- [file]: [X commits since]

This might affect your previous work. 

Options:
1. **Review changes** - See what changed
2. **Continue anyway** - Trust the changes
3. **Start fresh** - Run `/start`
```

### If Astro Version Changed
```markdown
⚠️ **Astro Version Changed**

| At Pause | Now |
|----------|-----|
| [X.X.X] | [Y.Y.Y] |

**Searching Astro Docs for breaking changes...**
[Search result]

Previous Astro docs findings may need verification.
```

### If Feature Plan Outdated
```markdown
⚠️ **Feature Plan May Need Update**

The feature plan was created [X days ago]. Requirements may have changed.

Options:
1. **Review plan** - `/feature:plan` to see current plan
2. **Continue anyway** - Trust the original plan
3. **Replan** - `/feature "[description]"` to start fresh
```

---

## MCP Usage Summary

| Step | Astro Docs MCP | astro-mcp |
|------|----------------|-----------|
| Verify | Error solutions | Check availability |
| Compare | - | Current vs snapshot state |
| Restore | Previous findings | Route/config verification |
| Continue | Verify patterns still valid | Confirm routes |
