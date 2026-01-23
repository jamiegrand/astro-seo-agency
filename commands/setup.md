---
description: Setup wizard, verification, and configuration tools
argument-hint: "[existing|verify|commands|index|help]"
---

# /setup - Configuration & Help

Run the setup wizard or access configuration tools.

## Subcommands

| Subcommand | Direct Command | Description |
|------------|----------------|-------------|
| (none) | — | Interactive setup wizard (below) |
| `existing` | `/setup-existing` | Analyze existing Astro project |
| `verify` | `/setup-verify` | Verify plugin installation |
| `commands` | `/setup-commands` | Generate custom commands |
| `index [action]` | `/setup-index` | Manage project indexing |
| `help` | `/help` | Show all available commands |

## Routing

**No subcommand:** Execute the setup wizard (content below).

**With subcommand:** Route to implementation file:
- `existing` → Read `commands/setup-existing.md` and execute
- `verify` → Read `commands/setup-verify.md` and execute
- `commands` → Read `commands/setup-commands.md` and execute
- `index` → Read `commands/setup-index.md` and execute
- `help` → Read `commands/help.md` and execute

## Examples

```bash
/setup              # Run setup wizard
/setup existing     # Brownfield analysis
/setup verify       # Check installation
/setup commands     # Generate custom commands
/setup index run    # Run project indexing
/setup help         # Show all commands
```

---

# Setup Wizard

Interactive setup for the Astro SEO Agency plugin with Astro MCP integration.

---

## Automatic Detection

First, I'll analyze your project automatically:

```bash
# Detect project configuration
cat package.json
ls -la src/
```

```markdown
## Project Analysis

### Detected Configuration

| Item | Value | Status |
|------|-------|--------|
| Project Name | [from package.json] | |
| Astro Version | [version] | |
| Tailwind | [yes/no] | |
| TypeScript | [yes/no] | |
| Content Collections | [yes/no] | |

### Directory Structure
```
src/
├── components/    [X files]
├── content/       [X files]
├── data/          [X files]
├── layouts/       [X files]
├── pages/         [X files]
└── styles/        [X files]
```

### Existing Configuration
- [ ] CLAUDE.md: [Found/Missing]
- [ ] AI-INFO.md: [Found/Missing]
- [ ] .env: [Found/Missing]
- [ ] Issue tracker: [Found/Missing]
- [ ] astro-mcp: [Installed/Not installed]
```

---

## Step 1: Basic Information

I've detected most settings automatically. Please confirm or update:

```markdown
### Project Settings

1. **Project Name:** [detected]
   → Press Enter to accept, or type a new name

2. **Site URL:**
   → Enter your production URL (e.g., https://example.com)

3. **Business Type:**
   - [ ] Local Business (services in specific locations)
   - [ ] E-commerce (products for sale)
   - [ ] SaaS (software product)
   - [ ] Agency/Portfolio (showcase work)
   - [ ] Blog/Content (articles, guides)
   - [ ] Documentation site
   - [ ] Other

Type your choices or say "auto" to use detected values.
```

---

## Step 2: Astro MCP Setup

```markdown
### Astro MCP Integration

This plugin works best with two MCP servers that provide:
- **Real-time Astro documentation** (always current, no outdated info)
- **Project awareness** (routes, config, content locations)

#### Astro Docs MCP (Recommended)
Gives Claude access to official Astro documentation.

**Status:** [Checking...]

**Setup:**
Add to your MCP configuration (Claude Desktop, VS Code, etc.):
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

#### astro-mcp Integration (Recommended)
Gives Claude awareness of your project's routes and configuration.

**Status:** [Checking package.json...]

[If not installed:]
**Install now?**
```bash
npx astro add astro-mcp
```

[If installed:]
Already installed! Make sure to run `npm run dev` for full functionality.

---

**Configure MCP servers?**
1. **"yes"** - I'll guide you through setup
2. **"later"** - Skip for now (can configure anytime)
3. **"skip"** - Don't use MCP features
```

---

## Step 3: Analytics Configuration

```markdown
### Analytics Setup (Optional)

Analytics integration enables:
- Traffic-based priority scoring
- SEO quick wins detection
- Impact measurement
- Content ROI analysis

**Do you want to configure analytics?**

1. **"yes"** - Configure Google Analytics + Search Console
2. **"later"** - Skip for now, configure later
3. **"no"** - Use without analytics (still fully functional)
```

### If "yes":

```markdown
### Google Analytics

Enter your GA4 Property ID (numbers only):
→ Find it: GA Admin → Property Settings → Property ID

**GA_PROPERTY_ID:** _______________

---

### Google Search Console

Enter your site URL exactly as it appears in GSC:
→ Usually: https://your-site.com/ (with trailing slash)

**GSC_SITE_URL:** _______________

---

### GSC Authentication

For Search Console, you need a service account:

1. Go to [Google Cloud Console](https://console.cloud.google.com)
2. Create or select a project
3. Enable "Search Console API"
4. Create a Service Account
5. Download the JSON key
6. Save it to: `./credentials/gsc-service-account.json`
7. Add the service account email to your GSC property

**Have you completed this setup?**
- "done" - I've set up the service account
- "help" - Show me detailed instructions
- "skip" - Skip GSC for now
```

