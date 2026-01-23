---
description: Initialize work session with data-driven priorities
---

# Session Start

## Step 0: MCP Health Check

Before starting, verify which MCP servers are available. Check for these tool prefixes:

| MCP Server | Tool Prefix | Required For |
|------------|-------------|--------------|
| **Astro Docs** | `mcp__astro-docs__*` | `/astro-check docs`, best practices alerts |
| **Google Search Console** | `mcp__gsc__*` | `/seo-wins`, `/seo refresh`, ranking data |
| **astro-mcp** | `mcp__astro-project__*` | `/astro-check routes`, real-time project state |
| **DataForSEO** | `mcp__dataforseo__*` | `/audit content` keyword data, SERP features |
| **ScraperAPI** | `mcp__scraperapi__*` | Competitor content analysis |

### Display MCP Status

```markdown
### 🔌 MCP Server Status

| Server | Status | Features Affected |
|--------|--------|-------------------|
| Astro Docs | ✅ Connected / ❌ Not loaded | Docs search, best practices |
| Google Search Console | ✅ Connected / ❌ Not loaded | SEO wins, rankings, CTR data |
| astro-mcp | ✅ Connected / ❌ Not loaded | Route analysis, config queries |
| DataForSEO | ✅ Connected / ❌ Not loaded | Keyword research, PAA questions |
| ScraperAPI | ✅ Connected / ❌ Not loaded | Competitor analysis |

**[X/5] MCP servers active**
```

### If any MCP servers missing:

```markdown
⚠️ **Some MCP servers not detected**

Missing servers will limit certain features but won't block your workflow.

**Options:**
1. **Continue anyway** - Proceed with available features
2. **Show setup help** - Display setup instructions for missing MCPs
3. **Run `/astro-check mcp`** - Detailed MCP diagnostics and setup guide

What would you like to do? (1/2/3) [1]:
```

### If user selects "Show setup help" (option 2):

For each missing MCP, display the relevant setup from README:

**Astro Docs (if missing):**
```markdown
### Astro Docs MCP Setup

Add to `.mcp.json`:
\`\`\`json
{
  "mcpServers": {
    "astro-docs": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "https://mcp.docs.astro.build/mcp"]
    }
  }
}
\`\`\`
Then restart Claude Code.
```

**Google Search Console (if missing):**
```markdown
### Google Search Console MCP Setup

1. Create a Google Cloud Service Account with Search Console API enabled
2. Download JSON key to `./credentials/gsc-service-account.json`
3. Add service account email to your GSC property
4. Add to `.env`:
   \`\`\`
   GSC_SITE_URL=https://your-site.com/
   GOOGLE_APPLICATION_CREDENTIALS=./credentials/gsc-service-account.json
   \`\`\`
5. Add to `.mcp.json`:
   \`\`\`json
   {
     "mcpServers": {
       "gsc": {
         "command": "npx",
         "args": ["-y", "gsc-mcp-server"],
         "env": {
           "GSC_SITE_URL": "${GSC_SITE_URL}",
           "GOOGLE_APPLICATION_CREDENTIALS": "${GOOGLE_APPLICATION_CREDENTIALS}"
         }
       }
     }
   }
   \`\`\`
6. Restart Claude Code.
```

**astro-mcp (if missing):**
```markdown
### astro-mcp Setup

1. Install: `npx astro add astro-mcp`
2. Start dev server: `npm run dev`
3. Add to `.mcp.json`:
   \`\`\`json
   {
     "mcpServers": {
       "astro-project": {
         "type": "sse",
         "url": "http://localhost:4321/__mcp/sse"
       }
     }
   }
   \`\`\`
**Note:** Dev server must be running for this MCP to work.
```

**DataForSEO (if missing):**
```markdown
### DataForSEO MCP Setup

1. Sign up at https://dataforseo.com/
2. Add to `.env`:
   \`\`\`
   DATAFORSEO_USERNAME=your_username
   DATAFORSEO_PASSWORD=your_password
   \`\`\`
3. Add to `.mcp.json`:
   \`\`\`json
   {
     "mcpServers": {
       "dataforseo": {
         "command": "npx",
         "args": ["-y", "dataforseo-mcp-server"],
         "env": {
           "DATAFORSEO_USERNAME": "${DATAFORSEO_USERNAME}",
           "DATAFORSEO_PASSWORD": "${DATAFORSEO_PASSWORD}"
         }
       }
     }
   }
   \`\`\`
4. Restart Claude Code.
```

**ScraperAPI (if missing):**
```markdown
### ScraperAPI MCP Setup

1. Sign up at https://www.scraperapi.com/ (1,000 free calls/month)
2. Add to `.env`:
   \`\`\`
   SCRAPERAPI_KEY=your_api_key
   \`\`\`
3. Add to `.mcp.json`:
   \`\`\`json
   {
     "mcpServers": {
       "scraperapi": {
         "command": "npx",
         "args": ["@scraperapi/mcp"],
         "env": {
           "SCRAPERAPI_KEY": "${SCRAPERAPI_KEY}"
         }
       }
     }
   }
   \`\`\`
4. Restart Claude Code.
```

