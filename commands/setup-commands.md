---
description: Generate custom commands based on your site's content structure
---

# Generate Custom Commands

Analyzes your Astro project's content structure and generates tailored slash commands for your specific content types.

## Overview

Every site is different. This command:
1. Scans your content collections, data files, and page structure
2. Identifies your content types (blog, products, services, team, FAQs, etc.)
3. Generates custom commands specific to your content
4. Installs them to `.claude/commands/`

---

## Step 1: Analyze Content Structure

### Query astro-mcp for Project Info

```markdown
### 📁 Content Structure Analysis

#### Content Collections Found
| Collection | Location | Count | Schema Fields |
|------------|----------|-------|---------------|
| [name] | src/content/[name]/ | X | [fields] |

#### Data Files Found
| File | Location | Type | Items |
|------|----------|------|-------|
| [name] | src/data/[name].js | Array/Object | X |

#### Dynamic Routes
| Pattern | Source | Content Type |
|---------|--------|--------------|
| /blog/[slug] | src/pages/blog/[slug].astro | Blog posts |
| /products/[id] | src/pages/products/[id].astro | Products |

#### Static Pages
| Path | Source | Purpose |
|------|--------|---------|
| / | src/pages/index.astro | Homepage |
| /about | src/pages/about.astro | About page |
```

---

## Step 2: Identify Content Types

### Common Content Types to Detect

| Type | Detection Signals | Potential Commands |
|------|-------------------|-------------------|
| **Blog** | content/blog, posts, articles | /new-post, /optimize-post, /post-ideas |
| **Products** | content/products, data/products | /new-product, /product-seo, /product-gaps |
| **Services** | content/services, data/services | /new-service, /service-pages |
| **Team** | content/team, data/team | /new-team-member, /team-bios |
| **FAQs** | content/faqs, data/faqs | /new-faq, /faq-from-gsc |
| **Testimonials** | content/testimonials | /new-testimonial |
| **Case Studies** | content/cases, case-studies | /new-case-study |
| **Locations** | content/locations, data/locations | /new-location, /local-seo |
| **Events** | content/events | /new-event |
| **Docs** | content/docs, documentation | /new-doc, /doc-gaps |
| **Portfolio** | content/portfolio, projects | /new-project |
| **Recipes** | content/recipes | /new-recipe, /recipe-seo |
| **Jobs** | content/jobs, careers | /new-job |

---

## Step 3: Generate Command Templates

### For Each Content Type Found, Generate:

#### 1. Creation Command: `/new-[type]`
```markdown
---
description: Create a new [type] with SEO optimization
---

# Create New [Type]

## Prerequisites
- Content collection schema understood
- GSC data available (optional, for keyword suggestions)

## Step 1: Gather Information

**Required fields** (from your schema):
[List fields from collection schema]

**SEO fields:**
- Title (< 60 chars)
- Meta description (< 155 chars)
- Target keyword

## Step 2: Keyword Research (if GSC available)

Query GSC for related opportunities:
- Filter: queries related to [type]
- Look for gaps in current [type] content

## Step 3: Generate Content

**File location:** `src/content/[collection]/[slug].md`

```yaml
---
[Schema fields with values]
---
```

[Content structure based on type]

## Step 4: Internal Linking

Suggest links from:
- Homepage (if high-traffic)
- Related [types]
- Category/listing pages

## Step 5: Verify

- [ ] Schema valid
- [ ] Build passes
- [ ] Preview looks correct
```

#### 2. Optimization Command: `/optimize-[type]`
```markdown
---
description: Optimize existing [type] content for SEO
---

# Optimize [Type] for SEO

## Step 1: Select [Type] to Optimize

**Options:**
1. By GSC performance (low CTR, high impressions)
2. By age (oldest content first)
3. Specific [type] by name/slug

## Step 2: Current Performance (if GSC available)

| Metric | Value |
|--------|-------|
| Impressions | X |
| Clicks | X |
| CTR | X% |
| Position | X.X |
| Top queries | [list] |

## Step 3: Optimization Checklist

- [ ] Title includes target keyword (< 60 chars)
- [ ] Meta description compelling with CTA (< 155 chars)
- [ ] H1 matches search intent
- [ ] Content addresses top queries
- [ ] Internal links from high-traffic pages
- [ ] Schema markup present
- [ ] Images optimized with alt text

## Step 4: Apply Changes

[Edit the specific file with optimizations]

## Step 5: Track

Add to impact tracker for measurement in 14+ days.
```

