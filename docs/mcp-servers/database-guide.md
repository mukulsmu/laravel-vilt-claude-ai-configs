# Database MCP Servers Guide

**Primary Purpose**: Database operations, query execution, and schema management for Laravel development

## Overview

Database MCP Servers provide direct database access and operations that integrate with AI-assisted Laravel development. They enable query execution, schema inspection, data manipulation, and database debugging without leaving the AI workflow.

## Available Database MCP Servers

### 1. SQLite MCP Server
**Best For:** Development, testing, small applications

### 2. PostgreSQL MCP Server
**Best For:** Production applications, complex queries, JSON operations

### 3. MySQL MCP Server (via generic database MCP)
**Best For:** Laravel applications using MySQL/MariaDB

---

## Installation & Setup

### SQLite MCP Server

```json
{
  "mcpServers": {
    "sqlite": {
      "command": "uvx",
      "args": ["mcp-server-sqlite", "--db-path", "/path/to/database.sqlite"]
    }
  }
}
```

**Laravel SQLite Configuration:**
```bash
# .env
DB_CONNECTION=sqlite
DB_DATABASE=/absolute/path/to/database/database.sqlite
```

### PostgreSQL MCP Server

```json
{
  "mcpServers": {
    "postgres": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres", "postgresql://user:password@localhost:5432/database"]
    }
  }
}
```

**Laravel PostgreSQL Configuration:**
```bash
# .env
DB_CONNECTION=pgsql
DB_HOST=127.0.0.1
DB_PORT=5432
DB_DATABASE=laravel
DB_USERNAME=postgres
DB_PASSWORD=password
```

### MySQL MCP Server (Generic Database MCP)

```json
{
  "mcpServers": {
    "mysql": {
      "command": "uvx",
      "args": ["mcp-server-database", "--connection-string", "mysql://user:password@localhost:3306/database"]
    }
  }
}
```

**Laravel MySQL Configuration:**
```bash
# .env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=root
DB_PASSWORD=password
```

---

## Core Database Operations

### 1. Schema Inspection

#### List Tables
```bash
# List all tables
mcp__database__list_tables

# Get table details
mcp__database__describe_table --table="users"
mcp__database__describe_table --table="posts"
```

#### Inspect Columns
```bash
# Get column information
mcp__database__get_columns --table="posts"

# Expected output:
# - id (bigint, primary key, auto_increment)
# - user_id (bigint, foreign key)
# - title (varchar(255))
# - content (text)
# - published_at (timestamp, nullable)
# - created_at (timestamp)
# - updated_at (timestamp)
# - deleted_at (timestamp, nullable)
```

#### Inspect Indexes
```bash
# List indexes on table
mcp__database__list_indexes --table="posts"

# Expected output:
# - PRIMARY (id)
# - posts_user_id_index (user_id)
# - posts_published_at_index (published_at)
```

#### Inspect Foreign Keys
```bash
# List foreign keys
mcp__database__list_foreign_keys --table="posts"

# Expected output:
# - posts_user_id_foreign: posts.user_id -> users.id
```

### 2. Query Execution

#### SELECT Queries
```bash
# Simple select
mcp__database__query --sql="SELECT * FROM users LIMIT 10"

# With conditions
mcp__database__query --sql="SELECT id, name, email FROM users WHERE email_verified_at IS NOT NULL"

# With joins
mcp__database__query --sql="SELECT posts.*, users.name as author 
FROM posts 
INNER JOIN users ON posts.user_id = users.id 
WHERE posts.published_at IS NOT NULL 
ORDER BY posts.created_at DESC 
LIMIT 20"
```

#### Aggregate Queries
```bash
# Count records
mcp__database__query --sql="SELECT COUNT(*) as total FROM posts"

# Group by analysis
mcp__database__query --sql="SELECT user_id, COUNT(*) as post_count 
FROM posts 
GROUP BY user_id 
ORDER BY post_count DESC"

# Statistics
mcp__database__query --sql="SELECT 
    COUNT(*) as total_posts,
    COUNT(DISTINCT user_id) as total_authors,
    AVG(LENGTH(content)) as avg_content_length
FROM posts"
```

### 3. Data Manipulation

#### INSERT
```bash
# Insert single record
mcp__database__query --sql="INSERT INTO posts (user_id, title, content, created_at, updated_at) 
VALUES (1, 'Test Post', 'Test content', NOW(), NOW())"

# Insert multiple records
mcp__database__query --sql="INSERT INTO tags (name, created_at, updated_at) VALUES 
('Laravel', NOW(), NOW()),
('Vue', NOW(), NOW()),
('Inertia', NOW(), NOW())"
```

