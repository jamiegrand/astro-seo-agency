---
description: Show current project and session status
---

# Project Status

---

## ⚠️ REQUIRED FIRST: Verify MCP & Integrations

**This section MUST appear in every status output. Actually test each connection.**

### Run These Checks NOW:

1. **Astro Docs MCP** - Try calling `search_astro_docs` with query "astro"
2. **astro-mcp** - Try calling `get-astro-config`
3. **Read .env file** - Check which integrations have values set
4. **GitHub** - If token exists, run `gh auth status`

### Output This Section First:

```markdown
### 🔌 MCP Servers

| Server | Status | Test Result |
|--------|--------|-------------|
| Astro Docs MCP | [✅ Connected / ❌ Not configured] | [what happened when you called search_astro_docs] |
| astro-mcp | [✅ Running / ❌ Not running / ❌ Not installed] | [what happened when you called get-astro-config] |

### 🔗 Integrations (.env)

| Integration | Status | Details |
|-------------|--------|---------|
| Google Analytics | [✅/❌] | [GA_PROPERTY_ID value or "not set"] |
| Search Console | [✅/❌] | [GSC_SITE_URL value or "not set"] |
| GitHub | [✅ Working / ⚠️ Invalid / ❌ Not set] | [gh auth status result] |
| Brave Search | [✅/❌] | [BRAVE_API_KEY present or "not set"] |

### 📁 Configuration Files

| File | Status |
|------|--------|
| .env | [✅ Exists / ❌ Missing] |
| CLAUDE.md | [✅ Exists / ❌ Missing] |
| credentials/ | [✅ Exists / ❌ Missing] |
```

---

## Step 1: Project Overview

Read project configuration:

```markdown
### Project Info
| Field | Value |
|-------|-------|
| Framework | Astro [version from package.json] |
| Output Mode | [static/server/hybrid from astro.config] |
| Site URL | [from CLAUDE.md or .env] |
| Repository | [from CLAUDE.md or git remote] |
| Last Deploy | [date/time if known] |

### Astro Configuration (via astro-mcp if available)
| Setting | Value |
|---------|-------|
| TypeScript | [strict/relaxed] |
| Image Service | [sharp/squoosh] |
| Adapter | [adapter or none] |
| Integrations | [count] active |
```

---

## Step 4: Route Summary (via astro-mcp)

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

## Step 5: Session State

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

## Step 6: Issue Tracker Status

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

## Step 7: Git Status

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

## Step 8: Build Status

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

## Step 9: Content Summary (via astro-mcp)

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

## Step 10: Analytics Summary (If Configured)

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

## Step 11: Feature Status

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

## Step 12: Health Checks

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

**Order matters: MCP/Integrations MUST come first (right after title)**

```markdown
## 📊 Status: [Project Name]

### 🔌 MCP Servers (VERIFIED - show actual test results)
| Server | Status | Test Result |
|--------|--------|-------------|
| Astro Docs MCP | ✅/❌ | [actual result from search_astro_docs call] |
| astro-mcp | ✅/❌ | [actual result from get-astro-config call] |

### 🔗 Integrations (VERIFIED - from .env file)
| Integration | Status | Details |
|-------------|--------|---------|
| Google Analytics | ✅/❌ | [actual GA_PROPERTY_ID or "not set"] |
| Search Console | ✅/❌ | [actual GSC_SITE_URL or "not set"] |
| GitHub | ✅/⚠️/❌ | [gh auth status result] |
| Brave Search | ✅/❌ | [present or "not set - optional"] |

### Quick Stats
| Metric | Value |
|--------|-------|
| Astro Version | [X.X.X] |
| Output Mode | [static/server/hybrid] |
| Total Routes | X |
| Open Issues | X |
| Build Status | ✅ / ❌ |
| Last Commit | [X hours ago] |

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
| `/fix-batch` | Fix multiple issues in sequence |
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
