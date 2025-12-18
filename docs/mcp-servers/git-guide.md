# Git MCP Server Guide

**Primary Purpose**: Version control automation, commit management, and workflow optimization for Laravel projects

## Overview

The Git MCP Server provides comprehensive Git operations that integrate with AI-assisted development workflows. It enables automated commit messages, branch management, PR assistance, and intelligent version control strategies.

## Installation & Setup

### Configure Git MCP Server

Add to your Claude Code configuration (`~/.config/claude-code/config.json`):

```json
{
  "mcpServers": {
    "git": {
      "command": "uvx",
      "args": ["mcp-server-git", "--repository", "/path/to/your/laravel/project"]
    }
  }
}
```

### Verify Installation

```bash
# Test Git MCP connection
claude "Use mcp__git__status to show repository status"
```

---

## Core Git Operations

### 1. Repository Status & Information

#### Get Status
```bash
# View working directory status
mcp__git__status

# Check for uncommitted changes
mcp__git__diff_staged  # Staged changes
mcp__git__diff_unstaged  # Unstaged changes
```

#### Branch Information
```bash
# List all branches
mcp__git__branch_list

# Get current branch
mcp__git__branch_current

# Show commit history
mcp__git__log --limit=10
```

### 2. Branch Management

#### Create & Switch Branches
```bash
# Create feature branch
mcp__git__branch_create --name="feature/user-authentication"

# Switch branches
mcp__git__checkout --branch="feature/user-authentication"

# Create and switch in one command
mcp__git__checkout --branch="feature/new-feature" --create=true
```

#### Branch Strategies
```bash
# Feature branches
mcp__git__branch_create --name="feature/posts-crud"
mcp__git__branch_create --name="feature/user-profiles"

# Fix branches
mcp__git__branch_create --name="fix/authentication-bug"

# Refactor branches
mcp__git__branch_create --name="refactor/service-layer"
```

### 3. Staging & Committing

#### Stage Files
```bash
# Stage specific files
mcp__git__add --files="app/Models/User.php,database/migrations/2024_01_01_create_users_table.php"

# Stage all changes
mcp__git__add --all=true

# Stage by pattern
mcp__git__add --files="app/Http/Controllers/*.php"
```

#### Commit Changes
```bash
# Standard commit
mcp__git__commit --message="feat: Add user authentication system"

# Commit with detailed description
mcp__git__commit --message="feat: Add user authentication system

- Implement login/logout functionality
- Add password reset flow
- Integrate Laravel Breeze
- Add user profile management"

# Amend last commit
mcp__git__commit --amend=true --message="feat: Add user authentication system (updated)"
```

---

## Laravel-Specific Git Workflows

### 1. Feature Development Workflow

```bash
# 1. Create feature branch
mcp__git__checkout --branch="feature/blog-posts" --create=true

# 2. Work on feature (create files, write code)

# 3. Stage Laravel-specific files
mcp__git__add --files="app/Models/Post.php"
mcp__git__add --files="app/Http/Controllers/PostController.php"
mcp__git__add --files="database/migrations/2024_01_15_create_posts_table.php"
mcp__git__add --files="resources/js/Pages/Posts/Index.vue"

# 4. Commit with conventional commits
mcp__git__commit --message="feat: Add blog post CRUD functionality

- Create Post model and migration
- Add PostController with Inertia responses
- Create Vue components for post management
- Add routes for post operations"

# 5. Push to remote
mcp__git__push --remote="origin" --branch="feature/blog-posts"
```

### 2. Migration Management

```bash
# After creating migrations
mcp__git__add --files="database/migrations/*.php"
mcp__git__commit --message="db: Add posts and comments tables

- Create posts table with user relationship
- Create comments table with post relationship
- Add indexes for performance"

# After modifying migrations (before running)
mcp__git__add --files="database/migrations/2024_01_15_create_posts_table.php"
mcp__git__commit --message="fix: Correct posts table schema

- Fix user_id foreign key constraint
- Add missing published_at column
- Update indexes"
```

### 3. Frontend Asset Commits

```bash
# Vue components and styles
mcp__git__add --files="resources/js/Pages/**/*.vue"
mcp__git__add --files="resources/js/Components/**/*.vue"
mcp__git__add --files="resources/css/app.css"

mcp__git__commit --message="feat: Add post editor component

- Create rich text editor component
- Add image upload functionality
- Implement auto-save feature
- Style with Tailwind CSS"

# Configuration changes
mcp__git__add --files="vite.config.js,tsconfig.json"
mcp__git__commit --message="chore: Update Vite and TypeScript config

- Add Vue plugin configuration
- Update TypeScript paths
- Add development server proxy"
```

### 4. Dependency Updates

```bash
# After composer update
mcp__git__add --files="composer.json,composer.lock"
mcp__git__commit --message="chore: Update Laravel dependencies

- Update Laravel to 11.x
- Update Inertia.js adapter
- Update dev dependencies"

# After npm update
mcp__git__add --files="package.json,package-lock.json"
mcp__git__commit --message="chore: Update Node dependencies

- Update Vue to 3.4
- Update Inertia.js client
- Update Vite to latest"
```

