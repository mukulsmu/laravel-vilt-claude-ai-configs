# Serena MCP Server Guide

**Primary Purpose**: Semantic code analysis, intelligent navigation, and symbol-based code editing

## Overview

The Serena MCP Server provides advanced code analysis and navigation capabilities that enable intelligent, token-efficient exploration of codebases. It's designed to help you understand code structure, relationships, and patterns without reading entire files unnecessarily.

## Core Philosophy

**"Read Less, Understand More"** - Serena helps you intelligently acquire only the information needed for your task through:
- **Symbol-based exploration** instead of full file reading
- **Relationship mapping** to understand code dependencies
- **Pattern-based searching** for targeted information discovery
- **Semantic understanding** of code structure and organization

## Tool Categories

### 1. Discovery & Exploration Tools

#### `mcp__serena__list_dir`
**Purpose**: List files and directories with gitignore awareness
```bash
# Explore project structure
mcp__serena__list_dir --relative_path="." --recursive=true

# Check specific directory
mcp__serena__list_dir --relative_path="app/Services" --recursive=false
```

**Best Practices:**
- Use to understand project structure before diving into code
- Set `recursive=false` for focused exploration
- Combine with memory system to document structure understanding

#### `mcp__serena__find_file`
**Purpose**: Find files matching patterns with wildcards
```bash
# Find all controller files
mcp__serena__find_file --relative_path="." --file_mask="*Controller.php"

# Find specific configuration files
mcp__serena__find_file --relative_path="config" --file_mask="*.php"
```

**Best Practices:**
- Use wildcards effectively: `*Test.php`, `*Service.php`, `*Controller.php`
- Start broad, then narrow down search scope
- Combine with symbol overview to understand found files

### 2. Code Understanding Tools

#### `mcp__serena__get_symbols_overview`
**Purpose**: Get high-level understanding of code symbols in files/directories
```bash
# Overview of service directory
mcp__serena__get_symbols_overview --relative_path="app/Services/Agents"

# Understand specific file structure
mcp__serena__get_symbols_overview --relative_path="app/Models/User.php"
```

**Best Practices:**
- **ALWAYS use this before reading entire files**
- Start with directories to understand organization
- Use for files you're unfamiliar with
- Document discoveries in memory system

#### `mcp__serena__find_symbol`
**Purpose**: Find specific symbols with powerful path-based matching
```bash
# Find specific method in class
mcp__serena__find_symbol --name_path="AgentExecutor/execute" --include-body=true

# Find all methods in a class
mcp__serena__find_symbol --name_path="User" --depth=1

# Find symbols by pattern
mcp__serena__find_symbol --name_path="create" --substring_matching=true
```

**Name Path Patterns:**
- `"method"` - Match any method named "method" anywhere
- `"Class/method"` - Method must be in Class (or nested within Class)
- `"/Class/method"` - Absolute path: method in top-level Class only
- Use `depth=1` to see class methods without their bodies
- Use `include_body=true` only when you need the implementation

**Best Practices:**
- Use without `include_body` first to understand structure
- Add `depth=1` for class methods overview
- Use `substring_matching` for partial name searches
- Restrict with `relative_path` when you know the location

#### `mcp__serena__find_referencing_symbols`
**Purpose**: Find all references to a specific symbol
```bash
# Find where a method is used
mcp__serena__find_referencing_symbols --name_path="execute" --relative_path="app/Services/AgentExecutor.php"

# Understand usage patterns
mcp__serena__find_referencing_symbols --name_path="KnowledgeDocument" --relative_path="app/Models/KnowledgeDocument.php"
```

**Best Practices:**
- Use before refactoring to understand impact
- Essential for understanding code relationships
- Helps identify integration points
- Use with memory system to document usage patterns

### 3. Search & Pattern Discovery

#### `mcp__serena__search_for_pattern`
**Purpose**: Flexible regex-based search across codebase
```bash
# Find specific patterns
mcp__serena__search_for_pattern --substring_pattern="dispatch\(['\"].*['\"]" --restrict_search_to_code_files=true

# Search in specific area
mcp__serena__search_for_pattern --substring_pattern="validation.*rules" --relative_path="app/Livewire"

# Find configuration patterns
mcp__serena__search_for_pattern --substring_pattern="config\(['\"].*['\"]" --paths_include_glob="**/*.php"
```

**Pattern Examples:**
- `"function\s+\w+"` - Find function definitions
- `"class\s+\w+.*extends"` - Find class inheritance
- `"dispatch\(['\"].*['\"]"` - Find event dispatches
- `"->with\(.*\)"` - Find relationship eager loading

**Best Practices:**
- Use `restrict_search_to_code_files=true` for code analysis
- Combine with glob patterns for targeted searches
- Use context lines for better understanding
- Document discovered patterns in memory

### 4. Code Editing Tools

#### `mcp__serena__replace_symbol_body`
**Purpose**: Replace entire symbol definitions (classes, methods, functions)
```bash
# Replace entire method implementation
mcp__serena__replace_symbol_body --name_path="User/getName" --relative_path="app/Models/User.php" --body="public function getName(): string
{
    return $this->first_name . ' ' . $this->last_name;
}"
```

