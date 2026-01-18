# Project Setup Wizard

Interactive setup for the Astro SEO Agency plugin.

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
   - [ ] Other

Type your choices or say "auto" to use detected values.
```

---

## Step 2: Analytics Configuration

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

## Step 3: Issue Tracking

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

## Step 4: Generate Configuration Files

Based on your choices, generating:

```markdown
### 📝 Generating Files

| File | Status |
|------|--------|
| CLAUDE.md | ✅ Creating... |
| AI-INFO.md | ✅ Analyzing project... |
| .env | ✅ Writing credentials... |
| .gitignore | ✅ Updating... |

#### CLAUDE.md Preview
```markdown
# [Project Name] - Claude Code Instructions

| Field | Value |
|-------|-------|
| Framework | Astro [version] |
| Site URL | [url] |
| Analytics | [Configured/Not configured] |
...
```

**Look good?** (yes/edit)
```

---

## Step 5: Initial Audit (Optional)

```markdown
### 🔍 Initial SEO Audit

Would you like me to run an initial audit to find issues?

This will check:
- Meta tags on all pages
- Schema markup validity
- Image optimization
- Accessibility basics
- Internal linking

**Options:**
- **"full"** - Complete audit (takes 2-3 minutes)
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

---

### 📊 Audit Results

| Category | Issues Found |
|----------|--------------|
| SEO | X critical, X high |
| Accessibility | X critical, X high |
| Performance | X warnings |

**Top Priority Issues:**
1. [Issue] - Critical
2. [Issue] - Critical
3. [Issue] - High

These have been added to your issue tracker.

Run `/fix-next` to start fixing them!
```

---

## Step 6: Completion

```markdown
## ✅ Setup Complete!

### Configuration Summary

| Setting | Value |
|---------|-------|
| Project | [name] |
| Site URL | [url] |
| Analytics | ✅ Configured / ⏭️ Skipped |
| Issue Tracker | GitHub / Markdown / None |
| Initial Issues | [X] found |

### Files Created/Updated
- ✅ CLAUDE.md
- ✅ AI-INFO.md
- ✅ .env
- ✅ .gitignore
- ✅ .planning/

---

### 🚀 You're Ready!

**Start your first session:**
```bash
/start
```

**Or jump right in:**
```bash
/fix-next    # Fix highest priority issue
/seo-wins    # Find ranking opportunities
/audit       # Run full audit
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
| Save progress | `/pause` |
| Continue | `/resume` |
| All commands | `/help` |

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

The following commands may still work:
- `/feature` - Generic feature development
- `/pause` / `/resume` - Session management
- `/status` - Project status

SEO-specific commands require Astro project structure.
```

### If credentials fail validation:

```markdown
## ⚠️ Credential Validation Failed

**Google Analytics:**
❌ Could not connect with Property ID: [id]

Possible issues:
- Property ID is incorrect
- GA4 API not enabled
- Insufficient permissions

**Options:**
1. **"retry"** - Enter a different Property ID
2. **"skip"** - Continue without GA (can configure later)
3. **"help"** - Show detailed setup instructions
```
