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

| Server | Status | Purpose | Action Needed |
|--------|--------|---------|---------------|
| Astro Docs MCP | ✅ Available | Real-time documentation | None |
| Astro Docs MCP | ❌ Unavailable | Real-time documentation | See setup below |
| astro-mcp | ✅ Available | Project routes & config | None |
| astro-mcp | ⚠️ Not running | Project routes & config | Run `npm run dev` |
| astro-mcp | ❌ Not installed | Project routes & config | Run `npx astro add astro-mcp` |

### Feature Availability

| Feature | Astro Docs | astro-mcp | Status |
|---------|------------|-----------|--------|
| Documentation search | Required | - | ✅/❌ |
| Route listing | - | Required | ✅/❌ |
| Config inspection | - | Required | ✅/❌ |
| Best practice checks | Required | Optional | ✅/❌ |
| Full project report | Optional | Required | ✅/❌ |
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

Run this subcommand to get detailed MCP status:

```markdown
## 🔌 MCP Diagnostics Report

### Server Status

| Server | Status | Test Result |
|--------|--------|-------------|
| Astro Docs MCP | [status] | [test query result] |
| astro-mcp | [status] | [config query result] |

### Astro Docs MCP
- **URL:** https://mcp.docs.astro.build/mcp
- **Status:** ✅ Connected / ❌ Not configured / ⚠️ Error
- **Test:** Searched "astro basics" → [result count] results
- **Last verified:** [timestamp]

### astro-mcp (Project Integration)
- **URL:** http://localhost:4321/__mcp/sse
- **Status:** ✅ Connected / ❌ Not installed / ⚠️ Dev server not running
- **Test:** get-astro-config → [success/failure]
- **Astro Version:** [if available]

### Plugin Commands Affected

| Command | Astro Docs | astro-mcp | Current Status |
|---------|------------|-----------|----------------|
| `/start` | Used | Used | ✅ Full / ⚠️ Partial / ❌ Limited |
| `/fix-next` | Required | Optional | ✅ Full / ⚠️ Partial / ❌ Limited |
| `/audit` | Used | Used | ✅ Full / ⚠️ Partial / ❌ Limited |
| `/feature` | Used | Used | ✅ Full / ⚠️ Partial / ❌ Limited |
| `/seo-wins` | - | Optional | ✅ Full / ⚠️ Partial |
| `/deploy-check` | Used | Used | ✅ Full / ⚠️ Partial / ❌ Limited |

### Recommendations

[Based on status, provide specific recommendations]

**If Astro Docs MCP missing:**
> Your commands will work but won't have access to current Astro documentation.
> This may result in outdated patterns being used. See setup instructions above.

**If astro-mcp missing:**
> Project-specific features (route checking, config validation) unavailable.
> Install with: `npx astro add astro-mcp`

**If astro-mcp not running:**
> Start your dev server: `npm run dev`
> Then run `/astro-check mcp` again to verify.
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

| Without astro-mcp | Effect |
|-------------------|--------|
| `/astro-check` | Shows "unavailable" for project info |
| `/start` | Skips route summary |
| `/deploy-check` | Manual config verification needed |

**Recommendation:** Configure at least Astro Docs MCP for best results.