**Best Practices:**
- Use for complete method/class replacements
- Maintain proper indentation in body
- Don't include leading indentation for first line
- Ideal for architectural changes

#### `mcp__serena__insert_after_symbol`
**Purpose**: Insert code after a symbol definition
```bash
# Add new method after existing method
mcp__serena__insert_after_symbol --name_path="User/getName" --relative_path="app/Models/User.php" --body="
    public function getFullName(): string
    {
        return trim($this->getName());
    }"
```

#### `mcp__serena__insert_before_symbol`
**Purpose**: Insert code before a symbol definition
```bash
# Add import before first class
mcp__serena__insert_before_symbol --name_path="UserController" --relative_path="app/Http/Controllers/UserController.php" --body="use App\Services\UserService;
"
```

#### `mcp__serena__replace_regex`
**Purpose**: Targeted regex-based replacements
```bash
# Replace specific code patterns
mcp__serena__replace_regex --relative_path="app/Services/Example.php" --regex="old_method_call\([^)]*\)" --repl="new_method_call()" --allow_multiple_occurrences=true
```

**Best Practices:**
- Use for small, targeted changes within symbols
- Use wildcards: `.*?` for non-greedy matching
- Test regex patterns carefully
- Use `allow_multiple_occurrences` when appropriate

### 5. Memory Management Tools

#### `mcp__serena__write_memory`
**Purpose**: Document discoveries and decisions
```bash
# Document architectural understanding
mcp__serena__write_memory --memory_name="agent_system_architecture" --content="# Agent System Architecture

## Core Components
- AgentExecutor: Main orchestration service
- StreamingController: Real-time response handling
- Tool implementations in app/Tools/

## Key Patterns
- All agents follow execution pipeline pattern
- Tools use Prism-PHP type-safe definitions
- Status updates via Laravel broadcasting"
```

#### `mcp__serena__read_memory`
**Purpose**: Retrieve documented knowledge
```bash
# Read previous discoveries
mcp__serena__read_memory --memory_file_name="agent_system_architecture"
```

#### `mcp__serena__list_memories`
**Purpose**: See available memory files
```bash
mcp__serena__list_memories
```

## Intelligent Workflow Patterns

### 1. New Codebase Exploration Workflow
```bash
# Step 1: Understand overall structure
mcp__serena__list_dir --relative_path="." --recursive=true

# Step 2: Explore key directories
mcp__serena__get_symbols_overview --relative_path="app"
mcp__serena__get_symbols_overview --relative_path="app/Services"

# Step 3: Identify main components
mcp__serena__find_symbol --name_path="Controller" --substring_matching=true
mcp__serena__find_symbol --name_path="Service" --substring_matching=true

# Step 4: Document understanding
mcp__serena__write_memory --memory_name="codebase_overview" --content="[discoveries]"
```

### 2. Feature Implementation Exploration
```bash
# Step 1: Find similar existing implementations
mcp__serena__search_for_pattern --substring_pattern="similar_functionality" --restrict_search_to_code_files=true

# Step 2: Understand existing patterns
mcp__serena__find_symbol --name_path="ExistingFeature" --depth=1
mcp__serena__find_referencing_symbols --name_path="ExistingFeature" --relative_path="path/to/file"

# Step 3: Explore dependencies
mcp__serena__search_for_pattern --substring_pattern="use.*ExistingFeature"

# Step 4: Plan implementation based on patterns
mcp__serena__write_memory --memory_name="feature_implementation_plan" --content="[plan based on discoveries]"
```

### 3. Code Refactoring Exploration
```bash
# Step 1: Understand current implementation
mcp__serena__find_symbol --name_path="TargetClass" --include_body=true --depth=1

# Step 2: Find all usage points
mcp__serena__find_referencing_symbols --name_path="TargetClass" --relative_path="app/Models/TargetClass.php"

# Step 3: Understand integration patterns
mcp__serena__search_for_pattern --substring_pattern="TargetClass.*method" --restrict_search_to_code_files=true

# Step 4: Plan refactoring approach
mcp__serena__write_memory --memory_name="refactoring_strategy" --content="[refactoring plan with impact analysis]"
```

### 4. Bug Investigation Workflow
```bash
# Step 1: Find relevant code
mcp__serena__search_for_pattern --substring_pattern="error_symptom" --context_lines_before=3 --context_lines_after=3

# Step 2: Understand code structure
mcp__serena__get_symbols_overview --relative_path="path/to/suspected/file"

# Step 3: Analyze method implementations
mcp__serena__find_symbol --name_path="SuspectedMethod" --include_body=true

# Step 4: Check usage patterns
mcp__serena__find_referencing_symbols --name_path="SuspectedMethod" --relative_path="file/path"

# Step 5: Document investigation
mcp__serena__write_memory --memory_name="bug_investigation_findings" --content="[investigation results]"
```

## Advanced Usage Patterns

### Complex Symbol Path Matching
```bash
# Find nested methods
mcp__serena__find_symbol --name_path="OuterClass/InnerClass/method"

# Find methods across inheritance hierarchy
mcp__serena__find_symbol --name_path="BaseClass" --depth=2 --include_kinds=[5,6] # Classes and methods

# Find all constructors
mcp__serena__find_symbol --name_path="__construct" --substring_matching=true
```

