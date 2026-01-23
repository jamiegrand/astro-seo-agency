---
description: Deep dive E-E-A-T audit (Experience, Expertise, Authority, Trust)
argument-hint: "[page-path]"
---

# E-E-A-T Deep Dive Audit

Focused audit specifically on Experience, Expertise, Authoritativeness, and Trustworthiness signals. Essential for YMYL (Your Money Your Life) content and competitive niches.

---

## What is E-E-A-T?

Google's quality rater guidelines emphasize these signals:

| Signal | Meaning | Why It Matters |
|--------|---------|----------------|
| **E**xperience | Author has first-hand experience | "I did this" > "Here's how to" |
| **E**xpertise | Author has knowledge/credentials | Qualifications matter |
| **A**uthoritativeness | Content is recognized as authoritative | Citations, comprehensiveness |
| **T**rustworthiness | Content can be trusted | Accuracy, transparency |

---

## Prerequisites

- Page path or URL to audit
- No MCP servers required

---

## Step 1: Read and Analyze Content

```markdown
### 📄 Content Overview

**Page:** `[path]`
**URL:** /[url]
**Word Count:** X words
**Topic:** [inferred topic]
**YMYL Status:** [Yes/No - health, finance, legal, safety topics]
```

---

## Step 2: Experience Audit (0-25 points)

Check for first-hand experience signals:

```markdown
### 👤 Experience Score: X/25

#### Personal Anecdotes (0-6 points)
**Looking for:** First-person stories, "I tried...", "In my experience..."

| Check | Found | Points |
|-------|-------|--------|
| First-person anecdotes | ✅/❌ | 0-3 |
| Specific personal examples | ✅/❌ | 0-3 |

**Evidence found:**
> "[Quote showing personal experience, if any]"

**Assessment:** [Present/Weak/Missing]

---

#### Original Visuals (0-6 points)
**Looking for:** Screenshots, personal photos, not stock images

| Check | Found | Points |
|-------|-------|--------|
| Original screenshots | ✅/❌ | 0-3 |
| Personal photos | ✅/❌ | 0-2 |
| Process documentation | ✅/❌ | 0-1 |

**Images analyzed:**
| Image | Type | Assessment |
|-------|------|------------|
| [image1.jpg] | Stock photo | ❌ |
| [screenshot.png] | Original | ✅ |

---

#### Specific Case Studies (0-8 points)
**Looking for:** Real data, named examples, measurable outcomes

| Check | Found | Points |
|-------|-------|--------|
| Named case study | ✅/❌ | 0-3 |
| Specific data/metrics | ✅/❌ | 0-3 |
| Before/after comparison | ✅/❌ | 0-2 |

**Evidence found:**
> "[Quote with specific data, if any]"

---

#### First-Hand Language (0-5 points)
**Looking for:** "I discovered...", "When I tested...", "My results showed..."

| Phrase Type | Count | Example |
|-------------|-------|---------|
| "I [verb]..." | X | "[example]" |
| "My experience..." | X | "[example]" |
| "When I tried..." | X | "[example]" |

**Assessment:** [Strong/Moderate/Weak/Missing]
```

---

## Step 3: Expertise Audit (0-25 points)

Check for subject matter expertise:

