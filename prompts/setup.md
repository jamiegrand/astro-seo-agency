# Project Setup Wizard

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
## 🔍 Project Analysis

### Detected Configuration

| Item | Value | Status |
|------|-------|--------|
| Project Name | [from package.json] | ✅ |
| Astro Version | [version] | ✅ |
| Tailwind | [yes/no] | ✅/❌ |
| TypeScript | [yes/no] | ✅/❌ |
| Content Collections | [yes/no] | ✅/❌ |

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

## Step 2: Astro MCP Setup (NEW)

```markdown
### 🔌 Astro MCP Integration

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
✅ Already installed! Make sure to run `npm run dev` for full functionality.

---

**Configure MCP servers?**
1. **"yes"** - I'll guide you through setup
2. **"later"** - Skip for now (can configure anytime)
3. **"skip"** - Don't use MCP features
```

### If "yes" for MCP Setup:

```markdown
### Astro Docs MCP Setup

This is a remote server - no installation needed, just configuration.

**For Claude Desktop:**
1. Open Claude Desktop settings
2. Go to MCP Servers
3. Add new server with:
   - Name: `astro-docs`
   - Command: `npx`
   - Args: `-y`, `mcp-remote`, `https://mcp.docs.astro.build/mcp`

**For VS Code:**
Create `.vscode/mcp.json`:
```json
{
  "servers": {
    "Astro Docs": {
      "type": "http",
      "url": "https://mcp.docs.astro.build/mcp"
    }
  }
}
```

**Verify:** Ask me "search Astro docs for content collections"

---

### astro-mcp Integration Setup

This runs inside your Astro project.

**Step 1: Install**
```bash
npx astro add astro-mcp
```

**Step 2: Verify** (in astro.config.mjs)
```javascript
import mcp from 'astro-mcp';

export default defineConfig({
  integrations: [mcp()]
});
```

**Step 3: Start dev server**
```bash
npm run dev
```

**Verify:** Run `/astro-check` to see your project info

---

**MCP Setup Status:**
- [ ] Astro Docs MCP configured
- [ ] astro-mcp installed
- [ ] Dev server running

Continue? (yes / help with [item] / skip)
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

### If GitHub:

```markdown
### GitHub Configuration

**Repository:** [detected or enter username/repo]

**GitHub Token:**
1. Go to: GitHub → Settings → Developer settings → Personal access tokens
2. Generate new token with 'repo' scope
3. Enter token below (stored in .env, gitignored)

**GITHUB_TOKEN:** _______________

[Token entered]
✅ Validating access... 
✅ Repository access confirmed
```

### If Markdown:

```markdown
### Markdown Tracker

Creating AUDIT_TRACKER.md...

✅ Tracker created

You can:
- Add issues manually
- Run `/audit` to populate automatically
- Use `/fix-next` to work through issues
```

---

## Step 5: Generate Configuration Files

Based on your choices, generating:

```markdown
### 📝 Generating Files

| File | Status |
|------|--------|
| CLAUDE.md | ✅ Creating... |
| AI-INFO.md | ✅ Analyzing project... |
| .env | ✅ Writing credentials... |
| .gitignore | ✅ Updating... |
| .vscode/mcp.json | ✅ Creating (if VS Code)... |

#### CLAUDE.md Preview
```markdown
# [Project Name] - Claude Code Instructions

| Field | Value |
|-------|-------|
| Framework | Astro [version] |
| Site URL | [url] |
| Analytics | [Configured/Not configured] |
| Astro MCP | [Configured/Not configured] |
...
```

**Look good?** (yes/edit)
```

---

## Step 6: Verify Astro MCP (NEW)

