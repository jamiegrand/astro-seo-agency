---
description: Full SEO content audit with E-E-A-T and AI Overview scoring (0-100)
argument-hint: "[page-path] [target-keyword?]"
---

# Content Audit - Comprehensive SEO Analysis

Performs a full 6-category SEO audit on a single page with scoring, competitor analysis, and actionable recommendations. Results are stored in SQLite for trend tracking.

---

## Prerequisites

**Required:**
- Page path (e.g., `src/content/blog/my-post.md`) OR URL (e.g., `/blog/my-post`)

**Optional:**
- Target keyword (auto-detected if not provided)

**Optional MCP Servers:**
- **GSC MCP** - Page performance metrics (clicks, impressions, position)
- **DataForSEO** - Keyword volume, difficulty, PAA questions
- **ScraperAPI** - Competitor content analysis

---

## Step 0: Auto-Detect Target Keyword

If no keyword is provided, attempt to detect it automatically:

### Priority 1: Check page_keywords table (from link data import)

```sql
SELECT pk.keyword
FROM page_keywords pk
JOIN page_analysis pa ON pk.page_id = pa.id
WHERE pa.url LIKE '%[slug]%'
   OR pa.source_file LIKE '%[slug]%'
ORDER BY pk.is_primary DESC
LIMIT 1;
```

### Priority 2: Check frontmatter for seoKeyword/targetKeyword field

```markdown
Read the source file and check for:
- `seoKeyword: "..."`
- `targetKeyword: "..."`
- `keyword: "..."`
```

### Priority 3: Query GSC for top query

```sql
-- If GSC MCP available
SELECT query
FROM gsc_snapshots
WHERE page_path LIKE '%[slug]%'
ORDER BY impressions DESC
LIMIT 1;
```

### Priority 4: Extract from title

Strip common patterns from title:
- Remove "How to...", "A Guide to...", "The Complete...", etc.
- Remove year references (2024, 2025, 2026)
- Extract core noun phrase

### Display Detection Result

```markdown
### 🔑 Target Keyword Detection

| Source | Keyword | Confidence |
|--------|---------|------------|
| Link Data Import | "Web Designer Woodford" | ✅ High |
| Frontmatter | - | - |
| GSC Top Query | "web designer woodford" | ✅ High |
| Title Extraction | "web design mistakes woodford" | ⚠️ Medium |

**Selected:** "Web Designer Woodford" (from Link Data Import)

**Additional keywords found:**
- Local SEO
- Mobile-friendly design
- Site Speed
- Conversion Rate Optimization

*Override with: `/audit content [page] "your keyword"`*
```

---

## Step 1: Resolve Page to Source File

### If URL provided:
Use astro-mcp to map URL to source file:

```markdown
### 📍 Page Resolution

| Input | Value |
|-------|-------|
| URL | /blog/[slug] |
| Source File | `src/content/blog/[slug].md` |
| Content Type | Collection (blog) |
| Route Type | Dynamic |
```

### If path provided:
Verify file exists and determine content type:

```markdown
### 📍 Page Resolution

| Input | Value |
|-------|-------|
| Path | src/content/blog/[slug].md |
| URL | /blog/[slug] |
| Content Type | Collection (blog) |
| Collection Schema | (from astro-mcp) |
```

---

## Step 2: Read and Parse Content

Read the source file and extract:

```markdown
### 📄 Content Analysis

**Frontmatter:**
| Field | Value |
|-------|-------|
| title | "[extracted]" |
| description | "[extracted]" |
| pubDate | [date] |
| author | [if present] |
| image | [if present] |

**Content Metrics:**
| Metric | Value |
|--------|-------|
| Word Count | X words |
| Reading Time | ~X min |
| Headings | X H2, X H3 |
| Images | X total |
| Internal Links | X |
| External Links | X |
```

---

## Step 3: Query Performance Data (GSC)

If GSC MCP is available:

```markdown
### 📊 GSC Performance (Last 28 Days)

| Metric | Value |
|--------|-------|
| Clicks | X |
| Impressions | X |
| CTR | X% |
| Avg Position | X.X |

**Top Queries:**
| Query | Clicks | Impressions | Position |
|-------|--------|-------------|----------|
| [query 1] | X | X | X.X |
| [query 2] | X | X | X.X |
| [query 3] | X | X | X.X |
```

