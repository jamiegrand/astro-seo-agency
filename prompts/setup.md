# Project Setup Wizard

Initialize a new or existing Astro project with the complete SEO Agency workflow.

---

## Usage

Run this setup when:
- Starting a new Astro project
- Adding the plugin to an existing project
- Reconfiguring an existing setup

---

## Step 1: Gather Project Information

```markdown
## 🚀 Astro SEO Agency Setup

Let's configure your project. Please provide:

### Required Information

1. **Project Name:** 
   (e.g., "Sitech London", "My Agency Site")

2. **Site URL:** 
   (e.g., https://example.com)

3. **Is this a new or existing project?**
   - [ ] New project (greenfield)
   - [ ] Existing project (brownfield)

### Analytics (Recommended)

4. **Google Analytics Property ID:**
   (e.g., 509657124)
   
5. **Google Search Console URL:**
   (Usually same as site URL)

### Optional

6. **GitHub Repository:**
   (e.g., username/repo-name)

7. **Business Type:**
   - [ ] Local Business
   - [ ] E-commerce
   - [ ] SaaS
   - [ ] Agency/Portfolio
   - [ ] Blog/Content
   - [ ] Other

8. **Primary Services/Products:**
   (Brief list for schema markup)
```

---

## Step 2: Existing Project Detection

If existing project:

```bash
# Check for existing configuration
ls -la CLAUDE.md AI-INFO.md .claude/
ls -la src/data/ src/content/ src/components/
cat package.json | grep -E "astro|tailwind"
```

```markdown
### Existing Setup Detected

| Item | Status | Action |
|------|--------|--------|
| CLAUDE.md | ✅ Found / ❌ Missing | [Merge/Create] |
| AI-INFO.md | ✅ Found / ❌ Missing | [Update/Create] |
| .claude/commands/ | ✅ Found / ❌ Missing | [Add/Create] |
| Issue tracker | ✅ Found / ❌ Missing | [Keep/Create] |

**Recommendation:** [Merge existing with new / Fresh setup]

How would you like to proceed?
- **"merge"** - Keep existing, add new features
- **"replace"** - Start fresh with new configuration
- **"review"** - Show me what would change
```

---

## Step 3: Create Directory Structure

```bash
# Create required directories
mkdir -p .claude/commands
mkdir -p .planning/archive
mkdir -p AI

# Create if not exists
touch .env.example
```

---

## Step 4: Generate Configuration Files

### CLAUDE.md

Generate from template with provided values:
- Project name
- Site URL
- GA Property ID
- GSC URL
- Framework version (detected)
- Business type
- Custom notes

### AI-INFO.md (For Existing Projects)

If existing project, generate comprehensive AI-INFO.md:

```markdown
# [Project Name] - Architecture Reference

## Quick Reference
- Framework: Astro [version]
- Styling: Tailwind [version]
- Site: [URL]

## Data Architecture
[Discovered from src/data/]

## Component Patterns
[Discovered from src/components/]

## Page Routes
[Discovered from src/pages/]

## Content Collections
[Discovered from src/content/]

## Styling Conventions
[Discovered from styles]

## Business Context
[From user input]
```

### .env.example

```bash
# Google Analytics
GA_PROPERTY_ID=

# Google Search Console
GSC_SITE_URL=
GOOGLE_APPLICATION_CREDENTIALS=

# GitHub (optional)
GITHUB_TOKEN=
GITHUB_REPO=

# Brave Search (optional)
BRAVE_API_KEY=
```

### .mcp.json (Project-scoped)

```json
{
  "mcpServers": {
    "gsc": {
      "command": "npx",
      "args": ["-y", "mcp-server-gsc"],
      "env": {
        "GOOGLE_APPLICATION_CREDENTIALS": "${GOOGLE_APPLICATION_CREDENTIALS}"
      }
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    },
    "sequential-thinking": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-sequential-thinking"]
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "context7-mcp"]
    }
  }
}
```

---

## Step 5: Install Commands