---

## Conventional Commits for Laravel

### Commit Type Prefixes

```bash
# feat: New features
mcp__git__commit --message="feat: Add user profile editing"
mcp__git__commit --message="feat: Implement real-time notifications"

# fix: Bug fixes
mcp__git__commit --message="fix: Resolve authentication redirect loop"
mcp__git__commit --message="fix: Correct validation rules for post creation"

# refactor: Code improvements without changing functionality
mcp__git__commit --message="refactor: Extract service layer for user management"
mcp__git__commit --message="refactor: Optimize database queries with eager loading"

# perf: Performance improvements
mcp__git__commit --message="perf: Add indexes to posts table"
mcp__git__commit --message="perf: Implement Redis caching for user data"

# style: Code style changes
mcp__git__commit --message="style: Format code with Laravel Pint"
mcp__git__commit --message="style: Organize imports in Vue components"

# test: Testing changes
mcp__git__commit --message="test: Add integration tests for post creation"
mcp__git__commit --message="test: Add browser tests for authentication flow"

# docs: Documentation updates
mcp__git__commit --message="docs: Update API documentation"
mcp__git__commit --message="docs: Add inline documentation for services"

# chore: Maintenance tasks
mcp__git__commit --message="chore: Update dependencies"
mcp__git__commit --message="chore: Configure Laravel Herd environment"

# db: Database changes
mcp__git__commit --message="db: Add users table migration"
mcp__git__commit --message="db: Seed test data for development"
```

### Scope Examples (Laravel-specific)

```bash
# Model changes
mcp__git__commit --message="feat(models): Add Post model with relationships"

# Controller changes
mcp__git__commit --message="feat(controllers): Add PostController with CRUD methods"

# Frontend changes
mcp__git__commit --message="feat(vue): Add post editor component"

# API changes
mcp__git__commit --message="feat(api): Add RESTful endpoints for posts"

# Authentication
mcp__git__commit --message="fix(auth): Resolve session timeout issue"

# Admin panel
mcp__git__commit --message="feat(filament): Add custom post resource"
```

---

## Advanced Git Workflows

### 1. Interactive Staging

```bash
# Review changes before staging
mcp__git__diff_unstaged

# Stage specific hunks (via review)
# Use Serena to analyze changes, then stage selectively
mcp__git__add --files="app/Models/User.php"
```

### 2. Stash Management

```bash
# Stash work in progress
mcp__git__stash_save --message="WIP: User profile editing"

# List stashes
mcp__git__stash_list

# Apply stash
mcp__git__stash_apply --stash="stash@{0}"

# Pop stash (apply and remove)
mcp__git__stash_pop

# Drop stash
mcp__git__stash_drop --stash="stash@{0}"
```

### 3. Commit Amending & History Rewriting

```bash
# Amend last commit message
mcp__git__commit --amend=true --message="feat: Add user authentication (corrected)"

# Amend last commit with additional changes
mcp__git__add --files="app/Models/User.php"
mcp__git__commit --amend=true --no-edit=true

# Interactive rebase (use with caution)
mcp__git__rebase --interactive=true --base="HEAD~3"
```

### 4. Cherry-picking & Reverting

```bash
# Cherry-pick commit from another branch
mcp__git__cherry_pick --commit="abc123def"

# Revert commit
mcp__git__revert --commit="abc123def"

# Revert without committing (for review)
mcp__git__revert --commit="abc123def" --no-commit=true
```

---

## Integration with Development Workflow

### 1. Pre-commit Quality Gates

```bash
# Before committing, run quality checks
# 1. Check code style
./vendor/bin/pint --test

# 2. Run tests
php artisan test

# 3. Check frontend
npm run type-check
npm run build

# 4. If all pass, commit
mcp__git__add --all=true
mcp__git__commit --message="feat: Add new feature with quality checks"
```

### 2. Automated Commit Messages with AI

```bash
# Use Zen to generate commit message from changes
# 1. Get diff
mcp__git__diff_staged

# 2. Use Zen to analyze and generate message
mcp__zen__analyze --input="Generate conventional commit message for these changes"

# 3. Commit with generated message
mcp__git__commit --message="<generated message>"
```

### 3. Branch Naming Conventions

```bash
# Feature branches
mcp__git__branch_create --name="feature/LAR-123-user-authentication"
mcp__git__branch_create --name="feature/blog-post-crud"

# Bug fix branches
mcp__git__branch_create --name="fix/LAR-456-authentication-redirect"
mcp__git__branch_create --name="hotfix/critical-security-patch"

# Improvement branches
mcp__git__branch_create --name="improve/database-query-performance"
mcp__git__branch_create --name="refactor/service-layer-extraction"

# Documentation branches
mcp__git__branch_create --name="docs/api-documentation-update"
```