#### 3. Gap Analysis Command: `/[type]-gaps`
```markdown
---
description: Find [type] content gaps from GSC data
---

# [Type] Content Gaps

## Step 1: Query GSC

Filter for queries related to [type]:
- Keywords containing: [type-related terms]
- Landing pages: /[type-path]/*

## Step 2: Identify Gaps

| Query | Impressions | Position | Has Dedicated [Type]? |
|-------|-------------|----------|----------------------|
| [query] | X | X.X | Yes/No |

## Step 3: Prioritize

Score by: (Impressions × Intent Match) / Effort

## Step 4: Generate Briefs

For top gaps, create content briefs with:
- Target keyword
- Recommended structure
- Internal linking plan
```

#### 4. Bulk Operations Command: `/[type]-audit`
```markdown
---
description: Audit all [type] content for issues
---

# [Type] Content Audit

## Audit Criteria

| Check | Pass | Fail | Action |
|-------|------|------|--------|
| Has meta description | X | X | List to fix |
| Title < 60 chars | X | X | List to fix |
| Has featured image | X | X | List to fix |
| Word count > 300 | X | X | List to expand |
| Has internal links | X | X | List to link |
| Schema markup | X | X | List to add |

## Output

Prioritized list of [types] needing attention.
```

---

## Step 4: Present Generated Commands

```markdown
## 🎯 Custom Commands Generated

Based on your content structure, I can create these commands:

### For: Blog Posts (src/content/blog/)
| Command | Description |
|---------|-------------|
| `/new-post` | Create new blog post with SEO optimization |
| `/optimize-post` | Improve existing post's SEO performance |
| `/post-gaps` | Find blog topic gaps from GSC data |
| `/post-audit` | Audit all posts for SEO issues |

### For: Products (src/content/products/)
| Command | Description |
|---------|-------------|
| `/new-product` | Add new product with schema markup |
| `/optimize-product` | Improve product page SEO |
| `/product-gaps` | Find product page opportunities |
| `/product-audit` | Audit all product pages |

### For: Services (src/data/services.js)
| Command | Description |
|---------|-------------|
| `/new-service` | Add new service offering |
| `/optimize-service` | Improve service page SEO |
| `/service-gaps` | Find service page opportunities |

### For: FAQs (src/content/faqs/)
| Command | Description |
|---------|-------------|
| `/new-faq` | Add new FAQ entry |
| `/faq-from-gsc` | Generate FAQs from GSC "question" queries |
| `/faq-schema` | Ensure FAQ schema markup is correct |

---

## Installation Options

1. **"Install all"** - Create all recommended commands
2. **"Install [type]"** - Create commands for specific content type
3. **"Preview [command]"** - See the full command before installing
4. **"Customize [command]"** - Modify before installing

Which would you like?
```

---

## Step 5: Install Selected Commands

When user selects commands to install:

```markdown
## Installing Custom Commands

### Creating: /new-post

**File:** `.claude/commands/new-post.md`

[Write customized command file based on actual schema]

### Creating: /optimize-post

**File:** `.claude/commands/optimize-post.md`

[Write customized command file]

---

## ✅ Installation Complete

**Commands installed:**
- `/new-post` - Create blog posts
- `/optimize-post` - Optimize posts for SEO
- `/post-gaps` - Find content gaps
- `/post-audit` - Audit all posts

**To use:**
```bash
/new-post "How to optimize images in Astro"
/optimize-post  # Will prompt for selection
/post-gaps      # Requires GSC
/post-audit     # Full audit
```

**Commands are in:** `.claude/commands/`

Would you like to generate commands for another content type?
```

