---
description: Analyze content performance and ROI
---

# Content ROI Analysis

## Step 1: Inventory Content

Scan the project for content:

### Blog Posts
```
Location: src/content/blog/ or src/pages/blog/
```

### Product Pages
```
Location: src/data/products.js or src/content/products/
```

### Service Pages
```
Location: src/data/services.js or src/pages/services/
```

### Location Pages
```
Location: src/data/locations.js or src/pages/locations/
```

For each piece of content, extract:
- URL/slug
- Title
- Publish date (if available)
- Word count
- Last modified date

---

## Step 2: Query Performance Data

### Google Analytics (90 Days)
For each content URL:
- Sessions
- Users
- Bounce rate
- Avg. session duration
- Pageviews
- Exit rate

### Google Search Console (90 Days)
For each content URL:
- Impressions
- Clicks
- CTR
- Average position
- Top queries driving traffic

---

## Step 3: Calculate Performance Scores

### Scoring Formula

```
Traffic Score = (Sessions / 90) × 10
  → Daily average, scaled

Engagement Score = ((100 - Bounce Rate) / 100) × (Duration / 180) × 10
  → Lower bounce + higher duration = better

SEO Score = (Impressions × CTR × 10) + ((30 - Position) × 2)
  → High impressions + good CTR + good position

Overall Score = (Traffic × 0.4) + (Engagement × 0.3) + (SEO × 0.3)
  → Weighted combination
```

---

## Step 4: Categorize Content

### ⭐ Top Performers
**Criteria:**
- Traffic Score > 70
- Engagement Score > 60
- SEO Score > 50

**Action:** Replicate format, update regularly, link FROM these pages.

### ✅ Solid Performers
**Criteria:**
- Traffic Score 40-70
- Engagement Score > 40
- Some SEO traction

**Action:** Optimize titles/metas, add internal links, consider expansion.

### 🔄 Update Candidates
**Criteria:**
- Low traffic BUT good engagement
- OR High impressions but low clicks
- OR Published > 12 months ago, still relevant

**Action:** Refresh content, update date, improve titles, promote internally.

### ❌ Underperformers
**Criteria:**
- Traffic Score < 20
- Engagement Score < 30
- No SEO traction

**Action:** Major rewrite, merge with better content, or redirect.

### 🗑️ Removal Candidates
**Criteria:**
- Zero sessions for 90+ days
- Outdated/irrelevant content
- Thin content (< 300 words) with no value

**Action:** 301 redirect to relevant page or remove.

---

## Step 5: Identify Patterns

Analyze top performers to find:
- Common topics/themes
- Optimal content length
- Formats that work (lists, guides, comparisons)
- Publishing patterns
- Internal linking patterns

---

## Step 6: Generate Report

