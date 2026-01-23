#!/bin/bash

# Astro SEO Agency - Installation Script
# Usage: curl -fsSL https://raw.githubusercontent.com/jamiegrand/astro-seo-agency/main/install.sh | bash

set -euo pipefail

# Error handler
error_exit() {
    echo -e "\n${RED}ERROR:${NC} $1" >&2
    exit 1
}

# Trap for cleanup on error
cleanup() {
    if [ $? -ne 0 ]; then
        echo -e "\n${RED}Installation failed. Check errors above.${NC}"
    fi
}
trap cleanup EXIT

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Version - read from plugin.json if available, fallback to hardcoded
if [ -f "plugin.json" ]; then
    VERSION=$(grep -o '"version": *"[^"]*"' plugin.json | head -1 | cut -d'"' -f4)
fi
VERSION="${VERSION:-3.0.0}"

# Print banner
echo ""
echo -e "${CYAN}╔═══════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${NC}  ${BOLD}ASTRO SEO AGENCY${NC} v${VERSION} - Installation                        ${CYAN}║${NC}"
echo -e "${CYAN}╚═══════════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Check if we're in a valid project directory
check_project() {
    if [ ! -f "package.json" ]; then
        echo -e "${RED}Error:${NC} No package.json found."
        echo "Please run this script from your Astro project root."
        exit 1
    fi
    
    # Check if it's likely an Astro project
    if ! grep -q "astro" package.json 2>/dev/null; then
        echo -e "${YELLOW}Warning:${NC} This doesn't appear to be an Astro project."
        read -p "Continue anyway? (y/N) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi
}

# Detect script location (for local installs)
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
REPO_URL="https://raw.githubusercontent.com/jamiegrand/astro-seo-agency/main"

# Determine if running locally or from curl
if [ -d "$SCRIPT_DIR/commands" ]; then
    SOURCE="local"
    echo -e "${BLUE}Installing from local files...${NC}"
else
    SOURCE="remote"
    echo -e "${BLUE}Installing from GitHub...${NC}"
fi

# Track installation success
INSTALL_ERRORS=0
COMMANDS_INSTALLED=0

# Create directories
create_directories() {
    echo -e "\n${BOLD}Creating directories...${NC}"
    
    mkdir -p .claude/commands
    echo -e "  ${GREEN}✓${NC} .claude/commands/"
    
    mkdir -p .planning/archive
    echo -e "  ${GREEN}✓${NC} .planning/archive/"
    
    mkdir -p credentials
    echo -e "  ${GREEN}✓${NC} credentials/"
}

# Download or copy a file
install_file() {
    local src=$1
    local dest=$2
    local desc=$3
    
    if [ "$SOURCE" = "local" ]; then
        if [ -f "$SCRIPT_DIR/$src" ]; then
            cp "$SCRIPT_DIR/$src" "$dest"
            echo -e "  ${GREEN}✓${NC} $desc"
            return 0
        else
            echo -e "  ${YELLOW}⚠${NC} $desc (not found in source)"
            return 1
        fi
    else
        if curl -fsSL "$REPO_URL/$src" -o "$dest" 2>/dev/null; then
            # Verify file was actually downloaded (not empty or error page)
            if [ -s "$dest" ] && head -1 "$dest" | grep -q -v "404"; then
                echo -e "  ${GREEN}✓${NC} $desc"
                return 0
            else
                rm -f "$dest"
                echo -e "  ${RED}✗${NC} $desc (invalid content)"
                return 1
            fi
        else
            echo -e "  ${RED}✗${NC} $desc (download failed)"
            return 1
        fi
    fi
}

