# Copilot Workspace Context (@workspace)

Guide to using Copilot's `@workspace` feature for code navigation and analysis - the equivalent to Serena MCP's semantic code analysis.

## Overview

The `@workspace` agent provides context-aware assistance by understanding your entire codebase structure. It's built directly into GitHub Copilot and requires no additional installation.

## Core Capabilities

### 1. Symbol Search & Discovery

```plaintext
# Find specific types of code
@workspace "Find all controller classes"
@workspace "Show me all Vue components"
@workspace "List all Eloquent models with soft deletes"
@workspace "Find classes that implement Notifiable"
```

### 2. Pattern Recognition

```plaintext
# Search for coding patterns
@workspace "Show all places where we use whereHas queries"
@workspace "Find components using the useForm composable"
@workspace "List all routes that require authentication middleware"
@workspace "Show files that import Inertia"
```

### 3. Relationship Mapping

```plaintext
# Understand code relationships
@workspace "What files depend on UserService?"
@workspace "Show me all components that use the Button UI component"
@workspace "Which controllers use the StorePostRequest?"
@workspace "Map the relationships between models in app/Models"
```

### 4. Architecture Analysis

```plaintext
# High-level structure understanding
@workspace "Explain the service layer architecture"
@workspace "How is authentication implemented in this project?"
@workspace "What's the pattern for form validation?"
@workspace "Describe the Vue component organization structure"
```

## Comparison to Serena MCP

| Serena MCP | @workspace Equivalent |
|------------|----------------------|
| `mcp__serena__list_dir` | `@workspace "List files in app/Services"` |
| `mcp__serena__find_file` | `@workspace "Find *Controller.php files"` |
| `mcp__serena__get_symbols_overview` | `@workspace "Show symbols in UserController"` |
| `mcp__serena__search_for_pattern` | `@workspace /search "pattern here"` |
| `mcp__serena__get_symbol_info` | `@workspace "Explain the User::verified() scope"` |

## Advanced Usage

### Multi-File Analysis

```plaintext
# Analyze across multiple files
@workspace "Find all API endpoints and their authentication requirements"
@workspace "Show me the complete user registration flow across all files"
@workspace "List all database queries that could cause N+1 problems"
```

### Code Generation with Context

```plaintext
# Use workspace context for better generation
@workspace "Create a new ProductController following the patterns used in PostController"
@workspace "Generate a Vue component similar to UserProfile.vue but for products"
@workspace "Write tests for PaymentService following the existing test patterns"
```

### Refactoring Assistance

```plaintext
# Plan refactoring with full context
@workspace "I want to extract authentication logic to a service. Show me all files that would need changes"
@workspace "Help me consolidate duplicate validation rules across Form Requests"
@workspace "Identify opportunities to use Form Objects instead of Form Requests"
```

## Best Practices

### 1. Start Broad, Then Narrow

```plaintext
# Step 1: Get overview
@workspace "What's in the app/Services directory?"

# Step 2: Focus on specifics
@workspace "Explain how NotificationService works"

# Step 3: Dive into details
@workspace "Show me the implementation of NotificationService::sendEmail"
```

### 2. Combine with File References

```plaintext
# Reference specific files for context
@workspace #file:app/Models/User.php "How does this model relate to other models?"

# Multiple file context
@workspace #file:app/Http/Controllers/UserController.php #file:app/Services/UserService.php "How do these work together?"
```

### 3. Use for Code Reviews

```plaintext
# Pre-commit review
@workspace "Review my changes to the authentication system for security issues"

# Consistency check
@workspace "Are all my controllers following the same patterns?"

# Impact analysis
@workspace "What parts of the codebase might be affected by changing the User model?"
```

### 4. Architecture Documentation

```plaintext
# Generate documentation
@workspace "Create architectural documentation for the payment module"

# Explain decisions
@workspace "Why do we use repositories in the data layer?"

# Onboarding help
@workspace "Explain how a new feature should be structured in this project"
```

## Use Cases

### Feature Development

```plaintext
# Before starting
@workspace "How are similar features implemented? Show me the blog post feature structure"

# During development
@workspace "I'm creating a comment system. What existing patterns should I follow?"

# After implementation
@workspace "Review my comment feature implementation for consistency with project patterns"
```

### Debugging

```plaintext
# Finding issues
@workspace "Where could this authentication error be coming from?"

# Tracing execution
@workspace "Show me the full flow from UserController::login to the actual authentication"

# Impact assessment
@workspace "If I change this method, what else might break?"
```

### Testing

```plaintext
# Test planning
@workspace "What test coverage do we have for the payment system?"

# Test generation
@workspace "Generate tests for CommentController following the patterns in PostControllerTest"

# Gap analysis
@workspace "What parts of the UserService are not covered by tests?"
```

## Tips & Tricks

### 1. Use Specific Language

```plaintext
❌ "Show me stuff about users"
✅ "Show me all controller methods that handle user CRUD operations"

❌ "Find components"
✅ "Find all Vue components in resources/js/Components that use props"
```

### 2. Leverage IntelliSense Integration

```plaintext
# @workspace works with VS Code's symbol navigation
# Use together:
1. @workspace "Find UserService usages"
2. Ctrl/Cmd+Click on results to navigate
3. F12 for Go to Definition
4. Shift+F12 for Find All References
```

### 3. Iterate on Results

```plaintext
# Start general
@workspace "Show authentication-related code"

# Refine based on response
@workspace "Focus on the middleware that handles authentication"

# Get specific
@workspace "Explain how the AuthenticateMiddleware validates tokens"
```

### 4. Use for Learning

```plaintext
# Understand patterns
@workspace "Show me examples of Eloquent relationship definitions"

# Learn conventions
@workspace "What naming conventions does this project use for controllers?"

# Study implementations
@workspace "How does this project handle API versioning?"
```

## Limitations

1. **Context Window**: Large codebases may require focused queries
2. **Real-time Updates**: May not immediately reflect very recent changes
3. **Binary Files**: Cannot analyze images, PDFs, or compiled code
4. **Generated Code**: May not see code in ignored directories (node_modules, vendor)

## When to Use @workspace vs Other Tools

| Task | Use |
|------|-----|
| Code navigation | @workspace + IntelliSense |
| Symbol search | @workspace |
| Full-text search | VS Code Search (Ctrl/Cmd+Shift+F) |
| Git history | @github or Git extensions |
| Documentation | Ask Copilot directly |
| Multi-file edits | Copilot Edits panel |

## Integration with Copilot Edits

```plaintext
# Step 1: Analyze with @workspace
@workspace "Find all components using old Button implementation"

# Step 2: Plan changes
"Create a plan to migrate all Button usages to new shadcn Button"

# Step 3: Execute with Copilot Edits
# Open Edits panel (Ctrl/Cmd+Shift+I)
# Apply changes across multiple files simultaneously
```

## Comparison Summary

**Serena MCP** was designed for token-efficient code exploration with specific tools for each operation.

**@workspace** provides a natural language interface that combines multiple capabilities:
- Symbol search
- Pattern matching
- Relationship analysis
- Code understanding

Both achieve similar goals but with different approaches:
- **MCP**: Explicit tool calls, structured data
- **@workspace**: Natural language, conversational interface

---

For Laravel VILT development, `@workspace` combined with native IDE features (IntelliSense, Go to Definition) provides excellent code navigation without additional setup.
