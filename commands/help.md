---
description: Show all available commands
---

# Astro SEO Agency - Command Reference

## Quick Start

```bash
/start              # Begin session with priorities
/fix                # Fix highest-impact issue
/pause              # Save progress
/resume             # Continue later
```

---

## Commands

### Session
| Command | Description |
|---------|-------------|
| `/start` | Begin session with data-driven priorities |
| `/status` | Show current project and session status |
| `/pause` | Save session state for later |
| `/resume` | Continue from saved session |

### Issues
| Command | Description |
|---------|-------------|
| `/fix` | Fix single issue (or `/fix 5` for batch, `/fix #42` for specific) |

### SEO & Analytics
| Command | Description |
|---------|-------------|
| `/seo` | Show all SEO subcommands |
| `/seo wins` | Find GSC quick wins (position 4-15) |
| `/seo gaps` | Find content opportunities |
| `/seo roi` | Analyze content performance |
| `/seo refresh` | Find declining pages |
| `/seo history [page]` | View audit score trends |
| `/seo impact [#]` | Measure before/after effect |
| `/seo keywords` | Manage keyword cache |

### Auditing
| Command | Description |
|---------|-------------|
| `/audit` | Full site audit (SEO + a11y + performance) |
| `/audit seo` | SEO-only site audit |
| `/audit content [page] [kw]` | Deep content audit (0-100) |
| `/audit quick [page] [kw]` | Rapid 10-point check |
| `/audit batch [collection]` | Audit multiple pages |
| `/audit eeat [page]` | E-E-A-T deep dive |

### Astro Tools
| Command | Description |
|---------|-------------|
| `/astro-check` | Full project report |
| `/astro-check routes` | List all routes |
| `/astro-check docs "query"` | Search Astro docs |

### Development
| Command | Description |
|---------|-------------|
| `/feature "desc"` | Plan and build a feature |
| `/feature deploy` | Pre-deployment checks |

### Setup & Help
| Command | Description |
|---------|-------------|
| `/setup` | Interactive setup wizard |
| `/setup existing` | Analyze existing project |
| `/setup verify` | Verify installation |
| `/setup commands` | Generate custom commands |
| `/setup index` | Manage project indexing |
| `/help` | Show this reference |

---

## Tips

- Run any router command without arguments to see its subcommands
- Direct commands still work: `/seo-wins` = `/seo wins`
- Use `/fix 5` to batch-fix multiple issues quickly

---

## Command Aliases

For backward compatibility, these legacy commands still work:

| Legacy Command | Routes To |
|----------------|-----------|
| `/content-audit` | `/audit content` |
| `/content-audit-quick` | `/audit quick` |
| `/content-audit-batch` | `/audit batch` |
| `/content-eeat` | `/audit eeat` |
| `/content-refresh` | `/seo refresh` |
| `/content-roi` | `/seo roi` |
| `/content-gap` | `/seo gaps` |
| `/content-history` | `/seo history` |
| `/keyword-cache` | `/seo keywords` |
| `/impact` | `/seo impact` |
| `/brownfield` | `/setup existing` |
| `/verify` | `/setup verify` |
| `/generate-commands` | `/setup commands` |
| `/deploy-check` | `/feature deploy` |

**Recommended:** Use the new router-based commands for consistency.

---

## MCP Integration

This plugin uses two MCP servers for enhanced Astro development:

### Astro Docs MCP
**Purpose:** Real-time access to official Astro documentation
**URL:** `https://mcp.docs.astro.build/mcp`

- Prevents outdated recommendations
- Searches current best practices
- Used automatically by `/fix`, `/feature`, `/audit`

### astro-mcp Integration
**Purpose:** Runtime project information
**URL:** `http://localhost:4321/__mcp/sse` (requires dev server)

- Gets project configuration
- Lists all routes
- Checks for conflicts
- Used automatically by `/start`, `/feature`, `/feature deploy`

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

## Command Details

### `/fix`

The fix router handles issue resolution:
- `/fix` - Fix highest-priority issue
- `/fix 5` - Batch fix top 5 issues
- `/fix #42` - Fix specific issue #42

### `/seo`

SEO & Analytics tools:
- `wins` - Find GSC quick wins (position 4-15)
- `gaps` - Find content opportunities
- `roi` - Analyze content performance
- `refresh` - Find declining pages
- `history` - View audit score trends
- `impact` - Measure before/after effect
- `keywords` - Manage keyword cache

### `/audit`

Site audits (handled directly):
- `seo` - Schema, meta tags, content, linking
- `a11y` - WCAG 2.1 AA compliance
- `perf` - Core Web Vitals, image optimization
- `astro` - Astro best practices, deprecated patterns
- `full` - All of the above (default)

Content audits (routed):
- `content` - Full SEO content audit (0-100)
- `quick` - 10-point rapid check
- `batch` - Audit multiple pages
- `eeat` - E-E-A-T deep dive

### `/setup`

Configuration tools:
- (no args) - Interactive setup wizard
- `existing` - Analyze existing project
- `verify` - Verify installation
- `commands` - Generate custom commands
- `index` - Manage project indexing

### `/feature`

Feature development:
- `"description"` - Plan and build a feature
- `deploy` - Pre-deployment verification

---

## Daily Workflow

```
Morning:  /start           → See priorities + project health
Work:     /fix             → Fix issues (or /fix 5 for batch)
          /seo wins        → Find ranking opportunities
Evening:  /pause           → Save progress
```

## Weekly Review

```
/audit                     → Full site audit
/seo wins                  → Find ranking opportunities
/seo gaps                  → Find content opportunities
/seo roi                   → Review content performance
```

## Monthly Maintenance

```
/seo refresh               → Find declining pages
/audit batch blog          → Audit all blog posts
/seo history [page]        → Check improvement trends
```

---

## Configuration

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

## Troubleshooting

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

## How MCP Servers Are Used

| Command | Astro Docs MCP | astro-mcp |
|---------|----------------|-----------|
| `/start` | Deprecation check | Project health |
| `/fix` | Best practices | Affected routes |
| `/feature` | Implementation patterns | Route conflicts |
| `/audit` | Current recommendations | Route validation |
| `/feature deploy` | Deploy best practices | Config validation |
| `/astro-check` | Doc search | Full report |

---

*Astro SEO Agency Plugin v3.0.0*
