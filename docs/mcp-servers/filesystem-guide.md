# Filesystem MCP Server Guide

**Primary Purpose**: File operations, directory management, and file watching for Laravel development

## Overview

The Filesystem MCP Server provides comprehensive file system operations that integrate with AI-assisted development workflows. It enables automated file manipulation, directory management, file watching, and intelligent file organization.

## Installation & Setup

### Configure Filesystem MCP Server

Add to your Claude Code configuration (`~/.config/claude-code/config.json`):

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/path/to/your/laravel/project"]
    }
  }
}
```

### Verify Installation

```bash
# Test Filesystem MCP connection
claude "Use mcp__filesystem__list_directory to show project root"
```

---

## Core Operations

### 1. Directory Management

#### List Directory Contents
```bash
# List root directory
mcp__filesystem__list_directory --path="."

# List specific directory
mcp__filesystem__list_directory --path="app/Models"

# Recursive listing
mcp__filesystem__list_directory --path="resources/js" --recursive=true
```

#### Create Directories
```bash
# Create single directory
mcp__filesystem__create_directory --path="app/Services/Agents"

# Create nested directories
mcp__filesystem__create_directory --path="resources/js/Components/Custom/Cards"
```

#### Move/Rename Directories
```bash
# Rename directory
mcp__filesystem__move --source="app/Http/Livewire" --destination="app/Livewire"

# Move directory
mcp__filesystem__move --source="resources/js/old-components" --destination="resources/js/Components/Legacy"
```

### 2. File Operations

#### Read Files
```bash
# Read entire file
mcp__filesystem__read_file --path="config/app.php"

# Read specific lines
mcp__filesystem__read_file --path="routes/web.php" --start_line=10 --end_line=50
```

#### Write Files
```bash
# Create new file
mcp__filesystem__write_file --path="app/Services/UserService.php" --content="<?php

namespace App\\Services;

class UserService
{
    // Service implementation
}"

# Overwrite existing file
mcp__filesystem__write_file --path="config/services.php" --content="..." --overwrite=true
```

#### Copy Files
```bash
# Copy file
mcp__filesystem__copy --source="app/Models/User.php" --destination="app/Models/Admin.php"

# Copy with overwrite
mcp__filesystem__copy --source="config/app.php" --destination="config/app.backup.php" --overwrite=true
```

#### Delete Files
```bash
# Delete file
mcp__filesystem__delete_file --path="storage/logs/laravel-old.log"

# Delete multiple files
mcp__filesystem__delete_file --path="public/js/app.old.js"
mcp__filesystem__delete_file --path="public/css/app.old.css"
```

### 3. File Watching

#### Watch for Changes
```bash
# Watch specific directory
mcp__filesystem__watch --path="resources/js/Pages" --events="create,modify,delete"

# Watch with pattern
mcp__filesystem__watch --path="app/Models" --pattern="*.php" --events="modify"
```

#### Use Cases for File Watching
```bash
# Auto-reload when Vue components change
mcp__filesystem__watch --path="resources/js/Components" --events="modify"

# Monitor log files
mcp__filesystem__watch --path="storage/logs" --pattern="laravel.log" --events="modify"

# Track migration changes
mcp__filesystem__watch --path="database/migrations" --events="create,delete"
```

---

## Laravel-Specific Workflows

### 1. Model Generation Workflow

```bash
# Create model directory structure
mcp__filesystem__create_directory --path="app/Models/Traits"
mcp__filesystem__create_directory --path="app/Models/Observers"

# Generate model file
mcp__filesystem__write_file --path="app/Models/Post.php" --content="<?php

namespace App\\Models;

use Illuminate\\Database\\Eloquent\\Factories\\HasFactory;
use Illuminate\\Database\\Eloquent\\Model;
use Illuminate\\Database\\Eloquent\\SoftDeletes;

class Post extends Model
{
    use HasFactory, SoftDeletes;
    
    protected \\$fillable = [
        'title',
        'content',
        'user_id',
        'published_at',
    ];
    
    protected \\$casts = [
        'published_at' => 'datetime',
    ];
    
    public function user()
    {
        return \\$this->belongsTo(User::class);
    }
    
    public function comments()
    {
        return \\$this->hasMany(Comment::class);
    }
}"

# Generate factory
mcp__filesystem__write_file --path="database/factories/PostFactory.php" --content="..."
```

### 2. Vue Component Organization

```bash
# Create component structure
mcp__filesystem__create_directory --path="resources/js/Components/Posts"
mcp__filesystem__create_directory --path="resources/js/Components/Posts/Partials"

