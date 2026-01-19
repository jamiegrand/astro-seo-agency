---
description: Show current project and session status
---

# Project Status

## Step 1: Project Overview

Read project configuration and query astro-mcp:

```markdown
## 📊 Project Status: [Project Name]

**Last Updated:** [timestamp]

### Project Info
| Field | Value |
|-------|-------|
| Framework | Astro [version] |
| Output Mode | [static/server/hybrid] |
| Site URL | [url] |
| Repository | [repo] |
| Last Deploy | [date/time if known] |

### Astro Configuration (via astro-mcp)
| Setting | Value |
|---------|-------|
| TypeScript | [strict/relaxed] |
| Image Service | [sharp/squoosh] |
| Adapter | [adapter or none] |
| Integrations | [count] active |

### MCP Status
| Server | Status |
|--------|--------|
| Astro Docs MCP | ✅ / ❌ |
| astro-mcp | ✅ / ❌ |
| Google Analytics | ✅ / ❌ |
| Search Console | ✅ / ❌ |
| GitHub | ✅ / ❌ |
```

---

## Step 2: Route Summary (via astro-mcp)

Query `list-astro-routes`:

```markdown
### 🗺️ Routes Overview

| Type | Count |
|------|-------|
| Static Pages | X |
| Dynamic Routes | X |
| API Endpoints | X |
| **Total** | **X** |

#### Recent Routes (if tracking available)
| Route | Added | Status |
|-------|-------|--------|
| /[route] | [date] | ✅ Live |

#### Route Health
| Check | Status |
|-------|--------|
| All routes build | ✅ / ❌ |
| No orphan pages | ✅ / ⚠️ |
| Sitemap coverage | X% |
```

---

## Step 3: Session State

### Check for Active Session

If `.planning/SESSION.md` exists:
```markdown
### 🔄 Active Session
- **Started:** [timestamp]
- **Duration:** [X hours]
- **Focus:** [current task/feature]
- **Tasks Completed:** [X]
- **Astro Docs Consulted:** [X] times
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

## Step 4: Issue Tracker Status

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

#### By Type
| Type | Count |
|------|-------|
| Astro/Code | X |
| SEO | X |
| Content | X |
| Bug | X |

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

## Step 5: Git Status

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

## Step 6: Build Status

```bash
npm run build 2>&1 | tail -20
```

```markdown
### 🔨 Build Status

**Last Check:** [timestamp]
**Status:** ✅ Passing / ❌ Failing

[If failing:]
**Error Summary:**
```
[error]
```

**Astro Docs Suggestion:**
[Search for error and provide guidance]
```

---

## Step 7: Content Summary (via astro-mcp)

```markdown
### 📝 Content Summary

#### Content Collections
| Collection | Location | Items |
|------------|----------|-------|
| blog | src/content/blog/ | X |
| docs | src/content/docs/ | X |

#### Data-Driven Content
| Source | Location | Items | Routes |
|--------|----------|-------|--------|
| Products | src/data/products.js | X | /products/* |
| Services | src/data/services.js | X | /services/* |

#### Total Content
| Type | Count |
|------|-------|
| Blog Posts | X |
| Products | X |
| Services | X |
| Static Pages | X |
| **Total** | **X** |
```

---

## Step 8: Analytics Summary (If Configured)

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

## Step 9: Feature Status

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

**Astro Docs Consulted:** [topics]
```

---

## Step 10: Health Checks

```markdown
### 🏥 Project Health

| Check | Status | Last Run |
|-------|--------|----------|
| TypeScript | ✅ / ❌ | [time] |
| Build | ✅ / ❌ | [time] |
| Dependencies | ✅ / ⚠️ Outdated | [time] |
| Astro Version | ✅ / ⚠️ Update available | [time] |
| Routes Valid | ✅ / ❌ | [time] |

[If issues found:]
#### ⚠️ Attention Needed
- [Issue 1]
- [Issue 2]

#### Astro-Specific Checks
| Check | Status |
|-------|--------|
| Using current APIs | ✅ / ⚠️ |
| No deprecated patterns | ✅ / ⚠️ |
| Integrations up to date | ✅ / ⚠️ |
```

---

## Full Status Output

```markdown
## 📊 Status: [Project Name]

### Quick Stats
| Metric | Value |
|--------|-------|
| Astro Version | [X.X.X] |
| Output Mode | [static/server/hybrid] |
| Total Routes | X |
| Open Issues | X |
| Build Status | ✅ / ❌ |
| Last Commit | [X hours ago] |
| Sessions (7d) | X |
| GSC Position | X.X |

### Session
[Active / Paused / None]

### MCP Servers
| Server | Status |
|--------|--------|
| Astro Docs | ✅ / ❌ |
| astro-mcp | ✅ / ❌ |

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
| `/astro-check` | Full Astro project report |

### Quick Actions
- **"fix [issue]"** - Work on specific issue
- **"deploy"** - Run deploy checklist
- **"refresh"** - Update all status data
- **"astro health"** - Check Astro-specific status
```

---

## MCP Usage Summary

| Section | Astro Docs MCP | astro-mcp |
|---------|----------------|-----------|
| Project Info | - | Config, version |
| Routes | - | Full route list |
| Build errors | Error solutions | - |
| Health | Current version, deprecations | Integration status |
| Content | - | Collections, data files |
