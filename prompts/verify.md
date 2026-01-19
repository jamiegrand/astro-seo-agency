---
description: Verify plugin installation is complete and working
---

# Installation Verification

Run this command to verify the Astro SEO Agency plugin is correctly installed.

---

## Step 1: Check Installed Files

Verify all required files exist:

```bash
# Check commands directory
ls -la .claude/commands/
```

### Expected Files (16 total)

**Commands (14):**
- [ ] `start.md`
- [ ] `fix-next.md`
- [ ] `fix-batch.md`
- [ ] `seo-wins.md`
- [ ] `content-roi.md`
- [ ] `impact.md`
- [ ] `feature.md`
- [ ] `pause.md`
- [ ] `resume.md`
- [ ] `status.md`
- [ ] `audit.md`
- [ ] `astro-check.md`
- [ ] `deploy-check.md`
- [ ] `help.md`

**Prompts (2):**
- [ ] `setup.md`
- [ ] `brownfield.md`

### Report File Status

```markdown
## 📁 File Check

| Category | Expected | Found | Status |
|----------|----------|-------|--------|
| Commands | 14 | [count] | ✅/❌ |
| Prompts | 2 | [count] | ✅/❌ |
| CLAUDE.md | 1 | [0/1] | ✅/❌ |
| .env.example | 1 | [0/1] | ✅/❌ |
| .planning/ | exists | [yes/no] | ✅/❌ |

### Missing Files
[List any missing files]
```

---

## Step 2: Verify Frontmatter

Check that command files have valid frontmatter:

```bash
# Check a few key files for frontmatter
head -3 .claude/commands/start.md
head -3 .claude/commands/setup.md
head -3 .claude/commands/brownfield.md
```

### Expected Format

Each file should start with:
```yaml
---
description: [description text]
---
```

### Report Frontmatter Status

```markdown
## 📝 Frontmatter Check

| File | Has Frontmatter | Description Present |
|------|-----------------|---------------------|
| start.md | ✅/❌ | ✅/❌ |
| setup.md | ✅/❌ | ✅/❌ |
| brownfield.md | ✅/❌ | ✅/❌ |
| help.md | ✅/❌ | ✅/❌ |
```

---

## Step 3: Check MCP Configuration

### Check for .mcp.json

```bash
cat .mcp.json 2>/dev/null || echo "Not found"
```

### Check MCP Server Availability

Attempt to use the `search_astro_docs` tool:

```
Search: "astro basics"
```

### Report MCP Status

```markdown
## 🔌 MCP Status

| Server | Configured | Connected |
|--------|------------|-----------|
| Astro Docs MCP | ✅/❌ | ✅/❌ |
| astro-mcp | ✅/❌ | ✅/❌ (requires dev server) |

[If Astro Docs MCP not working, show setup instructions]
```

---

## Step 4: Verify Project Detection

Check this is an Astro project:

```bash
# Check package.json for Astro
grep -q "astro" package.json && echo "✅ Astro detected" || echo "❌ Astro not found"

# Get Astro version
grep '"astro"' package.json
```

### Report Project Status

```markdown
## 🚀 Project Detection

| Check | Result |
|-------|--------|
| package.json exists | ✅/❌ |
| Astro dependency | ✅/❌ |
| Astro version | [version] |
| src/ directory | ✅/❌ |
| astro.config.mjs | ✅/❌ |
```

---

## Step 5: Test Key Commands

### Test /help

The `/help` command should list all available commands including:
- `/setup`
- `/brownfield`
- `/start`
- `/fix-next`

### Test /astro-check mcp

Run `/astro-check mcp` to verify MCP diagnostics work.

---

## Final Report

```markdown
## ✅ Installation Verification Complete

### Summary

| Category | Status |
|----------|--------|
| Files Installed | ✅ 16/16 |
| Frontmatter Valid | ✅/❌ |
| MCP Configured | ✅/⚠️/❌ |
| Project Detected | ✅/❌ |

### Commands Available

**Session:** /start, /status, /pause, /resume
**Issues:** /fix-next, /fix-batch, /audit
**SEO:** /seo-wins, /content-roi, /impact
**Development:** /feature, /deploy-check, /astro-check
**Setup:** /setup, /brownfield
**Help:** /help

### Next Steps

[If all passed:]
✅ **Installation verified!**

Run `/setup` to configure the plugin for your project, or `/start` to begin working.

[If issues found:]
⚠️ **Issues detected:**

1. [Issue description]
   → [How to fix]

2. [Issue description]
   → [How to fix]

### Quick Fix Commands

```bash
# Re-run installer to fix missing files
curl -fsSL https://raw.githubusercontent.com/jamiegrand/astro-seo-agency/main/install.sh | bash

# Or run /setup to configure
/setup
```
```

---

## Troubleshooting

### "Command not found" when running /setup or /brownfield

The prompts may not have been installed. Re-run the installer:

```bash
curl -fsSL https://raw.githubusercontent.com/jamiegrand/astro-seo-agency/main/install.sh | bash
```

### Files exist but commands don't work

1. Restart Claude Code
2. Check that `.claude/commands/` is in your project root
3. Verify files have correct frontmatter

### MCP not connecting

See `/astro-check mcp` for detailed MCP diagnostics and setup instructions.