#### UPDATE
```bash
# Update single record
mcp__database__query --sql="UPDATE users 
SET email_verified_at = NOW() 
WHERE id = 1"

# Bulk update
mcp__database__query --sql="UPDATE posts 
SET published_at = NOW() 
WHERE published_at IS NULL AND created_at < DATE_SUB(NOW(), INTERVAL 7 DAY)"
```

#### DELETE
```bash
# Delete with condition
mcp__database__query --sql="DELETE FROM posts 
WHERE deleted_at IS NOT NULL AND deleted_at < DATE_SUB(NOW(), INTERVAL 30 DAY)"

# Soft delete (Laravel pattern)
mcp__database__query --sql="UPDATE posts 
SET deleted_at = NOW() 
WHERE id = 123"
```

---

## Laravel-Specific Patterns

### 1. Migration Verification

```bash
# Check migration status
mcp__database__query --sql="SELECT * FROM migrations ORDER BY batch DESC"

# Verify table was created
mcp__database__list_tables

# Check table structure matches migration
mcp__database__describe_table --table="posts"
```

### 2. Eloquent Relationship Debugging

```bash
# Verify foreign key exists
mcp__database__list_foreign_keys --table="posts"

# Check relationship data
mcp__database__query --sql="SELECT 
    u.id as user_id,
    u.name,
    COUNT(p.id) as post_count
FROM users u
LEFT JOIN posts p ON u.id = p.user_id
GROUP BY u.id, u.name"

# Find orphaned records
mcp__database__query --sql="SELECT p.* 
FROM posts p 
LEFT JOIN users u ON p.user_id = u.id 
WHERE u.id IS NULL"
```

### 3. Performance Analysis

```bash
# Find slow query patterns
mcp__database__query --sql="EXPLAIN SELECT posts.*, users.name 
FROM posts 
INNER JOIN users ON posts.user_id = users.id 
WHERE posts.published_at > DATE_SUB(NOW(), INTERVAL 30 DAY)"

# Check index usage
mcp__database__query --sql="SHOW INDEX FROM posts"

# Analyze table statistics
mcp__database__query --sql="SELECT 
    table_name,
    table_rows,
    avg_row_length,
    data_length,
    index_length,
    (data_length + index_length) as total_size
FROM information_schema.TABLES 
WHERE table_schema = DATABASE()"
```

### 4. Data Seeding Verification

```bash
# Check seeded data
mcp__database__query --sql="SELECT COUNT(*) as count FROM users"
mcp__database__query --sql="SELECT COUNT(*) as count FROM posts"

# Verify relationships
mcp__database__query --sql="SELECT 
    (SELECT COUNT(*) FROM users) as users,
    (SELECT COUNT(*) FROM posts) as posts,
    (SELECT COUNT(*) FROM comments) as comments"

# Check data integrity
mcp__database__query --sql="SELECT COUNT(*) as orphaned_posts
FROM posts p
LEFT JOIN users u ON p.user_id = u.id
WHERE u.id IS NULL"
```

### 5. Queue Table Management

```bash
# Check queue status
mcp__database__query --sql="SELECT 
    queue,
    COUNT(*) as pending_jobs
FROM jobs 
GROUP BY queue"

# Check failed jobs
mcp__database__query --sql="SELECT * FROM failed_jobs ORDER BY failed_at DESC LIMIT 10"

# Clear old completed jobs
mcp__database__query --sql="DELETE FROM jobs WHERE created_at < DATE_SUB(NOW(), INTERVAL 7 DAY)"
```

---

## Advanced Patterns

### 1. Database Migrations Debugging

```bash
# Check if migration ran
mcp__database__query --sql="SELECT * FROM migrations WHERE migration LIKE '%create_posts_table%'"

# Find missing migrations
mcp__database__query --sql="SELECT batch, COUNT(*) as migrations 
FROM migrations 
GROUP BY batch 
ORDER BY batch"

# Check rollback state
mcp__database__query --sql="SELECT MAX(batch) as last_batch FROM migrations"
```

### 2. Complex Query Optimization

```bash
# Before optimization - N+1 detection
mcp__database__query --sql="SELECT id, title FROM posts"
# (Then multiple queries for each post's user)

# After optimization - eager loading verification
mcp__database__query --sql="SELECT posts.*, users.name 
FROM posts 
INNER JOIN users ON posts.user_id = users.id"

# Analyze query performance
mcp__database__query --sql="EXPLAIN ANALYZE SELECT posts.*, users.name 
FROM posts 
INNER JOIN users ON posts.user_id = users.id 
WHERE posts.published_at > DATE_SUB(NOW(), INTERVAL 30 DAY)"
```