```markdown
### 🎓 Expertise Score: X/25

#### Author Byline (0-5 points)
**Looking for:** Named author, not "Admin" or site name

| Check | Found | Points |
|-------|-------|--------|
| Author name present | ✅/❌ | 0-2 |
| Author photo | ✅/❌ | 0-1 |
| Link to bio page | ✅/❌ | 0-2 |

**Current author display:**
- Name: [found or missing]
- Photo: [found or missing]
- Bio link: [found or missing]

---

#### Author Credentials (0-10 points)
**Looking for:** Relevant qualifications, experience, certifications

| Check | Found | Points |
|-------|-------|--------|
| Professional title | ✅/❌ | 0-2 |
| Relevant experience (years) | ✅/❌ | 0-3 |
| Certifications/degrees | ✅/❌ | 0-3 |
| Published work/speaking | ✅/❌ | 0-2 |

**Credentials found:**
> "[Author bio text, if present]"

**Assessment:** [Expert/Knowledgeable/Unclear/Anonymous]

---

#### Technical Accuracy (0-5 points)
**Looking for:** Correct information, up-to-date facts

| Check | Status | Points |
|-------|--------|--------|
| No factual errors spotted | ✅/❌ | 0-2 |
| Information is current | ✅/❌ | 0-2 |
| Terminology used correctly | ✅/❌ | 0-1 |

**Concerns noted:**
- [Any accuracy issues found]

---

#### Depth of Coverage (0-5 points)
**Looking for:** Beyond surface-level, addresses nuances

| Check | Status | Points |
|-------|--------|--------|
| Covers advanced aspects | ✅/❌ | 0-2 |
| Addresses edge cases | ✅/❌ | 0-1 |
| Provides unique insights | ✅/❌ | 0-2 |

**Assessment:** [Comprehensive/Adequate/Surface-level/Thin]
```

---

## Step 4: Authoritativeness Audit (0-25 points)

Check for authority signals:

```markdown
### 🏆 Authoritativeness Score: X/25

#### External Citations (0-10 points)
**Looking for:** Links to credible sources that support claims

| Check | Count | Points |
|-------|-------|--------|
| External links present | X | 0-3 |
| Links to authoritative domains | X | 0-4 |
| Links support specific claims | X | 0-3 |

**Citations found:**
| Claim | Source | Domain Authority |
|-------|--------|------------------|
| "[claim]" | [source] | [assessment] |
| "[claim]" | [source] | [assessment] |

**Domain quality:**
- .gov/.edu sources: X
- Industry authorities: X
- Generic sources: X

---

#### Topic Comprehensiveness (0-10 points)
**Looking for:** Covers all aspects a user would want

| Check | Status | Points |
|-------|--------|--------|
| Main topic fully covered | ✅/❌ | 0-4 |
| Related subtopics addressed | ✅/❌ | 0-3 |
| Common questions answered | ✅/❌ | 0-3 |

**Topic coverage analysis:**
| Expected Subtopic | Covered? |
|-------------------|----------|
| [subtopic 1] | ✅/❌ |
| [subtopic 2] | ✅/❌ |
| [subtopic 3] | ✅/❌ |

**Gaps identified:**
- [Missing topic 1]
- [Missing topic 2]

---

#### Unique Insights (0-5 points)
**Looking for:** Original research, unique perspective, new information

| Check | Found | Points |
|-------|-------|--------|
| Original research/data | ✅/❌ | 0-2 |
| Unique perspective | ✅/❌ | 0-2 |
| Information not elsewhere | ✅/❌ | 0-1 |

**Unique elements found:**
> "[Any unique insights or original content]"
```

---

## Step 5: Trustworthiness Audit (0-25 points)

Check for trust signals:

```markdown
### 🛡️ Trustworthiness Score: X/25

#### Content Freshness (0-7 points)
**Looking for:** Updated date, current information

| Check | Status | Points |
|-------|--------|--------|
| Publish date visible | ✅/❌ | 0-2 |
| Last updated date visible | ✅/❌ | 0-3 |
| Content reflects current year | ✅/❌ | 0-2 |

**Dates found:**
- Published: [date or not found]
- Updated: [date or not found]
- Age: [X months/years]

---

#### Source Attribution (0-8 points)
**Looking for:** Proper citations, clear sourcing

| Check | Status | Points |
|-------|--------|--------|
| Claims have sources | ✅/❌ | 0-3 |
| Sources are linked | ✅/❌ | 0-2 |
| Statistics have attribution | ✅/❌ | 0-3 |

**Unsourced claims found:**
- "[Claim without source]"
- "[Claim without source]"

---

#### Contact & Transparency (0-5 points)
**Looking for:** Contact info, about page, editorial policy

| Check | Status | Points |
|-------|--------|--------|
| Contact info accessible | ✅/❌ | 0-2 |
| About page exists | ✅/❌ | 0-2 |
| Editorial/disclosure policy | ✅/❌ | 0-1 |

---

#### Technical Trust (0-5 points)
**Looking for:** HTTPS, professional design

| Check | Status | Points |
|-------|--------|--------|
| HTTPS enabled | ✅/❌ | 0-2 |
| Professional appearance | ✅/❌ | 0-2 |
| No intrusive ads | ✅/❌ | 0-1 |
```

