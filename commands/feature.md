---
description: Build features or run deploy checks
argument-hint: "\"description\" | deploy"
---

# /feature - Feature Development

Plan and build features, or run pre-deployment checks.

## Usage

| Command | Routes To | Description |
|---------|-----------|-------------|
| `/feature "Add dark mode"` | (direct) | Plan and build a feature |
| `/feature deploy` | `feature-deploy.md` | Pre-deployment verification |

## Routing

**`deploy` subcommand:** Read `commands/feature-deploy.md` and execute

**Any other argument (quoted string):** Execute feature planning directly (below)

## Examples

```bash
/feature "Add newsletter signup"   # Build feature
/feature "Improve mobile nav"      # Build feature
/feature deploy                    # Pre-deploy checks
```

---

# Feature Planning Implementation

## Philosophy

This command implements spec-driven development with Astro-aware planning:
1. **Clarify** - Extract everything needed
2. **Consult** - Search Astro docs for best practices (NEW)
3. **Analyze** - Check project state via astro-mcp (NEW)
4. **Plan** - Break into atomic tasks
5. **Execute** - Fresh context per task
6. **Verify** - Quality gates on each task
7. **Ship** - Atomic commits, perfect traceability

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
- Must follow current Astro best practices
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

## Phase 2: CONSULT ASTRO DOCS (NEW)

**Before planning, always search Astro documentation for the feature type.**

### Identify Relevant Topics

Based on "$1", determine what to search:

| Feature Type | Search Queries |
|--------------|----------------|
| New page | "astro pages routing" |
| Blog/content | "astro content collections" |
| API endpoint | "astro api routes endpoints" |
| Dynamic routes | "astro dynamic routes params" |
| Form handling | "astro forms actions" |
| Auth | "astro authentication" |
| Database | "astro database integration" |
| E-commerce | "astro e-commerce" |
| Image gallery | "astro image optimization gallery" |
| Search | "astro search implementation" |
| i18n | "astro internationalization i18n" |
| RSS | "astro rss feed" |

### Document Best Practices

```markdown
## 📚 Astro Documentation Review

### Feature: $1

**Searched:** 
- "[query 1]"
- "[query 2]"

### Recommended Approach (Astro [version])

[Summary of what docs recommend]

### Code Patterns to Follow

```astro
[Example code from docs]
```

### Required Integrations

| Integration | Purpose | Install |
|-------------|---------|---------|
| [name] | [why needed] | `npx astro add [name]` |

### Common Mistakes to Avoid

1. [Mistake from docs]
2. [Mistake from docs]

### Related Features to Consider

- [Related feature 1]
- [Related feature 2]
```

---

## Phase 3: ANALYZE PROJECT STATE (NEW)

**Query astro-mcp to understand current project context.**

### Check Existing Routes

Use `list-astro-routes` to find conflicts and patterns:

```markdown
### 🗺️ Route Analysis

#### Potential Conflicts
| Proposed Route | Existing Route | Status |
|----------------|----------------|--------|
| /[feature]/... | - | ✅ Available |
| /api/[feature] | /api/contact | ✅ No conflict |

#### Similar Routes (Pattern Reference)
| Route | File | Pattern to Match |
|-------|------|------------------|
| /blog/[slug] | src/pages/blog/[slug].astro | Dynamic route |
| /products | src/pages/products/index.astro | Index page |

#### Route Summary
- Total existing routes: X
- Feature will add: Y routes
- No conflicts detected: ✅
```

### Check Project Configuration

Use `get-astro-config` to understand capabilities:

```markdown
### ⚙️ Project Capabilities

| Capability | Status | Affects Feature |
|------------|--------|-----------------|
| Output mode | static | [implications] |
| TypeScript | strict | Must type everything |
| Image service | sharp | Can use transforms |
| MDX | installed | Can use in content |

#### Installed Integrations
| Integration | Can Use For |
|-------------|-------------|
| @astrojs/tailwind | Styling |
| @astrojs/sitemap | Auto-include new routes |
| @astrojs/mdx | Rich content |

#### Missing Integrations (May Need)
| Integration | Why | Install |
|-------------|-----|---------|
| [name] | [reason] | `npx astro add [name]` |
```

### Check for Existing Patterns

Use files in project to find patterns:

```markdown
### 📁 Existing Patterns to Follow

#### Data Layer Pattern
```javascript
// From src/data/[similar].js
export const items = [
  { id: '...', name: '...', ... }
];
```

#### Component Pattern
```astro
// From src/components/[Similar]Card.astro
---
interface Props { ... }
const { ... } = Astro.props;
---
```

#### Page Pattern
```astro
// From src/pages/[similar]/[slug].astro
---
export async function getStaticPaths() { ... }
---
```
```

---

## Phase 4: PLAN

### Create Task Breakdown

Break feature into atomic tasks (max 3 at a time):