```markdown
## 📊 Content ROI Report

**Generated:** [Date]
**Analysis Period:** 90 days
**Content Analyzed:** [X] pieces

---

### Executive Summary

| Metric | Value |
|--------|-------|
| Total Content Pieces | X |
| Total Sessions (90d) | X |
| Avg. Sessions per Content | X |
| Content Driving 80% Traffic | X pieces (Y%) |

### Performance Distribution

| Category | Count | % of Total | Traffic Share |
|----------|-------|------------|---------------|
| ⭐ Top Performers | X | X% | X% |
| ✅ Solid | X | X% | X% |
| 🔄 Update Needed | X | X% | X% |
| ❌ Underperforming | X | X% | X% |
| 🗑️ Remove | X | X% | X% |

---

### ⭐ Top Performers

These are your best content pieces. Replicate what works.

| Content | Sessions | Bounce | Duration | Position | Score |
|---------|----------|--------|----------|----------|-------|
| [Title](/url/) | X | X% | X:XX | X.X | X |
| [Title](/url/) | X | X% | X:XX | X.X | X |
| [Title](/url/) | X | X% | X:XX | X.X | X |

**Common Patterns:**
- Average length: X words
- Common topics: [topics]
- Format: [format type]
- Avg internal links: X

**Recommendation:** Create more content like these. Link new content TO these pages.

---

### 🔄 High-Potential Updates

These have potential but need work.

| Content | Issue | Current | Potential | Effort |
|---------|-------|---------|-----------|--------|
| [Title](/url/) | Low CTR | X clicks | +X clicks | 30m |
| [Title](/url/) | Outdated | X sessions | +X sessions | 2h |
| [Title](/url/) | Thin | X sessions | +X sessions | 1h |

#### 1. [Title] - Low CTR Despite Impressions

**Current Performance:**
- Impressions: X
- Clicks: X
- CTR: X% (should be ~3-5%)
- Position: X.X

**Problem:** Good rankings but users don't click.

**Fix:**
- Current title: "[title]"
- Suggested title: "[new title]"
- Current meta: "[meta]"
- Suggested meta: "[new meta]"

**Estimated Impact:** +X clicks/month
**Effort:** 15 minutes

---

#### 2. [Title] - Needs Content Refresh

**Current Performance:**
- Published: [date]
- Last updated: [date]
- Sessions: X (down X% YoY)

**Problem:** Content is stale, competitors have newer info.

**Fix:**
- Update statistics and data
- Add section about [new topic]
- Refresh examples
- Update publish date

**Estimated Impact:** +X sessions/month
**Effort:** 2 hours

---

### ❌ Underperformers

These need significant work or removal.

| Content | Sessions | Issue | Recommendation |
|---------|----------|-------|----------------|
| [Title](/url/) | X | No traffic | Merge with [other] |
| [Title](/url/) | X | High bounce | Rewrite intro |
| [Title](/url/) | X | Off-topic | Redirect |

#### Merge Candidates
These thin/similar pieces should be combined:

| Merge These | Into | Combined Potential |
|-------------|------|-------------------|
| [Post A] + [Post B] | [New comprehensive post] | X sessions |

#### Redirect Candidates
These should 301 redirect to better content:

| Remove | Redirect To | Reason |
|--------|-------------|--------|
| /[old-url]/ | /[better-url]/ | [reason] |

---

### 📝 Content Gaps

Based on GSC data, you're getting impressions for topics without dedicated content:

| Query | Impressions | Current Page | Recommendation |
|-------|-------------|--------------|----------------|
| [query] | X | /[wrong-page]/ | Create dedicated page |
| [query] | X | None | Create new content |

#### Suggested New Content

1. **"[Topic]"**
   - Search volume indicator: X impressions
   - Competition: [Low/Medium/High]
   - Suggested URL: /[slug]/
   - Estimated effort: X hours
   - Potential: +X sessions/month

---

### 📈 Content Strategy Recommendations

#### This Month
1. **Update [Post]** - Est: 2h - Impact: +X sessions
2. **Optimize titles for [Posts]** - Est: 1h - Impact: +X clicks
3. **Merge [Posts]** - Est: 1h - Impact: Cleanup + X sessions

#### Next Month
4. **Create [New Topic]** - Est: 4h - Impact: +X sessions
5. **Expand [Post]** - Est: 2h - Impact: +X sessions

#### Ongoing
- Update top performers quarterly
- Publish X new posts per month on [successful topics]
- Internal link from every new post to top performers

---

### 🎯 30-Day Goals

| Goal | Target | Current | Action |
|------|--------|---------|--------|
| Blog traffic | +20% | X sessions | Update top 3 posts |
| Avg. bounce rate | <60% | X% | Improve intros |
| New content | 2 posts | 0 | [Topics] |
| Content refreshes | 5 posts | 0 | [Posts] |

---

### 📋 Add to Tracker?

Create issues for:
- [ ] Content updates (X items)
- [ ] New content to create (X items)
- [ ] Redirects to set up (X items)
- [ ] Merges to perform (X items)

**Options:**
- **"Add all"** - Create all issues
- **"Add updates only"** - Just update tasks
- **"No"** - Keep report only
```

---

## Step 7: Implementation Support

If user wants to act immediately:

```markdown
## Quick Actions Available

1. **"Update [title]"** - Start content refresh
2. **"Optimize titles"** - Batch update meta tags
3. **"Create [topic]"** - Start new content
4. **"Set up redirects"** - Configure 301s
5. **"Add to tracker"** - Create issues

What would you like to do?
```
