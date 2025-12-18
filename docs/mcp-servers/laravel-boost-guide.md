# Laravel Boost MCP Guide

Comprehensive AI-powered tooling for Laravel applications via the Model Context Protocol (MCP). Laravel Boost provides 15+ specialized tools for code analysis, database queries, configuration extraction, logging, and documentation search.

## Overview

Laravel Boost is the official Laravel MCP server that enables AI agents (like Claude) to interact directly with your Laravel application for debugging, development, and analysis tasks.

**Official Documentation**: https://boost.laravel.com/

## Installation & Setup

### Prerequisites
```bash
# Ensure you have Laravel 12+
composer require laravel/boost

# Publish the MCP configuration
php artisan boost:install
```

### Claude Configuration

Add Laravel Boost to your `.claude/config.json`:

```json
{
  "mcpServers": {
    "laravel-boost": {
      "command": "php",
      "args": [
        "artisan",
        "mcp:serve"
      ],
      "cwd": "/absolute/path/to/your/laravel/project"
    }
  }
}
```

## Core Tools & Best Practices

### 1. **Log Analysis Tools**

#### ⚠️ CRITICAL: Log Truncation Configuration

**Problem**: Laravel logs can be massive (100MB+), causing context window overflow and slow responses.

**Solution**: Always use line limits and time filters:

```bash
# ❌ BAD: Retrieves entire log file
mcp__boost__get_laravel_logs

# ✅ GOOD: Get only last 50 lines
mcp__boost__get_laravel_logs --lines=50

# ✅ GOOD: Get logs from last hour
mcp__boost__get_laravel_logs --since="1 hour ago" --lines=100

# ✅ GOOD: Filter by log level (errors only)
mcp__boost__get_laravel_logs --level=error --lines=30

# ✅ GOOD: Specific date range
mcp__boost__get_laravel_logs --from="2024-01-15" --to="2024-01-16" --lines=50
```

**Recommended Default Configuration**:

Create `config/boost.php`:

```php
<?php

return [
    'logs' => [
        'default_lines' => 50,        // Maximum lines to return
        'max_lines' => 200,            // Hard limit
        'default_level' => 'info',     // Minimum log level
        'truncate_long_messages' => true, // Truncate individual messages
        'message_max_length' => 500,   // Max chars per log entry
    ],
    
    'console' => [
        'default_lines' => 100,
        'max_lines' => 500,
    ],
    
    'cache' => [
        'ttl' => 60, // Cache log queries for 60 seconds
    ],
];
```

#### Log Analysis Patterns

```bash
# Debug recent errors
mcp__boost__get_laravel_logs --level=error --lines=20

# Investigate specific exception
mcp__boost__get_laravel_logs --search="QueryException" --lines=30

# Monitor queue failures
mcp__boost__get_laravel_logs --channel=queue --level=error --lines=25

# Check authentication issues
mcp__boost__get_laravel_logs --search="auth" --since="today" --lines=40
```

### 2. **Database Tools**

```bash
# List all database tables
mcp__boost__list_database_tables

# Describe table structure
mcp__boost__describe_table --table=users

# Execute read-only queries
mcp__boost__query_database --query="SELECT * FROM users WHERE created_at > NOW() - INTERVAL 1 DAY LIMIT 10"

# Get model relationships
mcp__boost__get_model_relationships --model=User
```

**Best Practices**:
- Always use `LIMIT` in queries
- Prefer specific queries over `SELECT *`
- Use `describe_table` before complex queries
- Cache frequent query results

### 3. **Configuration Tools**

```bash
# Get specific config value
mcp__boost__get_config --key=app.name

# List environment variables
mcp__boost__list_env_vars --filter=DB_

# Get route list
mcp__boost__list_routes --filter=api

# View middleware stack
mcp__boost__list_middleware
```

### 4. **Code Analysis Tools**

```bash
# Find class definition
mcp__boost__find_class --class=UserController

# List Artisan commands
mcp__boost__list_commands

# Get service container bindings
mcp__boost__list_bindings --filter=auth

# Analyze dependencies
mcp__boost__analyze_dependencies --package=laravel/framework
```

### 5. **Documentation Search**

```bash
# Search Laravel docs
mcp__boost__search_docs --query="validation rules" --version=12.x

# Get package documentation
mcp__boost__get_package_docs --package=laravel/sanctum

# Find code examples
mcp__boost__search_examples --topic="eloquent relationships"
```

## Workflow Patterns

### Debugging Workflow

```bash
# Step 1: Check recent errors
mcp__boost__get_laravel_logs --level=error --lines=20

# Step 2: Analyze specific error
mcp__boost__get_laravel_logs --search="[ErrorClassName]" --lines=10

# Step 3: Check related database
mcp__boost__describe_table --table=affected_table

# Step 4: Verify configuration
mcp__boost__get_config --key=relevant.config.key

# Step 5: Check routes
mcp__boost__list_routes --filter=problematic-route
```

### Performance Investigation

```bash
# Check slow query log
mcp__boost__get_laravel_logs --search="slow query" --lines=30

# Analyze database queries
mcp__boost__query_database --query="SHOW FULL PROCESSLIST"

# Review cache configuration
mcp__boost__get_config --key=cache

# Check queue status
mcp__boost__get_laravel_logs --channel=queue --lines=20
```

### Security Audit

```bash
# Check authentication logs
mcp__boost__get_laravel_logs --search="authentication" --level=warning --lines=50

# Review security-related config
mcp__boost__get_config --key=auth
mcp__boost__get_config --key=session

# List API routes
mcp__boost__list_routes --filter=api

# Check middleware configuration
mcp__boost__list_middleware
```

## Integration with Other MCP Tools

### With Serena (Code Navigation)

