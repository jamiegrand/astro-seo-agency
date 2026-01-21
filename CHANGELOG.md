# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.2.0] - 2026-01-21

### Added
- MCP auto-configuration: `install.sh` now creates `.mcp.json` with Astro Docs MCP server
- Smart merge for existing `.mcp.json` files (with backup)
- `/verify` command for installation verification
- YAML frontmatter to all prompts for slash command compatibility
- Badges to README (version, license, Astro, Node.js, Claude Code)
- Documentation for `/audit astro` option

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

[2.2.0]: https://github.com/jamiegrand/astro-seo-agency/compare/v2.1.0...v2.2.0
[2.1.0]: https://github.com/jamiegrand/astro-seo-agency/compare/v2.0.0...v2.1.0
[2.0.0]: https://github.com/jamiegrand/astro-seo-agency/compare/v1.0.0...v2.0.0
[1.0.0]: https://github.com/jamiegrand/astro-seo-agency/releases/tag/v1.0.0