# Install command files
install_commands() {
    echo -e "\n${BOLD}Installing commands...${NC}"

    local commands=(
        # Routers
        "seo"
        "audit"
        "fix"
        "setup"
        "feature"

        # Standalone
        "start"
        "status"
        "pause"
        "resume"
        "astro-check"
        "help"

        # SEO implementations
        "seo-wins"
        "seo-gaps"
        "seo-roi"
        "seo-refresh"
        "seo-history"
        "seo-impact"
        "seo-keywords"

        # Audit implementations
        "audit-content"
        "audit-quick"
        "audit-batch"
        "audit-eeat"

        # Fix implementations
        "fix-next"
        "fix-batch"

        # Setup implementations
        "setup-existing"
        "setup-verify"
        "setup-commands"
        "setup-index"

        # Feature implementations
        "feature-deploy"

        # Backwards-compatible aliases
        "content-gap"
        "content-roi"
        "content-refresh"
        "content-history"
        "impact"
        "keyword-cache"
        "content-audit"
        "content-audit-quick"
        "content-audit-batch"
        "content-eeat"
        "brownfield"
        "verify"
        "generate-commands"
        "index"
        "deploy-check"
    )

    for cmd in "${commands[@]}"; do
        if install_file "commands/${cmd}.md" ".claude/commands/${cmd}.md" "/${cmd}"; then
            ((COMMANDS_INSTALLED++))
        else
            ((INSTALL_ERRORS++))
        fi
    done

    echo -e "\n  Commands installed: ${COMMANDS_INSTALLED}/${#commands[@]}"

    if [ $INSTALL_ERRORS -gt 0 ]; then
        echo -e "  ${YELLOW}⚠${NC} Some commands failed to install"
    fi
}

# Install prompt files (interactive wizards)
# NOTE: Prompts are now integrated into commands as routers
# The setup wizard is now commands/setup.md
# Brownfield is now commands/setup-existing.md
# Verify is now commands/setup-verify.md
install_prompts() {
    echo -e "\n${BOLD}Prompts integrated into commands...${NC}"
    echo -e "  ${GREEN}✓${NC} /setup (router with setup wizard)"
    echo -e "  ${GREEN}✓${NC} /setup existing (was /brownfield)"
    echo -e "  ${GREEN}✓${NC} /setup verify (was /verify)"
}

# Install MCP configuration for Astro Docs server
install_mcp_config() {
    echo -e "\n${BOLD}Configuring MCP servers...${NC}"

    local mcp_config='{
  "mcpServers": {
    "astro-docs": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "https://mcp.docs.astro.build/mcp"]
    }
  }
}'

    if [ -f ".mcp.json" ]; then
        # Check if astro-docs is already configured
        if grep -q "astro-docs" .mcp.json 2>/dev/null; then
            echo -e "  ${GREEN}✓${NC} Astro Docs MCP already configured"
        else
            # Backup existing and merge
            echo -e "  ${YELLOW}⚠${NC} Existing .mcp.json found"
            echo -e "    Adding astro-docs server to existing config..."

            # Create backup
            cp .mcp.json .mcp.json.backup

            # Use node to merge JSON if available, otherwise inform user
            if command -v node &> /dev/null; then
                node -e "
                    const fs = require('fs');
                    const existing = JSON.parse(fs.readFileSync('.mcp.json', 'utf8'));
                    existing.mcpServers = existing.mcpServers || {};
                    existing.mcpServers['astro-docs'] = {
                        command: 'npx',
                        args: ['-y', 'mcp-remote', 'https://mcp.docs.astro.build/mcp']
                    };
                    fs.writeFileSync('.mcp.json', JSON.stringify(existing, null, 2) + '\n');
                " 2>/dev/null && echo -e "  ${GREEN}✓${NC} Merged astro-docs into .mcp.json" || {
                    echo -e "  ${YELLOW}⚠${NC} Could not auto-merge. Please add manually:"
                    echo -e "    ${CYAN}astro-docs: npx -y mcp-remote https://mcp.docs.astro.build/mcp${NC}"
                }
            else
                echo -e "  ${YELLOW}⚠${NC} Please add astro-docs to your .mcp.json manually:"
                echo -e "    ${CYAN}\"astro-docs\": { \"command\": \"npx\", \"args\": [\"-y\", \"mcp-remote\", \"https://mcp.docs.astro.build/mcp\"] }${NC}"
            fi
        fi
    else
        # Create new .mcp.json
        echo "$mcp_config" > .mcp.json
        echo -e "  ${GREEN}✓${NC} Created .mcp.json with Astro Docs MCP"
    fi

    echo -e "\n  ${CYAN}ℹ${NC}  Astro Docs MCP provides real-time documentation access"
    echo -e "  ${CYAN}ℹ${NC}  Restart Claude Code after installation to activate"
}

