# Laravel Herd MCP Guide

Native PHP development environment management and service orchestration through the Model Context Protocol. Laravel Herd MCP provides direct integration with Herd's service management, site configuration, and PHP version control.

## Overview

Laravel Herd MCP server enables AI agents to interact with your local Laravel Herd environment, managing services, sites, PHP versions, and debugging directly from Claude.

**Official Documentation**: https://herd.laravel.com/docs/windows/advanced-usage/ai-integrations

## Installation & Setup

### Prerequisites

1. **Install Laravel Herd**: Download from https://herd.laravel.com/
2. **Ensure Herd is running**: Check system tray icon

### Claude Configuration

Add Herd MCP to your `.claude/config.json`:

```json
{
  "mcpServers": {
    "herd": {
      "command": "herd",
      "args": ["mcp"]
    }
  }
}
```

### Verify Installation

```bash
# Test Herd MCP connection
claude "Use mcp__herd__get_all_sites to list my Laravel sites"
```

## Core Tools & Capabilities

### 1. **Site Management**

#### Get All Sites

```bash
# List all Herd-managed sites
mcp__herd__get_all_sites

# Returns:
# - Domain names (e.g., myapp.test)
# - Full URLs
# - Project paths
# - PHP versions
# - SSL status
# - Environment type (development, staging)
```

**Use Cases**:
- Quickly identify which sites are available
- Check PHP versions across projects
- Verify SSL configuration
- Audit project paths

#### Debug Site

```bash
# Get detailed debugging information for a specific site
mcp__herd__debug_site --site=myapp.test

# Returns:
# - Recent query logs
# - Job dispatches
# - Dump() outputs
# - HTTP requests
# - Errors and exceptions
```

**Best Practice**: Use with time filters to avoid large responses

```bash
# Debug recent activity only
mcp__herd__debug_site --site=myapp.test --since="5 minutes ago"

# Get specific debug type
mcp__herd__debug_site --site=myapp.test --type=queries --limit=20
```

### 2. **PHP Version Management**

#### Get All PHP Versions

```bash
# List installed PHP versions
mcp__herd__get_all_php_versions

# Returns:
# - Installed versions (8.1, 8.2, 8.3, etc.)
# - Currently active version
# - Version-specific paths
```

#### Install PHP Version

```bash
# Install a new PHP version
mcp__herd__install_php_version --version=8.3

# Switch default PHP version
mcp__herd__set_default_php --version=8.3

# Set PHP version for specific site
mcp__herd__set_site_php --site=myapp.test --version=8.2
```

**Use Cases**:
- Test application on multiple PHP versions
- Upgrade projects incrementally
- Maintain compatibility across team

### 3. **Service Management**

#### Find Available Services

```bash
# List all available services
mcp__herd__find_available_services

# Returns services like:
# - MySQL
# - Redis
# - PostgreSQL
# - Typesense
# - Meilisearch
# - Laravel Reverb
# - MinIO
# - Mailpit
```

**Best Practice**: Check connection details

```bash
# Get service connection info
mcp__herd__get_service_details --service=mysql

# Returns:
# - Host
# - Port
# - Username
# - Environment variables for .env
```

#### Install Service

```bash
# Install and start a service
mcp__herd__install_service --service=redis --port=6379

# Install with custom configuration
mcp__herd__install_service --service=meilisearch --port=7700 --version=latest
```

#### Start/Stop Services

```bash
# Start a service
mcp__herd__start_service --service=mysql

# Stop a service
mcp__herd__stop_service --service=redis

# Restart a service
mcp__herd__restart_service --service=mysql
```

**Use Cases**:
- Free up system resources
- Isolate service testing
- Quick service recovery

## Workflow Patterns

### Development Setup Workflow

```bash
# Step 1: Check existing sites
mcp__herd__get_all_sites

# Step 2: Verify PHP version
mcp__herd__get_all_php_versions

# Step 3: Check required services
mcp__herd__find_available_services

# Step 4: Install missing services
mcp__herd__install_service --service=redis
mcp__herd__install_service --service=meilisearch

# Step 5: Start services
mcp__herd__start_service --service=redis
mcp__herd__start_service --service=meilisearch
```

### Debugging Workflow

```bash
# Step 1: Identify site issue
mcp__herd__get_all_sites

# Step 2: Debug specific site
mcp__herd__debug_site --site=myapp.test --limit=50

# Step 3: Check service status
mcp__herd__find_available_services

# Step 4: Review logs (combine with Boost)
mcp__boost__get_laravel_logs --lines=30

# Step 5: Test with different PHP version
mcp__herd__set_site_php --site=myapp.test --version=8.2
```

