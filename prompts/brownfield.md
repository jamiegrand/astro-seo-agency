---
description: Analyze and integrate with an existing Astro project
---

# Brownfield Analysis

This prompt analyzes an existing Astro project and integrates the SEO Agency workflow with full Astro MCP support.

---

## Step 1: Project Discovery

### Scan Project Structure
```bash
# Get directory structure
find . -type f -name "*.astro" -o -name "*.ts" -o -name "*.js" -o -name "*.md" | head -100

# Check package.json
cat package.json
```

### Check for astro-mcp

```bash
# Check if astro-mcp is installed
grep -q "astro-mcp" package.json && echo "✅ astro-mcp installed" || echo "❌ astro-mcp not installed"
```

### Identify Key Elements
```markdown
## Project Analysis: [Project Name]

### Framework Details
| Item | Value |
|------|-------|
| Astro Version | [from package.json] |
| Tailwind Version | [from package.json] |
| TypeScript | [yes/no] |
| astro-mcp | [installed/not installed] |
| Other Integrations | [list] |

### Directory Structure
```
[tree output]
```

### Key Files Found
- [ ] astro.config.mjs
- [ ] tailwind.config.js
- [ ] src/content/config.ts (content collections)
- [ ] src/data/*.js (data files)
- [ ] src/content/ (content collections)
- [ ] src/components/ (components)
- [ ] src/pages/ (pages)
- [ ] src/layouts/ (layouts)
```

---

## Step 2: Query Project via astro-mcp (if available)

### If astro-mcp is installed and dev server running:

```markdown
### 🔌 Live Project Analysis (via astro-mcp)

#### Configuration (get-astro-config)
| Setting | Value |
|---------|-------|
| Output Mode | [static/server/hybrid] |
| Site URL | [url or not set] |
| Build Format | [file/directory] |
| Image Service | [sharp/squoosh] |
| TypeScript | [strict/relaxed] |

#### All Routes (list-astro-routes)
| Type | Count | Examples |
|------|-------|----------|
| Static Pages | X | /, /about, /contact |
| Dynamic Routes | X | /blog/[slug], /products/[id] |
| API Endpoints | X | /api/contact |
| **Total** | **X** | |

#### Integrations Detected
| Integration | Purpose |
|-------------|---------|
| [name] | [purpose] |
| [name] | [purpose] |
```

### If astro-mcp not available:

```markdown
### ℹ️ Manual Project Analysis

astro-mcp not detected. Analyzing from file system...

[Fallback to file-based analysis]

**Recommendation:** Install astro-mcp for better project awareness:
```bash
npx astro add astro-mcp
```
```

---

## Step 3: Architecture Analysis

### Data Layer Discovery

```markdown
### Data Files Found

| File | Type | Items | Schema |
|------|------|-------|--------|
| src/data/products.js | Array | X | {name, slug, ...} |
| src/data/services.js | Array | X | {title, ...} |
| src/data/locations.js | Array | X | {city, ...} |
```

### Content Collections (if using)

```markdown
### Content Collections

[If src/content/config.ts exists:]

| Collection | Location | Items | Schema Status |
|------------|----------|-------|---------------|
| blog | src/content/blog/ | X | ✅ Defined |
| docs | src/content/docs/ | X | ✅ Defined |

[Query Astro docs for content collection best practices]
**Current Astro Recommendation:** [from docs search]
```

### Component Inventory
```markdown
### Components Found

| Component | Props | Used In | Hydration |
|-----------|-------|---------|-----------|
| ProductCard.astro | {product} | products/[slug] | Server |
| ServiceCard.astro | {service} | services/[slug] | Server |
| ContactForm.tsx | {onSubmit} | contact | client:load |
```

### Page Routes

```markdown
### Routes Discovered

[From astro-mcp if available, otherwise from file scan]

| Route | Type | Source | Data Source |
|-------|------|--------|-------------|
| / | Static | src/pages/index.astro | - |
| /blog/[slug] | Dynamic | src/pages/blog/[slug].astro | content/blog |
| /products/[id] | Dynamic | src/pages/products/[id].astro | data/products.js |
```

---

## Step 4: Existing Documentation Check

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
- MCP configured: [yes/no]

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

## Step 5: SEO Assessment

### Meta Tags Audit

```markdown
### Meta Tag Analysis

[Using route list from astro-mcp or file scan]

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

[From astro-mcp route analysis + file scan]

| Type | Count | Location | With Meta |
|------|-------|----------|-----------|
| Blog Posts | X | src/content/blog/ | X |
| Products | X | src/data/products.js | X |
| Services | X | src/data/services.js | X |
| Static Pages | X | src/pages/ | X |
```

---

## Step 6: Astro Best Practices Check (NEW)

### Query Astro Docs

Search Astro docs for current best practices relevant to this project:

```markdown
### 🔍 Astro Best Practices Audit

[Search Astro docs for relevant topics based on project analysis]

#### Image Handling
**Project uses:** [current pattern]
**Astro docs recommend:** [from search]
**Status:** ✅ Following / ⚠️ Could improve

#### Content Collections
**Project uses:** [current pattern]
**Astro docs recommend:** [from search]
**Status:** ✅ Following / ⚠️ Could improve

#### Component Hydration
**Project uses:** [detected directives]
**Astro docs recommend:** [from search]
**Status:** ✅ Following / ⚠️ Could improve

#### Performance
**Current setup:** [from config]
**Astro docs recommend:** [from search]
**Status:** ✅ Following / ⚠️ Could improve

### Deprecated Patterns Found
[Search docs for deprecations]

| Pattern | Location | Current Recommendation |
|---------|----------|------------------------|
| [pattern] | [file] | [from docs] |
```

