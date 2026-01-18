#!/bin/bash

# Astro SEO Agency - Post-Install Script
# Runs after plugin installation

echo ""
echo "╔═══════════════════════════════════════════════════════════════════╗"
echo "║  ASTRO SEO AGENCY - Installation Complete                         ║"
echo "╚═══════════════════════════════════════════════════════════════════╝"
echo ""

PROJECT_ROOT=$(pwd)

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}Project:${NC} $PROJECT_ROOT"
echo ""

# Check for existing setup
echo "Checking existing configuration..."

if [ -f "$PROJECT_ROOT/CLAUDE.md" ]; then
    echo -e "${YELLOW}⚠️  CLAUDE.md found${NC} - Will offer to merge during setup"
fi

if [ -f "$PROJECT_ROOT/AI-INFO.md" ]; then
    echo -e "${YELLOW}⚠️  AI-INFO.md found${NC} - Will preserve during setup"
fi

if [ -d "$PROJECT_ROOT/.claude/commands" ]; then
    echo -e "${YELLOW}⚠️  Existing commands found${NC} - New commands will be added"
fi

# Create directories
echo ""
echo "Creating directory structure..."

mkdir -p "$PROJECT_ROOT/.claude/commands" 2>/dev/null
mkdir -p "$PROJECT_ROOT/.planning/archive" 2>/dev/null
mkdir -p "$PROJECT_ROOT/AI" 2>/dev/null

echo -e "${GREEN}✓${NC} .claude/commands/"
echo -e "${GREEN}✓${NC} .planning/archive/"
echo -e "${GREEN}✓${NC} AI/"

# Create .env.example if not exists
if [ ! -f "$PROJECT_ROOT/.env.example" ]; then
    cat > "$PROJECT_ROOT/.env.example" << 'EOF'
# Astro SEO Agency Configuration

# Google Analytics (Required for /start, /content-roi)
GA_PROPERTY_ID=

# Google Search Console (Required for /seo-wins, /impact)
GSC_SITE_URL=https://your-site.com/
GOOGLE_APPLICATION_CREDENTIALS=./credentials/gsc-service-account.json

# GitHub (Optional - for issue management)
GITHUB_TOKEN=
GITHUB_REPO=username/repo-name

# Brave Search (Optional - for competitor research)
BRAVE_API_KEY=
EOF
    echo -e "${GREEN}✓${NC} Created .env.example"
fi

# Add to .gitignore if exists
if [ -f "$PROJECT_ROOT/.gitignore" ]; then
    if ! grep -q "credentials/" "$PROJECT_ROOT/.gitignore"; then
        echo "" >> "$PROJECT_ROOT/.gitignore"
        echo "# Astro SEO Agency" >> "$PROJECT_ROOT/.gitignore"
        echo "credentials/" >> "$PROJECT_ROOT/.gitignore"
        echo ".planning/HANDOFF.md" >> "$PROJECT_ROOT/.gitignore"
        echo -e "${GREEN}✓${NC} Updated .gitignore"
    fi
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${GREEN}✅ Plugin installed successfully!${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Next steps:"
echo ""
echo -e "1. Run the setup wizard:"
echo -e "   ${GREEN}/setup${NC}"
echo ""
echo -e "2. Or for existing projects:"
echo -e "   ${GREEN}/brownfield${NC}"
echo ""
echo -e "3. Configure credentials in .env"
echo ""
echo -e "4. Start working:"
echo -e "   ${GREEN}/start${NC}"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Available commands after setup:"
echo ""
echo "  /start        - Begin session with priorities"
echo "  /fix-next     - Fix highest-impact issue"
echo "  /seo-wins     - Find GSC quick wins"
echo "  /content-roi  - Analyze content performance"
echo "  /feature      - Build new features (GSD-style)"
echo "  /pause        - Save progress"
echo "  /resume       - Continue later"
echo "  /help         - Show all commands"
echo ""