---

## Step 6: Smart Command Generation

### Detect Schema and Customize

For a blog collection with this schema:
```typescript
const blog = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    description: z.string(),
    pubDate: z.date(),
    author: z.string(),
    image: z.object({
      url: z.string(),
      alt: z.string()
    }).optional(),
    tags: z.array(z.string()),
    draft: z.boolean().default(false)
  })
});
```

Generate `/new-post` that includes:
```markdown
## Required Fields

| Field | Type | Validation |
|-------|------|------------|
| title | string | Required, < 60 chars for SEO |
| description | string | Required, < 155 chars for SEO |
| pubDate | date | Required, format: YYYY-MM-DD |
| author | string | Required |
| image.url | string | Optional, but recommended |
| image.alt | string | Required if image provided |
| tags | string[] | At least 1 recommended |
| draft | boolean | Default: false |

## Template

```yaml
---
title: "[TITLE]"
description: "[DESCRIPTION]"
pubDate: [DATE]
author: "[AUTHOR]"
image:
  url: "/images/blog/[SLUG].jpg"
  alt: "[ALT TEXT]"
tags: ["[TAG1]", "[TAG2]"]
draft: false
---
```
```

---

## Content-Specific Command Templates

### E-commerce Site Commands

If products detected:
```markdown
/new-product       - Add product with schema
/product-variants  - Manage product variants
/product-seo       - Optimize product for search
/collection-page   - Create collection/category page
/product-schema    - Validate Product schema markup
```

### Local Business Commands

If locations/services detected:
```markdown
/new-location      - Add new location with LocalBusiness schema
/local-seo         - Optimize for local search
/service-area      - Define service area pages
/review-schema     - Add/validate review schema
```

### Documentation Site Commands

If docs detected:
```markdown
/new-doc           - Create documentation page
/doc-nav           - Update navigation structure
/doc-search        - Optimize for search visibility
/doc-links         - Check internal doc links
```

### Blog/Content Site Commands

If blog detected:
```markdown
/new-post          - Create blog post
/post-series       - Create multi-part series
/update-post       - Refresh outdated content
/post-performance  - Review post metrics
/content-calendar  - Plan upcoming content
```

---

## MCP Usage

| Step | astro-mcp | Astro Docs | GSC |
|------|-----------|------------|-----|
| Structure scan | Collections, routes | - | - |
| Schema detection | Config | Collection API | - |
| Keyword research | - | - | Query data |
| Command generation | File paths | Best practices | - |

---

## Fallback: No astro-mcp

If astro-mcp not available:

```markdown
## Manual Content Detection

I'll scan your project structure directly:

1. **Checking src/content/** for collections
2. **Checking src/data/** for data files
3. **Checking src/pages/** for route patterns
4. **Reading astro.config.mjs** for integrations

[Proceed with file-based analysis]
```

---

## Example Output

```markdown
## 🎉 Analysis Complete

### Your Site Structure

**Type:** Local Business / Service Provider
**Content Collections:** 3
**Data Files:** 2
**Total Routes:** 47

### Recommended Custom Commands

#### High Priority (matches your content)
| Command | Why |
|---------|-----|
| `/new-service` | You have 12 services, likely adding more |
| `/service-gaps` | 340 GSC queries for services not covered |
| `/local-seo` | Location-based business benefits from local SEO |
| `/faq-from-gsc` | 89 question queries in GSC |

#### Medium Priority
| Command | Why |
|---------|-----|
| `/new-testimonial` | Social proof helps conversions |
| `/case-study` | You have 3, could expand |

#### Already Covered
| Need | Existing Command |
|------|------------------|
| Blog content | `/content-gap` covers this |
| General SEO | `/seo-wins` covers this |

### Install Now?

**Options:**
1. **"Install recommended"** - High priority commands
2. **"Install all"** - All suggested commands
3. **"Show me /new-service"** - Preview before installing
```
