#!/bin/bash

# ==============================================================================
# Astro SEO Agency - Database Setup & Maintenance
# ==============================================================================
#
# Usage:
#   ./scripts/setup-db.sh [command]
#
# Commands:
#   init      - Create database with all tables (default)
#   migrate   - Run pending migrations
#   reset     - Clear and reinitialize database
#   status    - Show database status
#   backup    - Create timestamped backup
#   index     - Run link indexer (requires Node.js)
#
# ==============================================================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Configuration
DB_PATH=".planning/seo-audit.db"
SCRIPTS_DIR="scripts"
BACKUP_DIR=".planning/backups"

# ==============================================================================
# Helper Functions
# ==============================================================================

log_info() {
    echo -e "${CYAN}ℹ${NC}  $1"
}

log_success() {
    echo -e "${GREEN}✓${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}⚠${NC}  $1"
}

log_error() {
    echo -e "${RED}✗${NC} $1"
}

check_sqlite() {
    if ! command -v sqlite3 &> /dev/null; then
        log_error "sqlite3 is required but not installed."
        echo "    Install with: brew install sqlite3 (macOS) or apt install sqlite3 (Linux)"
        exit 1
    fi
}

get_schema_version() {
    if [ ! -f "$DB_PATH" ]; then
        echo "0"
        return
    fi
    sqlite3 "$DB_PATH" "SELECT COALESCE(MAX(version), 0) FROM schema_version;" 2>/dev/null || echo "0"
}

# ==============================================================================
# Commands
# ==============================================================================

cmd_status() {
    echo -e "\n${BOLD}📊 Database Status${NC}\n"
    
    if [ ! -f "$DB_PATH" ]; then
        log_warning "Database does not exist: $DB_PATH"
        echo "    Run: ./scripts/setup-db.sh init"
        return
    fi
    
    local VERSION=$(get_schema_version)
    local SIZE=$(du -h "$DB_PATH" | cut -f1)
    local TABLES=$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM sqlite_master WHERE type='table';")
    
    echo "Location:       $DB_PATH"
    echo "Size:           $SIZE"
    echo "Schema Version: $VERSION"
    echo "Tables:         $TABLES"
    echo ""
    
    # Show table counts
    echo -e "${BOLD}Table Counts:${NC}"
    echo "─────────────────────────────"
    
    # Core tables
    local AUDITS=$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM audits;" 2>/dev/null || echo "0")
    local KEYWORDS=$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM keywords;" 2>/dev/null || echo "0")
    echo "  audits:           $AUDITS"
    echo "  keywords:         $KEYWORDS"
    
    # Link tables (v4)
    if [ "$VERSION" -ge 4 ]; then
        local PAGES=$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM page_analysis;" 2>/dev/null || echo "0")
        local PAGE_KW=$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM page_keywords;" 2>/dev/null || echo "0")
        local LINKS=$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM internal_links;" 2>/dev/null || echo "0")
        echo "  page_analysis:    $PAGES"
        echo "  page_keywords:    $PAGE_KW"
        echo "  internal_links:   $LINKS"
    fi
    
    # Index tables (v3)
    if [ "$VERSION" -ge 3 ]; then
        local ROUTES=$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM routes;" 2>/dev/null || echo "0")
        local COLLECTIONS=$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM collections;" 2>/dev/null || echo "0")
        local COMPONENTS=$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM components;" 2>/dev/null || echo "0")
        echo "  routes:           $ROUTES"
        echo "  collections:      $COLLECTIONS"
        echo "  components:       $COMPONENTS"
    fi
    
    echo ""
    
    # Migration status
    echo -e "${BOLD}Migration Status:${NC}"
    echo "─────────────────────────────"
    
    local LATEST_AVAILABLE=4
    if [ "$VERSION" -lt "$LATEST_AVAILABLE" ]; then
        log_warning "Migrations available: v$VERSION → v$LATEST_AVAILABLE"
        echo "    Run: ./scripts/setup-db.sh migrate"
    else
        log_success "Up to date (v$VERSION)"
    fi
}

cmd_init() {
    echo -e "\n${BOLD}🗄️  Initializing Database${NC}\n"
    
    check_sqlite
    
    # Create directory if needed
    local DB_DIR=$(dirname "$DB_PATH")
    if [ ! -d "$DB_DIR" ]; then
        mkdir -p "$DB_DIR"
        log_success "Created directory: $DB_DIR"
    fi
    
    # Check if database already exists
    if [ -f "$DB_PATH" ]; then
        local VERSION=$(get_schema_version)
        log_warning "Database already exists (v$VERSION)"
        echo "    Use 'reset' to clear and reinitialize"
        echo "    Use 'migrate' to run pending migrations"
        return
    fi
    
    # Run init script
    if [ -f "$SCRIPTS_DIR/init-db.sql" ]; then
        sqlite3 "$DB_PATH" < "$SCRIPTS_DIR/init-db.sql"
        log_success "Created database with base schema"
    else
        log_error "init-db.sql not found in $SCRIPTS_DIR"
        exit 1
    fi
    
    # Run v4 migration for link tables
    if [ -f "$SCRIPTS_DIR/migrate-v4.sql" ]; then
        sqlite3 "$DB_PATH" < "$SCRIPTS_DIR/migrate-v4.sql" 2>/dev/null || true
        log_success "Applied v4 migration (link tables)"
    fi
    
    local VERSION=$(get_schema_version)
    echo ""
    log_success "Database initialized at $DB_PATH (schema v$VERSION)"
    echo ""
    echo "Next steps:"
    echo "  1. Run '/index run' to index your project"
    echo "  2. Run '/index links' to build link graph"
    echo "  3. Run '/audit content [page]' to audit content"
}

