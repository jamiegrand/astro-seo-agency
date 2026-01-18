---
description: Show current project and session status
---

# Project Status

## Step 1: Project Overview

Read project configuration and display:

```markdown
## 📊 Project Status: [Project Name]

**Last Updated:** [timestamp]

### Project Info
| Field | Value |
|-------|-------|
| Framework | Astro [version] |
| Site URL | [url] |
| Repository | [repo] |
| Last Deploy | [date/time if known] |

### Configuration
| Feature | Status |
|---------|--------|
| Google Analytics | ✅ Connected / ❌ Not configured |
| Search Console | ✅ Connected / ❌ Not configured |
| GitHub Issues | ✅ Connected / ❌ Not configured |
| Session Persistence | ✅ Enabled |
```

---

## Step 2: Session State

### Check for Active Session

If `.planning/SESSION.md` exists:
```markdown
### 🔄 Active Session
- **Started:** [timestamp]
- **Duration:** [X hours]
- **Focus:** [current task/feature]
- **Tasks Completed:** [X]
```

If `.planning/HANDOFF.md` exists:
```markdown
### ⏸️ Paused Session Available
- **Paused:** [timestamp]
- **Was Working On:** [task summary]
- **Resume with:** `/resume`
```

If neither:
```markdown
### 💤 No Active Session
Start a new session with `/start`
```

---

## Step 3: Issue Tracker Status

### GitHub Issues (If Configured)
```markdown
### 📋 Issue Tracker

| Priority | Open | In Progress | Closed (30d) |
|----------|------|-------------|--------------|
| 🔴 Critical | X | X | X |
| 🟠 High | X | X | X |
| 🟡 Medium | X | X | X |
| 🟢 Low | X | X | X |
| **Total** | **X** | **X** | **X** |

#### Next Up
1. #[num] - [title] - [priority]
2. #[num] - [title] - [priority]
3. #[num] - [title] - [priority]
```

### Markdown Tracker (Fallback)
```markdown
### 📋 Issue Tracker (AUDIT_TRACKER.md)

| Phase | Total | Complete | Remaining |
|-------|-------|----------|-----------|
| Phase 1 | X | X | X |
| Phase 2 | X | X | X |
| Phase 3 | X | X | X |
| **Total** | **X** | **X (Y%)** | **X** |

#### Current Phase: [N]
- [ ] #[X]: [Title]
- [ ] #[X]: [Title]
- [x] #[X]: [Title] ✅
```

---

## Step 4: Git Status

```bash
git status
git log --oneline -5
```

```markdown
### 🔀 Git Status

**Branch:** [current branch]
**Status:** [clean / X uncommitted changes]

#### Recent Commits
```
[git log output]
```

#### Uncommitted Changes
[If any: list files]
```

---

## Step 5: Build Status

```bash
npm run build 2>&1 | tail -20
```

```markdown
### 🔨 Build Status

**Last Check:** [timestamp]
**Status:** ✅ Passing / ❌ Failing

[If failing: show error summary]
```

---

## Step 6: Analytics Summary (If Configured)

```markdown
### 📈 Traffic Summary (Last 7 Days)

| Metric | Value | Trend |
|--------|-------|-------|
| Sessions | X | ↑/↓ X% |
| Users | X | ↑/↓ X% |
| Bounce Rate | X% | ↑/↓ X% |

#### Top Pages
1. /[page]/ - X sessions
2. /[page]/ - X sessions
3. /[page]/ - X sessions

#### Search Performance (GSC)
| Metric | Value | Trend |
|--------|-------|-------|
| Impressions | X | ↑/↓ X% |
| Clicks | X | ↑/↓ X% |
| Avg Position | X.X | ↑/↓ X |
```

---

## Step 7: Feature Status

If `.planning/FEATURE-PLAN.md` exists:
```markdown
### 🚧 Active Feature

**Feature:** [name]
**Progress:** [X/Y tasks] - [Z%]

| Task | Status | Zone |
|------|--------|------|
| [Task 1] | ✅ Complete | ALPHA |
| [Task 2] | 🔄 In Progress | BETA |
| [Task 3] | ⏳ Pending | GAMMA |
```

---

## Step 8: Health Checks

```markdown
### 🏥 Project Health

| Check | Status | Last Run |
|-------|--------|----------|
| TypeScript | ✅ / ❌ | [time] |
| Build | ✅ / ❌ | [time] |
| Dependencies | ✅ / ⚠️ Outdated | [time] |
| Security | ✅ / ⚠️ Vulnerabilities | [time] |

[If issues found:]
#### ⚠️ Attention Needed
- [Issue 1]
- [Issue 2]
```

---

## Full Status Output

```markdown
## 📊 Status: [Project Name]

### Quick Stats
| Metric | Value |
|--------|-------|
| Open Issues | X |
| Build Status | ✅ |
| Last Commit | [X hours ago] |
| Sessions (7d) | X |
| GSC Position | X.X |

### Session
[Active / Paused / None]

### Next Priority
[#X: Title - Impact Score: Y]

---

### Available Commands

| Command | Description |
|---------|-------------|
| `/start` | Begin session with priorities |
| `/fix-next` | Fix highest priority issue |
| `/resume` | Continue paused session |
| `/feature "desc"` | Start new feature |
| `/audit` | Run full site audit |
| `/seo-wins` | Find ranking opportunities |

### Quick Actions
- **"fix [issue]"** - Work on specific issue
- **"deploy"** - Run deploy checklist
- **"refresh"** - Update all status data
```
