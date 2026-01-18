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

**Diagnosis:**
[What's wrong]

**Fix:**
[How to fix]

Would you like me to fix this issue?
```

---

## Step 2: Critical Pages Check

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
```

---

## Step 3: SEO Essentials

Check critical SEO elements:

```markdown
### 🔍 SEO Checklist

#### Meta Tags
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
```

---

## Step 4: Asset Verification

```markdown
### 🖼️ Assets Check

#### Images
| Check | Status |
|-------|--------|
| All images in /dist | ✅ / ❌ |
| No broken references | ✅ / ❌ |
| Optimized formats (webp) | ✅ / ❌ |

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

## Step 5: Links Verification

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

## Step 6: Git Status

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

## Step 7: Environment Check

```markdown
### ⚙️ Environment

| Check | Status |
|-------|--------|
| Node version | [X.X.X] ✅ / ⚠️ |
| npm version | [X.X.X] |
| Astro version | [X.X.X] |
| Dependencies up to date | ✅ / ⚠️ |

[If version mismatch:]
⚠️ **Version Warning**

Local Node version ([X]) differs from production ([Y]).
This might cause issues.
```

---

## Step 8: Performance Baseline

```markdown
### ⚡ Performance (Estimated)

Based on build output:

| Metric | Value | Target | Status |
|--------|-------|--------|--------|
| Total HTML size | X KB | <100 KB | ✅ / ⚠️ |
| JS bundle | X KB | <100 KB | ✅ / ⚠️ |
| CSS bundle | X KB | <50 KB | ✅ / ⚠️ |
| Largest image | X KB | <500 KB | ✅ / ⚠️ |

[If issues:]
⚠️ **Performance Concern**

[Item] exceeds target. Consider:
- [Optimization suggestion]
```

---

## Step 9: Final Summary

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
| Critical Pages | ✅ / ❌ | [X] |
| SEO | ✅ / ❌ | [X] |
| Assets | ✅ / ❌ | [X] |
| Links | ✅ / ❌ | [X] |
| Git | ✅ / ❌ | [X] |
| Performance | ✅ / ⚠️ | [X] |

### Overall: ✅ READY TO DEPLOY / ❌ ISSUES FOUND

---

[If ready:]
### Deploy Commands

**Manual:**
```bash
# If using Netlify CLI
netlify deploy --prod

# If using Vercel CLI
vercel --prod

# If using custom
[your deploy command]
```

**After Deploy:**
1. Verify live site loads
2. Check critical pages
3. Verify analytics tracking
4. Monitor for errors

---

[If issues:]
### ❌ Issues to Fix Before Deploy

| Priority | Issue | Fix |
|----------|-------|-----|
| 🔴 Critical | [issue] | [fix] |
| 🟡 Warning | [issue] | [fix] |

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

After deployment, verify:

### Immediate (Within 5 minutes)
- [ ] Homepage loads
- [ ] Critical pages accessible
- [ ] No console errors
- [ ] Forms working (if applicable)

### Within 1 Hour
- [ ] Google Search Console: No new errors
- [ ] Analytics: Data flowing
- [ ] Core Web Vitals: No regression

### Within 24 Hours
- [ ] All pages indexed correctly
- [ ] No 404 spikes
- [ ] No significant metric drops

**Set reminder?**
I can remind you to check these metrics in:
- [ ] 1 hour
- [ ] 24 hours
- [ ] Both
```