---

## Step 4: Issue Tracking

```markdown
### Issue Tracking Setup

Choose how to track SEO issues and tasks:

**Option A: GitHub Issues** (Recommended for teams)
- Integrated with your repository
- Labels, milestones, assignments
- Requires GitHub token

**Option B: Markdown Tracker** (Simple, local)
- Single file: AUDIT_TRACKER.md
- Works offline
- No setup required

**Option C: None**
- Manual tracking
- Commands still work

Which do you prefer? (A/B/C)
```

---

## Step 5: Project Indexing

Index project structure for AI-INFO.md generation and database-backed commands.

```markdown
### Project Indexing

Indexing your project enables:
- AI-INFO.md auto-generation
- Faster command execution (queries database instead of scanning files)
- Content inventory tracking
- Route-to-file mapping for SEO commands

---

### Phase 1: Quick Scan (Required)

Scanning project structure...

| Item | Count |
|------|-------|
| Content Collections | X |
| Collection Items | X |
| Pages | X |
| Components | X |
| Data Files | X |

Quick scan complete (X.Xs)
```

---

## Step 6: Generate Configuration Files

Based on your choices and indexed data, generating:

```markdown
### Generating Files

| File | Status |
|------|--------|
| CLAUDE.md | Creating... |
| AI-INFO.md | Analyzing project... |
| .env | Writing credentials... |
| .gitignore | Updating... |
| .vscode/mcp.json | Creating (if VS Code)... |

**Look good?** (yes/edit)
```

---

## Step 7: Verify Astro MCP

```markdown
### Verifying MCP Setup

#### Astro Docs MCP
[Attempting to search docs...]

[If working:]
**Astro Docs MCP working!**
Successfully searched for "astro basics"

[If not working:]
**Astro Docs MCP not responding**
- Check your MCP configuration
- Restart Claude/editor after adding config
- Try again with `/astro-check docs "test"`

#### astro-mcp
[Checking for dev server...]

[If working:]
**astro-mcp working!**
Found [X] routes, [X] integrations

[If not working:]
**astro-mcp not available**
- Is dev server running? `npm run dev`
- Is astro-mcp installed? Check astro.config.mjs
- Run `/astro-check` after starting dev server
```

---

## Step 8: Initial Audit (Optional)

```markdown
### Initial SEO Audit

Would you like me to run an initial audit to find issues?

This will check:
- Meta tags on all pages
- Schema markup validity
- Image optimization
- Accessibility basics
- Internal linking
- **Astro best practices** (via Astro Docs MCP)
- **Route completeness** (via astro-mcp)

**Options:**
- **"full"** - Complete audit including Astro checks
- **"quick"** - Critical issues only
- **"skip"** - Do this later with `/audit`
```

---

## Step 9: Completion

```markdown
## Setup Complete!

### Configuration Summary

| Setting | Value |
|---------|-------|
| Project | [name] |
| Site URL | [url] |
| Astro Docs MCP | Configured / Skipped |
| astro-mcp | Installed / Skipped |
| Analytics | Configured / Skipped |
| Issue Tracker | GitHub / Markdown / None |
| Project Index | Complete / Running in background |
| Initial Issues | [X] found |

### Files Created/Updated
- CLAUDE.md
- AI-INFO.md (generated from index)
- .env
- .gitignore
- .planning/
- .planning/seo-audit.db (project index)
- .vscode/mcp.json (if applicable)

---

### You're Ready!

**Start your first session:**
```bash
/start
```

**Or jump right in:**
```bash
/fix-next       # Fix highest priority issue
/seo-wins       # Find ranking opportunities
/audit          # Run full audit
/astro-check    # See project info via MCP
```

---

### Quick Reference Card

| Task | Command |
|------|---------|
| Start day | `/start` |
| Fix issues | `/fix` |
| SEO analysis | `/seo wins` |
| Content review | `/seo roi` |
| Build feature | `/feature "desc"` |
| Check Astro | `/astro-check` |
| Save progress | `/pause` |
| Continue | `/resume` |
| All commands | `/help` |

---

Happy building!
```

---

## Error Handling

### If package.json not found:

```markdown
## Not in a Project Directory

I couldn't find a package.json file.

**Please either:**
1. Navigate to your Astro project root
2. Create a new Astro project first:
   ```bash
   npm create astro@latest
   ```
3. Run `/setup` again from the project directory
```

### If not an Astro project:

```markdown
## Not an Astro Project

This appears to be a [detected framework] project, not Astro.

This plugin is specifically designed for Astro.js projects.

**Options:**
1. **Continue anyway** - Some features may not work correctly
2. **Cancel** - Exit setup

Note: Astro MCP features will not work with non-Astro projects.
```

### If MCP setup fails:

```markdown
## MCP Setup Issue

**Problem:** [description]

**Don't worry!** The plugin works without MCP, just with reduced features:
- Real-time Astro docs access
- Project route awareness
- All other commands work normally

You can configure MCP later by running `/setup` again.

Continue without MCP? (yes/retry)
```
