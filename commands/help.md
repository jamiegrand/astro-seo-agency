---
description: Show all available commands and usage
---

# Astro SEO Agency - Command Reference

## Quick Start

```bash
/start              # Begin your day - see priorities
/fix-next           # Work on highest-impact issue
/fix-batch          # Fix multiple issues fast
/pause              # Save progress and exit
/resume             # Continue tomorrow
```

---

## 📋 All Commands

### Session Management

| Command | Description | When to Use |
|---------|-------------|-------------|
| `/start` | Initialize session with data-driven priorities | Beginning of work session |
| `/status` | Show project and session status | Check current state |
| `/pause` | Save session state, create handoff | Stopping work |
| `/resume` | Restore session from handoff | Continuing work |

### Issue Resolution

| Command | Description | When to Use |
|---------|-------------|-------------|
| `/fix-next` | Auto-select and fix highest priority issue | Complex issues, careful review |
| `/fix-batch [n]` | Fix multiple issues in sequence (default: 5) | Clearing many similar issues fast |
| `/audit [type]` | Run comprehensive audit (seo/a11y/perf/astro/full) | Finding issues |

### SEO & Analytics

| Command | Description | When to Use |
|---------|-------------|-------------|
| `/seo-wins` | Find GSC quick wins (position 4-15) | Weekly SEO review |
| `/content-gap` | Find content opportunities, generate briefs | Content planning |
| `/content-roi` | Analyze content performance | Monthly content review |
| `/impact [#]` | Measure before/after effect | 14+ days after changes |

### Content Audit (NEW)

| Command | Description | When to Use |
|---------|-------------|-------------|
| `/content-audit [page] [kw]` | Full 6-category SEO audit (0-100 score) | Deep optimization of single page |
| `/content-audit-quick [page] [kw]` | 10-point rapid check (0-10 score) | Quick assessment, pre-publish |
| `/content-audit-batch [collection]` | Audit multiple pages, rank by priority | Quarterly content review |
| `/content-refresh` | Find declining pages via GSC data | Monthly maintenance |
| `/content-eeat [page]` | E-E-A-T deep dive (Experience/Expertise/Authority/Trust) | Trust/authority issues |
| `/content-history [page]` | View audit score trends over time | Track improvement progress |
| `/keyword-cache [action]` | Manage cached keyword research data | View/refresh keyword data |

### Astro Tools (NEW)

| Command | Description | When to Use |
|---------|-------------|-------------|
| `/astro-check` | Full project report (config, routes, health) | Understanding project state |
| `/astro-check mcp` | MCP server status and diagnostics | Troubleshooting MCP issues |
| `/astro-check routes` | List all routes | Before adding new pages |
| `/astro-check docs "query"` | Search Astro documentation | Finding best practices |

### Feature Development

| Command | Description | When to Use |
|---------|-------------|-------------|
| `/feature "desc"` | Plan and build new feature | Adding new functionality |
| `/deploy-check` | Pre-deployment verification | Before every deploy |
| `/generate-commands` | Create custom commands for your content types | After setup, when content changes |

### Setup & Configuration

| Command | Description | When to Use |
|---------|-------------|-------------|
| `/setup` | Interactive setup wizard | First time configuring the plugin |
| `/brownfield` | Analyze existing project | Adding plugin to established codebase |
| `/verify` | Verify installation is working | After install, troubleshooting |

### Help

| Command | Description |
|---------|-------------|
| `/help` | Show this reference |

---

## 🔌 Astro MCP Integration (NEW)

This plugin uses two MCP servers for enhanced Astro development:

### Astro Docs MCP
**Purpose:** Real-time access to official Astro documentation
**URL:** `https://mcp.docs.astro.build/mcp`

- Prevents outdated recommendations
- Searches current best practices
- Used automatically by `/fix-next`, `/feature`, `/audit`

### astro-mcp Integration
**Purpose:** Runtime project information
**URL:** `http://localhost:4321/__mcp/sse` (requires dev server)

- Gets project configuration
- Lists all routes
- Checks for conflicts
- Used automatically by `/start`, `/feature`, `/deploy-check`

### Setup

**Astro Docs MCP (add to MCP config):**
```json
{
  "mcpServers": {
    "astro-docs": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "https://mcp.docs.astro.build/mcp"]
    }
  }
}
```

**astro-mcp (install in project):**
```bash
npx astro add astro-mcp
```

---

## 🔧 Command Details

### `/start`

Initializes your work session by:
1. Querying Astro project state (via astro-mcp)
2. Checking for Astro deprecations (via Astro Docs MCP)
3. Querying Google Analytics (7-day traffic)
4. Querying Search Console (rankings, quick wins)
5. Checking issue tracker
6. Calculating priority scores

**Output:** Project health + prioritized task list with impact scores

---

### `/fix-next`

