# MCP Configuration Update Instructions

## Files Updated

### 1. Agent Files Fixed (Added Frontmatter)
- `.claude/agents/git-specialist.md` - Added name: "Git Specialist"
- `.claude/agents/admin-specialist.md` - Added name: "Admin Specialist"  
- `.claude/agents/database-architect.md` - Added name: "Database Architect"
- `.claude/agents/vilt-specialist.md` - Added name: "VILT Specialist"
- `.claude/agents/tall-specialist.md` - Added name: "TALL Specialist"

### 2. MCP Configuration Templates Created
- `templates/.mcp.json` - Claude Desktop MCP configuration
- `templates/.vscode-mcp.json` - GitHub Copilot (VS Code) MCP configuration

### 3. Installation Script Updated
- `install.sh` - Now copies MCP configurations during installation

## Key Changes in MCP Configurations

### Serena Tool Filtering
To reduce token usage from ~18,773 to manageable levels, Serena is now configured with `--filter-tools` containing only essential tools for Laravel VILT development:

**Selected Tools:**
- `read_file` - Read source files
- `write_file` - Create/update files
- `replace_in_file` - Edit existing files
- `search_for_pattern` - Code search
- `list_dir` - Directory navigation
- `create_directory` - Create folders
- `find_symbol_definition` - Find class/function definitions
- `find_referencing_symbols` - Find usage references
- `read_memory` - Access project memory
- `write_memory` - Store project context
- `search_memory` - Query stored context

This reduces the Serena tool context from ~18,773 tokens to approximately ~4,000 tokens.

### Fixed workspaceFolder Variable
Changed from hardcoded path to `${workspaceFolder}` variable which:
- Resolves to project path in both Claude Desktop and VS Code
- Makes configuration portable across machines
- Eliminates "Missing environment variables" warning

## Republishing Instructions

### Step 1: Commit Changes
```bash
cd /Users/mukulgupta/Projects/laravel-vilt-claude-ai-configs

git add .claude/agents/*.md templates/ install.sh
git commit -m "fix: Add required frontmatter to agent files and create MCP configuration templates

- Add 'name' field to 5 agent files (git, admin, database, vilt, tall)
- Create .mcp.json template for Claude Desktop with filtered Serena tools
- Create .vscode-mcp.json template for GitHub Copilot
- Update install.sh to copy MCP configurations
- Reduce Serena token usage from ~18k to ~4k tokens
- Fix workspaceFolder variable issue"
```

### Step 2: Push to GitHub
```bash
git push origin main
```

### Step 3: Tag New Version (Optional but Recommended)
```bash
# Get current version
CURRENT_VERSION=$(cat VERSION)

# Increment version (e.g., 1.0.0 -> 1.0.1)
# Or manually set: NEW_VERSION="1.1.0"
echo "1.0.1" > VERSION

git add VERSION
git commit -m "chore: Bump version to 1.0.1"
git tag -a v1.0.1 -m "Version 1.0.1: Fix agent frontmatter and add MCP configs"
git push origin main --tags
```

### Step 4: Update Existing Installation (Testing)
```bash
cd /Users/mukulgupta/Herd/anal

# Re-run installation from updated repo
curl -fsSL https://raw.githubusercontent.com/mukulsmu/laravel-vilt-claude-ai-configs/main/install.sh | bash
```

### Step 5: Verify MCP Configuration
```bash
cd /Users/mukulgupta/Herd/anal

# Check Claude Desktop config
cat .mcp.json

# Check VS Code config
cat .vscode/mcp.json

# Verify agents have frontmatter
head -15 .claude/agents/git-specialist.md
```

## Testing Checklist

### Claude Desktop
- [ ] Open Claude Desktop
- [ ] Check for agent parse errors (should be gone)
- [ ] Verify MCP server status (no missing variable warnings)
- [ ] Check MCP context usage (should be ~20k tokens vs 34k before)
- [ ] Test Serena file operations work
- [ ] Test Laravel Boost MCP commands work

### VS Code (GitHub Copilot)
- [ ] Open project in VS Code
- [ ] Open Copilot Chat
- [ ] Check MCP server status in output panel
- [ ] Test asking Copilot to read files via Serena
- [ ] Test Laravel Boost integration

## Expected Results

### Before
```
Agent Parse Errors
└ Failed to parse 5 agent file(s):
  └ Missing required "name" field in frontmatter

Context Usage Warnings
└ ⚠ Large MCP tools context (~34,252 tokens > 25,000)
  └ oraios_serena: 24 tools (~18,773 tokens)
  
[Warning] Missing environment variables: workspaceFolder
```

### After
```
✅ All agents parsed successfully (9 agents)

Context Usage
└ MCP tools context (~16,000 tokens)
  └ oraios_serena: 11 tools (~4,000 tokens)
  └ browsermcp: 12 tools (~7,391 tokens)
  └ herd: 11 tools (~6,795 tokens)
  └ laravel-boost: 2 tools (~1,293 tokens)
  
✅ No warnings
```

## Rollback Instructions (If Needed)

If something breaks:

```bash
cd /Users/mukulgupta/Herd/anal

# Restore backups
[ -f .mcp.json.backup ] && mv .mcp.json.backup .mcp.json
[ -f .vscode/mcp.json.backup ] && mv .vscode/mcp.json.backup .vscode/mcp.json

# Restore agent files from previous version
git clone https://github.com/mukulsmu/laravel-vilt-claude-ai-configs.git .ai-config-rollback
cd .ai-config-rollback
git checkout <previous-commit-hash>
cp -r .claude/agents/* ../.claude/agents/
cd .. && rm -rf .ai-config-rollback
```

## Support

If issues occur:
1. Check agent files have proper frontmatter format
2. Verify `${workspaceFolder}` resolves correctly
3. Confirm Serena accepts `--filter-tools` argument
4. Review MCP server logs in Claude Desktop / VS Code Output panel
