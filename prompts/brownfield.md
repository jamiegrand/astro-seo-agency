# Brownfield Analysis

This prompt analyzes an existing Astro project and integrates the SEO Agency workflow.

---

## Step 1: Project Discovery

### Scan Project Structure
```bash
# Get directory structure
find . -type f -name "*.astro" -o -name "*.ts" -o -name "*.js" -o -name "*.md" | head -100

# Check package.json
cat package.json
```

### Identify Key Elements
```markdown
## Project Analysis: [Project Name]

### Framework Details
| Item | Value |
|------|-------|
| Astro Version | [from package.json] |
| Tailwind Version | [from package.json] |
| Other Frameworks | [list] |

### Directory Structure
```
[tree output]
```

### Key Files Found
- [ ] astro.config.mjs
- [ ] tailwind.config.js
- [ ] src/data/*.js (data files)
- [ ] src/content/ (content collections)
- [ ] src/components/ (components)
- [ ] src/pages/ (pages)
- [ ] src/layouts/ (layouts)
```

---

## Step 2: Architecture Analysis

### Data Layer Discovery
```markdown
### Data Files Found

| File | Type | Items | Schema |
|------|------|-------|--------|
| products.js | Array | X | {name, slug, ...} |
| services.js | Array | X | {title, ...} |
| locations.js | Array | X | {city, ...} |
```

### Component Inventory
```markdown
### Components Found

| Component | Props | Used In |
|-----------|-------|---------|
| ProductCard.astro | {product} | products/[slug] |
| ServiceCard.astro | {service} | services/[slug] |
```

### Page Routes
```markdown
### Routes Discovered

| Route | Type | Data Source |
|-------|------|-------------|
| / | Static | - |
| /products/[slug] | Dynamic | products.js |
| /blog/[slug] | Dynamic | content/blog |
```

---

## Step 3: Existing Documentation Check

### Check for AI-INFO.md
```markdown
[If exists:]
✅ AI-INFO.md found
- Last updated: [date from file]
- Sections: [list sections]
- Completeness: [assessment]

**Recommendation:** Review and update if needed.

[If not exists:]
❌ AI-INFO.md not found

**Recommendation:** Generate comprehensive AI-INFO.md
```

### Check for CLAUDE.md
```markdown
[If exists:]
✅ CLAUDE.md found
- Content: [summary]

**Recommendation:** Merge with new template or replace.

[If not exists:]
❌ CLAUDE.md not found

**Recommendation:** Generate from template.
```

### Check for Issue Tracker
```markdown
[If AUDIT_TRACKER.md exists:]
✅ Issue tracker found
- Total issues: X
- Complete: X
- Remaining: X

[If not exists:]
❌ No issue tracker found

**Recommendation:** Create or use GitHub Issues.
```

---

## Step 4: SEO Assessment

### Meta Tags Audit
```markdown
### Meta Tag Analysis

Scanned [X] pages:

| Issue | Count | Examples |
|-------|-------|----------|
| Missing title | X | [pages] |
| Missing description | X | [pages] |
| Missing OG tags | X | [pages] |
| Title too long | X | [pages] |
```

### Schema Markup Check
```markdown
### Schema Markup

| Schema Type | Found | Valid | Location |
|-------------|-------|-------|----------|
| LocalBusiness | ✅/❌ | ✅/❌ | Layout.astro |
| Product | ✅/❌ | ✅/❌ | [file] |
| BreadcrumbList | ✅/❌ | ✅/❌ | [file] |
```

### Content Analysis
```markdown
### Content Inventory

| Type | Count | With Slug | With Meta |
|------|-------|-----------|-----------|
| Products | X | X | X |
| Services | X | X | X |
| Blog Posts | X | X | X |
| Locations | X | X | X |
```

---

## Step 5: Technical Assessment

### Build Health
```bash
npm run build
```

```markdown
### Build Status
- Status: ✅ Passing / ❌ Failing
- Errors: [if any]
- Warnings: [count]
- Build time: [X]s
- Output size: [X] MB
```

### TypeScript Status
```bash
npm run astro check
```

```markdown
### TypeScript Status
- Status: ✅ Clean / ⚠️ Warnings / ❌ Errors
- Issues: [list if any]
```

---

## Step 6: Generate Integration Plan

```markdown
## 🔧 Integration Plan

Based on analysis, here's how to integrate the SEO Agency workflow:

### Step 1: Create Configuration Files

**Create CLAUDE.md:**
- [ ] Generate from template
- [ ] Add project-specific context
- [ ] Configure MCP tools

**Create/Update AI-INFO.md:**
- [ ] Document data architecture
- [ ] Document component patterns
- [ ] Document styling conventions

### Step 2: Set Up Issue Tracking

**Option A: GitHub Issues**
- [ ] Configure GitHub MCP
- [ ] Create initial issues from SEO audit
- [ ] Set up labels (priority, type, phase)

**Option B: Markdown Tracker**
- [ ] Create AUDIT_TRACKER.md
- [ ] Import existing issues
- [ ] Add SEO findings

### Step 3: Configure Analytics

**Google Analytics:**
- [ ] Add GA_PROPERTY_ID to .env
- [ ] Verify MCP connection

**Google Search Console:**
- [ ] Add GSC MCP server
- [ ] Configure credentials
- [ ] Verify connection

### Step 4: Create Planning Directory

```bash
mkdir -p .planning/archive
```

### Step 5: Initial SEO Fixes

Based on the SEO assessment, prioritize:
1. [Critical issue 1]
2. [Critical issue 2]
3. [High priority 1]

---

## 📋 Checklist

### Configuration
- [ ] CLAUDE.md created
- [ ] AI-INFO.md created/updated
- [ ] .planning/ directory created
- [ ] .env configured

### MCP Servers
- [ ] Google Analytics connected
- [ ] Google Search Console connected
- [ ] GitHub connected (optional)

### Issue Tracking
- [ ] Tracker created/configured
- [ ] Initial issues added
- [ ] Priorities assigned

### Verification
- [ ] `/start` command works
- [ ] Analytics data accessible
- [ ] Build passes

---

Would you like me to:
1. **"Generate all"** - Create all configuration files
2. **"Fix SEO issues"** - Start fixing critical SEO issues
3. **"Show detail"** - Deep dive into specific area
```

---

## Step 7: Execute Integration

On confirmation, create:

1. **CLAUDE.md** - Populated from template with discovered values
2. **AI-INFO.md** - If not exists, generate comprehensive version
3. **.planning/** directory
4. **AUDIT_TRACKER.md** - If using markdown tracking
5. **.env.example** - With required variables

---

## Output

```markdown
## ✅ Integration Complete

### Files Created
| File | Status |
|------|--------|
| CLAUDE.md | ✅ Created |
| AI-INFO.md | ✅ Created/Updated |
| .planning/ | ✅ Created |
| AUDIT_TRACKER.md | ✅ Created |

### Next Steps
1. Add credentials to `.env`:
   ```
   GA_PROPERTY_ID=your-id
   GSC_SITE_URL=https://your-site.com/
   ```

2. Test the setup:
   ```
   /start
   ```

3. Begin work:
   ```
   /fix-next
   ```

Welcome to the Astro SEO Agency workflow! 🚀
```
