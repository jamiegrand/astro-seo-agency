# Astro SEO Agency Plugin

> Complete Astro.js project management with SEO workflows, analytics integration, and structured development.

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

## What It Does

- **Data-Driven Priorities** - Uses GA and GSC data to prioritize work by traffic impact
- **Session Persistence** - Pause and resume exactly where you left off
- **Structured Features** - GSD-style development with fresh context per task
- **Impact Measurement** - Measure before/after effect of changes
- **SEO Automation** - Find quick wins, audit content, optimize rankings

---

## Installation

```bash
# Add the marketplace
/plugin marketplace add jamiegrand/astro-seo-agency

# Install the plugin
/plugin install astro-seo-agency

# Run setup
/setup
```

---

## Quick Start

```bash
# Start your day
/start

# Fix the highest-impact issue
/fix-next

# Save progress
/pause

# Continue tomorrow
/resume
```

---

## Commands

### Session Management

| Command   | Description                                    |
| --------- | ---------------------------------------------- |
| `/start`  | Initialize session with data-driven priorities |
| `/status` | Show current project and session status        |
| `/pause`  | Save session state, create handoff document    |
| `/resume` | Restore session from handoff                   |

### Issue Resolution

| Command         | Description                                  |
| --------------- | -------------------------------------------- |
| `/fix-next`     | Auto-select and fix highest priority issue   |
| `/audit [type]` | Run comprehensive audit (seo/a11y/perf/full) |

### SEO & Analytics

| Command        | Description                            |
| -------------- | -------------------------------------- |
| `/seo-wins`    | Find GSC quick wins (position 4-15)    |
| `/content-roi` | Analyze content performance            |
| `/impact [#]`  | Measure before/after effect of changes |

### Feature Development

| Command             | Description                            |
| ------------------- | -------------------------------------- |
| `/feature "desc"`   | Plan and build new feature (GSD-style) |
| `/feature:plan`     | Show current feature plan              |
| `/feature:work [n]` | Execute specific task                  |

### Deployment

| Command         | Description                 |
| --------------- | --------------------------- |
| `/deploy-check` | Pre-deployment verification |
| `/help`         | Show all commands           |

---

## Workflow Examples

### Daily Maintenance

```bash
# Morning: See what needs work
/start

# Output shows:
# - Traffic overview (GA)
# - Quick wins (GSC)
# - Prioritized issues (by impact score)

# Work on highest priority
/fix-next

# Repeat until done
/fix-next
/fix-next

# Save progress
/pause
```

### Weekly SEO Review

```bash
# Find ranking opportunities
/seo-wins

# Output shows:
# - Almost there (position 4-10, low CTR)
# - Low hanging fruit (position 11-20)
# - Content gaps
# - Declining queries

# Implement quick wins
/fix-next
```

### Building a New Feature

```bash
# Start feature development
/feature "Add schema markup for location pages"

# Answer clarifying questions
# Review the plan
# Say "go" to execute

# Each task runs with fresh context
# Atomic commits for each task
# Quality gates on every step
```

### Measuring Impact

```bash
# After making changes, wait 14 days, then:
/impact 15

# Output shows:
# - Before/after comparison
# - Traffic changes
# - Ranking changes
# - ROI calculation
```

---

## Architecture

### The 3-Layer Model

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

**Golden Rule:** Prefer data changes over code changes.

### Zone Ownership (For Features)

```yaml
ALPHA (Foundation):
  - src/layouts/
  - src/styles/
  - src/config/

BETA (Components & Data):
  - src/components/
  - src/data/
  - src/content/

GAMMA (Pages & Integration):
  - src/pages/
  - public/
```

### Impact Scoring

All issues are prioritized by:

```
Impact Score = (Monthly Sessions × Severity) + (GSC Impressions × 0.1)
```

Higher score = fix first.

---

## Configuration

### Required Files

After setup, your project will have:

```
your-project/
├── .claude/
│   └── commands/           # All slash commands
├── .planning/
│   └── archive/            # Archived handoffs
├── AI/
│   └── (role files)        # Optional agent definitions
├── CLAUDE.md               # Project instructions
├── AI-INFO.md              # Architecture reference
├── .mcp.json               # MCP server config
└── .env                    # Credentials (gitignored)
```

### Environment Variables

```bash
# .env
GA_PROPERTY_ID=your-property-id
GSC_SITE_URL=https://your-site.com/
GOOGLE_APPLICATION_CREDENTIALS=./credentials/gsc.json
GITHUB_TOKEN=your-token  # Optional
```

### MCP Servers

| Server                | Purpose          | Required     |
| --------------------- | ---------------- | ------------ |
| Google Analytics      | Traffic data     | Recommended  |
| Google Search Console | Rankings, CTR    | Recommended  |
| GitHub                | Issue management | Optional     |
| Sequential Thinking   | Complex problems | Auto-enabled |
| Context7              | Framework docs   | Auto-enabled |

---

## For Existing Projects

```bash
# Run brownfield analysis
/brownfield

# This will:
# 1. Scan your project structure
# 2. Detect existing configuration
# 3. Analyze SEO status
# 4. Generate missing files
# 5. Create initial issues
```

---

## Session Persistence

```bash
# When you pause
/pause
# Creates .planning/HANDOFF.md

# When you resume
/resume
# Restores full context
# Continues exactly where you stopped
```

---

## Compared to Other Solutions

| Feature             | This Plugin  | GSD | PROAGENTS | SUPER-AGENT |
| ------------------- | ------------ | --- | --------- | ----------- |
| SEO Integration     | ✅ Full      | ❌  | ❌        | ❌          |
| GA/GSC Data         | ✅ Built-in  | ❌  | ❌        | ❌          |
| Session Persistence | ✅           | ❌  | ❌        | ✅          |
| Astro-Specific      | ✅           | ❌  | ❌        | ❌          |
| Feature Development | ✅ GSD-style | ✅  | ✅        | ✅          |
| Impact Measurement  | ✅           | ❌  | ❌        | ❌          |
| Complexity          | Medium       | Low | Medium    | High        |

---

## License

MIT

---

_Built for Astro.js agencies and freelancers who want data-driven, structured workflows._