### 3. Data Integrity Checks

```bash
# Check for duplicate emails
mcp__database__query --sql="SELECT email, COUNT(*) as count 
FROM users 
GROUP BY email 
HAVING count > 1"

# Verify unique constraints
mcp__database__query --sql="SELECT constraint_name, column_name 
FROM information_schema.key_column_usage 
WHERE table_schema = DATABASE() 
AND table_name = 'users' 
AND constraint_name LIKE '%unique%'"

# Check referential integrity
mcp__database__query --sql="SELECT 
    COUNT(*) as broken_references 
FROM posts p 
LEFT JOIN users u ON p.user_id = u.id 
WHERE u.id IS NULL"
```

### 4. Full-Text Search Setup (MySQL)

```bash
# Check full-text indexes
mcp__database__query --sql="SHOW INDEX FROM posts WHERE Index_type = 'FULLTEXT'"

# Create full-text index
mcp__database__query --sql="ALTER TABLE posts ADD FULLTEXT INDEX posts_fulltext (title, content)"

# Test full-text search
mcp__database__query --sql="SELECT id, title, MATCH(title, content) AGAINST('laravel inertia') as relevance 
FROM posts 
WHERE MATCH(title, content) AGAINST('laravel inertia' IN NATURAL LANGUAGE MODE) 
ORDER BY relevance DESC"
```

### 5. JSON Column Operations (PostgreSQL/MySQL 5.7+)

```bash
# Query JSON data
mcp__database__query --sql="SELECT id, name, metadata->>'$.role' as role 
FROM users 
WHERE metadata->>'$.active' = 'true'"

# Update JSON data
mcp__database__query --sql="UPDATE users 
SET metadata = JSON_SET(metadata, '$.last_login', NOW()) 
WHERE id = 1"

# Search in JSON arrays
mcp__database__query --sql="SELECT * FROM posts 
WHERE JSON_CONTAINS(tags, '\"laravel\"')"
```

---

## Laravel Telescope Integration

### Query Performance Monitoring

```bash
# Check slow queries from Telescope
mcp__database__query --sql="SELECT 
    content,
    time,
    created_at 
FROM telescope_entries 
WHERE type = 'query' 
AND time > 1000 
ORDER BY time DESC 
LIMIT 20"

# Analyze query patterns
mcp__database__query --sql="SELECT 
    JSON_EXTRACT(content, '$.sql') as query_pattern,
    COUNT(*) as execution_count,
    AVG(time) as avg_time
FROM telescope_entries
WHERE type = 'query'
GROUP BY query_pattern
ORDER BY execution_count DESC
LIMIT 10"
```

---

## Database Backup Patterns

### Export Data
```bash
# Export specific table data
mcp__database__query --sql="SELECT * FROM posts INTO OUTFILE '/tmp/posts_backup.csv' 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '\"' 
LINES TERMINATED BY '\n'"

# Get table creation SQL
mcp__database__query --sql="SHOW CREATE TABLE posts"
```

### Data Verification
```bash
# Compare record counts
mcp__database__query --sql="SELECT 
    'users' as table_name, COUNT(*) as count FROM users
UNION ALL
SELECT 'posts', COUNT(*) FROM posts
UNION ALL
SELECT 'comments', COUNT(*) FROM comments"

# Check data consistency
mcp__database__query --sql="SELECT 
    (SELECT COUNT(*) FROM posts WHERE deleted_at IS NULL) as active_posts,
    (SELECT COUNT(*) FROM posts WHERE deleted_at IS NOT NULL) as deleted_posts,
    (SELECT COUNT(*) FROM posts) as total_posts"
```

---

## Integration with Other MCP Servers

### With Serena (Code Analysis)

```bash
# 1. Use Database to find performance issues
mcp__database__query --sql="EXPLAIN SELECT * FROM posts WHERE user_id IN (SELECT id FROM users)"

# 2. Use Serena to analyze related models
mcp__serena__get_symbols_overview --relative_path="app/Models/Post.php"

# 3. Optimize based on findings
```

### With Zen (Performance Analysis)

```bash
# 1. Get query performance data
mcp__database__query --sql="SELECT content, time FROM telescope_entries WHERE type = 'query' AND time > 1000"

# 2. Analyze with Zen
mcp__zen__analyze --input="Analyze these slow queries and suggest optimizations"

# 3. Implement optimizations
```

### With Laravel Boost (Direct Laravel Integration)

