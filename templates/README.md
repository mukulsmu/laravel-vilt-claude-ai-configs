# MCP Configuration Templates

This directory contains MCP (Model Context Protocol) server configuration templates for Laravel VILT Stack AI development.

## Files

### `.mcp.json` - Claude Desktop Configuration

**Purpose**: Configuration for Claude Desktop app or project-level Claude Code MCP servers.

**Location Options**:
1. **Project Root**: Place as `.mcp.json` in your Laravel project root
2. **Claude Desktop Global**: Merge with `claude_desktop_config.json`:
   - **macOS**: `~/Library/Application Support/Claude/claude_desktop_config.json`
   - **Windows**: `%APPDATA%\Claude\claude_desktop_config.json`

**Usage**:
```bash
# Copy to project root (install script does this automatically)
cp templates/.mcp.json ./.mcp.json

# Update PROJECT_PATH_PLACEHOLDER with your actual project path
sed -i "s|PROJECT_PATH_PLACEHOLDER|$(pwd)|g" .mcp.json

# Update Herd path for your operating system
# macOS: /Applications/Herd.app/Contents/Resources/herd-mcp.phar
# Windows: C:\Program Files\Herd\resources\herd-mcp.phar
```

### `.vscode-mcp.json` - VS Code MCP Configuration

**Purpose**: Configuration for GitHub Copilot MCP servers in VS Code.

**Location**: `.vscode/mcp.json` in your Laravel project

**Usage**:
```bash
# Copy to .vscode directory (install script does this automatically)
mkdir -p .vscode
cp templates/.vscode-mcp.json .vscode/mcp.json

# Update Herd path for your operating system if needed
```

**Note**: Uses `${workspaceFolder}` variable which VS Code automatically resolves.

## MCP Servers Included

### 1. Laravel Boost
- **Command**: `php artisan boost:mcp`
- **Purpose**: Laravel code generation, scaffolding, and AI-ready project setup
- **Required**: Laravel Boost must be installed (`composer require laravel/boost`)

### 2. Laravel Herd
- **Command**: `php /path/to/herd-mcp.phar`
- **Purpose**: Local PHP development server management
- **Platform**: macOS and Windows only
- **Path Configuration**:
  - **macOS**: `/Applications/Herd.app/Contents/Resources/herd-mcp.phar`
  - **Windows**: `C:\Program Files\Herd\resources\herd-mcp.phar`
  - **Linux**: Not supported (use Laravel Valet, Sail, or Docker)

### 3. Serena
- **Command**: `uvx --from git+https://github.com/oraios/serena serena start-mcp-server`
- **Purpose**: Semantic code analysis and intelligent navigation
- **Requirements**: Python 3.8+ and uvx (`pip install uvx`)
- **Features**:
  - Symbol search and navigation
  - Code pattern analysis
  - Memory system for architectural decisions
  - Intelligent refactoring

### 4. BrowserMCP
- **Command**: `npx @browsermcp/mcp@latest`
- **Purpose**: Real-time browser automation and testing
- **Requirements**: Node.js and npm
- **Features**:
  - Browser navigation and screenshots
  - Real-time UI debugging
  - User workflow testing
  - Console error inspection

## Platform-Specific Configuration

### macOS

Default configuration works out of the box. Laravel Herd path is pre-configured.

### Windows

1. Update Herd path in both configuration files:
   ```json
   "args": ["C:\\Program Files\\Herd\\resources\\herd-mcp.phar"]
   ```

2. Ensure backslashes are escaped in JSON: `\\`

### Linux

Laravel Herd is not available on Linux. Options:

1. **Remove Herd server** from configuration
2. **Use Laravel Valet**: Configure custom MCP server path
3. **Use Docker/Sail**: Configure artisan commands via Docker
4. **Use native PHP**: Standard `php artisan serve`

## Troubleshooting

### "Command not found" errors

**Serena (uvx)**:
```bash
# Install uvx
pip install uvx

# Verify installation
uvx --version
```

**BrowserMCP (npx)**:
```bash
# Update npm
npm install -g npm@latest

# Verify npx
npx --version
```

### "MCP server failed to start"

**Laravel Boost**:
```bash
# Verify Laravel Boost is installed
php artisan list | grep boost

# Install if missing
composer require laravel/boost
php artisan boost:install
```

**Laravel Herd**:
```bash
# Verify Herd is installed
# macOS: Check /Applications/Herd.app exists
# Windows: Check C:\Program Files\Herd exists

# Update path in configuration if installed elsewhere
```

### "Project path not found"

Ensure `PROJECT_PATH_PLACEHOLDER` is replaced with your actual project path:

```bash
# For .mcp.json
sed -i "s|PROJECT_PATH_PLACEHOLDER|/full/path/to/your/project|g" .mcp.json
```

For `.vscode/mcp.json`, it uses `${workspaceFolder}` which is automatically resolved.

### "Permission denied" errors

Make sure the MCP server executables have proper permissions:

```bash
# Laravel Herd (macOS)
ls -l /Applications/Herd.app/Contents/Resources/herd-mcp.phar

# Should be executable (if not, contact Herd support)
```

## Advanced Configuration

### Adding Custom MCP Servers

You can add your own MCP servers to these configurations:

```json
{
  "mcpServers": {
    "my-custom-server": {
      "command": "node",
      "args": ["/path/to/your/server.js"],
      "env": {
        "CUSTOM_VAR": "value"
      },
      "description": "My custom MCP server"
    }
  }
}
```

### Environment Variables

MCP servers can use environment variables:

```json
{
  "env": {
    "API_KEY": "your-api-key",
    "DEBUG": "true",
    "SITE_PATH": "${workspaceFolder}"
  }
}
```

## Related Documentation

- **[MCP Setup Guide](../docs/mcp-servers/copilot-mcp-setup.md)** - Complete setup instructions
- **[Laravel Boost Guide](../docs/mcp-servers/laravel-boost-guide.md)** - Laravel Boost MCP usage
- **[Laravel Herd Guide](../docs/mcp-servers/laravel-herd-guide.md)** - Herd MCP usage
- **[Serena Guide](../docs/mcp-servers/serena-guide.md)** - Serena MCP usage
- **[BrowserMCP Guide](../docs/mcp-servers/browsermcp-guide.md)** - Browser automation

## Support

If you encounter issues with MCP configuration:

1. Check the [troubleshooting section](#troubleshooting) above
2. Review individual MCP server documentation
3. Validate your setup with `./validate-setup.sh`
4. Check [GitHub issues](https://github.com/mukulsmu/laravel-vilt-claude-ai-configs/issues)

---

**Note**: The `install.sh` script automatically configures these templates with the correct paths for your system.