Fixes ONE issue with full analysis:
1. Calculates impact scores for all open issues
2. Selects highest priority
3. **Consults Astro Docs MCP for best practices** (NEW)
4. **Queries astro-mcp for affected routes** (NEW)
5. Plans implementation (with approval)
6. Makes changes using current Astro patterns
7. Verifies and commits
8. Updates tracker

**Best for:** Complex issues that need careful review

---

### `/fix-batch [count]`

Fixes MULTIPLE issues in sequence:
1. Builds queue of top issues
2. Shows queue for approval
3. Fixes each without stopping
4. Skips complex issues automatically
5. Commits each atomically

**Best for:** Clearing many similar/simple issues quickly

---

### `/feature "description"`

Structured feature development with Astro awareness:
1. **Clarify** - Extract requirements
2. **Consult Astro Docs** - Search for best practices (NEW)
3. **Analyze Project** - Check routes for conflicts (NEW)
4. **Plan** - Break into tasks
5. **Execute** - Fresh context per task
6. **Verify** - Including route verification (NEW)
7. **Ship** - Atomic commits

---

### `/audit [type]`

Comprehensive site audit:
- `seo` - Schema, meta tags, content, linking
- `a11y` - WCAG 2.1 AA compliance
- `perf` - Core Web Vitals, image optimization
- `astro` - Astro best practices, deprecated patterns (NEW)
- `full` - All of the above (default)

**Astro audit includes:**
- Configuration validation against docs
- Route health analysis
- Deprecated pattern detection
- Integration audit
- Component hydration review

---

### `/astro-check`

Query Astro project information:
- Project configuration
- All routes (static, dynamic, API)
- Installed integrations
- MCP server status
- Search documentation

**Subcommands:**
```bash
/astro-check              # Full report
/astro-check mcp          # MCP server diagnostics
/astro-check config       # Configuration only
/astro-check routes       # Routes only
/astro-check routes blog  # Filter routes
/astro-check docs "query" # Search docs
/astro-check health       # Quick health check
```

**`/astro-check mcp` provides:**
- Connection status for all MCP servers
- Feature availability based on MCP status
- Setup instructions for missing servers
- Troubleshooting guidance

---

### `/deploy-check`

Pre-deployment verification:
- Build verification
- Critical pages check
- SEO essentials
- **Astro config validation** (NEW)
- **Route verification** (NEW)
- Asset verification
- Link checking

---

## 💡 Usage Tips

### Daily Workflow
```
Morning:  /start           → See priorities + project health
Work:     /fix-batch       → Clear issues fast
          /fix-next        → Handle complex ones
Evening:  /pause           → Save progress
```

### Before Building Features
```
/astro-check routes        → Check for conflicts
/astro-check docs "topic"  → Find best practices
/feature "description"     → Build with guidance
```

### Weekly Review
```
/audit astro               → Check Astro best practices
/seo-wins                  → Find ranking opportunities
/content-gap               → Find content opportunities
/content-roi               → Review performance
```

### Monthly Content Maintenance
```
/content-refresh           → Find declining pages
/content-audit-batch blog  → Audit all blog posts
/content-history [page]    → Check improvement trends
```

---

## ⚙️ Configuration

### MCP Servers

| Server | Purpose | Required |
|--------|---------|----------|
| Astro Docs MCP | Documentation access | Recommended |
| astro-mcp | Project runtime info | Recommended |
| Google Search Console | Rankings, CTR, performance | Recommended |
| Google Analytics | Traffic data | Optional |
| DataForSEO | Keyword research, PAA questions | Optional |
| ScraperAPI | Competitor content analysis | Optional |
| GitHub | Issue management | Optional |

### Environment Variables

```bash
# .env
GA_PROPERTY_ID=your-property-id
GSC_SITE_URL=https://your-site.com/
GITHUB_TOKEN=your-token

# Content Audit (optional)
SCRAPERAPI_KEY=your-key
DATAFORSEO_USERNAME=your-username
DATAFORSEO_PASSWORD=your-password
```

---

## 🆘 Troubleshooting

### "Astro Docs MCP not available"
Check MCP configuration. The server is remote and should always be accessible.

### "astro-mcp not available"
1. Install: `npx astro add astro-mcp`
2. Start dev server: `npm run dev`

### "No issues found"
Ensure AUDIT_TRACKER.md exists or GitHub Issues is configured.

### "Build failing"
```bash
npm run astro check  # Find TypeScript errors
npm run build        # See full error
```

---

## 📚 How MCP Servers Are Used

| Command | Astro Docs MCP | astro-mcp |
|---------|----------------|-----------|
| `/start` | Deprecation check | Project health |
| `/fix-next` | Best practices | Affected routes |
| `/feature` | Implementation patterns | Route conflicts |
| `/audit` | Current recommendations | Route validation |
| `/deploy-check` | Deploy best practices | Config validation |
| `/astro-check` | Doc search | Full report |

---

*Astro SEO Agency Plugin v3.0.0*