---

## Step 7: Technical Assessment

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
- Pages generated: [X]

[If failing, search Astro docs for error]
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

## Step 8: Generate Integration Plan

```markdown
## 🔧 Integration Plan

Based on analysis, here's how to integrate the SEO Agency workflow:

### Step 1: Install astro-mcp (Recommended)

[If not installed:]
```bash
npx astro add astro-mcp
```

This enables:
- Route awareness for all commands
- Content location discovery
- Configuration validation

### Step 2: Configure Astro Docs MCP (Recommended)

Add to your MCP configuration:
```json
{
  "mcpServers": {
    "astro-docs": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "https://mcp.docs.astro.build/mcp"]
    }
  }
}
```

This enables:
- Real-time documentation access
- Current best practices
- Error troubleshooting

### Step 3: Create Configuration Files

**Create CLAUDE.md:**
- [ ] Generate from template
- [ ] Add project-specific context
- [ ] Configure MCP references

**Create/Update AI-INFO.md:**
- [ ] Document data architecture
- [ ] Document component patterns
- [ ] Document content locations (from astro-mcp)

### Step 4: Set Up Issue Tracking

**Option A: GitHub Issues**
- [ ] Configure GitHub MCP
- [ ] Create initial issues from SEO audit
- [ ] Set up labels (priority, type, phase)

**Option B: Markdown Tracker**
- [ ] Create AUDIT_TRACKER.md
- [ ] Import existing issues
- [ ] Add SEO findings

### Step 5: Configure Analytics (Optional)

**Google Analytics:**
- [ ] Add GA_PROPERTY_ID to .env
- [ ] Verify MCP connection

**Google Search Console:**
- [ ] Add GSC MCP server
- [ ] Configure credentials
- [ ] Verify connection

### Step 6: Create Planning Directory

```bash
mkdir -p .planning/archive
```

### Step 7: Address Astro Best Practices

Based on the audit:
1. [Critical: pattern to update]
2. [High: pattern to update]
3. [Medium: pattern to update]

---

## 📋 Checklist

### Configuration
- [ ] astro-mcp installed
- [ ] Astro Docs MCP configured
- [ ] CLAUDE.md created
- [ ] AI-INFO.md created/updated
- [ ] .planning/ directory created
- [ ] .env configured

### MCP Servers
- [ ] Astro Docs MCP connected
- [ ] astro-mcp running (dev server)
- [ ] Google Analytics connected (optional)
- [ ] Google Search Console connected (optional)
- [ ] GitHub connected (optional)

### Issue Tracking
- [ ] Tracker created/configured
- [ ] Initial issues added
- [ ] Priorities assigned

### Astro Best Practices
- [ ] Deprecated patterns identified
- [ ] Improvement plan created
- [ ] Added to issue tracker

### Verification
- [ ] `/start` command works
- [ ] `/astro-check` shows project info
- [ ] Build passes

---

Would you like me to:
1. **"Generate all"** - Create all configuration files
2. **"Install astro-mcp"** - Add MCP integration to project
3. **"Fix Astro issues"** - Address deprecated patterns
4. **"Fix SEO issues"** - Start fixing critical SEO issues
5. **"Show detail"** - Deep dive into specific area
```

---

## Step 9: Execute Integration

On confirmation, create:

1. **CLAUDE.md** - Populated from template with discovered values + MCP config
2. **AI-INFO.md** - If not exists, generate comprehensive version with route info
3. **.planning/** directory
4. **AUDIT_TRACKER.md** - If using markdown tracking, include Astro issues
5. **.env.example** - With required variables
6. **.vscode/mcp.json** - If using VS Code

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
| .vscode/mcp.json | ✅ Created |

### MCP Status
| Server | Status |
|--------|--------|
| Astro Docs MCP | ✅ Configured |
| astro-mcp | ✅ Installed / ⏭️ Skipped |

### Project Insights Captured
- Routes: [X] total
- Content Collections: [X]
- Data Files: [X]
- Integrations: [X]

### Next Steps
1. Start dev server for full astro-mcp features:
   ```bash
   npm run dev
   ```

2. Add credentials to `.env`:
   ```
   GA_PROPERTY_ID=your-id
   GSC_SITE_URL=https://your-site.com/
   ```

3. Test the setup:
   ```bash
   /astro-check    # Verify MCP working
   /start          # Begin session
   ```

4. Begin work:
   ```bash
   /fix-next       # Fix highest priority
   ```

Welcome to the Astro SEO Agency workflow! 🚀

### MCP-Enhanced Features Now Available
- `/start` shows project health via astro-mcp
- `/fix-next` consults Astro docs automatically
- `/content-roi` knows where your content lives
- `/seo-wins` maps queries to source files
- `/audit astro` checks against current best practices
```

---

## MCP Usage in Brownfield Analysis

| Step | Astro Docs MCP | astro-mcp |
|------|----------------|-----------|
| Discovery | - | Routes, config, integrations |
| Architecture | Content collection patterns | Route-to-file mapping |
| Best Practices | Current recommendations | Current project state |
| SEO Audit | - | All routes for coverage |
| Integration | Setup guidance | Verify installation |
