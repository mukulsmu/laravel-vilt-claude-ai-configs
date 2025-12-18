# Copilot Edits - Multi-File Editing

Comprehensive guide to using Copilot Edits for complex, multi-file refactoring and code changes across your Laravel VILT project.

## Overview

**Copilot Edits** is a powerful feature in VS Code that allows you to make AI-assisted changes across multiple files simultaneously. It's the closest equivalent to having an autonomous coding agent that can refactor entire features.

## Key Features

- ✅ **Multi-file editing** - Change code across unlimited files in one session
- ✅ **Context-aware** - Understands relationships between files
- ✅ **Preview changes** - Review all edits before applying
- ✅ **Iterative refinement** - Add instructions to refine changes
- ✅ **Undo/redo** - Revert individual changes or entire sessions

## Getting Started

### Activation

```plaintext
# In VS Code:
1. Press Ctrl/Cmd+Shift+I (or Ctrl/Cmd+I)
2. Or: View → Command Palette → "Copilot: Open Edits"
3. Or: Click the Copilot icon in left sidebar → "Edits"
```

### Interface Components

```
┌─────────────────────────────────────────┐
│ Copilot Edits                           │
├─────────────────────────────────────────┤
│ [Working Set] - Files to edit           │
│ - app/Models/User.php                   │
│ - app/Http/Controllers/UserController.  │
│ - resources/js/Pages/Users/Index.vue   │
├─────────────────────────────────────────┤
│ [Instructions] - What to change         │
│ Your editing instructions here...       │
├─────────────────────────────────────────┤
│ [Apply] [Cancel] [Add Instruction]      │
└─────────────────────────────────────────┘
```

## Use Cases

### 1. Feature Renaming

```plaintext
# Working Set: Select all relevant files
app/Models/Post.php
app/Http/Controllers/PostController.php
app/Http/Requests/StorePostRequest.php
resources/js/Pages/Posts/*.vue
routes/web.php
tests/Feature/PostTest.php

# Instructions:
"Rename the Post model to Article throughout the entire codebase:
- Update class names
- Update file names
- Update imports
- Update route names
- Update test names
- Update all references in comments"
```

### 2. API Version Migration

```plaintext
# Working Set: Select API controllers
app/Http/Controllers/Api/*.php

# Instructions:
"Migrate all API controllers from v1 to v2:
- Add v2 namespace
- Update response formats to include metadata
- Add rate limiting attributes
- Update return type hints
- Maintain backward compatibility with v1"
```

### 3. Authentication System Refactor

```plaintext
# Working Set:
app/Http/Controllers/Auth/*.php
app/Services/AuthService.php (create)
app/Http/Middleware/Authenticate.php
resources/js/Pages/Auth/*.vue

# Instructions:
"Extract authentication logic from controllers to a new AuthService:
- Create app/Services/AuthService.php
- Move login, register, logout logic to service
- Update controllers to use the service
- Ensure all tests still pass
- Add proper dependency injection"
```

### 4. Component Library Migration

```plaintext
# Working Set:
resources/js/Components/**/*.vue
resources/js/Pages/**/*.vue

# Instructions:
"Migrate all Button components from custom implementation to shadcn-vue:
- Replace <Button> with <Button> from '@/Components/ui/button'
- Update prop names to match shadcn API (variant, size)
- Update event handlers to match new patterns
- Ensure styling is preserved
- Add proper imports"
```

### 5. Type Safety Enhancement

```plaintext
# Working Set:
resources/js/**/*.vue
resources/js/types/*.ts

# Instructions:
"Add TypeScript types to all Vue components:
- Define interfaces for all props
- Use defineProps<Interface>() syntax
- Create type files where needed
- Add proper imports
- Ensure strict type checking passes"
```

## Advanced Workflows

### Iterative Refinement

```plaintext
# Initial instruction
"Add error handling to all API calls"

# Review generated changes, then add refinement:
"Also add loading states and retry logic"

# Further refinement:
"Add toast notifications for errors"

# Each instruction builds on previous changes
```

### Context-Specific Changes

```plaintext
# Working Set: Select parent and child components
resources/js/Components/UserProfile.vue
resources/js/Pages/Users/Show.vue
resources/js/Pages/Users/Edit.vue

# Instructions:
"Update UserProfile component API:
- Add new 'role' prop
- Propagate to all parent components
- Update prop types
- Add default value
- Update all usage sites"
```

### Systematic Code Quality Improvements

```plaintext
# Working Set: All controller files
app/Http/Controllers/**/*.php

# Instructions:
"Improve code quality across all controllers:
- Add strict return types
- Add PHPDoc blocks
- Use dependency injection consistently
- Extract complex logic to service classes
- Ensure proper exception handling"
```

## Best Practices

### 1. Start with Clear Working Set

```plaintext
✅ Good: Select specific files you want to change
❌ Bad: Leave working set empty hoping Copilot finds files

# Be explicit about scope
app/Models/User.php
app/Services/UserService.php
# Copilot will focus only on these files
```

### 2. Write Detailed Instructions

```plaintext
✅ Good:
"Refactor authentication:
1. Extract Auth logic to AuthService
2. Update LoginController to use service
3. Add proper error handling
4. Update tests to mock service
5. Ensure backward compatibility"

❌ Bad:
"Fix auth"
```

### 3. Review Before Applying

```plaintext
# Always review the diff view:
1. Check each file's changes
2. Verify no unintended modifications
3. Ensure changes are complete
4. Look for edge cases
```

### 4. Use Version Control

