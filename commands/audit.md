---
description: Run audits - site-wide (seo/a11y/perf) or content-specific
argument-hint: "[seo|a11y|perf|full|content|quick|batch|eeat] [page] [keyword]"
---

# /audit - Comprehensive Auditing

Run `/audit <type>` for site audits or `/audit <content-type>` for content audits.

## Site Audits (handled directly)

| Command | Description |
|---------|-------------|
| `/audit` | Full site audit (SEO + a11y + performance + Astro) |
| `/audit seo` | SEO-only site audit |
| `/audit a11y` | Accessibility audit |
| `/audit perf` | Performance audit |
| `/audit astro` | Astro best practices audit |
| `/audit full` | Alias for full audit |

## Content Audits (routed to implementation files)

| Subcommand | Direct Command | Description |
|------------|----------------|-------------|
| `content [page] [kw]` | `/audit-content` | Deep content audit (0-100 score) |
| `quick [page] [kw]` | `/audit-quick` | Rapid 10-point check |
| `batch [collection]` | `/audit-batch` | Audit multiple pages |
| `eeat [page]` | `/audit-eeat` | E-E-A-T deep dive |

## Routing

**Site audits (seo/a11y/perf/astro/full or no args):** Handle directly using the Site Audit Implementation below.

**Content audits:** Route to implementation file:
- `content` → Read `commands/audit-content.md` and execute
- `quick` → Read `commands/audit-quick.md` and execute
- `batch` → Read `commands/audit-batch.md` and execute
- `eeat` → Read `commands/audit-eeat.md` and execute

## Examples

```bash
/audit                        # Full site audit (direct)
/audit seo                    # SEO site audit (direct)
/audit content /blog/post seo # Deep content audit (routed)
/audit quick /blog/post       # Quick check (routed)
/audit batch blog             # Batch audit collection (routed)
/audit eeat /about            # E-E-A-T analysis (routed)
```

---

# Site Audit Implementation

**Default:** "full" (all categories including Astro-specific)

---

## Audit Categories

| Type | Focus |
|------|-------|
| `seo` | Schema, meta tags, content, internal linking |
| `a11y` | WCAG 2.1 AA compliance |
| `perf` | Core Web Vitals, image optimization |
| `astro` | Astro best practices, deprecated patterns |
| `full` | All of the above |

---

## Step 0: Check Project Index

**Query the project index for fast access to routes, components, and collections:**

```sql
-- Check index status
SELECT * FROM index_status;

-- Get project summary
SELECT * FROM project_summary;
```

### Index Status Display

```markdown
### 📊 Project Index Status

| Phase | Status | Items |
|-------|--------|-------|
| Routes | ✅/🔄/❌ | X routes |
| Components | ✅/🔄/❌ | X components |
| Collections | ✅/🔄/❌ | X items |

**Data Source:** [Database / MCP / File scan]
```

**If index incomplete:**
```markdown
⚠️ **Project index incomplete**

Some audit checks may be slower without complete index.
Run `/index run` for comprehensive coverage.

Proceeding with available data...
```

---

## Astro Audit

**Uses Astro Docs MCP and astro-mcp integration for comprehensive Astro-specific checks.**

### 1. Configuration Audit

Query `get-astro-config` and validate against Astro docs:

```markdown
### ⚙️ Astro Configuration Audit

#### Core Settings
| Setting | Current | Recommended | Status |
|---------|---------|-------------|--------|
| output | [value] | [from docs] | ✅/⚠️ |
| site | [value] | (should be set) | ✅/⚠️ |
| trailingSlash | [value] | [depends on host] | ✅/⚠️ |
| build.format | [value] | directory | ✅/⚠️ |
| build.assets | [value] | _astro | ✅/⚠️ |

#### TypeScript Configuration
| Setting | Current | Recommended | Status |
|---------|---------|-------------|--------|
| Mode | [strict/relaxed] | strict | ✅/⚠️ |
| Paths configured | [yes/no] | yes | ✅/⚠️ |

#### Issues Found
- [ ] [Issue with recommendation from docs]
- [ ] [Issue with recommendation from docs]
```

### 2. Route Audit

**Priority 1: Query Database**

