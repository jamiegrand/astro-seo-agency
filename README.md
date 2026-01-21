# Astro SEO Agency Plugin

[![Version](https://img.shields.io/badge/version-2.2.0-blue.svg)](https://github.com/jamiegrand/astro-seo-agency/releases)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Astro](https://img.shields.io/badge/Astro-4.0%2B-ff5d01.svg?logo=astro)](https://astro.build)
[![Node](https://img.shields.io/badge/Node.js-18%2B-339933.svg?logo=node.js)](https://nodejs.org)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Compatible-6B4FBB.svg)](https://claude.ai/claude-code)

> Complete Astro.js project management with SEO workflows, analytics integration, and structured development for Claude Code.

```
╔═══════════════════════════════════════════════════════════════════╗
║  ASTRO SEO AGENCY                                                 ║
║                                                                   ║
║  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐               ║
║  │ DATA-DRIVEN │  │ SESSION     │  │ STRUCTURED  │               ║
║  │ PRIORITIES  │  │ PERSISTENCE │  │ DEVELOPMENT │               ║
║  └─────────────┘  └─────────────┘  └─────────────┘               ║
║                                                                   ║
║  GA + GSC Integration • Fresh Context Per Task • Atomic Commits  ║
╚═══════════════════════════════════════════════════════════════════╝
```

---

## Features

- **Data-Driven Priorities** - Uses GA and GSC data to prioritize work by traffic impact
- **Session Persistence** - Pause and resume exactly where you left off
- **Structured Features** - GSD-style development with fresh context per task
- **Impact Measurement** - Measure before/after effect of changes
- **SEO Automation** - Find quick wins, audit content, optimize rankings
- **MCP Integration** - Query Astro docs and project state via MCP tools
- **Batch Fixing** - Fix multiple issues in sequence without interruption
- **Smart Merge** - Preserves your existing CLAUDE.md project context on install

---

## Installation

### Option 1: Quick Install (Recommended)

```bash
# Navigate to your Astro project
cd your-astro-project

# Download and run the installer
curl -fsSL https://raw.githubusercontent.com/jamiegrand/astro-seo-agency/main/install.sh | bash
```

### Option 2: Manual Install

```bash
# 1. Clone the plugin repository
git clone https://github.com/jamiegrand/astro-seo-agency.git /tmp/astro-seo-agency

# 2. Run the install script
cd your-astro-project
bash /tmp/astro-seo-agency/install.sh

# 3. Clean up
rm -rf /tmp/astro-seo-agency
```

### Option 3: Copy Files Manually

If you prefer manual control:

```bash
# 1. Create directories
mkdir -p .claude/commands
mkdir -p .planning/archive

# 2. Copy command files
cp -r astro-seo-agency/commands/* .claude/commands/

# 3. Copy configuration templates
cp astro-seo-agency/templates/CLAUDE.md.example ./CLAUDE.md

# 4. Run setup
# In Claude Code, type: /setup
```

---

## Installing on Existing Projects

When you install on a project that already has a `CLAUDE.md`, the installer will ask:

```
Found existing CLAUDE.md

Options:
  1) MERGE    - Add plugin features, keep your project context
  2) REPLACE  - Backup existing, create fresh (saves to CLAUDE.md.backup)
  3) SKIP     - Keep existing unchanged

Choose option (1/2/3) [1]:
```

**Recommended: Choose MERGE (option 1)**

This will:

- ✅ Keep your project name, site URL, and configuration
- ✅ Preserve your project-specific notes
- ✅ Preserve any custom sections you've added
- ✅ Add the plugin's command reference and architecture docs
- ✅ Save a backup to `CLAUDE.md.pre-merge`

---

## Post-Installation Setup

After installing, open your project in Claude Code and run:

```
/start
```

This will initialize your first session with data-driven priorities.

### Configure Analytics (Optional but Recommended)

Create a `.env` file in your project root:

```bash
# Copy the example
cp .env.example .env

# Edit with your values
```

```env
# Google Analytics - for traffic data
GA_PROPERTY_ID=123456789

# Google Search Console - for ranking data
GSC_SITE_URL=https://your-site.com/
GOOGLE_APPLICATION_CREDENTIALS=./credentials/gsc-service-account.json

# GitHub - for issue management (optional)
GITHUB_TOKEN=ghp_xxxxxxxxxxxx
GITHUB_REPO=username/repo-name
```

<details>
<summary>📖 How to get these credentials</summary>

### Google Analytics Property ID

1. Go to [Google Analytics](https://analytics.google.com)
2. Admin → Property Settings
3. Copy the Property ID (numbers only)

### Google Search Console Setup

1. Go to [Google Cloud Console](https://console.cloud.google.com)
2. Create a new project or select existing
3. Enable the Search Console API
4. Create a Service Account
5. Download the JSON key file
6. Add the service account email to your GSC property

### GitHub Token

1. Go to GitHub → Settings → Developer settings → Personal access tokens
2. Generate new token with `repo` scope
3. Copy the token

</details>

---

## Quick Start

```bash
# Start your day - see data-driven priorities
/start

# Fix the highest-impact issue automatically
/fix-next

# Save your progress when stopping
/pause

# Continue tomorrow exactly where you left off
/resume
```

---

## All Commands

### 📋 Session Management

| Command   | Description                                    |
| --------- | ---------------------------------------------- |
| `/start`  | Initialize session with data-driven priorities |
| `/status` | Show current project and session status        |
| `/pause`  | Save session state for later                   |
| `/resume` | Continue from saved session                    |

### 🔧 Issue Resolution

| Command          | Description                                  |
| ---------------- | -------------------------------------------- |
| `/fix-next`      | Auto-select and fix highest priority issue   |
| `/fix-batch [n]` | Fix multiple issues in sequence (default: 5) |
| `/audit [type]`  | Run audit (seo / a11y / perf / astro / full) |

<details>
<summary>Audit types explained</summary>

| Type    | Focus                                                                       |
| ------- | --------------------------------------------------------------------------- |
| `seo`   | Schema markup, meta tags, content quality, internal linking                 |
| `a11y`  | WCAG 2.1 AA compliance, semantic HTML, image alt text                       |
| `perf`  | Core Web Vitals, image optimization, JavaScript analysis                    |
| `astro` | Astro config validation, deprecated patterns, hydration audit, route health |
| `full`  | All of the above (default)                                                  |

</details>

### 📈 SEO & Analytics

| Command        | Description                            |
| -------------- | -------------------------------------- |
| `/seo-wins`    | Find GSC quick wins (position 4-15)    |
| `/content-roi` | Analyze content performance            |
| `/impact [#]`  | Measure before/after effect of changes |

### 🚀 Feature Development

| Command           | Description                 |
| ----------------- | --------------------------- |
| `/feature "desc"` | Plan and build new feature  |
| `/deploy-check`   | Pre-deployment verification |

### 🔌 MCP Integration

| Command                     | Description                                 |
| --------------------------- | ------------------------------------------- |
| `/astro-check`              | Query project info via MCP (routes, config) |
| `/astro-check docs "query"` | Search Astro documentation                  |

### ❓ Help

| Command | Description                 |
| ------- | --------------------------- |
| `/help` | Show all commands and usage |

---

## How It Works

### The 3-Layer Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│  LAYER 1: DATA (What to display)                                │
│  └── src/data/*.js, src/content/**/*.md                         │
│      → CHANGE THIS for content updates                          │
├─────────────────────────────────────────────────────────────────┤
│  LAYER 2: COMPONENTS (How to display)                           │
│  └── src/components/*.astro, src/layouts/*.astro                │
│      → CHANGE THIS only for new features or fixes               │
├─────────────────────────────────────────────────────────────────┤
│  LAYER 3: STYLES (Visual presentation)                          │
│  └── src/styles/global.css, Tailwind utilities                  │
│      → CHANGE THIS for design updates                           │
└─────────────────────────────────────────────────────────────────┘
```

### Impact-Based Prioritization

All issues are scored by potential traffic impact:

```
Impact Score = (Monthly Sessions × Severity) + (GSC Impressions × 0.1)
```

Higher score = fix first.

---

## Workflow Examples

### Daily Maintenance

```bash
/start          # See priorities based on analytics
/fix-next       # Work on highest impact issue
/fix-next       # Continue with next priority
/pause          # Save progress when done
```

### Batch Processing

```bash
/fix-batch      # Fix 5 issues in sequence
/fix-batch 10   # Fix 10 issues
/fix-batch all  # Clear all simple issues
```

### Weekly SEO Review

```bash
/seo-wins       # Find ranking opportunities
/content-roi    # Review content performance
```

### Building Features

```bash
/feature "Add contact form with validation"
# → Answer clarifying questions
# → Review the generated plan
# → Type "go" to execute
```

### Measuring Results

```bash
# After making changes, wait 14+ days, then:
/impact 15      # Measure effect of issue #15
```

---

## Project Structure After Install

```
your-project/
├── .claude/
│   └── commands/          # Slash commands
│       ├── start.md
│       ├── fix-next.md
│       ├── seo-wins.md
│       └── ...
├── .planning/
│   └── archive/           # Archived sessions
├── CLAUDE.md              # Project instructions for Claude
├── AI-INFO.md             # Architecture reference (generated)
├── .env                   # Your credentials (gitignored)
└── .env.example           # Credential template
```

---

## Works Without Analytics

The plugin works great even without Google Analytics or Search Console configured:

| Feature            | With Analytics                  | Without Analytics       |
| ------------------ | ------------------------------- | ----------------------- |
| `/start`           | Shows traffic data + priorities | Shows issue priorities  |
| `/fix-next`        | Ranks by traffic impact         | Ranks by severity       |
| `/seo-wins`        | Full GSC analysis               | Content-based SEO audit |
| `/audit`           | ✅ Full functionality           | ✅ Full functionality   |
| `/feature`         | ✅ Full functionality           | ✅ Full functionality   |
| `/pause`/`/resume` | ✅ Full functionality           | ✅ Full functionality   |

---

## Troubleshooting

### Commands not showing up

```bash
# Verify commands are installed
ls -la .claude/commands/

# Should see: start.md, fix-next.md, etc.
```

### Download failed during installation

This usually means the GitHub repository isn't accessible. Try:

```bash
# Check if you can reach GitHub
curl -I https://raw.githubusercontent.com/jamiegrand/astro-seo-agency/main/install.sh

# If that fails, clone and install locally
git clone https://github.com/jamiegrand/astro-seo-agency.git
cd your-astro-project
bash ../astro-seo-agency/install.sh
```

### "GSC not configured" message

This is normal if you haven't set up Search Console. The plugin will:

- Skip GSC-specific features
- Use code-based SEO analysis instead
- Still provide full functionality for other features

### Build errors after changes

```bash
# Check TypeScript
npm run astro check

# Full build test
npm run build
```

### Need to start fresh

```bash
# Remove session state
rm -rf .planning/HANDOFF.md
rm -rf .planning/SESSION.md

# Run setup again
/setup
```

---

## MCP Setup (Optional)

The plugin integrates with MCP servers for enhanced functionality. Both are optional but recommended.

### Astro Docs MCP

Search official Astro documentation directly from Claude Code.

**Auto-configured on install:** The installer creates `.mcp.json` in your project root with Astro Docs MCP pre-configured. No manual setup needed.

<details>
<summary>Manual configuration (if needed)</summary>

MCP servers can be configured in multiple locations:

| Location | Scope | File |
|----------|-------|------|
| **Project** (recommended) | This project only | `.mcp.json` in project root |
| **User (CLI)** | All projects (CLI) | `~/.claude/mcp.json` |
| **User (VS Code)** | All projects (VS Code) | VS Code Settings → Claude Code → MCP Servers |

**Project-level config** (`.mcp.json`):
```json
{
  "mcpServers": {
    "astro-docs": {
      "type": "url",
      "url": "https://mcp.docs.astro.build/mcp"
    }
  }
}
```

**User-level config** (`~/.claude/mcp.json`):
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

</details>

### astro-mcp (Project Integration)

Query your project's routes, config, and integrations when the dev server is running.

```bash
npx astro add astro-mcp
```

Then start your dev server - MCP endpoint available at `http://localhost:4321/__mcp/sse`.

### Usage

```bash
/astro-check              # Full project report
/astro-check routes       # List all routes
/astro-check config       # Show configuration
/astro-check docs "image" # Search Astro docs for "image"
```

---

## Requirements

- **Astro** 4.0+ (optimized for Astro 5)
- **Node.js** 18+
- **Claude Code** (VS Code extension or CLI)

### Optional

- Google Analytics 4 property
- Google Search Console access
- GitHub repository (for issue tracking)
- Astro Docs MCP (for documentation search)
- astro-mcp integration (for project state queries)

---

## Updating

```bash
# Re-run the installer to update commands
curl -fsSL https://raw.githubusercontent.com/jamiegrand/astro-seo-agency/main/install.sh | bash
```

When updating, choose **MERGE** to keep your existing project configuration while getting the latest commands.

---

## Uninstalling

```bash
# Remove plugin files
rm -rf .claude/commands/
rm -rf .planning/
rm -f CLAUDE.md AI-INFO.md

# Remove from .gitignore (optional)
# Edit .gitignore and remove the "Astro SEO Agency" section
```

---

## Contributing

Contributions welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

---

## License

MIT

---

**Built for Astro.js developers who want data-driven, structured workflows.**