### If all MCP servers connected:

```markdown
✅ **All MCP servers connected**

Full feature set available. Proceeding with session start...
```

---

## Step 1: Check Project Index

First, verify the project index database status:

```sql
-- Check index status
SELECT * FROM index_status;
SELECT * FROM project_summary;
```

### Index Status Display

```markdown
### 📊 Index Status

| Phase | Status | Progress |
|-------|--------|----------|
| Quick Scan | ✅/🔄/❌ | X% |
| Collections | ✅/🔄/❌ | X% |
| Routes | ✅/🔄/❌ | X% |
| Data Files | ✅/🔄/❌ | X% |
| Components | ✅/🔄/❌ | X% |
```

**If index incomplete:**
```markdown
⚠️ **Project index incomplete**

Some project data may be missing. Background indexing will continue.

[If quick_scan not complete:]
**Recommendation:** Run `/index run` to index your project.

[If only later phases incomplete:]
Proceeding with available data. Full index recommended later.
```

**If index stale (>7 days old):**
```markdown
ℹ️ **Index may be stale** (last updated: [date])

Consider running `/index run` to refresh project data.
```

---

## Step 2: Load Project Context

Read these files in order:
1. `CLAUDE.md` - Project configuration
2. `.planning/HANDOFF.md` - If exists, offer to resume
3. `AI-INFO.md` - Architecture reference (generated from index)

If HANDOFF.md exists:
```
Found saved session from [DATE].
Resume where you left off? (yes/no)
→ If yes: Run /resume instead
→ If no: Archive handoff, start fresh
```

---

## Step 3: Query Project State (Database First, MCP Fallback)

### Priority 1: Query Database

```sql
-- Get project summary from indexed data
SELECT * FROM project_summary;

-- Get content overview
SELECT * FROM content_overview;

-- Get recent routes
SELECT route_pattern, route_type, source_file FROM routes LIMIT 20;
```

**If database has data:**

```markdown
### ⚙️ Project Status (from index)

| Setting | Value |
|---------|-------|
| Project Name | [from DB] |
| Astro Version | [from DB] |
| Output Mode | [from DB] |
| Site URL | [from DB] |
| Total Routes | [from DB] |
| Collections | [from DB] |
| Components | [from DB] |

#### Content Overview
| Collection | Items | Published | Last Updated |
|------------|-------|-----------|--------------|
| [name] | X | Y | [date] |

#### Route Summary
| Type | Count |
|------|-------|
| Static Pages | [from DB] |
| Dynamic Routes | [from DB] |
| API Endpoints | [from DB] |
| **Total** | **[from DB]** |
```

### Priority 2: MCP Fallback (if DB empty or stale)

If database is empty or index incomplete, fall back to astro-mcp:

```markdown
### ⚙️ Project Status (via astro-mcp)

[Query get-astro-config and list-astro-routes]

| Setting | Value |
|---------|-------|
| Astro Version | [from MCP] |
| Output Mode | [from MCP] |
...

**Note:** Consider running `/index run` to cache project data.
```

### Priority 3: File Scan Fallback

If both DB and MCP unavailable:

```markdown
### ⚙️ Project Status (from file scan)

Scanning project structure...

[Basic counts from file system]

**Note:** For better data, either:
- Run `/index run` to build project index
- Run `npm run dev` for astro-mcp access
```

### Check for Astro Issues

Search Astro docs for any deprecation warnings based on detected patterns:

```markdown
### ⚠️ Astro Best Practice Alerts

[If any found:]
1. **[Pattern]** - [Current recommendation from docs]
2. **[Pattern]** - [Current recommendation from docs]

[If none:]
✅ No deprecated patterns detected
```

---

## Step 4: Query Analytics (If Configured)

### Google Analytics (Last 7 Days)
```
Metrics needed:
- Total sessions + trend vs previous 7 days
- Total users + trend
- Bounce rate + trend
- Top 10 pages by sessions
- Pages with bounce rate > 70%
```

### Google Search Console (Last 7 Days)
```
Metrics needed:
- Total impressions, clicks, avg CTR, avg position
- Top 10 queries by impressions
- Quick wins: position 4-15, impressions > 100, CTR < 3%
- Any queries with position drop > 3 vs previous period
```

---

## Step 5: Check Issue Tracker

### If GitHub Issues configured:
```
Query open issues with labels:
- priority:critical (count)
- priority:high (count)  
- priority:medium (count)

Get details of top 5 by priority.
```

### If Markdown Tracker:
```
Read AUDIT_TRACKER.md (or similar)
Count incomplete issues by phase
List next 5 issues in current phase
```