```sql
-- Get route summary from index
SELECT
  route_type,
  COUNT(*) as count,
  SUM(CASE WHEN has_prerender = 1 THEN 1 ELSE 0 END) as prerendered
FROM routes
GROUP BY route_type;

-- Get all routes for analysis
SELECT
  route_pattern,
  route_type,
  source_file,
  has_prerender,
  generates_count
FROM routes
ORDER BY route_type, route_pattern;

-- Find potential orphan pages (routes with no internal links)
SELECT r.route_pattern, r.source_file
FROM routes r
WHERE r.route_type = 'static'
  AND r.route_pattern NOT IN (
    SELECT DISTINCT target_route FROM internal_links
  );
```

**Priority 2: MCP Fallback**

If routes not indexed, query `list-astro-routes`.

```markdown
### 🗺️ Route Audit

**Data Source:** [Database / MCP]

#### Route Health
| Metric | Count | Status |
|--------|-------|--------|
| Total routes | X | - |
| Static pages | X | - |
| Dynamic routes | X | - |
| API endpoints | X | - |
| Pre-rendered | X% | ✅ >80% / ⚠️ <80% |

#### Route Issues
| Route | Issue | Recommendation |
|-------|-------|----------------|
| /[route] | No getStaticPaths | Add for pre-rendering |
| /[route] | Missing trailing slash | Standardize |
| /api/[route] | No error handling | Add try/catch |

#### Orphan Detection
Routes not linked from anywhere:
- /[orphan-page] - Consider adding to navigation
- /[orphan-page] - Consider redirect or removal

#### Duplicate Content Risk
| Pattern | Routes | Risk |
|---------|--------|------|
| Similar slugs | /blog, /blogs | ⚠️ Canonicalize |
```

### 3. Deprecated Patterns Audit

Search Astro docs for deprecations and scan codebase:

```markdown
### ⚠️ Deprecated Patterns Audit

**Searched Astro docs for:** "deprecated", "breaking changes astro [version]"

#### Deprecated APIs Found
| File | Line | Pattern | Current Recommendation |
|------|------|---------|------------------------|
| [file] | [line] | `Astro.request.url` | Use `Astro.url` |
| [file] | [line] | `getStaticPaths()` return | Use new format |
| [file] | [line] | Old image import | Use `astro:assets` |

#### Migration Priority
| Pattern | Occurrences | Effort | Priority |
|---------|-------------|--------|----------|
| [pattern] | X | Low | High |
| [pattern] | X | Medium | Medium |
```

### 4. Integration Audit

Check integrations against docs:

```markdown
### 🔌 Integration Audit

#### Installed Integrations
| Integration | Version | Latest | Status |
|-------------|---------|--------|--------|
| @astrojs/tailwind | X.X | X.X | ✅/⚠️ |
| @astrojs/sitemap | X.X | X.X | ✅/⚠️ |
| @astrojs/mdx | X.X | X.X | ✅/⚠️ |

#### Configuration Check
| Integration | Config | Optimal | Status |
|-------------|--------|---------|--------|
| sitemap | [settings] | [from docs] | ✅/⚠️ |
| image | [settings] | [from docs] | ✅/⚠️ |

#### Recommended Additions
Based on project type and Astro docs:
| Integration | Why | Install |
|-------------|-----|---------|
| @astrojs/partytown | Third-party scripts | `npx astro add partytown` |
| astro-compress | Build optimization | `npm i astro-compress` |

#### Missing Common Integrations
| Integration | Benefit | Recommended |
|-------------|---------|-------------|
| sitemap | SEO | ✅ Yes |
| robots-txt | SEO | ⚠️ Consider |
```

### 5. Component Patterns Audit

**Priority 1: Query Database**

```sql
-- Get component summary from index
SELECT
  component_type,
  COUNT(*) as count,
  SUM(CASE WHEN uses_client_directive = 1 THEN 1 ELSE 0 END) as with_hydration
FROM components
GROUP BY component_type;

-- Get components with client directives
SELECT
  file_path,
  component_name,
  component_type,
  client_directive,
  props
FROM components
WHERE uses_client_directive = 1
ORDER BY client_directive, component_name;

-- Get all components for analysis
SELECT
  file_path,
  component_name,
  component_type,
  uses_client_directive,
  client_directive
FROM components
ORDER BY component_type, component_name;
```

**Priority 2: File Scan Fallback**

If components not indexed, scan src/components/ directory.

