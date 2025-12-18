# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [3.1.0] - 2024-12-18

### Added
- Comprehensive GitHub Copilot Extensions documentation (docs/copilot-extensions/)
- Guide for @workspace feature (workspace-context.md) - Serena MCP equivalent
- Guide for Copilot Edits (copilot-edits.md) - multi-file editing feature
- Quick reference guide comparing MCP servers to Copilot Extensions
- Extension recommendations and setup instructions
- VS Code workspace settings for optimal Copilot usage

### Changed
- **BREAKING**: Clarified that GitHub Copilot does NOT support MCP servers
- Updated README.md feature comparison table to show Extensions vs MCP
- Updated COPILOT-SETUP.md with Extensions and Copilot Edits information
- Updated DUAL-SETUP.md with comprehensive Extensions vs MCP comparison
- Improved accuracy of tool capability descriptions throughout documentation

### Fixed
- Incorrect claim that GitHub Copilot supports MCP servers
- Missing information about Copilot Edits feature
- Incomplete documentation about @workspace capabilities
- Lack of migration guidance from MCP to Extensions

### Documentation
- Added mapping between Claude MCP servers and Copilot equivalents:
  - Serena MCP → @workspace + IntelliSense
  - Context7 MCP → Built-in knowledge
  - Zen MCP → Chat analysis + SonarLint
  - BrowserMCP → Generated Playwright/Dusk tests
  - Laravel Herd/Boost → Built-in Laravel knowledge

## [3.0.0] - 2024-12-XX

### Added
- Initial dual-tool support (Claude Code + GitHub Copilot)
- Complete Laravel VILT stack configurations
- Specialist agents for both tools
- MCP server integration guides
- Development workflows and skills

### Changed
- Renamed from TALL to VILT stack focus
- Updated for Laravel 12 and Vue 3.4

### Documentation
- Complete documentation restructure
- Added workflow guides
- Added reference materials
- MCP server setup guides

## [2.0.0] - 2024-XX-XX

### Added
- Laravel TALL stack configurations
- Claude-specific agents
- Development workflows

## [1.0.0] - 2024-XX-XX

### Added
- Initial release
- Basic Laravel configurations
- Claude AI integration

---

## Legend

- `Added` for new features
- `Changed` for changes in existing functionality
- `Deprecated` for soon-to-be removed features
- `Removed` for now removed features
- `Fixed` for any bug fixes
- `Security` for vulnerability fixes
- `Documentation` for documentation changes
