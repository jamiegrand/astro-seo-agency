---
description: Pre-deployment verification checklist
---

# Deploy Check

Run this before every deployment to ensure nothing breaks.

---

## Step 1: Build Verification

```bash
# Clean build
rm -rf dist/
npm run build
```

### Expected Output
```markdown
### 🔨 Build Status

| Check | Status | Details |
|-------|--------|---------|
| TypeScript | ✅ / ❌ | [errors if any] |
| Astro Build | ✅ / ❌ | [errors if any] |
| Output Size | [X] MB | [comparison to last build] |
| Pages Generated | [X] | [expected vs actual] |
```

If build fails:
```markdown
## ❌ Build Failed

**Error:**
```
[error output]
```

**Searching Astro Docs for solution...**
[Search result for error]

**Diagnosis:**
[What's wrong based on docs]

**Fix:**
[How to fix per Astro docs]

Would you like me to fix this issue?
```

---

## Step 2: Astro Configuration Validation (NEW)

Query `get-astro-config` and validate against Astro docs:

```markdown
### ⚙️ Astro Configuration Check

| Setting | Value | Recommended | Status |
|---------|-------|-------------|--------|
| output | [static/server/hybrid] | [per deployment target] | ✅/⚠️ |
| site | [url] | Must be set for sitemap | ✅/⚠️ |
| trailingSlash | [value] | [per host requirements] | ✅/⚠️ |
| build.format | [value] | directory | ✅/⚠️ |
| build.assets | [value] | _astro | ✅/⚠️ |

#### Deployment Target Analysis
[Search Astro docs for deployment to detected platform]

**Detected adapter:** [adapter name or none]
**Recommended for [platform]:** [from docs]
**Status:** ✅ Correct / ⚠️ Consider changing
```

---

## Step 3: Route Verification (NEW)

Query `list-astro-routes` and verify against build output:

```markdown
### 🗺️ Route Verification

#### Routes in Config vs Build

| Route | In Astro | In Build | Status |
|-------|----------|----------|--------|
| / | ✅ | ✅ | ✅ |
| /about | ✅ | ✅ | ✅ |
| /blog/[slug] | ✅ | ✅ (X pages) | ✅ |
| /api/contact | ✅ | ⚠️ | Check adapter |

#### Dynamic Route Generation

| Pattern | Expected | Generated | Status |
|---------|----------|-----------|--------|
| /blog/[slug] | X posts | X pages | ✅/❌ |
| /products/[id] | X products | X pages | ✅/❌ |

#### Missing Routes
[Any routes in config not in build]

#### Orphan Files
[Any files in build not matching routes]
```

---

## Step 4: Critical Pages Check

Verify critical pages exist in build output:

```markdown
### 📄 Critical Pages

| Page | In Build | Status |
|------|----------|--------|
| / (Homepage) | ✅ / ❌ | |
| /products/ | ✅ / ❌ | |
| /services/ | ✅ / ❌ | |
| /contact/ | ✅ / ❌ | |
| /blog/ | ✅ / ❌ | |
| /sitemap.xml | ✅ / ❌ | |
| /robots.txt | ✅ / ❌ | |
| /404 | ✅ / ❌ | |
```

---

## Step 5: SEO Essentials

Check critical SEO elements:

```markdown
### 🔍 SEO Checklist

#### Meta Tags (Sample Check)
| Page | Title | Description | OG Tags |
|------|-------|-------------|---------|
| Homepage | ✅ / ❌ | ✅ / ❌ | ✅ / ❌ |
| Products | ✅ / ❌ | ✅ / ❌ | ✅ / ❌ |
| Services | ✅ / ❌ | ✅ / ❌ | ✅ / ❌ |

#### Technical SEO
| Item | Status | Notes |
|------|--------|-------|
| sitemap.xml valid | ✅ / ❌ | [X] URLs |
| robots.txt valid | ✅ / ❌ | |
| Canonical tags | ✅ / ❌ | |
| Schema markup | ✅ / ❌ | |
| No noindex on important pages | ✅ / ❌ | |

#### Sitemap Validation
[If @astrojs/sitemap installed - from astro-mcp config]
- Integration configured: ✅
- URLs in sitemap: [X]
- Matches route count: ✅/❌
```

---

## Step 6: Integration Verification (NEW)

Query integrations from `get-astro-config`:

```markdown
### 🔌 Integration Status

| Integration | Configured | Build Output | Status |
|-------------|------------|--------------|--------|
| @astrojs/sitemap | ✅ | sitemap.xml present | ✅ |
| @astrojs/tailwind | ✅ | CSS bundled | ✅ |
| @astrojs/image | ✅ | Images optimized | ✅ |
| [adapter] | ✅ | Server files present | ✅ |

#### Integration-Specific Checks

**@astrojs/sitemap:**
- Site URL configured: ✅/❌
- Sitemap generated: ✅/❌
- URL count: [X]

**Image Service:**
- Service: [sharp/squoosh]
- Optimized images in build: [X]
- Formats: [webp/avif enabled]
```

---

## Step 7: Asset Verification

```markdown
### 🖼️ Assets Check

#### Images
| Check | Status |
|-------|--------|
| All images in /dist | ✅ / ❌ |
| No broken references | ✅ / ❌ |
| Optimized formats (webp) | ✅ / ❌ |
| Total image size | [X] MB |

#### Fonts
| Check | Status |
|-------|--------|
| Font files present | ✅ / ❌ |
| Font-display: swap | ✅ / ❌ |

#### CSS/JS
| Check | Status |
|-------|--------|
| Styles bundled | ✅ / ❌ |
| Scripts bundled | ✅ / ❌ |
| No console errors | ✅ / ❌ |
```

