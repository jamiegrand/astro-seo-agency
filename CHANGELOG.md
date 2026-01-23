# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [3.0.0] - 2025-01-23

### Changed

#### Router-Based Command Architecture
Commands are now organized under router commands for better discoverability and consistency.

**New Router Commands:**
- `/seo` - SEO tools hub (wins, gaps, roi, refresh, history, impact, keywords)
- `/audit` - Audit tools hub (content, quick, batch, eeat)
- `/fix` - Issue resolution hub (next, batch)
- `/setup` - Configuration hub (existing, verify, commands, index)
- `/feature` - Development hub (deploy)

**Command Migration:**

| Old Command | New Command |
|-------------|-------------|
| `/content-audit` | `/audit content` |
| `/content-audit-quick` | `/audit quick` |
| `/content-audit-batch` | `/audit batch` |
| `/content-eeat` | `/audit eeat` |
| `/content-refresh` | `/seo refresh` |
| `/content-roi` | `/seo roi` |
| `/content-gap` | `/seo gaps` |
| `/content-history` | `/seo history` |
| `/keyword-cache` | `/seo keywords` |
| `/impact` | `/seo impact` |
| `/brownfield` | `/setup existing` |
| `/verify` | `/setup verify` |
| `/generate-commands` | `/setup commands` |
| `/deploy-check` | `/feature deploy` |

**Backward Compatibility:** All old command names still work as aliases.

### Added
- Router pattern with `type: "router"` and `type: "implementation"` annotations
- Alias command support with `type: "alias"` for backward compatibility
- Improved help documentation with alias reference table

### Fixed
- Consistent command naming across all documentation
- Agent invocation references updated to new command names
- astro-mcp capabilities list corrected (removed search-astro-docs which belongs to Astro Docs MCP)

## [2.3.0] - 2026-01-22

### Added
- **Content Audit Suite** - 7 new commands for comprehensive SEO content analysis:
  - `/content-audit [page] [keyword]` - Full 6-category SEO audit with 0-100 scoring
  - `/content-audit-quick [page] [keyword]` - 10-point rapid check with 0-10 score
  - `/content-audit-batch [collection]` - Audit multiple pages with priority ranking
  - `/content-refresh` - Find declining pages via GSC data (clicks dropped, low CTR, striking distance)
  - `/content-eeat [page]` - E-E-A-T deep dive (Experience, Expertise, Authority, Trust)
  - `/content-history [page]` - View audit score trends over time
  - `/keyword-cache [action]` - Manage cached keyword research data
- **SQLite Database** - Persistent storage for audit data at `.planning/seo-audit.db`
  - Track audit scores over time
  - Cache keyword research data (reduces API calls)
  - Store GSC performance snapshots
  - Competitor analysis history
- **New MCP Integrations**:
  - ScraperAPI - For competitor content analysis
  - DataForSEO - For keyword volume, difficulty, and People Also Ask questions
- `/content-gap` command - Find content opportunities from GSC data and generate content briefs
  - Analyzes GSC for high-impression queries without dedicated content
  - Generates detailed content briefs with keyword targeting
  - Includes competitor analysis and internal linking strategy
  - Supports content creation directly from briefs
- `/generate-commands` command - Create custom commands based on your site's content structure
  - Scans content collections, data files, and page structure
  - Detects content types (blog, products, services, FAQs, etc.)
  - Generates tailored commands: `/new-[type]`, `/optimize-[type]`, `/[type]-gaps`, `/[type]-audit`
  - Installs custom commands to `.claude/commands/`

### Changed
- Install script now installs 26 total files (23 commands + 3 prompts)
- Updated `content-strategist` agent with E-E-A-T and AI Overview scoring sections
- Updated `help.md` with new Content Audit section
- Added `SCRAPERAPI_KEY`, `DATAFORSEO_USERNAME`, `DATAFORSEO_PASSWORD` to `.env.example`

## [2.2.0] - 2026-01-21

### Added
- MCP auto-configuration: `install.sh` now creates `.mcp.json` with Astro Docs MCP server
- Smart merge for existing `.mcp.json` files (with backup)
- `/verify` command for installation verification
- YAML frontmatter to all prompts for slash command compatibility
- Badges to README (version, license, Astro, Node.js, Claude Code)
- Documentation for `/audit astro` option
- Clarified MCP config locations in README (project vs user-level)

### Changed
- Install script now installs 17 total files (14 commands + 3 prompts)
- Updated `help.md` and `plugin.json` with new commands

## [2.1.0] - 2026-01-20

### Added
- `/setup` and `/brownfield` prompts as slash commands
- `/astro-check mcp` subcommand for MCP server diagnostics and availability validation
- `/fix-batch [n]` command for batch issue fixing
- MCP Integration section in README
- Batch Processing workflow examples

### Changed
- Improved `/astro-check` with better MCP server status reporting

## [2.0.0] - 2026-01-19

### Added
- Full MCP integration with Astro Docs MCP and astro-mcp
- `/astro-check` command for querying project info via MCP
- `/astro-check docs "query"` for searching Astro documentation
- Smart CLAUDE.md merge on install (MERGE/REPLACE/SKIP options)
- Session persistence with `/pause` and `/resume` commands
- Interactive pipe detection in install script

### Changed
- Restructured install script for better reliability
- Improved QUICKSTART.md with clearer instructions

## [1.0.0] - 2026-01-18

### Added
- Initial release
- 14 slash commands for Astro project management
- Session management: `/start`, `/status`, `/pause`, `/resume`
- Issue resolution: `/fix-next`, `/audit`
- SEO & Analytics: `/seo-wins`, `/content-roi`, `/impact`
- Feature development: `/feature`, `/deploy-check`
- 3 agent definitions (SEO Analyst, Astro Maintainer, Content Strategist)
- CLAUDE.md template with 3-layer architecture
- Impact-based prioritization formula
- Google Analytics and Search Console integration
- GitHub issue tracking integration

[3.0.0]: https://github.com/jamiegrand/astro-seo-agency/compare/v2.3.0...v3.0.0
[2.3.0]: https://github.com/jamiegrand/astro-seo-agency/compare/v2.2.0...v2.3.0
[2.2.0]: https://github.com/jamiegrand/astro-seo-agency/compare/v2.1.0...v2.2.0
[2.1.0]: https://github.com/jamiegrand/astro-seo-agency/compare/v2.0.0...v2.1.0
[2.0.0]: https://github.com/jamiegrand/astro-seo-agency/compare/v1.0.0...v2.0.0
[1.0.0]: https://github.com/jamiegrand/astro-seo-agency/releases/tag/v1.0.0