### Multi-Project Management

```bash
# List all projects
mcp__herd__get_all_sites

# Check PHP versions across projects
for site in $(mcp__herd__get_all_sites | jq -r '.sites[].domain'); do
  echo "Checking $site"
  mcp__herd__debug_site --site=$site --type=php_version
done

# Standardize PHP versions
mcp__herd__set_site_php --site=project1.test --version=8.3
mcp__herd__set_site_php --site=project2.test --version=8.3
```

### Service Orchestration

```bash
# Check all services
mcp__herd__find_available_services

# Start development stack
mcp__herd__start_service --service=mysql
mcp__herd__start_service --service=redis
mcp__herd__start_service --service=meilisearch

# Stop services when done
mcp__herd__stop_service --service=mysql
mcp__herd__stop_service --service=redis
mcp__herd__stop_service --service=meilisearch
```

## Integration with Other MCP Tools

### With Laravel Boost (Application Debugging)

```bash
# Herd: Get site details
mcp__herd__debug_site --site=myapp.test --limit=20

# Boost: Get application logs
mcp__boost__get_laravel_logs --level=error --lines=30

# Boost: Check database queries
mcp__boost__query_database --query="SHOW PROCESSLIST"
```

### With Serena (Code Navigation)

```bash
# Herd: Identify site path
mcp__herd__get_all_sites

# Serena: Navigate codebase at that path
mcp__serena__get_symbols_overview --relative_path="app/Http/Controllers"

# Herd: Debug site behavior
mcp__herd__debug_site --site=myapp.test --type=queries
```

### With Zen (Advanced Analysis)

```bash
# Herd: Gather debugging data
mcp__herd__debug_site --site=myapp.test --limit=50

# Zen: Analyze patterns
mcp__zen__analyze --prompt="Analyze these query patterns for N+1 issues..."

# Herd: Test with different PHP version
mcp__herd__set_site_php --site=myapp.test --version=8.2
```

## Best Practices

### 1. **Limit Debug Output**

```bash
# ❌ BAD: Unlimited debug data
mcp__herd__debug_site --site=myapp.test

# ✅ GOOD: Limited and filtered
mcp__herd__debug_site --site=myapp.test --limit=50 --since="5 minutes ago"

# ✅ GOOD: Specific debug type
mcp__herd__debug_site --site=myapp.test --type=errors --limit=20
```

### 2. **Service Resource Management**

```bash
# Stop unused services to free resources
mcp__herd__stop_service --service=meilisearch

# Start only required services
mcp__herd__start_service --service=mysql
mcp__herd__start_service --service=redis
```

### 3. **PHP Version Testing**

```bash
# Test on target production version first
mcp__herd__set_site_php --site=myapp.test --version=8.3

# Run tests
php artisan test

# Revert if needed
mcp__herd__set_site_php --site=myapp.test --version=8.2
```

### 4. **Site Organization**

```bash
# Use consistent naming
myapp.test          # Primary application
myapp-api.test      # API service
myapp-admin.test    # Admin panel

# Document PHP versions
mcp__serena__write_memory "site_php_versions" "myapp.test uses PHP 8.3"
```

## Common Use Cases

### 1. **New Project Setup**

```bash
# AI Prompt: "Set up development environment for new Laravel project"

# Herd will:
1. Create site: myproject.test
2. Set PHP version: 8.3
3. Install services: MySQL, Redis, Mailpit
4. Configure environment variables
5. Generate SSL certificate
```

### 2. **Debugging Production Issues**

```bash
# AI Prompt: "Debug slow queries on myapp.test"

# Workflow:
mcp__herd__debug_site --site=myapp.test --type=queries --limit=30
mcp__boost__get_laravel_logs --search="slow query" --lines=20
mcp__zen__analyze --prompt="Identify query optimization opportunities"
```

### 3. **Version Compatibility Testing**

```bash
# AI Prompt: "Test myapp on PHP 8.3"

# Workflow:
mcp__herd__set_site_php --site=myapp.test --version=8.3
# Run tests
mcp__herd__debug_site --site=myapp.test --type=errors --limit=20
# Revert if issues found
mcp__herd__set_site_php --site=myapp.test --version=8.2
```

### 4. **Service Configuration**

