---
description: Show all available commands and usage
---

# Astro SEO Agency - Command Reference

## Quick Start

```bash
/start              # Begin your day - see priorities
/fix-next           # Work on highest-impact issue
/pause              # Save progress and exit
/resume             # Continue tomorrow
```

---

## 📋 All Commands

### Session Management

| Command | Description | When to Use |
|---------|-------------|-------------|
| `/start` | Initialize session with data-driven priorities | Beginning of work session |
| `/status` | Show project and session status | Check current state |
| `/pause` | Save session state, create handoff | Stopping work |
| `/resume` | Restore session from handoff | Continuing work |

### Issue Resolution

| Command | Description | When to Use |
|---------|-------------|-------------|
| `/fix-next` | Auto-select and fix highest priority issue | Daily maintenance |
| `/audit [type]` | Run comprehensive audit (seo/a11y/perf/full) | Finding issues |

### SEO & Analytics

| Command | Description | When to Use |
|---------|-------------|-------------|
| `/seo-wins` | Find GSC quick wins (position 4-15) | Weekly SEO review |
| `/content-roi` | Analyze content performance | Monthly content review |
| `/impact [#]` | Measure before/after effect | 14+ days after changes |

### Feature Development

| Command | Description | When to Use |
|---------|-------------|-------------|
| `/feature "desc"` | Plan and build new feature | Adding new functionality |
| `/feature:plan` | Show current feature plan | Mid-feature check |
| `/feature:work [n]` | Execute specific task | Manual task selection |
| `/feature:complete` | Finalize feature | Feature done |

### Deployment

| Command | Description | When to Use |
|---------|-------------|-------------|
| `/deploy-check` | Pre-deployment verification | Before every deploy |

### Help

| Command | Description |
|---------|-------------|
| `/help` | Show this reference |

---

## 🔧 Command Details

### `/start`

Initializes your work session by:
1. Querying Google Analytics (7-day traffic)
2. Querying Search Console (rankings, quick wins)
3. Checking issue tracker
4. Calculating priority scores
5. Recommending focus for the session

**Output:** Prioritized task list with impact scores

---

### `/fix-next`

Automatically selects and implements the highest-impact issue:
1. Calculates impact scores for all open issues
2. Selects highest priority
3. Reads architecture context
4. Plans implementation
5. Makes changes (with approval)
6. Verifies and commits
7. Updates tracker

**Requires:** Active issue tracker (GitHub or Markdown)

---

### `/feature "description"`

Structured feature development (GSD-style):
1. **Clarify** - Extract requirements, ask questions
2. **Plan** - Break into tasks (max 3 at a time)
3. **Execute** - Fresh context per task
4. **Verify** - Quality gates on each task
5. **Ship** - Atomic commits

**Best for:** New features, significant changes

---

### `/seo-wins`

Finds SEO opportunities from GSC data:
- **Almost There:** Position 4-10, low CTR
- **Low Hanging Fruit:** Position 11-20, high impressions
- **Content Gaps:** Queries without dedicated pages
- **Declining:** Queries losing position

**Requires:** Google Search Console MCP configured

---

### `/content-roi`

Analyzes all content performance:
- Traffic scores
- Engagement scores
- SEO scores
- Categorizes: Top / Solid / Update / Underperform / Remove

**Output:** Action plan for content optimization

---

### `/impact [issue-number]`

Measures the effect of changes:
- Compares 30 days before vs after
- GA metrics: sessions, bounce, duration
- GSC metrics: impressions, clicks, position
- Calculates ROI

**Best used:** 14-30 days after making changes

---

### `/audit [type]`

Comprehensive site audit:
- `seo` - Schema, meta tags, content, linking
- `a11y` - WCAG 2.1 AA compliance
- `perf` - Core Web Vitals, image optimization
- `full` - All of the above (default)

**Output:** Scored report with prioritized fixes

---

### `/pause` / `/resume`

Session persistence:
- `/pause` creates `.planning/HANDOFF.md`
- `/resume` restores full context
- Walk away, come back tomorrow, continue exactly

---

### `/deploy-check`

Pre-deployment verification:
- Build verification
- Critical pages check
- SEO essentials
- Asset verification
- Link checking
- Git status
- Performance baseline

**Run before:** Every deployment

---

## 💡 Usage Tips

### Daily Workflow
```
Morning:  /start           → See priorities
Work:     /fix-next        → Fix issues (repeat)
Evening:  /pause           → Save progress
```

### Weekly Review
```
Monday:   /seo-wins        → Find opportunities
Friday:   /content-roi     → Review performance
```

### Feature Development
```
/feature "Add contact form"
→ Answer clarifying questions
→ Review plan
→ "go" to execute
```

### Measuring Impact
```
# After making SEO changes
# Wait 14 days, then:
/impact 15
```

---

## ⚙️ Configuration

### MCP Servers

| Server | Purpose | Setup |
|--------|---------|-------|
| Google Analytics | Traffic data | Configured in plugin |
| Search Console | Rankings, CTR | `claude mcp add gsc` |
| GitHub | Issue management | `claude mcp add github` |

### Environment Variables

```bash
# .env
GA_PROPERTY_ID=your-property-id
GSC_SITE_URL=https://your-site.com/
GITHUB_TOKEN=your-token
```

---

## 🆘 Troubleshooting

### "GSC not configured"
```bash
claude mcp add gsc -- npx -y mcp-server-gsc
```

### "No issues found"
Ensure AUDIT_TRACKER.md exists or GitHub Issues is configured.

### "Build failing"
```bash
npm run astro check  # Find TypeScript errors
npm run build        # See full error
```

### "Context seems wrong"
```
/pause
# Close and reopen Claude Code
/resume
```

---

## 📚 Related Documentation

- `AI-INFO.md` - Project architecture reference
- `CLAUDE.md` - Project-specific instructions
- `.planning/HANDOFF.md` - Session state (when paused)
- `.planning/FEATURE-PLAN.md` - Active feature plan

---

*Astro SEO Agency Plugin v2.0.0*