### Intelligent Code Exploration
```bash
# Understand component relationships
mcp__serena__search_for_pattern --substring_pattern="implements.*Interface" --restrict_search_to_code_files=true

# Find design patterns
mcp__serena__search_for_pattern --substring_pattern="protected.*\$.*=" --relative_path="app/Models"

# Analyze configuration usage
mcp__serena__search_for_pattern --substring_pattern="config\(['\"].*['\"]" --paths_include_glob="**/*.php"
```

## Integration with Other MCP Servers

### Serena + Zen Server Workflows
```bash
# Use Serena for discovery, Zen for analysis
mcp__serena__get_symbols_overview --relative_path="app/Services/Complex"
# Then use findings for:
mcp__zen__analyze --files_checked=[discovered_files]
```

### Serena + Context7 Integration
```bash
# Understand existing patterns with Serena
mcp__serena__search_for_pattern --substring_pattern="Laravel.*pattern"

# Get current documentation with Context7
mcp__context7__resolve-library-id "laravel"
mcp__context7__get-library-docs [library_id] --topic="patterns"
```

## Performance Considerations

### Efficient Symbol Exploration
- **Start broad, narrow down**: Use overview before detailed symbol analysis
- **Limit depth appropriately**: Use `depth=0` for symbol discovery, `depth=1` for method lists
- **Use include_body sparingly**: Only include body when you need implementation details
- **Leverage caching**: Serena caches symbol information for performance

### Search Optimization
- **Restrict search scope**: Use `relative_path` to limit search area
- **Use appropriate file filters**: `restrict_search_to_code_files` for code analysis
- **Limit context lines**: Only use context lines when necessary
- **Pattern efficiency**: Use specific patterns rather than overly broad ones

## Common Pitfalls & Solutions

### ❌ Reading Entire Files Unnecessarily
```bash
# Don't do this for exploration
Read --file_path="app/Services/LargeService.php"

# Do this instead
mcp__serena__get_symbols_overview --relative_path="app/Services/LargeService.php"
mcp__serena__find_symbol --name_path="LargeService" --depth=1
```

### ❌ Inefficient Symbol Searches
```bash
# Don't search without context
mcp__serena__find_symbol --name_path="method" --substring_matching=true

# Do this instead
mcp__serena__find_symbol --name_path="method" --relative_path="specific/area" --substring_matching=true
```

### ❌ Missing Relationship Analysis
```bash
# Don't modify without understanding usage
mcp__serena__replace_symbol_body --name_path="method" --body="new implementation"

# Do this first
mcp__serena__find_referencing_symbols --name_path="method" --relative_path="file/path"
```

## Tool Selection Guidelines

### When to Use Serena vs. Other Tools

**Use Serena when:**
- Exploring unfamiliar code
- Understanding code structure and relationships
- Planning refactoring or architectural changes
- Implementing features following existing patterns
- Investigating bugs by understanding code flow

**Use Edit/MultiEdit when:**
- Making simple, targeted changes
- You already know exactly what to change
- Working with small, well-understood modifications
- Time efficiency is critical for simple edits

**Use Zen Server when:**
- Need systematic analysis workflows
- Quality assurance and code review
- Performance optimization analysis
- Security auditing
- Complex debugging requiring structured investigation

## Memory-Driven Development with Serena

### Capturing Architectural Insights
```bash
# Document system understanding
mcp__serena__write_memory --memory_name="database_patterns" --content="# Database Architecture Patterns

## Model Relationships
- User model uses UUID primary keys
- Soft deletes implemented for user data
- Pivot tables have additional metadata columns

## Performance Patterns
- Composite indexes for user_id + created_at queries
- Eager loading with select() for performance
- Chunked processing for large datasets"
```

### Building Knowledge Base
```bash
# Cross-reference discoveries
mcp__serena__write_memory --memory_name="livewire_patterns" --content="# Livewire Component Patterns

## Discovered Patterns
1. All components extend base component classes
2. Event communication via dispatch() method
3. Real-time updates use Laravel Echo integration
4. Validation follows $rules property pattern

## Integration Points
- Agent system: Components listen for execution events
- Knowledge system: Search components use RAG tools
- Database: Components use optimized query patterns (see database_patterns memory)"
```

## Success Metrics

### Effective Serena Usage
- **Reduced file reads**: Reading fewer complete files while maintaining understanding
- **Faster exploration**: Quickly understanding new code areas
- **Better refactoring**: Understanding all usage points before changes
- **Pattern recognition**: Identifying and following established patterns
- **Knowledge retention**: Building persistent understanding through memory system

## See Also

- **[Zen MCP Server Guide](zen-guide.md)** - Advanced analysis workflows
- **[Context7 MCP Server Guide](context7-guide.md)** - Documentation access
- **[Feature Development Workflow](../workflows/feature-development.md)** - Development integration
- **[AI Interaction Patterns](../reference/ai-interaction-patterns.md)** - Natural language usage