```markdown
### 🔌 Verifying MCP Setup

#### Astro Docs MCP
[Attempting to search docs...]

[If working:]
✅ **Astro Docs MCP working!**
Successfully searched for "astro basics"

[If not working:]
⚠️ **Astro Docs MCP not responding**
- Check your MCP configuration
- Restart Claude/editor after adding config
- Try again with `/astro-check docs "test"`

#### astro-mcp
[Checking for dev server...]

[If working:]
✅ **astro-mcp working!**
Found [X] routes, [X] integrations

[If not working:]
⚠️ **astro-mcp not available**
- Is dev server running? `npm run dev`
- Is astro-mcp installed? Check astro.config.mjs
- Run `/astro-check` after starting dev server
```

---

## Step 7: Initial Audit (Optional)

```markdown
### 🔍 Initial SEO Audit

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
- **"full"** - Complete audit including Astro checks (takes 2-3 minutes)
- **"quick"** - Critical issues only (30 seconds)
- **"skip"** - Do this later with `/audit`
```

### If audit selected:

```markdown
### Running Audit...

[Progress indicator]

Checking meta tags... ✅
Checking schema... ✅
Checking images... ✅
Checking accessibility... ✅
Checking links... ✅
Checking Astro patterns... ✅ (via Astro Docs MCP)
Verifying routes... ✅ (via astro-mcp)

---

### 📊 Audit Results

| Category | Issues Found |
|----------|--------------|
| SEO | X critical, X high |
| Accessibility | X critical, X high |
| Performance | X warnings |
| Astro Best Practices | X recommendations |

**Top Priority Issues:**
1. [Issue] - Critical
2. [Issue] - Critical
3. [Issue] - High

**Astro-Specific Findings:**
- [Finding based on docs check]
- [Finding based on route analysis]

These have been added to your issue tracker.

Run `/fix-next` to start fixing them!
```

---

## Step 8: Completion

```markdown
## ✅ Setup Complete!

### Configuration Summary

| Setting | Value |
|---------|-------|
| Project | [name] |
| Site URL | [url] |
| Astro Docs MCP | ✅ Configured / ⏭️ Skipped |
| astro-mcp | ✅ Installed / ⏭️ Skipped |
| Analytics | ✅ Configured / ⏭️ Skipped |
| Issue Tracker | GitHub / Markdown / None |
| Initial Issues | [X] found |

### Files Created/Updated
- ✅ CLAUDE.md
- ✅ AI-INFO.md
- ✅ .env
- ✅ .gitignore
- ✅ .planning/
- ✅ .vscode/mcp.json (if applicable)

### MCP Status
| Server | Status | Benefit |
|--------|--------|---------|
| Astro Docs | ✅/⏭️ | Real-time documentation |
| astro-mcp | ✅/⏭️ | Project awareness |

---

### 🚀 You're Ready!

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
| Fix issues | `/fix-next` |
| SEO analysis | `/seo-wins` |
| Content review | `/content-roi` |
| Build feature | `/feature "desc"` |
| Check Astro | `/astro-check` |
| Save progress | `/pause` |
| Continue | `/resume` |
| All commands | `/help` |

---

### 💡 Tips for Best Results

1. **Keep dev server running** for full astro-mcp features
2. **MCP servers** give Claude current Astro knowledge
3. **Run `/start`** at the beginning of each session
4. **Use `/pause`** to save context between sessions

---

Happy building! 🎉
```

---

## Error Handling

### If package.json not found:

```markdown
## ⚠️ Not in a Project Directory

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
## ⚠️ Not an Astro Project

This appears to be a [detected framework] project, not Astro.

This plugin is specifically designed for Astro.js projects.

**Options:**
1. **Continue anyway** - Some features may not work correctly
2. **Cancel** - Exit setup

Note: Astro MCP features will not work with non-Astro projects.
```

### If MCP setup fails:

```markdown
## ⚠️ MCP Setup Issue

**Problem:** [description]

**Don't worry!** The plugin works without MCP, just with reduced features:
- ❌ Real-time Astro docs access
- ❌ Project route awareness
- ✅ All other commands work normally

You can configure MCP later by running `/setup` again or following the guide in `prompts/astro-mcp-integration.md`.

Continue without MCP? (yes/retry)
```