---

## Step 8: Links Verification

```bash
# If link checker available
npx linkinator ./dist --recurse
```

```markdown
### 🔗 Link Check

| Type | Count | Broken |
|------|-------|--------|
| Internal links | X | X |
| External links | X | X |
| Image sources | X | X |

[If broken links found:]
#### Broken Links Found

| Page | Broken Link | Type |
|------|-------------|------|
| /page/ | /broken-link | Internal |
| /page/ | https://... | External |

**Action Required:** Fix broken links before deploy.
```

---

## Step 9: Git Status

```bash
git status
git log origin/main..HEAD --oneline
```

```markdown
### 🔀 Git Status

| Check | Status |
|-------|--------|
| Working directory clean | ✅ / ❌ |
| All changes committed | ✅ / ❌ |
| Branch | [branch name] |
| Commits ahead of main | [X] |

#### Changes to Deploy
```
[git log output]
```

[If uncommitted changes:]
⚠️ **Uncommitted changes detected**

Files:
- [list]

**Options:**
1. Commit changes now
2. Stash and deploy
3. Cancel deployment
```

---

## Step 10: Environment Check

```markdown
### ⚙️ Environment

| Check | Status |
|-------|--------|
| Node version | [X.X.X] ✅ / ⚠️ |
| npm version | [X.X.X] |
| Astro version | [X.X.X] |
| Dependencies up to date | ✅ / ⚠️ |

#### Astro Version Check
[Search Astro docs for latest version]

| Current | Latest | Status |
|---------|--------|--------|
| [X.X.X] | [X.X.X] | ✅ Current / ⚠️ Update available |

[If version mismatch with production:]
⚠️ **Version Warning**

Local Astro version ([X]) may differ from production.
```

---

## Step 11: Performance Baseline

```markdown
### ⚡ Performance (Estimated)

Based on build output:

| Metric | Value | Target | Status |
|--------|-------|--------|--------|
| Total HTML size | X KB | <100 KB | ✅ / ⚠️ |
| JS bundle | X KB | <100 KB | ✅ / ⚠️ |
| CSS bundle | X KB | <50 KB | ✅ / ⚠️ |
| Largest image | X KB | <500 KB | ✅ / ⚠️ |
| Total pages | X | - | - |

#### Astro Performance Features
[Check config for performance settings]

| Feature | Status | Recommendation |
|---------|--------|----------------|
| Image optimization | ✅/❌ | [from docs] |
| CSS inlining | ✅/❌ | [from docs] |
| Prefetch | ✅/❌ | Consider enabling |
```

---

## Step 12: Final Summary

```markdown
## 🚀 Deploy Check Summary

**Project:** [Name]
**Branch:** [branch]
**Commits:** [X] to deploy
**Time:** [timestamp]

### Results

| Category | Status | Issues |
|----------|--------|--------|
| Build | ✅ / ❌ | [X] |
| Astro Config | ✅ / ❌ | [X] |
| Routes | ✅ / ❌ | [X] |
| Critical Pages | ✅ / ❌ | [X] |
| SEO | ✅ / ❌ | [X] |
| Integrations | ✅ / ❌ | [X] |
| Assets | ✅ / ❌ | [X] |
| Links | ✅ / ❌ | [X] |
| Git | ✅ / ❌ | [X] |
| Performance | ✅ / ⚠️ | [X] |

### Overall: ✅ READY TO DEPLOY / ❌ ISSUES FOUND

---

[If ready:]
### Deploy Commands

**For [detected adapter/platform]:**
```bash
# Netlify
netlify deploy --prod

# Vercel
vercel --prod

# Cloudflare
wrangler pages deploy dist

# Static hosting
# Upload dist/ folder
```

**After Deploy:**
1. Verify live site loads
2. Check critical pages
3. Verify sitemap accessible
4. Test forms/API routes
5. Monitor analytics

---

[If issues:]
### ❌ Issues to Fix Before Deploy

| Priority | Issue | Category | Fix |
|----------|-------|----------|-----|
| 🔴 Critical | [issue] | [cat] | [fix] |
| 🟡 Warning | [issue] | [cat] | [fix] |

**Fix these issues?**
- "Fix all" - Attempt to fix automatically
- "Fix [issue]" - Fix specific issue
- "Deploy anyway" - Proceed despite warnings (not recommended)
- "Cancel" - Abort deployment
```

---

## Post-Deploy Monitoring

```markdown
## 📡 Post-Deploy Checklist

### Immediate (Within 5 minutes)
- [ ] Homepage loads
- [ ] Critical pages accessible
- [ ] No console errors
- [ ] Forms working (if applicable)
- [ ] API routes responding (if applicable)

### Within 1 Hour
- [ ] Google Search Console: No new errors
- [ ] Analytics: Data flowing
- [ ] Sitemap: Accessible and valid

### Within 24 Hours
- [ ] All pages indexed correctly
- [ ] No 404 spikes
- [ ] No significant metric drops

**Set reminder?**
- [ ] 1 hour
- [ ] 24 hours
- [ ] Both
```

---

## MCP Usage Summary

| Step | Astro Docs MCP | astro-mcp |
|------|----------------|-----------|
| Build errors | Search for solutions | - |
| Config validation | Best practices | Get current config |
| Route verification | - | List all routes |
| Integration check | Integration docs | Installed integrations |
| Version check | Latest version info | Current version |
| Performance | Optimization tips | Current settings |