# Create .env.example
create_env_example() {
    echo -e "\n${BOLD}Creating configuration files...${NC}"
    
    if [ ! -f ".env.example" ]; then
        cat > .env.example << 'ENVEOF'
# Astro SEO Agency - Configuration
# Copy this file to .env and fill in your values

# ============================================
# Google Analytics (Optional)
# ============================================
# Find this in GA4: Admin → Property Settings → Property ID
GA_PROPERTY_ID=

# ============================================
# Google Search Console (Optional)
# ============================================
# Your site URL exactly as it appears in GSC
GSC_SITE_URL=https://your-site.com/

# Path to your service account JSON key
# See README for setup instructions
GOOGLE_APPLICATION_CREDENTIALS=./credentials/gsc-service-account.json

# ============================================
# GitHub (Optional)
# ============================================
# Personal access token with 'repo' scope
GITHUB_TOKEN=

# Your repository in format: username/repo-name
GITHUB_REPO=

# ============================================
# Brave Search (Optional)
# ============================================
# For competitor research features
BRAVE_API_KEY=

# ============================================
# ScraperAPI (Optional)
# ============================================
# For competitor content analysis in content audits
# Get key at: https://www.scraperapi.com/
SCRAPERAPI_KEY=

# ============================================
# DataForSEO (Optional)
# ============================================
# For keyword research data (volume, difficulty, PAA)
# Get credentials at: https://dataforseo.com/
DATAFORSEO_USERNAME=
DATAFORSEO_PASSWORD=
ENVEOF
        echo -e "  ${GREEN}✓${NC} .env.example"
    else
        echo -e "  ${YELLOW}⚠${NC} .env.example (already exists, skipping)"
    fi
}

# Extract value from existing CLAUDE.md
extract_from_claude_md() {
    local file=$1
    local pattern=$2
    local default=$3
    
    if [ -f "$file" ]; then
        local value=$(grep -i "$pattern" "$file" | head -1 | sed 's/.*| *\([^|]*\) *|.*/\1/' | xargs)
        if [ -n "$value" ] && [ "$value" != "$pattern" ]; then
            echo "$value"
            return
        fi
    fi
    echo "$default"
}

# Extract project notes section from existing CLAUDE.md
extract_project_notes() {
    local file=$1
    
    if [ ! -f "$file" ]; then
        echo ""
        return
    fi
    
    # Try to extract content between "Project-Specific Notes" and the next major heading or end
    local in_notes=0
    local notes=""
    
    while IFS= read -r line; do
        if echo "$line" | grep -qi "project.specific\|project notes\|custom notes"; then
            in_notes=1
            continue
        fi
        
        if [ $in_notes -eq 1 ]; then
            # Stop at next major heading (# or ## at start) or end markers
            if echo "$line" | grep -q "^#\|^---$\|^\*Generated\|^\*Astro SEO"; then
                break
            fi
            notes="${notes}${line}"$'\n'
        fi
    done < "$file"
    
    # Trim whitespace
    echo "$notes" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//'
}

# Extract any custom sections from existing CLAUDE.md
extract_custom_sections() {
    local file=$1
    
    if [ ! -f "$file" ]; then
        echo ""
        return
    fi
    
    # Look for sections that aren't part of the standard template
    local standard_sections="Quick Start|Project Context|3-Layer|Architecture|Commands Reference|Quality Gates|MCP Tools|Operating Principles|Session Persistence|Common Tasks|Emergency Procedures|Project-Specific Notes"
    
    local in_custom=0
    local custom=""
    local current_section=""
    
    while IFS= read -r line; do
        # Detect section headers
        if echo "$line" | grep -q "^## "; then
            current_section=$(echo "$line" | sed 's/^## //')
            
            # Check if this is a standard section
            if echo "$current_section" | grep -qiE "$standard_sections"; then
                in_custom=0
            else
                in_custom=1
                custom="${custom}"$'\n'"${line}"
            fi
            continue
        fi
        
        if [ $in_custom -eq 1 ]; then
            custom="${custom}"$'\n'"${line}"
        fi
    done < "$file"
    
    echo "$custom"
}