# Create index component
mcp__filesystem__write_file --path="resources/js/Components/Posts/PostCard.vue" --content="<template>
  <div class=\"post-card\">
    <h3>{{ post.title }}</h3>
    <p>{{ post.content }}</p>
  </div>
</template>

<script setup lang=\"ts\">
interface Props {
  post: {
    id: number
    title: string
    content: string
  }
}

defineProps<Props>()
</script>"

# Create related components
mcp__filesystem__write_file --path="resources/js/Components/Posts/PostList.vue" --content="..."
mcp__filesystem__write_file --path="resources/js/Components/Posts/Partials/PostHeader.vue" --content="..."
```

### 3. Configuration Management

```bash
# Read existing config
mcp__filesystem__read_file --path="config/app.php"

# Backup config before changes
mcp__filesystem__copy --source="config/app.php" --destination="config/app.backup.php"

# Update config
mcp__filesystem__write_file --path="config/app.php" --content="..." --overwrite=true

# Restore from backup if needed
mcp__filesystem__copy --source="config/app.backup.php" --destination="config/app.php" --overwrite=true
```

### 4. Log File Management

```bash
# Read recent logs
mcp__filesystem__read_file --path="storage/logs/laravel.log" --tail=100

# Archive old logs
mcp__filesystem__move --source="storage/logs/laravel.log" --destination="storage/logs/archive/laravel-$(date +%Y%m%d).log"

# Clear log file
mcp__filesystem__write_file --path="storage/logs/laravel.log" --content="" --overwrite=true

# Monitor logs in real-time
mcp__filesystem__watch --path="storage/logs/laravel.log" --events="modify"
```

### 5. Migration File Management

```bash
# List all migrations
mcp__filesystem__list_directory --path="database/migrations"

# Read specific migration
mcp__filesystem__read_file --path="database/migrations/2024_01_15_create_posts_table.php"

# Create new migration
mcp__filesystem__write_file --path="database/migrations/$(date +%Y_%m_%d_%H%M%S)_add_status_to_posts_table.php" --content="<?php

use Illuminate\\Database\\Migrations\\Migration;
use Illuminate\\Database\\Schema\\Blueprint;
use Illuminate\\Support\\Facades\\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('posts', function (Blueprint \\$table) {
            \\$table->string('status')->default('draft')->after('content');
            \\$table->index('status');
        });
    }
    
    public function down(): void
    {
        Schema::table('posts', function (Blueprint \\$table) {
            \\$table->dropColumn('status');
        });
    }
};"
```

---

## Advanced Patterns

### 1. Bulk File Operations

```bash
# Create multiple related files at once
# Controller
mcp__filesystem__write_file --path="app/Http/Controllers/PostController.php" --content="..."

# Request
mcp__filesystem__write_file --path="app/Http/Requests/StorePostRequest.php" --content="..."
mcp__filesystem__write_file --path="app/Http/Requests/UpdatePostRequest.php" --content="..."

# Resource
mcp__filesystem__write_file --path="app/Http/Resources/PostResource.php" --content="..."
```

### 2. Directory Structure Cloning

```bash
# Clone structure for new feature
mcp__filesystem__create_directory --path="app/Services/Reports"
mcp__filesystem__create_directory --path="app/Services/Reports/Generators"
mcp__filesystem__create_directory --path="app/Services/Reports/Exporters"
mcp__filesystem__create_directory --path="app/Services/Reports/Formatters"

# Copy template files
mcp__filesystem__copy --source="app/Services/Templates/BaseService.php" --destination="app/Services/Reports/ReportService.php"
```

### 3. Asset Organization

```bash
# Organize Vue components
mcp__filesystem__list_directory --path="resources/js/Components" --recursive=true

# Move to better structure
mcp__filesystem__move --source="resources/js/Components/UserCard.vue" --destination="resources/js/Components/Users/UserCard.vue"
mcp__filesystem__move --source="resources/js/Components/PostCard.vue" --destination="resources/js/Components/Posts/PostCard.vue"

# Group by feature
mcp__filesystem__create_directory --path="resources/js/Features"
mcp__filesystem__create_directory --path="resources/js/Features/Auth"
mcp__filesystem__create_directory --path="resources/js/Features/Posts"
mcp__filesystem__create_directory --path="resources/js/Features/Users"
```

### 4. Template-Based Generation

```bash
# Read template
mcp__filesystem__read_file --path=".templates/controller.stub"