```bash
# Use Laravel Boost for more convenient database operations
mcp__boost__tinker --code="DB::table('posts')->count()"
mcp__boost__tinker --code="Post::with('user')->latest()->take(10)->get()"
```

---

## Best Practices

### 1. Query Safety

```bash
# ✅ GOOD: Use parameterized queries (when available)
mcp__database__query --sql="SELECT * FROM users WHERE id = ?" --params="[1]"

# ❌ AVOID: String concatenation (SQL injection risk)
# Do not build queries with user input directly
```

### 2. Performance Monitoring

```bash
# ✅ GOOD: Regular performance checks
mcp__database__query --sql="SELECT 
    table_name,
    table_rows,
    ROUND(data_length / 1024 / 1024, 2) as data_mb,
    ROUND(index_length / 1024 / 1024, 2) as index_mb
FROM information_schema.TABLES 
WHERE table_schema = DATABASE()
ORDER BY data_length DESC"
```

### 3. Index Verification

```bash
# ✅ GOOD: Check indexes after migrations
mcp__database__list_indexes --table="posts"

# Verify foreign key indexes exist
mcp__database__query --sql="SELECT 
    table_name,
    column_name,
    constraint_name
FROM information_schema.key_column_usage
WHERE table_schema = DATABASE()
AND referenced_table_name IS NOT NULL"
```

### 4. Data Integrity

```bash
# ✅ GOOD: Regular integrity checks
mcp__database__query --sql="SELECT 
    'orphaned_posts' as issue,
    COUNT(*) as count
FROM posts p
LEFT JOIN users u ON p.user_id = u.id
WHERE u.id IS NULL

UNION ALL

SELECT 
    'orphaned_comments',
    COUNT(*)
FROM comments c
LEFT JOIN posts p ON c.post_id = p.id
WHERE p.id IS NULL"
```

---

## Troubleshooting

### Connection Issues

```bash
# Test connection
mcp__database__query --sql="SELECT 1"

# Check database version
mcp__database__query --sql="SELECT VERSION()"

# Verify Laravel can connect (use Laravel Boost)
mcp__boost__tinker --code="DB::connection()->getPdo()"
```

### Query Errors

```bash
# Check table exists
mcp__database__list_tables

# Verify column names
mcp__database__describe_table --table="posts"

# Test query syntax
mcp__database__query --sql="SELECT 1 as test"
```

### Performance Issues

```bash
# Check slow query log (MySQL)
mcp__database__query --sql="SHOW VARIABLES LIKE 'slow_query%'"

# Analyze table
mcp__database__query --sql="ANALYZE TABLE posts"

# Optimize table
mcp__database__query --sql="OPTIMIZE TABLE posts"
```

---

## Real-World Examples

### Example 1: Debug N+1 Query

```bash
# 1. Identify the issue
mcp__database__query --sql="SELECT * FROM telescope_entries 
WHERE type = 'query' 
AND content LIKE '%SELECT * FROM users WHERE id = %'
ORDER BY created_at DESC 
LIMIT 20"

# 2. Find the source
# Use Serena to find where the query is executed

# 3. Verify fix
mcp__database__query --sql="SELECT posts.*, users.name 
FROM posts 
INNER JOIN users ON posts.user_id = users.id"
```

### Example 2: Optimize Slow Query

```bash
# 1. Analyze query
mcp__database__query --sql="EXPLAIN SELECT * FROM posts 
WHERE published_at > DATE_SUB(NOW(), INTERVAL 30 DAY) 
AND user_id IN (SELECT id FROM users WHERE email_verified_at IS NOT NULL)"

# 2. Check if index exists
mcp__database__list_indexes --table="posts"

# 3. Add missing index
mcp__database__query --sql="CREATE INDEX posts_published_at_user_id_index 
ON posts(published_at, user_id)"

# 4. Re-analyze
mcp__database__query --sql="EXPLAIN SELECT * FROM posts 
WHERE published_at > DATE_SUB(NOW(), INTERVAL 30 DAY) 
AND user_id IN (SELECT id FROM users WHERE email_verified_at IS NOT NULL)"
```

---

## Related Resources

- **[Laravel Boost Guide](laravel-boost-guide.md)** - Laravel-specific utilities including Tinker
- **[Serena Guide](serena-guide.md)** - Code analysis for database-related code
- **[Performance Specialist](.claude/agents/performance-specialist.md)** - Database optimization strategies
- **[Database Architect](.claude/agents/database-architect.md)** - Schema design and migrations

---

**Pro Tip**: Use Database MCP servers for direct database inspection and debugging, but prefer Laravel Boost's Tinker integration for operations that should respect Laravel's ORM logic (events, observers, scopes, etc.).