```markdown
### 🧩 Component Patterns Audit

**Data Source:** [Database / File scan]

#### Hydration Audit
| Component | Directive | Recommendation |
|-----------|-----------|----------------|
| [file] | client:load | Consider client:visible |
| [file] | client:only | Document SSR limitations |
| [file] | (none) | ✅ Server-only optimal |

**Hydration Summary (from components table):**
- Server-only components: X (ideal)
- client:load: X (review if needed)
- client:visible: X (good for below-fold)
- client:idle: X (good for non-critical)
- client:only: X (review necessity)

#### Props Typing
| Component | Props Typed | Status |
|-----------|-------------|--------|
| [file] | ✅ interface Props | ✅ |
| [file] | ❌ No types | ⚠️ Add types |

#### Slot Usage
| Component | Has Slots | Named Slots | Status |
|-----------|-----------|-------------|--------|
| [file] | ✅ | ✅ | ✅ Good |
| [file] | ❌ | - | Consider for flexibility |
```

### 6. Content Collections Audit

**Priority 1: Query Database**

```sql
-- Get collection summary from index
SELECT
  name,
  location,
  item_count,
  schema_fields,
  last_indexed
FROM collections;

-- Get content health metrics
SELECT
  c.name,
  c.item_count,
  SUM(CASE WHEN ce.description IS NOT NULL THEN 1 ELSE 0 END) as with_meta,
  SUM(CASE WHEN ce.word_count > 0 THEN 1 ELSE 0 END) as with_content,
  AVG(ce.word_count) as avg_word_count
FROM collections c
LEFT JOIN collection_entries ce ON c.id = ce.collection_id
WHERE ce.draft = 0
GROUP BY c.id;

-- Find content issues
SELECT
  ce.file_path,
  ce.title,
  ce.word_count,
  ce.description
FROM collection_entries ce
WHERE ce.draft = 0
  AND (ce.description IS NULL OR ce.word_count < 300)
ORDER BY ce.word_count ASC
LIMIT 20;
```

**Priority 2: File Scan Fallback**

If collections not indexed, scan src/content/ directory.

```markdown
### 📝 Content Collections Audit

**Data Source:** [Database / File scan]

#### Schema Validation
| Collection | Schema | Issues |
|------------|--------|--------|
| blog | ✅ Defined | None |
| products | ⚠️ Missing fields | Add 'image' field |

#### Content Health (from collection_entries)
| Collection | Items | With Description | Avg Words |
|------------|-------|------------------|-----------|
| blog | X | X (Y%) | X |
| products | X | X (Y%) | X |

#### Content Issues Found
| File | Issue | Recommendation |
|------|-------|----------------|
| [file_path] | Missing description | Add meta description |
| [file_path] | Thin content (<300 words) | Expand content |

#### Recommended Schema Improvements
Based on Astro docs best practices:
```typescript
// Suggested schema updates
const blog = defineCollection({
  type: 'content',
  schema: ({ image }) => z.object({
    // Add image validation
    cover: image().optional(),
    // Add better date handling
    pubDate: z.coerce.date(),
  })
});
```
```

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

Scan all pages (using route list from astro-mcp):

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

Cross-reference with route data:

```markdown
### Internal Linking Matrix

| Page | Type | Incoming Links | Linking Pages |
|------|------|----------------|---------------|
| /products/[slug]/ | Product | 3 | [list] |
| /services/[slug]/ | Service | 0 | ⚠️ Orphan |

### Orphan Content
- [ ] /[slug] - Needs links from high-traffic pages

### Link Opportunities
| From (High Traffic) | To (Needs Links) | Anchor |
|---------------------|------------------|--------|
| [page] | [page] | [text] |
```

---

## Accessibility Audit

### 1. Semantic HTML

```markdown
### Semantic Structure

| Component | Issue | Severity | Fix |
|-----------|-------|----------|-----|
| Header | Skip link missing | High | Add skip-to-main |
| Modal | No focus trap | High | Implement trap |

### Landmark Usage
- [ ] `<main>` present: ✅/❌
- [ ] `<nav>` present: ✅/❌
- [ ] `<header>` present: ✅/❌
- [ ] `<footer>` present: ✅/❌
```

### 2. Images (Enhanced with Astro)

