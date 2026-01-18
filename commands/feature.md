---
argument-hint: "[feature description]"
description: Plan and build a new feature using structured workflow
---

# Feature Development: $1

## Philosophy

This command implements spec-driven development:
1. **Clarify** - Extract everything needed
2. **Plan** - Break into atomic tasks
3. **Execute** - Fresh context per task
4. **Verify** - Quality gates on each task
5. **Ship** - Atomic commits, perfect traceability

---

## Phase 1: CLARIFY

### Extract Requirements

From the description "$1", gather:

```markdown
## Feature Brief

### What We're Building
[Clear description of the feature]

### Why It Matters
[Business value / user benefit]

### Success Criteria
- [ ] [Measurable outcome 1]
- [ ] [Measurable outcome 2]
- [ ] [Measurable outcome 3]

### Inputs Required
- [Data/content needed]
- [Design decisions needed]
- [API keys/credentials needed]

### Constraints
- Must follow existing patterns in AI-INFO.md
- Must not break existing functionality
- Must pass quality gates
```

### Ask Clarifying Questions

If anything is ambiguous:
```
Before I plan this feature, I need to clarify:

1. [Question about scope]
2. [Question about design]
3. [Question about priority]

Please answer these, or say "use your judgment" for any.
```

Wait for answers before proceeding.

---

## Phase 2: ANALYZE

### Read Project Context

1. Read `AI-INFO.md` for:
   - Existing patterns to follow
   - Components that might be reusable
   - Data structures involved

2. Read relevant existing files:
   - Similar features for patterns
   - Data files that will be affected
   - Components that might be extended

### Determine Zone Ownership

Based on files involved, assign to zones:

```yaml
ALPHA (Foundation):
  - Config changes
  - Layout updates
  - Style additions
  
BETA (Components & Data):
  - New components
  - Data file changes
  - Utility functions
  
GAMMA (Pages & Integration):
  - New pages
  - Page modifications
  - Public assets
```

### Identify Dependencies

```markdown
## Dependencies

### Must Complete First
- [Blocking task/issue]

### Can Run Parallel
- [Non-blocking work]

### External Dependencies
- [API access needed]
- [Content needed from client]
```

---

## Phase 3: PLAN

### Create Task Breakdown

Break feature into atomic tasks (max 3 at a time):

```markdown
## Feature Plan: $1

### Overview
- Total tasks: X
- Estimated time: Xh
- Zones affected: [ALPHA/BETA/GAMMA]

---

### Task 1: [Foundation]
**Zone:** ALPHA
**Files:**
- [ ] `src/config/[file]`
- [ ] `src/layouts/[file]`

**Description:**
[What this task accomplishes]

**Acceptance Criteria:**
- [ ] [Specific check]
- [ ] [Specific check]

**Estimated:** X min

---

### Task 2: [Components/Data]
**Zone:** BETA
**Files:**
- [ ] `src/components/[file]`
- [ ] `src/data/[file]`

**Description:**
[What this task accomplishes]

**Acceptance Criteria:**
- [ ] [Specific check]
- [ ] [Specific check]

**Estimated:** X min

---

### Task 3: [Integration]
**Zone:** GAMMA  
**Files:**
- [ ] `src/pages/[file]`

**Description:**
[What this task accomplishes]

**Acceptance Criteria:**
- [ ] [Specific check]
- [ ] [Specific check]

**Estimated:** X min
```

### Save Plan

Write to `.planning/FEATURE-PLAN.md`

### Present for Approval

```markdown
## 📋 Feature Plan Ready

I've created a plan for: **$1**

### Summary
- **Tasks:** X total
- **Estimated:** Xh
- **Zones:** [list]

### Task Overview
1. [Task 1 title] - X min - ALPHA
2. [Task 2 title] - X min - BETA
3. [Task 3 title] - X min - GAMMA

### Ready to Execute?

Options:
- **"go"** - Execute all tasks
- **"go 1"** - Execute just task 1
- **"modify"** - Adjust the plan
- **"cancel"** - Abandon this feature
```

---

## Phase 4: EXECUTE

### For Each Task

#### 4.1 Fresh Context Setup
```
Starting Task [N]: [Title]
Zone: [ALPHA/BETA/GAMMA]
Files: [list]
```

#### 4.2 Read Required Files
- Read all files that will be modified
- Read related files for patterns
- Note any existing code to preserve

#### 4.3 Implement
- Make changes following existing patterns
- Add comments where helpful
- Ensure no conflicts with other zones

#### 4.4 Quality Gate
```bash
# Must pass before continuing
npm run astro check    # TypeScript
npm run build          # Full build
```

If gate fails:
- Read error message
- Fix the issue
- Re-run gate
- Only proceed when passing

#### 4.5 Atomic Commit
```bash
git add [specific files]
git commit -m "feat([scope]): [description]

- [Change 1]
- [Change 2]

Part of: [Feature name]
Task: [N] of [Total]"
```

#### 4.6 Update Progress
```markdown
## Task [N] Complete ✅

**Changes Made:**
- [File]: [What changed]
- [File]: [What changed]

**Verified:**
- [x] TypeScript compiles
- [x] Build succeeds
- [x] [Acceptance criteria 1]
- [x] [Acceptance criteria 2]

**Commit:** [hash]

---

Next: Task [N+1] - [Title]
Continue? (yes/no)
```

---

## Phase 5: VERIFY

### After All Tasks Complete

#### Run Full Verification
```bash
# Clean build
rm -rf dist/
npm run build

# Preview
npm run preview
# → Manual check of feature
```

#### Feature Checklist
```markdown
## Feature Verification: $1

### Functionality
- [ ] Feature works as specified
- [ ] No regressions in related areas
- [ ] Edge cases handled

### Quality
- [ ] TypeScript strict mode passes
- [ ] No console errors
- [ ] Performance acceptable

### SEO (if applicable)
- [ ] Meta tags present
- [ ] Schema markup correct
- [ ] Internal links added

### Accessibility
- [ ] Keyboard navigable
- [ ] Screen reader friendly
- [ ] Color contrast OK

### Documentation
- [ ] AI-INFO.md updated (if architecture changed)
- [ ] Comments in complex code
```

---

## Phase 6: SHIP

### Final Report

```markdown
## ✅ Feature Complete: $1

### Summary
- **Tasks Completed:** X/X
- **Time Taken:** Xh (estimated: Xh)
- **Commits:** X

### Changes Made
| File | Change Type | Description |
|------|-------------|-------------|
| [file] | Created | [desc] |
| [file] | Modified | [desc] |

### Commits
1. `[hash]` - [message]
2. `[hash]` - [message]

### Verification
- [x] Build passes
- [x] Feature works
- [x] No regressions

### Deployment Notes
[Any special deployment considerations]

---

### Next Steps
- Deploy with: `npm run build && [deploy command]`
- Monitor: Check GA/GSC in 7 days for impact
- Schedule: `/impact` in 14 days to measure effect
```

### Cleanup
- Archive `.planning/FEATURE-PLAN.md` to `.planning/archive/`
- Update issue tracker if applicable
- Clear session state

---

## Subcommands

### `/feature:plan`
Show current feature plan without executing.

### `/feature:work [N]`
Execute specific task number.

### `/feature:status`
Show progress on current feature.

### `/feature:complete`
Run final verification and ship.

### `/feature:abort`
Cancel feature, provide rollback instructions.