# Generate from template (with replacements)
# Use Serena or Claude to perform template substitutions
# Then write generated file
mcp__filesystem__write_file --path="app/Http/Controllers/CommentController.php" --content="<generated-content>"
```

---

## Integration with Other MCP Servers

### With Serena (Code Analysis)

```bash
# 1. Use Filesystem to list files
mcp__filesystem__list_directory --path="app/Models"

# 2. Use Serena to analyze each model
mcp__serena__get_symbols_overview --relative_path="app/Models/User.php"

# 3. Use Filesystem to create optimized version
mcp__filesystem__write_file --path="app/Models/User.php" --content="<optimized-content>" --overwrite=true
```

### With Git (Version Control)

```bash
# 1. Use Filesystem to create files
mcp__filesystem__write_file --path="app/Services/PaymentService.php" --content="..."

# 2. Use Git to track
mcp__git__add --files="app/Services/PaymentService.php"
mcp__git__commit --message="feat: Add payment service"
```

### With Zen (Quality Assurance)

```bash
# 1. Use Filesystem to read file
mcp__filesystem__read_file --path="app/Http/Controllers/PostController.php"

# 2. Use Zen to analyze
mcp__zen__codereview --file="app/Http/Controllers/PostController.php"

# 3. Use Filesystem to apply improvements
mcp__filesystem__write_file --path="app/Http/Controllers/PostController.php" --content="<improved-content>" --overwrite=true
```

---

## Best Practices

### 1. File Safety

```bash
# ✅ GOOD: Backup before modifying critical files
mcp__filesystem__copy --source="config/app.php" --destination="config/app.backup.php"
mcp__filesystem__write_file --path="config/app.php" --content="..." --overwrite=true

# ❌ AVOID: Direct overwrite without backup
mcp__filesystem__write_file --path="config/app.php" --content="..." --overwrite=true
```

### 2. Directory Organization

```bash
# ✅ GOOD: Logical feature-based structure
resources/js/Features/
  Auth/
    Login.vue
    Register.vue
  Posts/
    Index.vue
    Create.vue
    Edit.vue

# ❌ AVOID: Flat structure
resources/js/Pages/
  Login.vue
  Register.vue
  PostIndex.vue
  PostCreate.vue
  PostEdit.vue
```

### 3. File Naming Conventions

```bash
# ✅ GOOD: Laravel conventions
app/Http/Controllers/PostController.php
app/Models/Post.php
app/Services/PostService.php
database/migrations/2024_01_15_create_posts_table.php

# ❌ AVOID: Inconsistent naming
app/Http/Controllers/post_controller.php
app/Models/PostModel.php
app/Services/post-service.php
```

### 4. Atomic Operations

```bash
# ✅ GOOD: Create all related files together
mcp__filesystem__write_file --path="app/Models/Post.php" --content="..."
mcp__filesystem__write_file --path="database/migrations/..._create_posts_table.php" --content="..."
mcp__filesystem__write_file --path="database/factories/PostFactory.php" --content="..."

# Track with Git immediately
mcp__git__add --all=true
mcp__git__commit --message="feat: Add Post model with migration and factory"
```

---

## Laravel Project Templates

### Standard Controller Structure
```bash
# Create complete controller structure
mcp__filesystem__create_directory --path="app/Http/Controllers/Api"
mcp__filesystem__create_directory --path="app/Http/Controllers/Admin"
mcp__filesystem__create_directory --path="app/Http/Controllers/Auth"

# Create base controllers
mcp__filesystem__write_file --path="app/Http/Controllers/Controller.php" --content="..."
mcp__filesystem__write_file --path="app/Http/Controllers/Api/ApiController.php" --content="..."
```

### Vue Component Library Structure
```bash
# Create component library
mcp__filesystem__create_directory --path="resources/js/Components/ui"
mcp__filesystem__create_directory --path="resources/js/Components/layouts"
mcp__filesystem__create_directory --path="resources/js/Components/forms"
mcp__filesystem__create_directory --path="resources/js/Components/data"

# Create index files
mcp__filesystem__write_file --path="resources/js/Components/ui/index.ts" --content="export * from './button'
export * from './input'
export * from './card'"
```

### Service Layer Structure
```bash
# Create service layer
mcp__filesystem__create_directory --path="app/Services"
mcp__filesystem__create_directory --path="app/Services/Contracts"
mcp__filesystem__create_directory --path="app/Services/Implementations"