Copy all command files to `.claude/commands/`:

```
.claude/commands/
├── start.md
├── fix-next.md
├── seo-wins.md
├── content-roi.md
├── impact.md
├── feature.md
├── pause.md
├── resume.md
├── status.md
├── audit.md
├── deploy-check.md
└── help.md
```

---

## Step 6: Set Up Issue Tracking

```markdown
### Issue Tracking Setup

**Option A: GitHub Issues (Recommended for teams)**
- [ ] Enable GitHub MCP
- [ ] Create labels: priority:critical, priority:high, etc.
- [ ] Create initial issues from audit

**Option B: Markdown Tracker (Simple, local)**
- [ ] Create AUDIT_TRACKER.md
- [ ] Add initial issues
- [ ] Configure phases

Which would you prefer?
```

If Markdown Tracker:
```markdown
# [Project Name] - Issue Tracker

## Overview
- **Total Issues:** 0
- **Complete:** 0
- **In Progress:** 0

---

## Phase 1: Critical Fixes

### [ ] Issue #1: [Title]
- **Priority:** Critical
- **Type:** [SEO/Bug/A11y/Perf]
- **Affected Pages:** [URLs]
- **Description:** [Description]
- **Estimated Time:** [X] min
- **Files to Modify:**
  - `path/to/file`

---

## Phase 2: High Priority
[To be populated after audit]

---

## Phase 3: Medium Priority
[To be populated after audit]

---

## Completed
[Completed issues moved here]
```

---

## Step 7: Run Initial Audit (Optional)

```markdown
### Initial SEO Audit

Would you like me to run an initial SEO audit to populate your issue tracker?

This will check:
- [ ] Meta tags on all pages
- [ ] Schema markup
- [ ] Image optimization
- [ ] Accessibility basics
- [ ] Internal linking

**Options:**
- **"Yes, full audit"** - Run comprehensive audit
- **"Yes, quick scan"** - Check critical items only
- **"Skip"** - Set up later with `/audit`
```

---

## Step 8: Verification

```markdown
### ✅ Setup Verification

| Check | Status |
|-------|--------|
| CLAUDE.md exists | ✅ / ❌ |
| AI-INFO.md exists | ✅ / ❌ |
| Commands installed | ✅ / ❌ |
| .planning/ directory | ✅ / ❌ |
| Issue tracker ready | ✅ / ❌ |
| Build passes | ✅ / ❌ |

### Test Commands

Try these commands to verify setup:

```bash
/help          # Should show all commands
/status        # Should show project status
/start         # Should initialize session
```
```

---

## Step 9: Final Summary

```markdown
## 🎉 Setup Complete!

### Project: [Name]
**Site:** [URL]
**Framework:** Astro [version]

### Configuration Created
- ✅ CLAUDE.md - Project instructions
- ✅ AI-INFO.md - Architecture reference
- ✅ .claude/commands/ - [X] commands installed
- ✅ .planning/ - Session persistence
- ✅ Issue tracker - [GitHub/Markdown]

### MCP Servers
| Server | Status |
|--------|--------|
| Google Analytics | [Configured/Needs setup] |
| Search Console | [Configured/Needs setup] |
| GitHub | [Configured/Needs setup] |

### Next Steps

1. **Add credentials** (if not done):
   ```bash
   cp .env.example .env
   # Edit .env with your values
   ```

2. **Start your first session:**
   ```bash
   /start
   ```

3. **Run initial audit** (recommended):
   ```bash
   /audit full
   ```

4. **Begin work:**
   ```bash
   /fix-next
   ```

---

### Quick Reference

| Task | Command |
|------|---------|
| Start session | `/start` |
| Fix issues | `/fix-next` |
| SEO opportunities | `/seo-wins` |
| Content analysis | `/content-roi` |
| Build feature | `/feature "desc"` |
| Save progress | `/pause` |
| Continue | `/resume` |
| All commands | `/help` |

---

Happy building! 🚀
```