# Smart merge for CLAUDE.md
create_claude_md() {
    # Detect project info from package.json
    PROJECT_NAME=$(grep -o '"name": *"[^"]*"' package.json | head -1 | cut -d'"' -f4)
    PROJECT_NAME=${PROJECT_NAME:-"My Astro Project"}
    
    ASTRO_VERSION=$(grep -o '"astro": *"[^"]*"' package.json | head -1 | cut -d'"' -f4)
    ASTRO_VERSION=${ASTRO_VERSION:-"5.x"}
    
    # Check for existing CLAUDE.md
    if [ -f "CLAUDE.md" ]; then
        echo -e "\n${BOLD}Found existing CLAUDE.md${NC}"
        
        # Check if running interactively (has a terminal)
        if [ -t 0 ]; then
            # Interactive mode - ask user
            echo ""
            echo -e "  Options:"
            echo -e "    ${CYAN}1${NC}) MERGE    - Add plugin features, keep your project context"
            echo -e "    ${CYAN}2${NC}) REPLACE  - Backup existing, create fresh (saves to CLAUDE.md.backup)"
            echo -e "    ${CYAN}3${NC}) SKIP     - Keep existing unchanged"
            echo ""
            read -p "  Choose option (1/2/3) [1]: " merge_choice
            merge_choice=${merge_choice:-1}
        else
            # Non-interactive (piped) - default to MERGE
            echo -e "  ${BLUE}Non-interactive mode detected, defaulting to MERGE${NC}"
            merge_choice=1
        fi
        
        case $merge_choice in
            1)
                echo -e "\n  ${BLUE}Merging...${NC}"
                
                # Extract existing values
                EXISTING_SITE_URL=$(extract_from_claude_md "CLAUDE.md" "Site URL" "")
                EXISTING_GA=$(extract_from_claude_md "CLAUDE.md" "GA Property" "")
                EXISTING_GSC=$(extract_from_claude_md "CLAUDE.md" "GSC Property" "")
                EXISTING_REPO=$(extract_from_claude_md "CLAUDE.md" "Repository" "")
                EXISTING_NOTES=$(extract_project_notes "CLAUDE.md")
                EXISTING_CUSTOM=$(extract_custom_sections "CLAUDE.md")
                
                # Create backup
                cp "CLAUDE.md" "CLAUDE.md.pre-merge"
                echo -e "  ${GREEN}✓${NC} Backup saved to CLAUDE.md.pre-merge"
                
                # Generate merged file
                generate_claude_md "$PROJECT_NAME" "$ASTRO_VERSION" "$EXISTING_SITE_URL" "$EXISTING_GA" "$EXISTING_GSC" "$EXISTING_REPO" "$EXISTING_NOTES" "$EXISTING_CUSTOM"
                echo -e "  ${GREEN}✓${NC} CLAUDE.md merged with plugin features"
                ;;
            2)
                echo -e "\n  ${BLUE}Replacing...${NC}"
                cp "CLAUDE.md" "CLAUDE.md.backup"
                echo -e "  ${GREEN}✓${NC} Backup saved to CLAUDE.md.backup"
                
                generate_claude_md "$PROJECT_NAME" "$ASTRO_VERSION" "" "" "" "" "" ""
                echo -e "  ${GREEN}✓${NC} CLAUDE.md created fresh"
                ;;
            3)
                echo -e "  ${YELLOW}⚠${NC} CLAUDE.md unchanged"
                return
                ;;
            *)
                echo -e "  ${YELLOW}⚠${NC} Invalid choice, skipping CLAUDE.md"
                return
                ;;
        esac
    else
        echo -e "\n${BOLD}Creating CLAUDE.md...${NC}"
        generate_claude_md "$PROJECT_NAME" "$ASTRO_VERSION" "" "" "" "" "" ""
        echo -e "  ${GREEN}✓${NC} CLAUDE.md created"
    fi
}