If not available:
```markdown
### 📊 Performance Data

GSC MCP not configured. Configure for:
- Historical performance tracking
- Query-level insights
- Decline detection

Run `/verify` to check MCP status.
```

---

## Step 4: Query Keyword Data (DataForSEO)

If DataForSEO is available:

```markdown
### 🔑 Keyword Research: "[target keyword]"

| Metric | Value |
|--------|-------|
| Search Volume | X/month |
| Keyword Difficulty | X/100 |
| CPC | $X.XX |
| Competition | [Low/Medium/High] |

**SERP Features Present:**
- [ ] Featured Snippet
- [ ] People Also Ask
- [ ] Image Pack
- [ ] Video Results
- [ ] Local Pack

**People Also Ask:**
1. [Question 1]
2. [Question 2]
3. [Question 3]
4. [Question 4]
5. [Question 5]

**Related Keywords:**
| Keyword | Volume | Difficulty |
|---------|--------|------------|
| [related 1] | X | X |
| [related 2] | X | X |
| [related 3] | X | X |
```

If not available:
```markdown
### 🔑 Keyword Data

DataForSEO not configured. Configure for:
- Search volume insights
- Keyword difficulty scores
- People Also Ask questions
- Related keyword suggestions

Set DATAFORSEO_USERNAME and DATAFORSEO_PASSWORD in .env
```

---

## Step 5: Competitor Analysis (ScraperAPI)

If competitor URLs provided and ScraperAPI available:

```markdown
### 🏆 Competitor Analysis

**Competitors Analyzed:**
1. [URL 1]
2. [URL 2]
3. [URL 3]

**Comparison:**
| Metric | Your Page | Comp 1 | Comp 2 | Comp 3 |
|--------|-----------|--------|--------|--------|
| Word Count | X | X | X | X |
| H2 Count | X | X | X | X |
| Images | X | X | X | X |
| Internal Links | X | X | X | X |
| External Links | X | X | X | X |

**Topics Covered by Competitors (Missing from Your Content):**
1. [Topic not covered]
2. [Topic not covered]
3. [Topic not covered]

**Structural Elements:**
| Element | Your Page | Competitors |
|---------|-----------|-------------|
| FAQ Section | ❌ | 2/3 have |
| Comparison Table | ❌ | 3/3 have |
| Numbered Steps | ✅ | 2/3 have |
| Statistics w/ Sources | ❌ | 2/3 have |
```

---

## Step 6: Run 6-Category Audit

### Category 1: On-Page SEO Elements (0-20 points)

```markdown
#### 📝 On-Page SEO (X/20)

**Title Tag**
- Current: `[title]` (X chars)
- [ ] Under 60 characters: ✅/❌ (+2)
- [ ] Keyword front-loaded: ✅/❌ (+3)
- [ ] Includes power word/number: ✅/❌ (+1)
- Score: X/6

**Meta Description**
- Current: `[description]` (X chars)
- [ ] 150-160 characters: ✅/❌ (+2)
- [ ] Contains keyword: ✅/❌ (+2)
- [ ] Has call-to-action: ✅/❌ (+1)
- [ ] Active voice: ✅/❌ (+1)
- Score: X/6

**URL Slug**
- Current: `/[slug]`
- [ ] Short and descriptive: ✅/❌ (+1)
- [ ] Contains keyword: ✅/❌ (+2)
- [ ] No dates/stop words: ✅/❌ (+1)
- Score: X/4

**Heading Structure**
- [ ] Single H1: ✅/❌ (+1)
- [ ] H1 matches intent: ✅/❌ (+1)
- [ ] Logical H2 structure: ✅/❌ (+1)
- [ ] Keyword variations in headings: ✅/❌ (+1)
- Score: X/4
```

### Category 2: E-E-A-T Signals (0-25 points)