```plaintext
# Before starting major refactors:
git add .
git commit -m "Before Copilot Edits refactor"

# This allows easy rollback if needed
git diff  # Review Copilot's changes
git checkout . # Revert if needed
```

### 5. Break Down Large Changes

```plaintext
# Instead of one massive change:
❌ "Refactor entire authentication system"

# Break into steps:
✅ Step 1: "Extract logic to service"
✅ Step 2: "Update controllers"
✅ Step 3: "Update middleware"
✅ Step 4: "Update tests"
```

## Laravel VILT Specific Patterns

### Full-Stack Feature Changes

```plaintext
# Working Set: Complete feature stack
app/Models/Comment.php
app/Http/Controllers/CommentController.php
app/Http/Requests/StoreCommentRequest.php
resources/js/Pages/Comments/*.vue
resources/js/Components/CommentForm.vue

# Instructions:
"Add reply functionality to comments:
- Add parent_id to Comment model
- Update migrations
- Add replies relationship
- Update controller to handle nested comments
- Add ReplyForm component
- Update all Vue pages
- Add proper authorization"
```

### Inertia Response Standardization

```plaintext
# Working Set: All controllers
app/Http/Controllers/**/*.php

# Instructions:
"Standardize Inertia responses:
- Use consistent prop naming
- Always include 'meta' prop with pagination
- Add 'filters' prop to index pages
- Include 'flash' messages
- Add 'auth' user to all responses"
```

### Vue Composition API Migration

```plaintext
# Working Set: Old Vue components
resources/js/Components/Legacy/*.vue

# Instructions:
"Migrate from Options API to Composition API:
- Replace data() with ref/reactive
- Replace computed with computed()
- Replace methods with regular functions
- Update lifecycle hooks
- Use <script setup> syntax
- Maintain exact same functionality"
```

## Comparison to MCP Workflow

### Before (Claude + MCP)
```bash
# Multi-step manual process
1. mcp__serena__search_for_pattern "old pattern"
2. Review results
3. Claude generates changes
4. Apply changes manually or with custom scripts
5. Verify each file
```

### After (Copilot Edits)
```plaintext
# Single automated workflow
1. Select files in Working Set
2. Provide clear instructions
3. Review proposed changes
4. Click Apply
5. Done - all files updated simultaneously
```

## Troubleshooting

### Changes Not Applied

```plaintext
Problem: Copilot proposes changes but doesn't apply them
Solution:
1. Ensure files are not read-only
2. Check for merge conflicts
3. Verify files are in workspace
4. Reload VS Code window
```

### Incomplete Changes

```plaintext
Problem: Only some files are updated
Solution:
1. Add missing files to Working Set explicitly
2. Be more specific in instructions about which files
3. Use "Also update..." in follow-up instruction
```

### Unexpected Modifications

```plaintext
Problem: Changes to wrong files or wrong parts
Solution:
1. Be more specific in instructions
2. Reduce Working Set to only necessary files
3. Use step-by-step approach
4. Review and reject specific changes
```

## Tips & Tricks

### 1. Use File Patterns

```plaintext
# Instead of selecting each file:
Add pattern to Working Set: "app/Http/Controllers/*Controller.php"
Copilot will work with all matching files
```

### 2. Reference Existing Patterns

```plaintext
"Update all API controllers to follow the pattern used in UserController:
- Same response format
- Same error handling
- Same authorization checks"
```

### 3. Progressive Enhancement

```plaintext
# Start simple:
"Add basic error handling"

# Then enhance:
"Add logging to error handlers"

# Then refine:
"Add custom exception classes for specific errors"
```

### 4. Combine with Chat

```plaintext
# Step 1: Plan in Chat
"How should I refactor the authentication system?"

# Step 2: Use plan in Edits
[Paste the plan as instructions in Copilot Edits]

# Step 3: Execute and refine
```

## Performance Tips

### 1. Limit Working Set Size

```plaintext
✅ 5-10 files: Fast, accurate
⚠️ 20-30 files: Slower, may miss details
❌ 50+ files: Very slow, unreliable

# For large refactors, break into batches
```

### 2. Be Specific About Scope

```plaintext
❌ "Update the entire codebase"
✅ "Update all controller files in app/Http/Controllers"
```

### 3. Use Incremental Approach

```plaintext
# Better results with:
1. Small, focused changes
2. Review and commit
3. Next small change
4. Review and commit

# Than:
1. One massive change
2. Pray it works
```

## Integration with Other Features

### With @workspace

```plaintext
# Step 1: Discover with @workspace
@workspace "Find all components using old Form pattern"

# Step 2: Add results to Working Set
# Select the files Copilot identified

# Step 3: Apply changes with Edits
"Update all forms to use new Inertia useForm pattern"
```

### With Copilot Chat

```plaintext
# Step 1: Design in Chat
"Design a pattern for consistent API error handling"

# Step 2: Get code examples
"Show me the implementation for one controller"

# Step 3: Apply to all with Edits
"Apply this pattern to all API controllers"
```

### With Version Control

```plaintext
# Create branch
git checkout -b refactor/auth-service

# Use Copilot Edits
[Make changes with Copilot Edits]

# Review diff
git diff

# Commit if good
git add .
git commit -m "Refactor: Extract auth logic to service"
```

## Summary

**Copilot Edits** is the Copilot equivalent to having an autonomous coding agent that can:
- Refactor across multiple files
- Maintain consistency across changes
- Understand relationships between files
- Apply complex transformations systematically

It's particularly powerful for Laravel VILT projects where changes often span PHP controllers, Vue components, and configuration files.

---

**Pro Tip**: Combine Copilot Edits with version control. Make a commit before major refactors, review the diff after, and you can always revert if needed.
