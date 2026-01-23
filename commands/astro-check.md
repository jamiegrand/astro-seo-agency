---
description: Query Astro project info via MCP (routes, config, integrations)
---

# Astro Project Check

Query your Astro project's runtime information using the astro-mcp integration and search official documentation via Astro Docs MCP.

---

## Step 1: Validate MCP Server Availability

**IMPORTANT:** Always check MCP availability first before attempting to use MCP tools.

### Check Astro Docs MCP

Attempt to use the `search_astro_docs` tool with a simple query:

```
Search: "astro basics"
```

**If successful:** Tool returns documentation results
**If failed:** Tool not available or returns error

### Check astro-mcp (Project Integration)

Attempt to use the `get-astro-config` tool:

**If successful:** Returns project configuration
**If failed:** Tool not available (dev server may not be running)

### Report MCP Status

```markdown
## 🔌 MCP Server Status

| Server | Status | Purpose |
|--------|--------|---------|
| Astro Docs | ✅/❌ | Documentation search, best practices |
| Google Search Console | ✅/❌ | Rankings, CTR, impressions |
| astro-mcp | ✅/❌ | Project routes & config |
| DataForSEO | ✅/❌ | Keyword research, SERP features |
| ScraperAPI | ✅/❌ | Competitor content analysis |

**[X/5] MCP servers active**

### Feature Availability by MCP

| Feature | Required MCPs | Status |
|---------|---------------|--------|
| Documentation search | Astro Docs | ✅/❌ |
| Route listing | astro-mcp | ✅/❌ |
| Config inspection | astro-mcp | ✅/❌ |
| SEO quick wins | GSC | ✅/❌ |
| Ranking data | GSC | ✅/❌ |
| Keyword research | DataForSEO | ✅/❌ |
| Competitor analysis | ScraperAPI | ✅/❌ |
| Best practice checks | Astro Docs | ✅/❌ |
```

---

## MCP Setup Instructions (If Not Configured)

### Astro Docs MCP Setup

**For Claude Code CLI:**
Create/update `~/.claude/mcp.json`:
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

**For VS Code:**
Create `.vscode/mcp.json` in your project:
```json
{
  "servers": {
    "astro-docs": {
      "type": "http",
      "url": "https://mcp.docs.astro.build/mcp"
    }
  }
}
```

**For Claude Desktop:**
Add to Claude Desktop settings → MCP Servers.

After configuring, **restart Claude Code** to activate.

### astro-mcp Setup

```bash
# Install the integration
npx astro add astro-mcp

# Start the dev server (required for MCP to work)
npm run dev
```

The MCP endpoint will be available at `http://localhost:4321/__mcp/sse`.

---

## Step 2: Query Project Configuration (If astro-mcp Available)

Use `get-astro-config` tool:

```markdown
## ⚙️ Configuration

| Setting | Value |
|---------|-------|
| Astro Version | [version] |
| Output Mode | [static/server/hybrid] |
| Site URL | [url or not set] |
| TypeScript | [strict/relaxed] |
| Integrations | [count] |
```

---

## Step 3: List All Routes

Use `list-astro-routes` tool:

```markdown
## 🗺️ Routes

| Type | Count |
|------|-------|
| Static Pages | X |
| Dynamic Routes | X |
| API Endpoints | X |
| **Total** | **X** |
```

---

## Step 4: Search Documentation

Use `search_astro_docs` tool:

```markdown
## 📚 Astro Docs: "[query]"

[Search results with code examples]
```

---

## Subcommands

| Command | Description |
|---------|-------------|
| `/astro-check` | Full project report |
| `/astro-check mcp` | MCP server status and diagnostics |
| `/astro-check config` | Configuration only |
| `/astro-check routes` | Routes only |
| `/astro-check routes [filter]` | Filter routes |
| `/astro-check docs "[query]"` | Search docs |
| `/astro-check health` | Quick health check |

---