```bash
# AI Prompt: "Add Meilisearch to myapp.test"

# Workflow:
mcp__herd__install_service --service=meilisearch --port=7700
mcp__herd__get_service_details --service=meilisearch
# Update .env with connection details
# Test connection
```

## Security Considerations

### 1. **Local Development Only**

Herd MCP is designed for **local development** environments only. Never expose Herd MCP to production or public networks.

### 2. **Service Access Control**

```bash
# Ensure services are bound to localhost
mcp__herd__get_service_details --service=mysql

# Verify binding to 127.0.0.1 or ::1
# If exposed, reconfigure service
```

### 3. **Site Isolation**

```bash
# Use separate sites for different security contexts
myapp.test           # Standard development
myapp-secure.test    # Testing auth/security features
myapp-public.test    # Testing public-facing features
```

## Performance Tips

### 1. **Minimize Active Services**

```bash
# Stop services not in use
mcp__herd__find_available_services
# Stop unused services
mcp__herd__stop_service --service=typesense
mcp__herd__stop_service --service=minio
```

### 2. **Cache Site Information**

```bash
# Store site details in Serena memory
mcp__herd__get_all_sites
mcp__serena__write_memory "herd_sites" "[cached site data]"

# Reference memory instead of repeated queries
```

### 3. **Batch Operations**

```bash
# Start multiple services together
mcp__herd__start_service --service=mysql,redis,mailpit
```

## Troubleshooting

### Issue: Site Not Found

**Symptom**: `mcp__herd__debug_site` returns "Site not found"

**Solution**:
```bash
# Verify site exists
mcp__herd__get_all_sites

# Check Herd is running
herd --version

# Re-link project
cd /path/to/project
herd link
```

### Issue: PHP Version Switch Fails

**Symptom**: Site continues using old PHP version

**Solution**:
```bash
# Install target PHP version first
mcp__herd__install_php_version --version=8.3

# Clear Herd cache
herd restart

# Set site PHP version
mcp__herd__set_site_php --site=myapp.test --version=8.3
```

### Issue: Service Won't Start

**Symptom**: `mcp__herd__start_service` fails

**Solution**:
```bash
# Check service status
mcp__herd__find_available_services

# Check port conflicts
lsof -i :3306  # For MySQL
lsof -i :6379  # For Redis

# Kill conflicting process or use different port
mcp__herd__install_service --service=redis --port=6380
```

## AI Agent Prompts

### Development Environment Setup

```
Set up a complete Laravel development environment:
1. List existing Herd sites
2. Identify required services for this project
3. Install missing services (MySQL, Redis, Mailpit)
4. Configure environment variables
5. Verify site accessibility

Use Herd MCP tools for site and service management.
```

### Debugging Assistant

```
Debug performance issues on myapp.test:
1. Get site debugging info (queries, jobs, dumps)
2. Analyze for N+1 queries or slow operations
3. Check Laravel logs for errors
4. Suggest optimizations
5. Test on different PHP version if needed

Combine Herd and Boost MCP tools.
```

### Multi-Site Management

```
Audit all Laravel sites on this machine:
1. List all sites with their PHP versions
2. Check which services are running
3. Identify version inconsistencies
4. Suggest standardization strategy
5. Document current state

Use Herd MCP and store findings in Serena memory.
```

## Cheat Sheet

```bash
# Site Management
mcp__herd__get_all_sites
mcp__herd__debug_site --site=myapp.test --limit=50

# PHP Management
mcp__herd__get_all_php_versions
mcp__herd__install_php_version --version=8.3
mcp__herd__set_site_php --site=myapp.test --version=8.3

# Service Management
mcp__herd__find_available_services
mcp__herd__install_service --service=redis
mcp__herd__start_service --service=mysql
mcp__herd__stop_service --service=meilisearch

# Quick Debugging
mcp__herd__debug_site --site=myapp.test --type=errors --limit=20
mcp__herd__debug_site --site=myapp.test --type=queries --limit=30
mcp__herd__get_service_details --service=mysql
```

## Best Practices Summary

1. **Always limit debug output** (use --limit and --since)
2. **Stop unused services** (free system resources)
3. **Document PHP versions** (track versions per project)
4. **Use consistent site naming** (follow project.test pattern)
5. **Combine with other MCPs** (Boost for logs, Serena for code)
6. **Cache site information** (use Serena memory)
7. **Local development only** (never expose to production)

---

**Remember**: Herd MCP provides powerful environment control. Always use limits on debug operations and combine with Laravel Boost for comprehensive debugging workflows.
