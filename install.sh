#!/bin/bash

# Astro SEO Agency - Installation Script
# Usage: curl -fsSL https://raw.githubusercontent.com/yourusername/astro-seo-agency/main/install.sh | bash

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Print banner
echo ""
echo -e "${CYAN}╔═══════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${NC}  ${BOLD}ASTRO SEO AGENCY${NC} - Installation                                 ${CYAN}║${NC}"
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
REPO_URL="https://raw.githubusercontent.com/yourusername/astro-seo-agency/main"

# Determine if running locally or from curl
if [ -d "$SCRIPT_DIR/commands" ]; then
    SOURCE="local"
    echo -e "${BLUE}Installing from local files...${NC}"
else
    SOURCE="remote"
    echo -e "${BLUE}Installing from GitHub...${NC}"
fi

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
        else
            echo -e "  ${YELLOW}⚠${NC} $desc (not found in source)"
        fi
    else
        if curl -fsSL "$REPO_URL/$src" -o "$dest" 2>/dev/null; then
            echo -e "  ${GREEN}✓${NC} $desc"
        else
            echo -e "  ${YELLOW}⚠${NC} $desc (download failed)"
        fi
    fi
}

# Install command files
install_commands() {
    echo -e "\n${BOLD}Installing commands...${NC}"
    
    local commands=(
        "start"
        "fix-next"
        "seo-wins"
        "content-roi"
        "impact"
        "feature"
        "pause"
        "resume"
        "status"
        "audit"
        "deploy-check"
        "help"
    )
    
    for cmd in "${commands[@]}"; do
        install_file "commands/${cmd}.md" ".claude/commands/${cmd}.md" "/\$${cmd}"
    done
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
ENVEOF
        echo -e "  ${GREEN}✓${NC} .env.example"
    else
        echo -e "  ${YELLOW}⚠${NC} .env.example (already exists, skipping)"
    fi
}