```markdown
#### 🏅 E-E-A-T Signals (X/25)

**Experience (X/7)**
- [ ] Personal anecdotes present: ✅/❌ (+2)
- [ ] Original images/screenshots: ✅/❌ (+2)
- [ ] Specific case studies with data: ✅/❌ (+2)
- [ ] First-hand "I did this" language: ✅/❌ (+1)

**Expertise (X/7)**
- [ ] Author byline present: ✅/❌ (+2)
- [ ] Author bio with credentials: ✅/❌ (+3)
- [ ] Technical accuracy: ✅/❌ (+1)
- [ ] Depth beyond surface-level: ✅/❌ (+1)

**Authoritativeness (X/6)**
- [ ] External citations (2-3+): ✅/❌ (+3)
- [ ] Comprehensive topic coverage: ✅/❌ (+2)
- [ ] Unique insights: ✅/❌ (+1)

**Trustworthiness (X/5)**
- [ ] Last updated date visible: ✅/❌ (+2)
- [ ] Sources properly cited: ✅/❌ (+2)
- [ ] Contact info accessible: ✅/❌ (+1)
```

### Category 3: Content Quality & Depth (0-20 points)

```markdown
#### 📚 Content Quality (X/20)

**Formatting (X/6)**
- [ ] Short paragraphs (2-4 sentences): ✅/❌ (+2)
- [ ] Bullet points for lists: ✅/❌ (+2)
- [ ] Tables for comparisons: ✅/❌ (+1)
- [ ] Adequate white space: ✅/❌ (+1)

**Readability (X/6)**
- [ ] Clear, accessible language: ✅/❌ (+2)
- [ ] Complex terms explained: ✅/❌ (+2)
- [ ] Appropriate reading level: ✅/❌ (+2)

**Depth (X/8)**
- [ ] Appropriate length for topic: ✅/❌ (+2)
- [ ] Fully answers search intent: ✅/❌ (+3)
- [ ] No significant gaps: ✅/❌ (+3)
```

### Category 4: AI Overview Optimization (0-15 points)

```markdown
#### 🤖 AI Overview Optimization (X/15)

**Citation-Worthiness (X/7)**
- [ ] First paragraph answers query directly: ✅/❌ (+3)
- [ ] Clear, extractable statements: ✅/❌ (+2)
- [ ] Concise definitions: ✅/❌ (+2)

**Structure for AI (X/8)**
- [ ] Numbered steps for processes: ✅/❌ (+2)
- [ ] Comparison tables: ✅/❌ (+2)
- [ ] FAQ section: ✅/❌ (+2)
- [ ] Statistics with sources: ✅/❌ (+2)
```

### Category 5: Linking Strategy (0-10 points)

```markdown
#### 🔗 Linking Strategy (X/10)

**Internal Links (X/5)**
- [ ] 2-3+ internal links present: ✅/❌ (+2)
- [ ] Descriptive anchor text: ✅/❌ (+2)
- [ ] Part of topic cluster: ✅/❌ (+1)

**External Links (X/5)**
- [ ] 2-3+ external links present: ✅/❌ (+2)
- [ ] Links support claims: ✅/❌ (+2)
- [ ] Links to credible sources: ✅/❌ (+1)
```

### Category 6: Multimedia & Formatting (0-10 points)

```markdown
#### 🖼️ Multimedia (X/10)

**Images (X/6)**
- [ ] Relevant images throughout: ✅/❌ (+2)
- [ ] Descriptive alt text: ✅/❌ (+2)
- [ ] Descriptive file names: ✅/❌ (+1)
- [ ] Original images (not stock): ✅/❌ (+1)

**Other Media (X/4)**
- [ ] Video embedded where appropriate: ✅/❌ (+2)
- [ ] Infographics/visualizations: ✅/❌ (+2)
```

---

## Step 7: Generate Report

