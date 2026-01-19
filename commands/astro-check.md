---
description: Query Astro project info via MCP (routes, config, integrations)
---

# Astro Project Check

Query your Astro project's runtime information using the astro-mcp integration and search official documentation via Astro Docs MCP.

---

## Prerequisites

### astro-mcp Integration (For Project Info)

```bash
npx astro add astro-mcp
```

Server runs at `http://localhost:4321/__mcp/sse` when dev server is active.

### Astro Docs MCP (For Documentation)

Add to MCP config:
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

---

## Step 1: Check MCP Availability

```markdown
## 🔌 MCP Connection Status

| Server | Status | URL |
|--------|--------|-----|
| Astro Docs MCP | ✅/❌ | https://mcp.docs.astro.build/mcp |
| astro-mcp (project) | ✅/❌ | http://localhost:4321/__mcp/sse |
```

---

## Step 2: Query Project Configuration

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
| `/astro-check config` | Configuration only |
| `/astro-check routes` | Routes only |
| `/astro-check routes [filter]` | Filter routes |
| `/astro-check docs "[query]"` | Search docs |
| `/astro-check health` | Quick health check |

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