## `/astro-check mcp` - MCP Diagnostics

Run this subcommand to get detailed MCP status for all 5 servers.

### How to Detect MCP Availability

Check for these tool prefixes in available tools:

| MCP Server | Tool Prefix to Look For |
|------------|-------------------------|
| Astro Docs | `mcp__astro-docs__*` |
| Google Search Console | `mcp__gsc__*` |
| astro-mcp | `mcp__astro-project__*` |
| DataForSEO | `mcp__dataforseo__*` |
| ScraperAPI | `mcp__scraperapi__*` |

### Output Format

```markdown
## 🔌 MCP Diagnostics Report

### Server Status

| Server | Status | Purpose | Test Result |
|--------|--------|---------|-------------|
| Astro Docs | ✅/❌ | Documentation search | [test query result] |
| Google Search Console | ✅/❌ | Rankings, CTR, impressions | [list_properties result] |
| astro-mcp | ✅/❌ | Project routes & config | [config query result] |
| DataForSEO | ✅/❌ | Keyword research | [tool availability] |
| ScraperAPI | ✅/❌ | Competitor analysis | [tool availability] |

**[X/5] MCP servers active**

---

### Astro Docs MCP
- **Purpose:** Search official Astro documentation
- **Status:** ✅ Connected / ❌ Not configured
- **Test:** Search "astro basics" → [result count] results
- **Required for:** `/astro-check docs`, best practice alerts

### Google Search Console MCP
- **Purpose:** Real ranking data, CTR, impressions
- **Status:** ✅ Connected / ❌ Not configured / ⚠️ Auth error
- **Test:** list_properties → [success/failure]
- **Required for:** `/seo-wins`, `/seo refresh`, `/seo impact`

### astro-mcp (Project Integration)
- **Purpose:** Query project routes and config at runtime
- **Status:** ✅ Connected / ❌ Not installed / ⚠️ Dev server not running
- **Test:** get-astro-config → [success/failure]
- **Required for:** `/astro-check routes`, route conflict detection
- **Note:** Requires `npm run dev` to be running

### DataForSEO MCP
- **Purpose:** Keyword volume, difficulty, SERP features, PAA questions
- **Status:** ✅ Connected / ❌ Not configured / ⚠️ Auth error
- **Test:** Tool availability check
- **Required for:** `/audit content` keyword data, content gap analysis

### ScraperAPI MCP
- **Purpose:** Fetch and analyze competitor content
- **Status:** ✅ Connected / ❌ Not configured
- **Test:** Tool availability check
- **Required for:** Competitor content analysis in audits

---

### Plugin Commands Affected

| Command | Astro Docs | GSC | astro-mcp | DataForSEO | ScraperAPI |
|---------|------------|-----|-----------|------------|------------|
| `/start` | Used | Used | Used | - | - |
| `/fix-next` | Required | Optional | Optional | - | - |
| `/audit content` | Used | Used | - | Required | Optional |
| `/seo-wins` | - | **Required** | - | Optional | - |
| `/seo refresh` | - | **Required** | - | - | - |
| `/seo gaps` | - | Used | - | **Required** | Optional |
| `/feature` | Used | - | Used | - | - |
| `/astro-check` | Required | - | Required | - | - |

**Legend:** Required = Feature won't work without it | Used = Enhanced when available | - = Not used

---

### Quick Setup Commands

**Missing Astro Docs?**
\`\`\`json
// Add to .mcp.json
"astro-docs": {
  "command": "npx",
  "args": ["-y", "mcp-remote", "https://mcp.docs.astro.build/mcp"]
}
\`\`\`

**Missing GSC?**
\`\`\`json
// Add to .mcp.json (requires credentials setup first)
"gsc": {
  "command": "npx",
  "args": ["-y", "gsc-mcp-server"],
  "env": {
    "GSC_SITE_URL": "${GSC_SITE_URL}",
    "GOOGLE_APPLICATION_CREDENTIALS": "${GOOGLE_APPLICATION_CREDENTIALS}"
  }
}
\`\`\`

**Missing astro-mcp?**
\`\`\`bash
npx astro add astro-mcp
npm run dev
\`\`\`

**Missing DataForSEO?**
\`\`\`json
// Add to .mcp.json (requires account at dataforseo.com)
"dataforseo": {
  "command": "npx",
  "args": ["-y", "dataforseo-mcp-server"],
  "env": {
    "DATAFORSEO_USERNAME": "${DATAFORSEO_USERNAME}",
    "DATAFORSEO_PASSWORD": "${DATAFORSEO_PASSWORD}"
  }
}
\`\`\`

**Missing ScraperAPI?**
\`\`\`json
// Add to .mcp.json (1,000 free calls/month at scraperapi.com)
"scraperapi": {
  "command": "npx",
  "args": ["@scraperapi/mcp"],
  "env": {
    "SCRAPERAPI_KEY": "${SCRAPERAPI_KEY}"
  }
}
\`\`\`

After adding, restart Claude Code to activate.
```