---

## Step 6: Generate E-E-A-T Report

```markdown
## 📋 E-E-A-T Audit Report

**Page:** `[path]`
**URL:** /[url]
**Date:** [date]
**YMYL Content:** [Yes/No]

---

### Overall E-E-A-T Score: XX/100

| Dimension | Score | Max | Grade |
|-----------|-------|-----|-------|
| Experience | X | 25 | [A-F] |
| Expertise | X | 25 | [A-F] |
| Authoritativeness | X | 25 | [A-F] |
| Trustworthiness | X | 25 | [A-F] |

**Grade Scale:**
- A: 90-100% (23-25 points)
- B: 75-89% (19-22 points)
- C: 60-74% (15-18 points)
- D: 40-59% (10-14 points)
- F: 0-39% (0-9 points)

---

### 🚨 Critical E-E-A-T Issues

1. **[Issue]** - [Dimension]
   - Impact: [Why this matters]
   - Fix: [Specific action]

2. **[Issue]** - [Dimension]
   - Impact: [Why this matters]
   - Fix: [Specific action]

3. **[Issue]** - [Dimension]
   - Impact: [Why this matters]
   - Fix: [Specific action]

---

### ✅ E-E-A-T Strengths

- [Strength 1]
- [Strength 2]
- [Strength 3]

---

### 📝 Specific Additions to Make

#### Experience Additions
- Add this anecdote: "[Suggested personal story related to topic]"
- Include screenshot of: [What to document]
- Add case study: "[Suggested case study approach]"

#### Expertise Additions
- Add author byline linking to: /about/[author]
- Include credentials: "[Suggested credential display]"
- Demonstrate depth by adding section on: [Advanced subtopic]

#### Authority Additions
- Add citation for claim: "[Unsourced claim]" → [Suggested source]
- Cover missing topic: [Topic]
- Include unique data: [Suggested original contribution]

#### Trust Additions
- Add "Last updated: [date]" to frontmatter
- Source this statistic: "[Stat without source]"
- Link to contact page from footer

---

### 📋 Implementation Checklist

**File:** `[path]`

#### Frontmatter Updates
```yaml
# Add to frontmatter:
author: "[name]"
authorBio: "[credentials]"
lastUpdated: [date]
```

#### Content Additions
- [ ] Add personal experience paragraph at [location]
- [ ] Include case study with data in [section]
- [ ] Add author bio component after title
- [ ] Add "Last updated" display

#### External Changes
- [ ] Create author bio page at /about/[author]
- [ ] Add editorial policy page
- [ ] Ensure contact page is linked
```

---

## Step 7: Save to Database

```sql
INSERT INTO audits (
  page_path, audit_type, overall_score, eeat_score, findings
) VALUES (
  '[path]', 'eeat', [total], [total],
  '{"experience": X, "expertise": X, "authority": X, "trust": X}'
);
```

---

## Example Usage

```bash
# E-E-A-T audit on a blog post
/content-eeat /blog/health-tips

# E-E-A-T audit by file path
/content-eeat src/content/blog/investment-guide.md
```

---

## When E-E-A-T Matters Most

| Content Type | E-E-A-T Importance |
|--------------|-------------------|
| Health/Medical | Critical |
| Financial/Legal | Critical |
| News/Current Events | High |
| Product Reviews | High |
| How-To Guides | Medium |
| Entertainment | Lower |

**YMYL (Your Money Your Life):** Content that could impact health, finances, safety, or well-being requires the strongest E-E-A-T signals.