```markdown
## 📋 Content Audit Report

**Page:** `[source-file-path]`
**URL:** /[url]
**Target Keyword:** "[keyword]"
**Audit Date:** [date]

---

### Executive Summary

**Overall Score: XX/100 ([Rating])**

| Category | Score | Max | Status |
|----------|-------|-----|--------|
| On-Page SEO | X | 20 | [emoji] |
| E-E-A-T Signals | X | 25 | [emoji] |
| Content Quality | X | 20 | [emoji] |
| AI Overview | X | 15 | [emoji] |
| Linking | X | 10 | [emoji] |
| Multimedia | X | 10 | [emoji] |

**Score Rating:**
- 90-100: Excellent - minor tweaks only
- 75-89: Good - solid, needs optimization
- 60-74: Fair - significant gaps
- 40-59: Poor - major issues
- 0-39: Critical - full rewrite needed

---

### 🚨 Top 3 Issues (Fix Immediately)

1. **[Issue 1]** - [Category] - [Severity]
   - Current: [what exists]
   - Fix: [specific action]
   - File: `[path]` line [X]

2. **[Issue 2]** - [Category] - [Severity]
   - Current: [what exists]
   - Fix: [specific action]
   - File: `[path]` line [X]

3. **[Issue 3]** - [Category] - [Severity]
   - Current: [what exists]
   - Fix: [specific action]
   - File: `[path]` line [X]

---

### 📝 Recommended Rewrites

**Title Tag:**
```
Current: [current title]
Recommended: [optimized title < 60 chars]
```

**Meta Description:**
```
Current: [current description]
Recommended: [optimized description 150-160 chars with CTA]
```

**First Paragraph (AI-Optimized):**
```
[Rewritten first paragraph that directly answers the query]
```

---

### 📋 Full Action Checklist

#### Critical (Do Today)
- [ ] [Action 1] - File: `[path]`
- [ ] [Action 2] - File: `[path]`

#### High Priority (This Week)
- [ ] [Action 3] - File: `[path]`
- [ ] [Action 4] - File: `[path]`

#### Medium Priority (This Month)
- [ ] [Action 5] - File: `[path]`
- [ ] [Action 6] - File: `[path]`

#### Low Priority (When Time Permits)
- [ ] [Action 7] - File: `[path]`
- [ ] [Action 8] - File: `[path]`

---

### 🏆 Competitor Gap Analysis

| Topic/Element | Your Page | Competitors |
|---------------|-----------|-------------|
| [Topic 1] | ❌ Missing | 3/3 cover |
| [Topic 2] | ❌ Missing | 2/3 cover |
| [Element 1] | ❌ Missing | 3/3 have |

**Recommended Additions:**
1. Add section about [topic]
2. Include [element type]
3. Cover [missing subtopic]
```

---

## Step 8: Save to Database

Store audit results in SQLite for trend tracking:

```sql
INSERT INTO audits (
  page_path, url, target_keyword, audit_type,
  overall_score, onpage_score, eeat_score, content_score,
  ai_overview_score, linking_score, multimedia_score,
  findings, recommendations
) VALUES (...);
```

Also cache keyword data if DataForSEO was used:

```sql
INSERT OR REPLACE INTO keywords (
  keyword, search_volume, difficulty, cpc, serp_features
) VALUES (...);
```

---

## Step 9: Offer Actions

```markdown
### What would you like to do?

1. **"Apply critical fixes"** - Implement the top 3 issues now
2. **"Apply all fixes"** - Implement all recommended changes
3. **"Show diff"** - Preview changes before applying
4. **"Export report"** - Save to .planning/audits/[slug]-[date].md
5. **"View history"** - See previous audits for this page
6. **"Compare to competitor"** - Deep dive on a specific competitor
```

---

## MCP Usage Summary

| Step | GSC | DataForSEO | ScraperAPI | astro-mcp |
|------|-----|------------|------------|-----------|
| Resolve page | - | - | - | URL mapping |
| Performance | Metrics | - | - | - |
| Keywords | - | Volume, PAA | - | - |
| Competitors | - | - | Scraping | - |
| Best practices | - | - | - | Astro docs |

---

## Example Usage

```bash
# Full audit with all MCP servers
/content-audit src/content/blog/seo-guide.md "seo guide 2025"

# Quick audit by URL
/content-audit /blog/seo-guide "seo guide"

# With competitor URLs
/content-audit /blog/seo-guide "seo guide" --competitors "url1,url2,url3"
```
