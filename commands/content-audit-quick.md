---
description: 10-point rapid content check with score/10
argument-hint: "[page-path] [target-keyword]"
---

# Quick Content Audit - 10-Point Check

Fast SEO assessment covering the 10 most impactful factors. Returns a score out of 10 with the top 3 fixes and rewritten meta elements.

**Time:** ~2 minutes vs 10+ for full audit

---

## Prerequisites

- Page path or URL
- Target keyword

No MCP servers required (but GSC enhances results).

---

## The 10 Checkpoints

Run through these checks quickly:

```markdown
## Quick Audit: [page-path]
**Target Keyword:** "[keyword]"
**Date:** [date]

---

### 10-Point Assessment

| # | Check | Status | Points |
|---|-------|--------|--------|
| 1 | Title tag under 60 chars, keyword front-loaded | ✅/❌ | 0-1 |
| 2 | Meta description 150-160 chars with CTA | ✅/❌ | 0-1 |
| 3 | Single H1 that matches search intent | ✅/❌ | 0-1 |
| 4 | First 100 words directly answer the query | ✅/❌ | 0-1 |
| 5 | Logical H2/H3 heading structure | ✅/❌ | 0-1 |
| 6 | Author byline with linked bio | ✅/❌ | 0-1 |
| 7 | Personal experience/anecdotes included | ✅/❌ | 0-1 |
| 8 | 2-3+ internal links to related content | ✅/❌ | 0-1 |
| 9 | 2-3+ external links to authoritative sources | ✅/❌ | 0-1 |
| 10 | Images with descriptive alt text | ✅/❌ | 0-1 |

---

### Score: X/10

| Rating | Meaning |
|--------|---------|
| 9-10 | Excellent - minor polish only |
| 7-8 | Good - quick fixes needed |
| 5-6 | Fair - several improvements needed |
| 3-4 | Poor - significant work required |
| 0-2 | Critical - major rewrite needed |
```

---

## Check Details

### 1. Title Tag
```markdown
**Current:** "[title]" (X chars)

**Checks:**
- [ ] Under 60 characters
- [ ] Keyword "[keyword]" appears in first half
- [ ] Not truncated in SERPs

**Result:** ✅ Pass / ❌ Fail
```

### 2. Meta Description
```markdown
**Current:** "[description]" (X chars)

**Checks:**
- [ ] 150-160 characters (sweet spot)
- [ ] Contains target keyword
- [ ] Ends with CTA or value prop

**Result:** ✅ Pass / ❌ Fail
```

### 3. H1 Heading
```markdown
**Current:** "[h1]"

**Checks:**
- [ ] Exactly one H1 on page
- [ ] Clearly matches search intent for "[keyword]"
- [ ] Different from title tag (not duplicate)

**Result:** ✅ Pass / ❌ Fail
```

### 4. First 100 Words
```markdown
**First paragraph:**
> [first 100 words]

**Checks:**
- [ ] Directly answers "what is [keyword]" or the query intent
- [ ] Contains target keyword naturally
- [ ] Could be extracted by AI for featured snippet

**Result:** ✅ Pass / ❌ Fail
```

### 5. Heading Structure
```markdown
**Current structure:**
- H1: [title]
  - H2: [section 1]
    - H3: [subsection]
  - H2: [section 2]
  - H2: [section 3]

**Checks:**
- [ ] Logical hierarchy (no skipped levels)
- [ ] H2s create clear outline
- [ ] Keyword variations in headings

**Result:** ✅ Pass / ❌ Fail
```

### 6. Author Byline
```markdown
**Checks:**
- [ ] Author name visible on page
- [ ] Links to author bio/about page
- [ ] Bio includes relevant credentials

**Found:** [Yes/No - details]

**Result:** ✅ Pass / ❌ Fail
```

### 7. Personal Experience
```markdown
**Checks:**
- [ ] First-person anecdotes ("I tried...", "In my experience...")
- [ ] Specific examples with real data
- [ ] Original insights not found elsewhere

**Found:** [Examples if present]

**Result:** ✅ Pass / ❌ Fail
```

### 8. Internal Links
```markdown
**Found:** X internal links

**Links:**
1. [anchor text] → /[path]
2. [anchor text] → /[path]
3. [anchor text] → /[path]

**Checks:**
- [ ] At least 2-3 internal links
- [ ] Descriptive anchor text (not "click here")
- [ ] Links to related content

**Result:** ✅ Pass / ❌ Fail
```

### 9. External Links
```markdown
**Found:** X external links

**Links:**
1. [anchor text] → [domain]
2. [anchor text] → [domain]

**Checks:**
- [ ] At least 2-3 external links
- [ ] Links to authoritative sources
- [ ] Support claims made in content

**Result:** ✅ Pass / ❌ Fail
```

### 10. Image Alt Text
```markdown
**Found:** X images

**Images:**
1. [filename] - Alt: "[alt text]" ✅/❌
2. [filename] - Alt: "[alt text]" ✅/❌
3. [filename] - Alt: "[alt text]" ✅/❌

**Checks:**
- [ ] All images have alt text
- [ ] Alt text is descriptive (not "image1.jpg")
- [ ] At least one alt includes keyword naturally

**Result:** ✅ Pass / ❌ Fail
```

---

## Output Format

```markdown
## Quick Audit Results

**Page:** `[path]`
**Keyword:** "[keyword]"
**Score:** X/10 ([Rating])

---

### Top 3 Fixes (Most Impact)

1. **[Issue]** - [Fix in one sentence]
   - File: `[path]` line [X]

2. **[Issue]** - [Fix in one sentence]
   - File: `[path]` line [X]

3. **[Issue]** - [Fix in one sentence]
   - File: `[path]` line [X]

---

### Rewritten Elements

**Title Tag (optimized):**
```yaml
title: "[new title < 60 chars with keyword front-loaded]"
```

**Meta Description (optimized):**
```yaml
description: "[new description 150-160 chars with CTA]"
```

**First Paragraph (AI-optimized):**
```markdown
[Rewritten first paragraph that directly answers the query, contains keyword naturally, and could be extracted for AI Overview]
```

---

### Quick Actions

1. **"Apply fixes"** - Update the file with recommendations
2. **"Full audit"** - Run comprehensive /content-audit
3. **"Skip"** - Just note the findings
```

---

## Save to Database

Store quick audit with limited fields:

```sql
INSERT INTO audits (
  page_path, target_keyword, audit_type, overall_score
) VALUES (
  '[path]', '[keyword]', 'quick', [score * 10]
);
```

---

## Example Usage

```bash
# Quick check on a blog post
/content-audit-quick /blog/seo-tips "seo tips"

# Quick check by file path
/content-audit-quick src/content/blog/seo-tips.md "seo tips for beginners"
```

---

## When to Use Quick vs Full Audit

| Scenario | Use |
|----------|-----|
| Initial triage of many pages | Quick |
| Before publishing new content | Quick |
| Deep optimization effort | Full |
| Competitor analysis needed | Full |
| Keyword research needed | Full |
| Historical tracking | Full |