---

## Step 6: Calculate Priority Scores

For each open issue:
```
If issue affects specific pages:
  Impact = (Page Monthly Sessions × Severity) + (Page GSC Impressions × 0.1)
  
If issue is site-wide:
  Impact = (Total Monthly Sessions × Severity × 0.5)
  
If SEO-related:
  Add bonus: GSC Impressions for affected queries × 0.2

If Astro-specific (detected via astro-mcp):
  Add bonus: Affects X routes × 10
```

---

## Step 7: Detect Quick Wins

Find issues that are:
- High impact (score > 50)
- Low effort (estimated < 30 min)
- No dependencies

**Astro-Enhanced Quick Wins:**
- Deprecated API usage (from docs search)
- Missing image optimization (from config check)
- Unoptimized routes (from route analysis)

---

## Step 8: Generate Session Report

```markdown
## 🚀 Session Start: [DATE]

### ⚙️ Project Health
| Check | Status |
|-------|--------|
| Astro Version | [version] ✅/⚠️ |
| Output Mode | [static/server/hybrid] |
| Integrations | [X] active |
| Routes | [X] total |
| Collections | [X] with [Y] items |
| Project Index | ✅ Complete / 🔄 [X]% / ❌ Not indexed |
| Dev Server | 🟢 Running / 🔴 Stopped |

[If Astro issues detected:]
### ⚠️ Astro Alerts
- [Alert with recommendation from docs]

### 📊 Traffic Overview (7 days)
| Metric | Value | vs Last Week |
|--------|-------|--------------|
| Sessions | X | ↑/↓ X% |
| Users | X | ↑/↓ X% |
| Bounce Rate | X% | ↑/↓ X% |
| Avg Position | X.X | ↑/↓ X |

### 🎯 Quick Wins from GSC
Keywords you almost rank for:
1. "[query]" - Pos X.X, X impressions → Optimize [page]
2. "[query]" - Pos X.X, X impressions → Optimize [page]

### 🔧 Today's Priorities (by Impact Score)
| # | Task | Impact | Est. | Type |
|---|------|--------|------|------|
| 1 | [Task] | X | Xh | [SEO/Bug/Feature/Astro] |
| 2 | [Task] | X | Xh | [SEO/Bug/Feature/Astro] |
| 3 | [Task] | X | Xh | [SEO/Bug/Feature/Astro] |

### ⚡ Quick Wins Available
- [ ] [Task] - 15 min - Impact: X
- [ ] [Task] - 20 min - Impact: X

### ⚠️ Attention Needed
- [Any traffic anomalies]
- [Declining rankings]
- [Build/deploy issues]
- [Astro deprecation warnings]

---

### 💡 Recommended Focus

Based on [time available / priorities], I recommend:

**Option A (2 hours):** Fix issues #X, #Y, #Z
Combined impact: X monthly sessions improved

**Option B (Quick wins):** Complete all quick wins
Time: ~45 min, Impact: X sessions

**Option C (Feature work):** Start on [pending feature]
Use: `/feature "[description]"`

**Option D (Astro updates):** Address Astro alerts
Use: `/fix-next` (will auto-consult Astro docs)

---

Ready to work? Commands:
- `/fix-next` - Start on #1 priority (with Astro docs consultation)
- `/seo-wins` - Deep dive into GSC opportunities
- `/feature "desc"` - Build something new
- `/astro-check` - Full Astro project report
```

---

## Step 9: Set Session State

Create/update `.planning/SESSION.md`:
```markdown
# Active Session
Started: [TIMESTAMP]
Focus: [Recommended focus from above]
Completed: []
Astro MCP: [Active/Inactive]
Astro Version: [version]
Project Index: [Complete/Partial/Not indexed]
Data Source: [Database/MCP/File scan]
```

---

## Data Source Priority

### Priority Order
1. **Database** (`.planning/seo-audit.db`) - Fastest, always available
2. **astro-mcp** - Real-time but requires dev server
3. **File scan** - Slowest, always available

### If project index is complete:

```markdown
### ✅ Using Project Index

Project data loaded from database (indexed [date]).
No MCP or file scanning needed.

**To refresh index:** `/index run`
```

### If project index incomplete but MCP available:

```markdown
### ℹ️ Using astro-mcp (Index Incomplete)

Some data from database, supplemented by astro-mcp.

**Recommendation:** Run `/index run` to complete indexing.
```

### If neither index nor MCP available:

```markdown
### ⚠️ Limited Project Data

Using file scan fallback. Some features may be slower.

**To improve:**
1. Run `/index run` to build project index, OR
2. Run `npm run dev` for astro-mcp access
```

### Astro Docs MCP

If Astro Docs MCP is available, always search for warnings:

```
Search: "breaking changes astro [detected version]"
Search: "deprecated [detected pattern]"
```