```bash
# Find class with Serena
mcp__serena__find_symbol "UserController"

# Get logs related to that class
mcp__boost__get_laravel_logs --search="UserController" --lines=20
```

### With Zen (Advanced Analysis)

```bash
# Get logs for analysis
mcp__boost__get_laravel_logs --level=error --lines=50

# Deep analysis with Zen
mcp__zen__analyze --context="Analyze these error patterns..."
```

### With Herd MCP (Service Management)

```bash
# Check site configuration with Herd
mcp__herd__get_all_sites

# Get logs for specific site
mcp__boost__get_laravel_logs --lines=30

# Debug site issues
mcp__herd__debug_site --site=myapp.test
mcp__boost__get_laravel_logs --since="5 minutes ago" --lines=20
```

## Performance Optimization Tips

### 1. Response Size Limits

```bash
# Always specify limits
--lines=50         # Limit log lines
--limit=10         # Limit query results
--filter=specific  # Narrow search scope
```

### 2. Caching Strategy

```php
// In config/boost.php
'cache' => [
    'enabled' => true,
    'ttl' => 60,
    'driver' => 'redis', // Use fast cache driver
],
```

### 3. Async Operations

```bash
# For large operations, use async mode
mcp__boost__analyze_codebase --async=true

# Check status later
mcp__boost__get_job_status --job_id=abc123
```

## Security Considerations

### 1. Read-Only Access

Configure Boost for read-only operations in production:

```php
// config/boost.php
'security' => [
    'read_only' => env('BOOST_READ_ONLY', true),
    'allowed_operations' => [
        'logs.read',
        'database.select',
        'config.read',
    ],
    'blocked_operations' => [
        'database.write',
        'config.write',
        'file.write',
    ],
],
```

### 2. Sensitive Data Filtering

```php
'filtering' => [
    'mask_sensitive_keys' => true,
    'sensitive_patterns' => [
        '/password/i',
        '/secret/i',
        '/api[-_]key/i',
        '/token/i',
    ],
    'replacement' => '***FILTERED***',
],
```

### 3. Access Control

```php
'access' => [
    'require_authentication' => true,
    'allowed_ips' => [
        '127.0.0.1',
        '::1',
    ],
    'rate_limit' => 100, // Requests per minute
],
```

## Common Issues & Solutions

### Issue: Response Too Large

**Symptom**: Claude reports context window overflow

**Solution**:
```bash
# Reduce line count
mcp__boost__get_laravel_logs --lines=20

# Add filters
mcp__boost__get_laravel_logs --level=error --since="1 hour ago" --lines=30

# Use search
mcp__boost__get_laravel_logs --search="specific error" --lines=10
```

### Issue: Slow Responses

**Symptom**: MCP tool takes too long to respond

**Solution**:
```bash
# Enable caching
php artisan config:cache

# Use more specific queries
mcp__boost__query_database --query="SELECT id, name FROM users LIMIT 10"

# Limit log analysis timeframe
mcp__boost__get_laravel_logs --since="5 minutes ago" --lines=20
```

### Issue: Cannot Connect

**Symptom**: Claude cannot connect to Boost MCP

**Solution**:
```bash
# Check server is running
php artisan mcp:status

# Verify configuration
php artisan mcp:test

# Check permissions
ls -la bootstrap/cache
chmod -R 755 bootstrap/cache
```

## AI Agent Prompts

### Log Analysis Prompt

```
Use Laravel Boost to analyze recent application errors:
1. Get last 30 error-level logs
2. Identify patterns or recurring issues
3. Suggest potential fixes
4. Check related configuration

Use: mcp__boost__get_laravel_logs --level=error --lines=30
```

### Database Investigation Prompt

```
Investigate database performance issues:
1. List all tables
2. Describe the most frequently accessed tables
3. Execute EXPLAIN on slow queries
4. Suggest optimization strategies

Remember to use LIMIT in all queries.
```

### Configuration Audit Prompt

```
Audit application configuration:
1. Review security-related config (auth, session, cors)
2. Check environment-specific settings
3. Verify database configuration
4. Review cache and queue settings

Use mcp__boost__get_config for each area.
```

## Memory Patterns

Use Serena to store Boost insights:

```bash
mcp__serena__write_memory "boost_log_patterns" "Common error patterns found: [patterns]"

mcp__serena__write_memory "boost_optimization" "Performance bottlenecks identified: [details]"

mcp__serena__write_memory "boost_security" "Security audit findings: [findings]"
```

## Cheat Sheet

```bash
# Quick diagnostics
mcp__boost__get_laravel_logs --level=error --lines=20
mcp__boost__list_routes --filter=api
mcp__boost__query_database --query="SELECT * FROM failed_jobs LIMIT 10"

# Investigation
mcp__boost__get_laravel_logs --search="[ClassName]" --lines=30
mcp__boost__describe_table --table=affected_table
mcp__boost__get_config --key=relevant.config

# Performance
mcp__boost__get_laravel_logs --search="slow" --lines=20
mcp__boost__list_bindings
mcp__boost__analyze_dependencies

# Security
mcp__boost__get_laravel_logs --search="auth" --level=warning --lines=50
mcp__boost__list_middleware
```

## Best Practices Summary

1. **Always use line limits** (default: 50, max: 200)
2. **Filter by time** (last hour, today, specific date range)
3. **Search specifically** (use --search for targeted results)
4. **Cache results** (enable caching for repeated queries)
5. **Secure access** (read-only in production, IP whitelist)
6. **Monitor usage** (track API calls, set rate limits)
7. **Integrate tools** (combine Boost with Serena, Zen, Herd)

---

**Remember**: Laravel Boost is powerful but can overwhelm context windows. Always use limits, filters, and specific queries to get actionable insights without bloating the conversation.