cmd_migrate() {
    echo -e "\n${BOLD}🔄 Running Migrations${NC}\n"
    
    check_sqlite
    
    if [ ! -f "$DB_PATH" ]; then
        log_error "Database does not exist. Run 'init' first."
        exit 1
    fi
    
    local CURRENT=$(get_schema_version)
    log_info "Current schema version: $CURRENT"
    
    local MIGRATED=0
    
    # v3 migration
    if [ "$CURRENT" -lt 3 ] && [ -f "$SCRIPTS_DIR/migrate-v3.sql" ]; then
        log_info "Applying v3 migration..."
        sqlite3 "$DB_PATH" < "$SCRIPTS_DIR/migrate-v3.sql"
        log_success "Applied v3 migration"
        MIGRATED=1
    fi
    
    # v4 migration
    CURRENT=$(get_schema_version)
    if [ "$CURRENT" -lt 4 ] && [ -f "$SCRIPTS_DIR/migrate-v4.sql" ]; then
        log_info "Applying v4 migration..."
        sqlite3 "$DB_PATH" < "$SCRIPTS_DIR/migrate-v4.sql"
        log_success "Applied v4 migration"
        MIGRATED=1
    fi
    
    if [ "$MIGRATED" -eq 0 ]; then
        log_success "Database already up to date"
    else
        local NEW_VERSION=$(get_schema_version)
        echo ""
        log_success "Migrations complete (v$CURRENT → v$NEW_VERSION)"
    fi
}

cmd_reset() {
    echo -e "\n${BOLD}🗑️  Reset Database${NC}\n"
    
    if [ ! -f "$DB_PATH" ]; then
        log_warning "Database does not exist"
        cmd_init
        return
    fi
    
    # Confirm
    read -p "This will DELETE all data. Are you sure? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log_info "Cancelled"
        return
    fi
    
    # Backup first
    cmd_backup
    
    # Delete and reinitialize
    rm -f "$DB_PATH"
    log_success "Deleted existing database"
    
    cmd_init
}

cmd_backup() {
    echo -e "\n${BOLD}💾 Creating Backup${NC}\n"
    
    if [ ! -f "$DB_PATH" ]; then
        log_error "No database to backup"
        return
    fi
    
    # Create backup directory
    if [ ! -d "$BACKUP_DIR" ]; then
        mkdir -p "$BACKUP_DIR"
    fi
    
    # Create timestamped backup
    local TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    local BACKUP_FILE="$BACKUP_DIR/seo-audit_$TIMESTAMP.db"
    
    cp "$DB_PATH" "$BACKUP_FILE"
    log_success "Backup created: $BACKUP_FILE"
    
    # Show backup size
    local SIZE=$(du -h "$BACKUP_FILE" | cut -f1)
    echo "    Size: $SIZE"
    
    # Clean old backups (keep last 5)
    local BACKUP_COUNT=$(ls -1 "$BACKUP_DIR"/*.db 2>/dev/null | wc -l)
    if [ "$BACKUP_COUNT" -gt 5 ]; then
        log_info "Cleaning old backups (keeping last 5)..."
        ls -1t "$BACKUP_DIR"/*.db | tail -n +6 | xargs rm -f
    fi
}

cmd_index() {
    echo -e "\n${BOLD}🔗 Running Link Indexer${NC}\n"
    
    if [ ! -f "$DB_PATH" ]; then
        log_warning "Database does not exist. Initializing first..."
        cmd_init
        echo ""
    fi
    
    # Check for Node.js
    if ! command -v node &> /dev/null; then
        log_error "Node.js is required for the link indexer"
        echo "    Install Node.js or run '/index links' manually in Claude"
        exit 1
    fi
    
    # Run indexer
    if [ -f "$SCRIPTS_DIR/index-links.js" ]; then
        node "$SCRIPTS_DIR/index-links.js" "$@"
    else
        log_error "index-links.js not found in $SCRIPTS_DIR"
        exit 1
    fi
}

cmd_help() {
    echo -e "\n${BOLD}Astro SEO Agency - Database Setup${NC}\n"
    echo "Usage: ./scripts/setup-db.sh [command]"
    echo ""
    echo "Commands:"
    echo "  init      Create database with all tables (default)"
    echo "  migrate   Run pending schema migrations"
    echo "  reset     Clear and reinitialize database"
    echo "  status    Show database status and statistics"
    echo "  backup    Create timestamped backup"
    echo "  index     Run link indexer (requires Node.js)"
    echo "  help      Show this help message"
    echo ""
    echo "Examples:"
    echo "  ./scripts/setup-db.sh              # Initialize database"
    echo "  ./scripts/setup-db.sh status       # Check status"
    echo "  ./scripts/setup-db.sh index --full # Full link re-index"
}

# ==============================================================================
# Main
# ==============================================================================

COMMAND=${1:-init}

case $COMMAND in
    init)
        cmd_init
        ;;
    migrate)
        cmd_migrate
        ;;
    reset)
        cmd_reset
        ;;
    status)
        cmd_status
        ;;
    backup)
        cmd_backup
        ;;
    index)
        shift
        cmd_index "$@"
        ;;
    help|--help|-h)
        cmd_help
        ;;
    *)
        log_error "Unknown command: $COMMAND"
        cmd_help
        exit 1
        ;;
esac