# Create CLAUDE.md template
create_claude_md() {
    if [ ! -f "CLAUDE.md" ]; then
        # Detect project name from package.json
        PROJECT_NAME=$(grep -o '"name": *"[^"]*"' package.json | head -1 | cut -d'"' -f4)
        PROJECT_NAME=${PROJECT_NAME:-"My Astro Project"}
        
        # Detect Astro version
        ASTRO_VERSION=$(grep -o '"astro": *"[^"]*"' package.json | head -1 | cut -d'"' -f4)
        ASTRO_VERSION=${ASTRO_VERSION:-"5.x"}
        
        cat > CLAUDE.md << CLAUDEEOF
# ${PROJECT_NAME} - Claude Code Instructions

> Astro SEO Agency Plugin v2.0.0
> Generated: $(date +%Y-%m-%d)

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
| **Framework** | Astro ${ASTRO_VERSION} |
| **Site URL** | <!-- Add your site URL --> |
| **GA Property** | <!-- Add if configured --> |
| **GSC Property** | <!-- Add if configured --> |

---

## The 3-Layer Architecture

\`\`\`
┌─────────────────────────────────────────────────────────────────┐
│  LAYER 1: DATA (What to display)                                │
│  └── src/data/*.js, src/content/**/*.md                         │
│      → CHANGE THIS for content updates                          │
├─────────────────────────────────────────────────────────────────┤
│  LAYER 2: COMPONENTS (How to display)                           │
│  └── src/components/*.astro, src/layouts/*.astro                │
│      → CHANGE THIS only for new features or fixes               │
├─────────────────────────────────────────────────────────────────┤
│  LAYER 3: STYLES (Visual presentation)                          │
│  └── src/styles/global.css, Tailwind utilities                  │
│      → CHANGE THIS for design updates                           │
└─────────────────────────────────────────────────────────────────┘
\`\`\`

**Golden Rule:** Prefer data changes over code changes.

---

## Commands Reference

| Command | Description |
|---------|-------------|
| \`/start\` | Begin session with priorities |
| \`/fix-next\` | Fix highest-impact issue |
| \`/seo-wins\` | Find GSC quick wins |
| \`/content-roi\` | Analyze content performance |
| \`/impact [#]\` | Measure change effect |
| \`/feature "desc"\` | Build new feature |
| \`/audit [type]\` | Run site audit |
| \`/deploy-check\` | Pre-deploy verification |
| \`/pause\` | Save session |
| \`/resume\` | Continue session |
| \`/status\` | Show project status |
| \`/help\` | Show all commands |

---

## Quality Gates

Every change must pass:
- [ ] TypeScript compiles (\`npm run astro check\`)
- [ ] Build succeeds (\`npm run build\`)
- [ ] No console errors in dev

---

## Project-Specific Notes

<!-- Add notes about your specific project here -->
<!-- Examples: special patterns, gotchas, business context -->

---

*Generated by Astro SEO Agency Plugin*
*Run \`/setup\` in Claude Code to customize this file*
CLAUDEEOF
        echo -e "  ${GREEN}✓${NC} CLAUDE.md"
    else
        echo -e "  ${YELLOW}⚠${NC} CLAUDE.md (already exists, skipping)"
    fi
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
GITIGNOREEOF
    
    echo -e "  ${GREEN}✓${NC} .gitignore updated"
}

# Verify installation
verify_installation() {
    echo -e "\n${BOLD}Verifying installation...${NC}"
    
    local errors=0
    
    # Check commands directory
    if [ -d ".claude/commands" ] && [ "$(ls -A .claude/commands 2>/dev/null)" ]; then
        local cmd_count=$(ls -1 .claude/commands/*.md 2>/dev/null | wc -l)
        echo -e "  ${GREEN}✓${NC} Commands installed: ${cmd_count} files"
    else
        echo -e "  ${RED}✗${NC} Commands directory empty or missing"
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
        echo -e "  ${YELLOW}⚠${NC} CLAUDE.md not created (may already exist)"
    fi
    
    return $errors
}

# Print completion message
print_completion() {
    echo ""
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}✅ Installation complete!${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "${BOLD}Next steps:${NC}"
    echo ""
    echo -e "  1. ${CYAN}Open your project in Claude Code${NC}"
    echo ""
    echo -e "  2. ${CYAN}Run the setup wizard:${NC}"
    echo -e "     ${GREEN}/setup${NC}"
    echo ""
    echo -e "  3. ${CYAN}(Optional) Configure analytics:${NC}"
    echo -e "     ${GREEN}cp .env.example .env${NC}"
    echo -e "     Then edit .env with your credentials"
    echo ""
    echo -e "  4. ${CYAN}Start working:${NC}"
    echo -e "     ${GREEN}/start${NC}"
    echo ""
    echo -e "${BOLD}Quick command reference:${NC}"
    echo ""
    echo -e "  ${GREEN}/start${NC}        Begin session with priorities"
    echo -e "  ${GREEN}/fix-next${NC}     Fix highest-impact issue"
    echo -e "  ${GREEN}/seo-wins${NC}     Find ranking opportunities"
    echo -e "  ${GREEN}/feature${NC}      Build new features"
    echo -e "  ${GREEN}/pause${NC}        Save your progress"
    echo -e "  ${GREEN}/resume${NC}       Continue later"
    echo -e "  ${GREEN}/help${NC}         Show all commands"
    echo ""
}

# Main installation flow
main() {
    echo -e "${BOLD}Checking project...${NC}"
    check_project
    echo -e "  ${GREEN}✓${NC} Valid project found"
    
    create_directories
    install_commands
    create_env_example
    create_claude_md
    update_gitignore
    
    if verify_installation; then
        print_completion
    else
        echo ""
        echo -e "${YELLOW}Installation completed with warnings.${NC}"
        echo "Some files may not have been installed correctly."
        echo "Try running /setup in Claude Code to complete configuration."
    fi
}

# Run main
main "$@"
