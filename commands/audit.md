---
argument-hint: "[seo|a11y|perf|full]"
description: Run comprehensive site audit
---

# Site Audit: $1

Default: "full" (all categories)

---

## Audit Categories

| Type | Focus |
|------|-------|
| `seo` | Schema, meta tags, content, internal linking |
| `a11y` | WCAG 2.1 AA compliance |
| `perf` | Core Web Vitals, image optimization |
| `full` | All of the above |

---

## SEO Audit

### 1. Schema Markup

Check `src/layouts/Layout.astro` and page components for:

```markdown
### Schema Validation

| Schema Type | Present | Valid | Issues |
|-------------|---------|-------|--------|
| LocalBusiness | ✅/❌ | ✅/❌ | [issues] |
| Product | ✅/❌ | ✅/❌ | [issues] |
| Service | ✅/❌ | ✅/❌ | [issues] |
| BlogPosting | ✅/❌ | ✅/❌ | [issues] |
| BreadcrumbList | ✅/❌ | ✅/❌ | [issues] |
| FAQPage | ✅/❌ | ✅/❌ | [issues] |

### Schema Issues Found
- [ ] [Issue 1]
- [ ] [Issue 2]
```

### 2. Meta Tags

Scan all pages in `src/pages/`:

```markdown
### Meta Tag Audit

| Page | Title | Length | Meta Desc | Length | OG Tags | Canonical |
|------|-------|--------|-----------|--------|---------|-----------|
| / | ✅ | 55 | ✅ | 155 | ✅ | ✅ |
| /products/ | ⚠️ | 72 | ✅ | 140 | ✅ | ✅ |

### Issues
- [ ] [Page]: Title too long (>60 chars)
- [ ] [Page]: Missing meta description
- [ ] [Page]: Missing OG image
```

### 3. Content Quality

For each content page:

```markdown
### Content Analysis

| Page | Word Count | H1 | H2s | Images | Alt Text | Internal Links |
|------|------------|----|----|--------|----------|----------------|
| /blog/post-1 | 850 | ✅ | 4 | 2 | ✅ | 3 |
| /blog/post-2 | 320 | ✅ | 1 | 0 | - | 0 |

### Content Issues
- [ ] [Page]: Thin content (<500 words)
- [ ] [Page]: Missing internal links
- [ ] [Page]: No images
```

### 4. Internal Linking

Cross-reference with data files:

```markdown
### Internal Linking Matrix

| Asset | Type | Incoming Links | Pages Linking |
|-------|------|----------------|---------------|
| /products/maxim-3000/ | Product | 3 | [list] |
| /services/septic-tank/ | Service | 0 | ⚠️ Orphan |
| /locations/london/ | Location | 5 | [list] |

### Orphan Content (No Internal Links)
- [ ] /products/[slug] - Needs links from blog
- [ ] /services/[slug] - Needs links from homepage

### Link Opportunities
| From (High Traffic) | To (Needs Links) | Suggested Anchor |
|---------------------|------------------|------------------|
| [page] | [page] | [text] |
```

### 5. GSC Data Integration (If Available)

```markdown
### Search Performance Issues

| Page | Impressions | Clicks | CTR | Position | Issue |
|------|-------------|--------|-----|----------|-------|
| [page] | 5000 | 50 | 1% | 8.5 | Low CTR |
| [page] | 200 | 10 | 5% | 18 | Needs ranking boost |

### Quick Wins
1. [Query] - Pos 6, CTR 2% → Improve title
2. [Query] - Pos 12, 1000 impr → Add content
```

---

## Accessibility Audit

### 1. Semantic HTML

Scan components and layouts:

```markdown
### Semantic Structure

| Component | Issue | Severity | Fix |
|-----------|-------|----------|-----|
| Header | Skip link missing | High | Add skip-to-main |
| Modal | No focus trap | High | Implement trap |
| Card | Using div for button | Medium | Use <button> |

### Landmark Usage
- [ ] `<main>` present: ✅/❌
- [ ] `<nav>` present: ✅/❌
- [ ] `<header>` present: ✅/❌
- [ ] `<footer>` present: ✅/❌
```

### 2. Interactive Elements

```markdown
### Keyboard & ARIA Audit

| Element | Keyboard Accessible | ARIA Labels | Focus Visible |
|---------|---------------------|-------------|---------------|
| Nav menu | ✅/❌ | ✅/❌ | ✅/❌ |
| Modal | ✅/❌ | ✅/❌ | ✅/❌ |
| Accordion | ✅/❌ | ✅/❌ | ✅/❌ |
| Forms | ✅/❌ | ✅/❌ | ✅/❌ |

### Missing Labels
- [ ] [Component]: Icon button needs aria-label
- [ ] [Component]: Form input needs label association
```