---

## Pull Request Workflows

### 1. PR Preparation

```bash
# 1. Ensure branch is up to date
mcp__git__fetch --remote="origin"
mcp__git__merge --branch="main"

# 2. Squash commits if needed (interactive rebase)
mcp__git__rebase --interactive=true --base="main"

# 3. Push to remote
mcp__git__push --remote="origin" --branch="feature/user-authentication" --force=true

# 4. Use Zen to generate PR description
mcp__zen__analyze --input="Generate PR description from commit history"
```

### 2. Code Review Integration

```bash
# After code review comments
# 1. Make requested changes

# 2. Commit fixes
mcp__git__add --all=true
mcp__git__commit --message="review: Address code review comments

- Refactor authentication logic
- Add missing type hints
- Improve error handling"

# 3. Push updates
mcp__git__push --remote="origin" --branch="feature/user-authentication"
```

### 3. Merge Strategies

```bash
# Merge feature branch to main
mcp__git__checkout --branch="main"
mcp__git__merge --branch="feature/user-authentication" --no-ff=true

# Squash merge (for clean history)
mcp__git__merge --branch="feature/user-authentication" --squash=true
mcp__git__commit --message="feat: Add user authentication system"

# Rebase merge (linear history)
mcp__git__checkout --branch="feature/user-authentication"
mcp__git__rebase --base="main"
mcp__git__checkout --branch="main"
mcp__git__merge --branch="feature/user-authentication" --ff-only=true
```

---

## Best Practices

### 1. Commit Frequency

```bash
# ✅ GOOD: Small, focused commits
mcp__git__commit --message="feat: Add User model"
mcp__git__commit --message="feat: Add UserController"
mcp__git__commit --message="feat: Add user routes"

# ❌ AVOID: Large, unfocused commits
mcp__git__commit --message="feat: Add user management system"  # Too broad
```

### 2. Commit Message Quality

```bash
# ✅ GOOD: Descriptive with context
mcp__git__commit --message="fix: Resolve N+1 query in post index

- Add eager loading for user relationship
- Add eager loading for comments count
- Improves page load time from 2s to 200ms"

# ❌ AVOID: Vague messages
mcp__git__commit --message="fix stuff"
mcp__git__commit --message="WIP"
mcp__git__commit --message="test"
```

### 3. Branch Hygiene

```bash
# Delete merged branches
mcp__git__branch_delete --name="feature/completed-feature"

# List stale branches
mcp__git__branch_list --merged=true

# Clean up remote branches
mcp__git__push --remote="origin" --delete=true --branch="feature/old-feature"
```

### 4. .gitignore for Laravel

```bash
# Essential Laravel .gitignore entries
echo "/vendor
/node_modules
/public/hot
/public/storage
/storage/*.key
.env
.env.backup
.phpunit.result.cache
Homestead.json
Homestead.yaml
npm-debug.log
yarn-error.log
/.idea
/.vscode" > .gitignore

mcp__git__add --files=".gitignore"
mcp__git__commit --message="chore: Update .gitignore for Laravel project"
```

---

## Troubleshooting

### Merge Conflicts

```bash
# View conflicted files
mcp__git__status

# Resolve conflicts manually, then
mcp__git__add --files="<conflicted-file>"
mcp__git__commit --message="merge: Resolve conflicts from main"
```

### Undo Commits

```bash
# Undo last commit (keep changes)
mcp__git__reset --soft="HEAD~1"

# Undo last commit (discard changes)
mcp__git__reset --hard="HEAD~1"

# Undo last commit (mixed - default)
mcp__git__reset --mixed="HEAD~1"
```

### Lost Commits

```bash
# View reflog
mcp__git__reflog

# Recover lost commit
mcp__git__checkout --commit="<commit-hash>"
mcp__git__branch_create --name="recovered-work"
```

---

## Integration with Other MCP Servers

### With Serena (Code Analysis)

```bash
# 1. Use Serena to analyze changes before committing
mcp__serena__get_symbols_overview --relative_path="app/Models"

# 2. Generate intelligent commit message
mcp__git__commit --message="refactor: Optimize Post model

Based on analysis:
- Extract query scopes
- Add relationship methods
- Improve performance"
```

### With Zen (Quality Assurance)

```bash
# Pre-commit review
mcp__zen__codereview --scope="staged-changes"

# If approved, commit
mcp__git__commit --message="feat: Add user profiles (reviewed by Zen)"
```

---

## Related Resources

- **[Git Workflow Agent](.claude/agents/git-specialist.md)** - Specialized git workflow assistance
- **[Feature Development Workflow](../workflows/feature-development.md)** - Complete development process
- **[Quality Assurance Workflow](../workflows/quality-assurance.md)** - Pre-commit quality gates

---

**Pro Tip**: Combine Git MCP with Zen's code review capabilities for intelligent commit message generation and automated quality gates before every commit.