# Generate CLAUDE.md content
generate_claude_md() {
    local project_name=$1
    local astro_version=$2
    local site_url=$3
    local ga_property=$4
    local gsc_property=$5
    local repo=$6
    local project_notes=$7
    local custom_sections=$8
    
    # Set placeholders for empty values
    site_url=${site_url:-"<!-- Add your site URL -->"}
    ga_property=${ga_property:-"<!-- Add if configured -->"}
    gsc_property=${gsc_property:-"<!-- Add if configured -->"}
    repo=${repo:-"<!-- Add if using GitHub -->"}
    
    cat > CLAUDE.md << CLAUDEEOF
# ${project_name} - Claude Code Instructions

> Astro SEO Agency Plugin v${VERSION}
> Last updated: $(date +%Y-%m-%d)

---

## Quick Start

\`\`\`bash
/start              # Begin session with data-driven priorities
/fix-next           # Fix highest-impact issue
/feature "desc"     # Build new feature
/pause              # Save and exit
/resume             # Continue tomorrow
\`\`\`

---

## Project Context

| Field | Value |
|-------|-------|
| **Framework** | Astro ${astro_version} |
| **Site URL** | ${site_url} |
| **GA Property** | ${ga_property} |
| **GSC Property** | ${gsc_property} |
| **Repository** | ${repo} |

---

## The 3-Layer Architecture

This project follows a strict separation of concerns:

\`\`\`
┌─────────────────────────────────────────────────────────────────┐
│  LAYER 1: DATA (What to display)                                │
│  └── src/data/*.js, src/content/**/*.md                         │
│      Products, services, locations, blog posts, FAQs            │
│      → CHANGE THIS for content updates                          │
├─────────────────────────────────────────────────────────────────┤
│  LAYER 2: COMPONENTS (How to display)                           │
│  └── src/components/*.astro, src/layouts/*.astro                │
│      Reusable UI, page templates                                │
│      → CHANGE THIS only for new features or fixes               │
├─────────────────────────────────────────────────────────────────┤
│  LAYER 3: STYLES (Visual presentation)                          │
│  └── src/styles/global.css, Tailwind utilities                  │
│      Colors, typography, spacing                                │
│      → CHANGE THIS for design updates                           │
└─────────────────────────────────────────────────────────────────┘
\`\`\`

**Golden Rule:** Prefer data changes over code changes. Most updates should modify Layer 1, not Layer 2.

---

## Commands Reference

### Session Management
| Command | Description |
|---------|-------------|
| \`/start\` | Begin session with data-driven priorities |
| \`/status\` | Show current project and session status |
| \`/pause\` | Save session state for later |
| \`/resume\` | Continue from saved session |

### Issue Resolution
| Command | Description |
|---------|-------------|
| \`/fix-next\` | Auto-select and fix highest priority issue |
| \`/audit [type]\` | Run audit (seo / a11y / perf / full) |

### SEO & Analytics
| Command | Description |
|---------|-------------|
| \`/seo-wins\` | Find GSC quick wins (position 4-15) |
| \`/content-roi\` | Analyze content performance |
| \`/impact [#]\` | Measure before/after effect of changes |

### Feature Development
| Command | Description |
|---------|-------------|
| \`/feature "desc"\` | Plan and build new feature (GSD-style) |
| \`/deploy-check\` | Pre-deployment verification |

### Help
| Command | Description |
|---------|-------------|
| \`/help\` | Show all commands and usage |

---

## Quality Gates

Every change must pass:
- [ ] TypeScript compiles (\`npm run astro check\`)
- [ ] Build succeeds (\`npm run build\`)
- [ ] No console errors in dev

---

## Operating Principles

### 1. Read Before Writing
Never modify code without understanding existing patterns.

### 2. Data Over Code
Most changes should modify data files, not components.

### 3. Match Existing Patterns
Find similar code, copy its structure, only change what's necessary.

### 4. Atomic Commits
One logical change per commit. Perfect bisect. Surgical rollback.

---
CLAUDEEOF

    # Add custom sections if they exist
    if [ -n "$custom_sections" ]; then
        cat >> CLAUDE.md << CUSTOMEOF

## Custom Sections (Preserved from previous CLAUDE.md)
${custom_sections}

---
CUSTOMEOF
    fi

    # Add project notes section
    cat >> CLAUDE.md << NOTESEOF

## Project-Specific Notes

NOTESEOF

    if [ -n "$project_notes" ]; then
        echo "$project_notes" >> CLAUDE.md
    else
        cat >> CLAUDE.md << DEFAULTNOTES
<!-- Add notes about your specific project here -->
<!-- Examples: special patterns, gotchas, business context -->
<!-- This section is preserved during plugin updates -->
DEFAULTNOTES
    fi

    cat >> CLAUDE.md << FOOTEREOF

---

*Generated by Astro SEO Agency Plugin v${VERSION}*
*Full documentation: Run \`/help\` in Claude Code*
FOOTEREOF
}

# Initialize SQLite database for content audits
init_database() {
    echo -e "\n${BOLD}Initializing audit database...${NC}"

    # Check if sqlite3 is available
    if ! command -v sqlite3 &> /dev/null; then
        echo -e "  ${YELLOW}⚠${NC} sqlite3 not found - database will be created on first use"
        echo -e "    Install sqlite3 for better performance (brew install sqlite3)"
        return
    fi

    local DB_PATH=".planning/seo-audit.db"
    local NEEDS_INIT=true
    local NEEDS_MIGRATE=false

    # Check if database already exists
    if [ -f "$DB_PATH" ]; then
        NEEDS_INIT=false
        # Check schema version
        local CURRENT_VERSION=$(sqlite3 "$DB_PATH" "SELECT COALESCE(MAX(version), 0) FROM schema_version;" 2>/dev/null || echo "0")
        if [ "$CURRENT_VERSION" -lt 3 ]; then
            NEEDS_MIGRATE=true
            echo -e "  ${CYAN}ℹ${NC}  Existing database found (schema v${CURRENT_VERSION})"
        else
            echo -e "  ${GREEN}✓${NC} Database up to date (schema v${CURRENT_VERSION})"
            return
        fi
    fi

    # Initialize or migrate database
    if [ "$NEEDS_INIT" = true ]; then
        # Fresh install - use init-db.sql
        if [ "$SOURCE" = "local" ] && [ -f "$SCRIPT_DIR/scripts/init-db.sql" ]; then
            sqlite3 "$DB_PATH" < "$SCRIPT_DIR/scripts/init-db.sql" 2>/dev/null
            echo -e "  ${GREEN}✓${NC} Database initialized (schema v3)"
        elif [ "$SOURCE" = "remote" ]; then
            if curl -fsSL "$REPO_URL/scripts/init-db.sql" -o "/tmp/init-db.sql" 2>/dev/null; then
                sqlite3 "$DB_PATH" < /tmp/init-db.sql 2>/dev/null
                rm -f /tmp/init-db.sql
                echo -e "  ${GREEN}✓${NC} Database initialized (schema v3)"
            else
                echo -e "  ${YELLOW}⚠${NC} Could not download database schema - will create on first use"
            fi
        else
            echo -e "  ${YELLOW}⚠${NC} Database schema not found - will create on first use"
        fi
    elif [ "$NEEDS_MIGRATE" = true ]; then
        # Existing install - run migration
        echo -e "  ${BLUE}Migrating database to v3...${NC}"
        if [ "$SOURCE" = "local" ] && [ -f "$SCRIPT_DIR/scripts/migrate-v3.sql" ]; then
            sqlite3 "$DB_PATH" < "$SCRIPT_DIR/scripts/migrate-v3.sql" 2>/dev/null
            echo -e "  ${GREEN}✓${NC} Database migrated to v3"
        elif [ "$SOURCE" = "remote" ]; then
            if curl -fsSL "$REPO_URL/scripts/migrate-v3.sql" -o "/tmp/migrate-v3.sql" 2>/dev/null; then
                sqlite3 "$DB_PATH" < /tmp/migrate-v3.sql 2>/dev/null
                rm -f /tmp/migrate-v3.sql
                echo -e "  ${GREEN}✓${NC} Database migrated to v3"
            else
                echo -e "  ${YELLOW}⚠${NC} Could not download migration script"
                echo -e "    Run '/index reset' after installation to create tables"
            fi
        fi
    fi

    # Verify tables exist
    local TABLE_COUNT=$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM sqlite_master WHERE type='table';" 2>/dev/null || echo "0")
    echo -e "  ${CYAN}ℹ${NC}  Database contains ${TABLE_COUNT} tables"
}

# Update .gitignore
update_gitignore() {
    echo -e "\n${BOLD}Updating .gitignore...${NC}"
    
    if [ -f ".gitignore" ]; then
        # Check if our section already exists
        if grep -q "# Astro SEO Agency" .gitignore 2>/dev/null; then
            echo -e "  ${YELLOW}⚠${NC} .gitignore (already configured)"
            return
        fi
    fi
    
    cat >> .gitignore << 'GITIGNOREEOF'

# Astro SEO Agency
credentials/
.env
.env.local
.planning/HANDOFF.md
.planning/SESSION.md
.planning/seo-audit.db
*.pre-merge
GITIGNOREEOF
    
    echo -e "  ${GREEN}✓${NC} .gitignore updated"
}

# Verify installation
verify_installation() {
    echo -e "\n${BOLD}Verifying installation...${NC}"
    
    local errors=0
    
    # Check commands directory - verify actual command files exist and have content
    if [ -d ".claude/commands" ]; then
        local valid_commands=0
        for cmd_file in .claude/commands/*.md; do
            if [ -f "$cmd_file" ] && [ -s "$cmd_file" ]; then
                # Check if file has actual markdown content (not an error page)
                if head -5 "$cmd_file" | grep -q -E "^---|^#|description:"; then
                    ((valid_commands++))
                fi
            fi
        done
        
        if [ $valid_commands -gt 0 ]; then
            echo -e "  ${GREEN}✓${NC} Commands installed: ${valid_commands} valid files"
        else
            echo -e "  ${RED}✗${NC} No valid command files found"
            ((errors++))
        fi
    else
        echo -e "  ${RED}✗${NC} Commands directory missing"
        ((errors++))
    fi
    
    # Check planning directory
    if [ -d ".planning" ]; then
        echo -e "  ${GREEN}✓${NC} Planning directory created"
    else
        echo -e "  ${RED}✗${NC} Planning directory missing"
        ((errors++))
    fi
    
    # Check CLAUDE.md
    if [ -f "CLAUDE.md" ]; then
        echo -e "  ${GREEN}✓${NC} CLAUDE.md exists"
    else
        echo -e "  ${YELLOW}⚠${NC} CLAUDE.md not created"
    fi
    
    return $errors
}

# Print completion message
print_completion() {
    local has_errors=$1
    
    echo ""
    
    if [ "$has_errors" -gt 0 ]; then
        echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "${YELLOW}⚠️  Installation completed with warnings${NC}"
        echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo ""
        echo -e "Some commands may not have installed correctly."
        echo -e "You can try:"
        echo -e "  1. Run the installer again"
        echo -e "  2. Manually download commands from GitHub"
        echo -e "  3. Check your internet connection"
        echo ""
    else
        echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "${GREEN}✅ Installation complete!${NC}"
        echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    fi
    
    echo ""
    echo -e "${BOLD}Next steps:${NC}"
    echo ""
    echo -e "  1. ${CYAN}Open your project in Claude Code${NC}"
    echo ""
    echo -e "  2. ${CYAN}(Optional) Configure analytics:${NC}"
    echo -e "     ${GREEN}cp .env.example .env${NC}"
    echo -e "     Then edit .env with your credentials"
    echo ""
    echo -e "  3. ${CYAN}Start working:${NC}"
    echo -e "     ${GREEN}/start${NC}"
    echo ""
    echo -e "${BOLD}Quick command reference:${NC}"
    echo ""
    echo -e "  ${GREEN}/start${NC}            Begin session with priorities"
    echo -e "  ${GREEN}/fix${NC}              Fix issues (or /fix 5 for batch)"
    echo -e "  ${GREEN}/seo${NC}              SEO tools (wins, gaps, roi, refresh)"
    echo -e "  ${GREEN}/audit${NC}            Site + content audits"
    echo -e "  ${GREEN}/feature${NC}          Build features or deploy checks"
    echo -e "  ${GREEN}/setup${NC}            Configuration tools"
    echo -e "  ${GREEN}/help${NC}             Show all commands"
    echo ""
    echo -e "${BOLD}Router commands show subcommands:${NC}"
    echo ""
    echo -e "  ${GREEN}/seo wins${NC}         Find ranking opportunities"
    echo -e "  ${GREEN}/audit content${NC}    Full SEO content audit (0-100)"
    echo -e "  ${GREEN}/setup verify${NC}     Check installation"
    echo ""
}

# Main installation flow
main() {
    echo -e "${BOLD}Checking project...${NC}"
    check_project
    echo -e "  ${GREEN}✓${NC} Valid project found"
    
    create_directories
    install_commands
    install_prompts
    install_mcp_config
    init_database
    create_env_example
    create_claude_md
    update_gitignore
    
    verify_installation
    local verify_result=$?
    
    # Calculate total errors
    local total_errors=$((INSTALL_ERRORS + verify_result))
    
    print_completion $total_errors
}

# Run main
main "$@"