### 3. Images

```markdown
### Image Accessibility

| Location | Images | With Alt | Decorative | Issues |
|----------|--------|----------|------------|--------|
| Components | X | X | X | [count] |
| Pages | X | X | X | [count] |
| Content | X | X | X | [count] |

### Issues
- [ ] [file]: Image missing alt text
- [ ] [file]: Decorative image needs alt=""
```

### 4. Color Contrast

```markdown
### Contrast Check (from global.css)

| Element | Foreground | Background | Ratio | Pass |
|---------|------------|------------|-------|------|
| Body text | #333 | #fff | 12.6:1 | ✅ |
| Primary button | #fff | #0056b3 | 4.5:1 | ✅ |
| Secondary text | #666 | #f5f5f5 | 3.2:1 | ⚠️ |

### Contrast Issues
- [ ] [element]: Ratio 3.2:1, needs 4.5:1
```

---

## Performance Audit

### 1. Image Optimization

```markdown
### Image Analysis

| Directory | Count | Optimized | Lazy Load | WebP |
|-----------|-------|-----------|-----------|------|
| public/products/ | X | ✅/❌ | ✅/❌ | ✅/❌ |
| public/services/ | X | ✅/❌ | ✅/❌ | ✅/❌ |
| src/assets/ | X | ✅/❌ | ✅/❌ | ✅/❌ |

### Large Images (>500KB)
- [ ] [file]: X MB - Needs compression
- [ ] [file]: X MB - Needs resizing

### Missing Optimization
- [ ] Hero images need `loading="eager"`
- [ ] Below-fold images need `loading="lazy"`
```

### 2. JavaScript/CSS

```markdown
### Bundle Analysis

| Metric | Value | Target | Status |
|--------|-------|--------|--------|
| JS Bundle | X KB | <100KB | ✅/⚠️/❌ |
| CSS Bundle | X KB | <50KB | ✅/⚠️/❌ |
| Unused CSS | X% | <20% | ✅/⚠️/❌ |

### Issues
- [ ] [component]: Imports unused library
- [ ] [file]: Contains render-blocking script
```

### 3. Core Web Vitals Factors

```markdown
### CWV Optimization Check

| Factor | Status | Impact | Fix |
|--------|--------|--------|-----|
| LCP image preload | ✅/❌ | High | Add fetchpriority="high" |
| Font display swap | ✅/❌ | Medium | Add font-display: swap |
| Preconnect hints | ✅/❌ | Medium | Add preconnect links |
| CLS prevention | ✅/❌ | High | Add explicit dimensions |
```

---

## Audit Summary

```markdown
## 📊 Audit Summary: [Project Name]

**Audit Date:** [timestamp]
**Scope:** $1

### Scores

| Category | Score | Issues |
|----------|-------|--------|
| SEO | X/100 | X critical, X high, X medium |
| Accessibility | X/100 | X critical, X high, X medium |
| Performance | X/100 | X critical, X high, X medium |
| **Overall** | **X/100** | **X total issues** |

---

### 🔴 Critical Issues (Fix Immediately)

1. **[Issue]** - [Category]
   - Location: [file]
   - Impact: [description]
   - Fix: [solution]

2. **[Issue]** - [Category]
   ...

### 🟡 High Priority Issues

1. **[Issue]** - [Category]
   ...

### 🟢 Medium Priority Issues

1. **[Issue]** - [Category]
   ...

---

### 📈 Estimated Impact

If all issues fixed:
- SEO: +X% organic traffic potential
- Accessibility: WCAG 2.1 AA compliant
- Performance: +X Lighthouse points

---

### 🎯 Recommended Action Plan

**Week 1: Critical Fixes**
- [ ] [Task 1] - Est: X min
- [ ] [Task 2] - Est: X min

**Week 2: High Priority**
- [ ] [Task 1] - Est: X min
- [ ] [Task 2] - Est: X min

**Ongoing: Medium Priority**
- [ ] [Task 1] - Est: X min

---

### Add to Tracker?

Should I add these issues to your issue tracker?
- **Yes** - Creates issues with appropriate priority labels
- **No** - Just show this report
```

---

## Post-Audit Actions

| Command | Description |
|---------|-------------|
| "Add to tracker" | Create issues for all findings |
| "Fix critical" | Start fixing critical issues immediately |
| "/fix-next" | Work on highest-impact issue |
| "Export report" | Save as markdown file |