```markdown
### Image Accessibility

**Astro Image Component Usage:**
| Pattern | Count | Status |
|---------|-------|--------|
| Using `<Image>` from astro:assets | X | ✅ |
| Using `<img>` | X | ⚠️ Convert |
| Remote images | X | Check patterns |

**Alt Text Audit:**
| Location | Images | With Alt | Decorative | Issues |
|----------|--------|----------|------------|--------|
| Components | X | X | X | [count] |
| Content | X | X | X | [count] |
```

---

## Performance Audit

### 1. Image Optimization (Astro-Enhanced)

```markdown
### Image Analysis

**Astro Configuration:**
| Setting | Value | Optimal | Status |
|---------|-------|---------|--------|
| Image service | [sharp/squoosh] | sharp | ✅/⚠️ |
| Remote patterns | X configured | - | - |

**Image Usage:**
| Pattern | Count | Recommendation |
|---------|-------|----------------|
| Optimized (astro:assets) | X | ✅ |
| Unoptimized (<img>) | X | Convert |
| Missing dimensions | X | Add width/height |
| Missing loading="lazy" | X | Add for below-fold |

### Large Images
| File | Size | Recommendation |
|------|------|----------------|
| [file] | X MB | Compress or resize |
```

### 2. JavaScript Analysis

```markdown
### Client-Side JavaScript

**Hydration Analysis (from component audit):**
| Directive | Components | Bundle Impact |
|-----------|------------|---------------|
| client:load | X | Immediate load |
| client:visible | X | Deferred ✅ |
| client:idle | X | Background |
| None (server) | X | No JS ✅ |

**Recommendations:**
- [ ] Move X components from client:load to client:visible
- [ ] Consider client:only="react" for [component]
```

---

## Audit Summary

```markdown
## 📊 Audit Summary: [Project Name]

**Audit Date:** [timestamp]
**Scope:** $1
**Astro Version:** [version]

### Scores

| Category | Score | Issues |
|----------|-------|--------|
| SEO | X/100 | X critical, X high, X medium |
| Accessibility | X/100 | X critical, X high, X medium |
| Performance | X/100 | X critical, X high, X medium |
| Astro Best Practices | X/100 | X critical, X high, X medium |
| **Overall** | **X/100** | **X total issues** |

---

### 🔴 Critical Issues (Fix Immediately)

1. **[Issue]** - [Category]
   - Location: [file]
   - Impact: [description]
   - Fix: [solution from Astro docs if applicable]

### 🟡 High Priority Issues

1. **[Issue]** - [Category]
   - Astro docs recommendation: [if applicable]

### 🟢 Medium Priority Issues

1. **[Issue]** - [Category]

---

### 🚀 Astro-Specific Recommendations

Based on current Astro docs:

1. **[Recommendation]**
   - Current: [state]
   - Docs suggest: [improvement]
   - Impact: [benefit]

2. **[Recommendation]**
   - Current: [state]
   - Docs suggest: [improvement]
   - Impact: [benefit]

---

### 📈 Estimated Impact

If all issues fixed:
- SEO: +X% organic traffic potential
- Performance: +X Lighthouse points
- Astro: Following all current best practices

---

### 🎯 Action Plan

**Week 1: Critical + Astro Updates**
- [ ] [Task 1] - Est: X min
- [ ] Update deprecated patterns - Est: X min

**Week 2: High Priority**
- [ ] [Task 1] - Est: X min

---

### Add to Tracker?

Should I add these issues to your tracker?
- **Yes** - Creates issues with priority labels
- **No** - Just show this report
```

---

## Data Source Priority

| Check | Priority 1: Database | Priority 2: MCP | Priority 3: File Scan |
|-------|---------------------|-----------------|----------------------|
| Routes | `routes` table | astro-mcp | Glob src/pages |
| Components | `components` table | - | Glob src/components |
| Collections | `collections`, `collection_entries` | astro-mcp | Glob src/content |
| Config | `project_config` table | get-astro-config | Read astro.config |

## MCP Usage in Audit

| Check | Database | Astro Docs MCP | astro-mcp |
|-------|----------|----------------|-----------|
| Config validation | ✅ Primary | Best practice lookup | Fallback |
| Route audit | ✅ Primary | - | Fallback |
| Deprecated patterns | - | Search deprecations | - |
| Integration audit | `integrations` table | Integration docs | Fallback |
| Component patterns | ✅ Primary | Hydration best practices | - |
| Collections audit | ✅ Primary | Schema best practices | Fallback |
| Image optimization | - | Image service docs | Image config |