---

## Integration with Other Commands

- **`/start`** - Shows project health
- **`/fix-next`** - Consults docs, checks routes
- **`/feature`** - Checks route conflicts
- **`/audit`** - Validates against docs
- **`/deploy-check`** - Verifies config

---

## Available MCP Tools

**From astro-mcp:**
- `get-astro-config` - Project configuration
- `list-astro-routes` - All routes
- `get-astro-server-address` - Server status
- `get-integration-docs` - Integration help

**From Astro Docs MCP:**
- `search_astro_docs` - Search documentation

---

## Troubleshooting

### "Tool not found" or "MCP server unavailable"

**For Astro Docs MCP:**
1. Check your MCP configuration file exists:
   - CLI: `~/.claude/mcp.json`
   - VS Code: `.vscode/mcp.json`
2. Verify the configuration is valid JSON
3. Restart Claude Code after changes
4. Run `/astro-check mcp` to verify

**For astro-mcp:**
1. Verify installation: `grep astro-mcp package.json`
2. Check astro.config.mjs includes the integration
3. Ensure dev server is running: `npm run dev`
4. Check server console for MCP endpoint message

### "Connection refused" or timeout

**astro-mcp:**
- Dev server not running → `npm run dev`
- Wrong port → Check astro.config.mjs for custom port
- Firewall blocking → Allow localhost:4321

**Astro Docs MCP:**
- Network issue → Check internet connection
- Proxy blocking → Configure proxy settings

### MCP working but returning errors

**"No results found":**
- Try different search terms
- Check if querying correct MCP server

**"Invalid configuration":**
- astro-mcp may need project rebuild
- Try `npm run build` then restart dev server

### Graceful Degradation

When MCP servers are unavailable, the plugin continues to work with reduced functionality:

| Without Astro Docs MCP | Effect |
|------------------------|--------|
| `/fix-next` | Uses training data instead of live docs |
| `/audit` | Skips best practice checks |
| `/feature` | No pattern validation |

| Without GSC MCP | Effect |
|-----------------|--------|
| `/seo-wins` | Cannot find ranking opportunities |
| `/seo refresh` | Cannot identify declining pages |
| `/start` | No ranking data in priorities |

| Without astro-mcp | Effect |
|-------------------|--------|
| `/astro-check` | Shows "unavailable" for project info |
| `/start` | Skips route summary |
| `/deploy-check` | Manual config verification needed |

| Without DataForSEO MCP | Effect |
|------------------------|--------|
| `/audit content` | No keyword volume/difficulty data |
| `/seo gaps` | Limited content gap analysis |

| Without ScraperAPI MCP | Effect |
|------------------------|--------|
| `/audit content` | No competitor content comparison |

**Recommendation:** Configure at least **Astro Docs** and **GSC** for best results. DataForSEO and ScraperAPI are optional but enhance content audits.