# Create base service
mcp__filesystem__write_file --path="app/Services/BaseService.php" --content="..."
```

---

## Monitoring and Debugging

### Watch Development Files
```bash
# Watch Vue components for changes
mcp__filesystem__watch --path="resources/js" --pattern="*.vue" --events="modify"

# Watch PHP files
mcp__filesystem__watch --path="app" --pattern="*.php" --events="modify"

# Watch config files
mcp__filesystem__watch --path="config" --events="modify"
```

### Log Analysis
```bash
# Read error logs
mcp__filesystem__read_file --path="storage/logs/laravel.log" --tail=50

# Search for errors in logs
# (Use Serena search_for_pattern for advanced searching)

# Archive logs periodically
mcp__filesystem__move --source="storage/logs/laravel.log" --destination="storage/logs/archive/$(date +%Y%m%d).log"
```

---

## Troubleshooting

### Permission Issues

```bash
# Check file permissions (use terminal)
ls -la storage/logs/

# Fix permissions (Laravel standard)
chmod -R 775 storage bootstrap/cache
```

### File Not Found

```bash
# Verify file exists
mcp__filesystem__list_directory --path="app/Models"

# Check full path
mcp__filesystem__read_file --path="/full/absolute/path/to/file.php"
```

### Large File Handling

```bash
# Read large files in chunks
mcp__filesystem__read_file --path="storage/logs/laravel.log" --start_line=1 --end_line=100
mcp__filesystem__read_file --path="storage/logs/laravel.log" --start_line=101 --end_line=200

# Use tail for recent content
mcp__filesystem__read_file --path="storage/logs/laravel.log" --tail=100
```

---

## Real-World Examples

### Example 1: Feature Scaffold

```bash
# Create complete feature structure
# Models
mcp__filesystem__create_directory --path="app/Models"
mcp__filesystem__write_file --path="app/Models/Post.php" --content="..."

# Controllers
mcp__filesystem__create_directory --path="app/Http/Controllers"
mcp__filesystem__write_file --path="app/Http/Controllers/PostController.php" --content="..."

# Requests
mcp__filesystem__create_directory --path="app/Http/Requests"
mcp__filesystem__write_file --path="app/Http/Requests/StorePostRequest.php" --content="..."

# Resources
mcp__filesystem__create_directory --path="app/Http/Resources"
mcp__filesystem__write_file --path="app/Http/Resources/PostResource.php" --content="..."

# Vue Pages
mcp__filesystem__create_directory --path="resources/js/Pages/Posts"
mcp__filesystem__write_file --path="resources/js/Pages/Posts/Index.vue" --content="..."
mcp__filesystem__write_file --path="resources/js/Pages/Posts/Create.vue" --content="..."

# Tests
mcp__filesystem__create_directory --path="tests/Feature"
mcp__filesystem__write_file --path="tests/Feature/PostTest.php" --content="..."
```

### Example 2: Migration Management

```bash
# List migrations
mcp__filesystem__list_directory --path="database/migrations"

# Create new migration
mcp__filesystem__write_file --path="database/migrations/$(date +%Y_%m_%d_%H%M%S)_add_columns_to_users_table.php" --content="..."

# Backup migrations before modifying
mcp__filesystem__copy --source="database/migrations" --destination="database/migrations.backup"
```

### Example 3: Component Refactoring

```bash
# Read existing component
mcp__filesystem__read_file --path="resources/js/Components/OldComponent.vue"

# Create new structure
mcp__filesystem__create_directory --path="resources/js/Components/New"

# Write refactored component
mcp__filesystem__write_file --path="resources/js/Components/New/RefactoredComponent.vue" --content="..."

# Delete old component after verification
mcp__filesystem__delete_file --path="resources/js/Components/OldComponent.vue"
```

---

## Related Resources

- **[Serena Guide](serena-guide.md)** - Semantic code analysis
- **[Git Guide](git-guide.md)** - Version control automation
- **[DevOps Specialist](.claude/agents/devops-specialist.md)** - Infrastructure management
- **[Feature Development Workflow](../workflows/feature-development.md)** - Complete development process

---

**Pro Tip**: Combine Filesystem MCP with Serena for intelligent file operations - use Serena to analyze code structure, then use Filesystem to reorganize and refactor based on insights.