```markdown
## Feature Plan: $1

### Overview
- Total tasks: X
- Estimated time: Xh
- Zones affected: [ALPHA/BETA/GAMMA]
- Astro patterns: [from docs consultation]

### Prerequisites
- [ ] Install integrations: [list if any]
- [ ] Create data structure: [if needed]

---

### Task 1: [Foundation]
**Zone:** ALPHA
**Astro Pattern:** [from docs]
**Files:**
- [ ] `src/config/[file]`
- [ ] `src/layouts/[file]`

**Description:**
[What this task accomplishes]

**Astro Guidance:**
[Specific recommendation from docs]

**Acceptance Criteria:**
- [ ] [Specific check]
- [ ] [Specific check]

**Estimated:** X min

---

### Task 2: [Components/Data]
**Zone:** BETA
**Astro Pattern:** [from docs]
**Files:**
- [ ] `src/components/[file]`
- [ ] `src/data/[file]`

**Description:**
[What this task accomplishes]

**Astro Guidance:**
[Specific recommendation from docs]

**Acceptance Criteria:**
- [ ] [Specific check]
- [ ] [Specific check]

**Estimated:** X min

---

### Task 3: [Pages/Integration]
**Zone:** GAMMA
**Astro Pattern:** [from docs]
**Files:**
- [ ] `src/pages/[file]`

**Description:**
[What this task accomplishes]

**Astro Guidance:**
[Specific recommendation from docs]

**Acceptance Criteria:**
- [ ] [Specific check]
- [ ] Route appears in astro-mcp

**Estimated:** X min
```

### Save Plan

Write to `.planning/FEATURE-PLAN.md`

### Present for Approval

```markdown
## 📋 Feature Plan Ready

I've created a plan for: **$1**

### Astro Docs Consulted
- [Topic 1]: [Key finding]
- [Topic 2]: [Key finding]

### Project Analysis
- Routes to add: X (no conflicts)
- Integrations needed: [list or "none"]
- Patterns matched: [list]

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

## Phase 5: EXECUTE

### For Each Task

#### 5.1 Fresh Context Setup
```
Starting Task [N]: [Title]
Zone: [ALPHA/BETA/GAMMA]
Astro Pattern: [from docs]
Files: [list]
```

#### 5.2 Re-consult Docs if Needed

If implementing something complex:
```
Verifying current Astro approach for [specific topic]...
[Quick search result]
```

#### 5.3 Read Required Files
- Read all files that will be modified
- Read related files for patterns
- Note any existing code to preserve

#### 5.4 Implement
- Make changes following existing patterns
- **Use Astro APIs verified from docs**
- Add comments where helpful
- Ensure no conflicts with other zones

#### 5.5 Quality Gate
```bash
# Must pass before continuing
npm run astro check    # TypeScript
npm run build          # Full build
```

If gate fails:
- **Search Astro docs for the error**
- Read error message
- Fix the issue
- Re-run gate
- Only proceed when passing

#### 5.6 Verify Routes (via astro-mcp)

After creating/modifying pages:
```
Verifying new routes via astro-mcp...

| Expected Route | Status |
|----------------|--------|
| /[feature] | ✅ Found |
| /[feature]/[slug] | ✅ Found |
```

#### 5.7 Atomic Commit
```bash
git add [specific files]
git commit -m "feat([scope]): [description]

- [Change 1]
- [Change 2]

Astro pattern: [pattern followed]
Part of: [Feature name]
Task: [N] of [Total]"
```

#### 5.8 Update Progress
```markdown
## Task [N] Complete ✅

**Changes Made:**
- [File]: [What changed]
- [File]: [What changed]

**Astro Pattern Used:**
[Pattern from docs that was followed]

**Verified:**
- [x] TypeScript compiles
- [x] Build succeeds
- [x] Routes verified via astro-mcp
- [x] [Acceptance criteria 1]
- [x] [Acceptance criteria 2]

**Commit:** [hash]

---

Next: Task [N+1] - [Title]
Continue? (yes/no)
```

---

## Phase 6: VERIFY

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

#### Route Verification (via astro-mcp)

```markdown
### Route Verification

All new routes registered:
| Route | Type | Status |
|-------|------|--------|
| /[feature] | static | ✅ |
| /[feature]/[slug] | dynamic | ✅ |
```

#### Feature Checklist
```markdown
## Feature Verification: $1

### Functionality
- [ ] Feature works as specified
- [ ] No regressions in related areas
- [ ] Edge cases handled

### Astro Best Practices (from docs)
- [ ] Following recommended patterns
- [ ] Using current APIs (not deprecated)
- [ ] Proper component hydration

### Quality
- [ ] TypeScript strict mode passes
- [ ] No console errors
- [ ] Performance acceptable

### SEO (if applicable)
- [ ] Meta tags present
- [ ] Schema markup correct
- [ ] Internal links added
- [ ] New routes in sitemap

### Accessibility
- [ ] Keyboard navigable
- [ ] Screen reader friendly
- [ ] Color contrast OK

### Documentation
- [ ] AI-INFO.md updated (if architecture changed)
- [ ] Comments in complex code
```

---

## Phase 7: SHIP

### Final Report

```markdown
## ✅ Feature Complete: $1

### Summary
- **Tasks Completed:** X/X
- **Time Taken:** Xh (estimated: Xh)
- **Commits:** X

### Astro Docs Used
| Topic | Applied To |
|-------|------------|
| [topic] | [where used] |
| [topic] | [where used] |

### Routes Added
| Route | Type | File |
|-------|------|------|
| [route] | [type] | [file] |

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
- [x] Routes verified
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

---

## MCP Usage Summary

| Phase | Astro Docs MCP | astro-mcp |
|-------|----------------|-----------|
| Clarify | - | - |
| Consult | Search patterns & best practices | - |
| Analyze | Integration requirements | Route conflicts, config |
| Plan | Verify approach | Match existing patterns |
| Execute | Verify APIs, error lookup | Verify new routes |
| Verify | Check against current docs | Full route check |
| Ship | - | Final verification |
