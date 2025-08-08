# Context7 MCP Server Guide

**Primary Purpose**: Up-to-date library documentation retrieval and current best practices access

## Overview

The Context7 MCP Server provides access to current, authoritative documentation for libraries and frameworks. It's essential for staying current with best practices, verifying feature availability, and understanding proper implementation patterns for external dependencies.

## Core Philosophy

**"Current Knowledge, Correct Implementation"** - Context7 ensures:
- **Up-to-date documentation** from authoritative sources
- **Version-specific information** for accurate implementation
- **Best practices validation** for library usage
- **Feature availability confirmation** before implementation

## Tool Overview

### `mcp__context7__resolve-library-id`
**Purpose**: Find correct Context7-compatible library identifiers
```bash
# Find Laravel library identifier
mcp__context7__resolve-library-id --libraryName="laravel"

# Find Livewire documentation
mcp__context7__resolve-library-id --libraryName="livewire"

# Find FilamentPHP resources
mcp__context7__resolve-library-id --libraryName="filamentphp"
```

**Library Resolution Process:**
1. Analyzes library name for best matches
2. Returns Context7-compatible ID (e.g., `/laravel/docs`, `/vercel/next.js`)
3. Includes relevance scoring and description
4. Prioritizes libraries with comprehensive documentation

### `mcp__context7__get-library-docs`
**Purpose**: Retrieve up-to-date library documentation
```bash
# Get Laravel documentation
mcp__context7__get-library-docs --context7CompatibleLibraryID="/laravel/docs" --tokens=10000

# Get specific topic documentation
mcp__context7__get-library-docs --context7CompatibleLibraryID="/livewire/livewire" --topic="components" --tokens=5000

# Get version-specific docs
mcp__context7__get-library-docs --context7CompatibleLibraryID="/laravel/docs/v10.x"
```

**Documentation Features:**
- **Current Information**: Always up-to-date with latest releases
- **Focused Retrieval**: Topic-specific documentation for efficiency
- **Version Awareness**: Version-specific guidance when needed
- **Code Examples**: Practical implementation examples

## Essential Libraries for Laravel TALL Project

### Laravel Framework
```bash
# Get Laravel core documentation
mcp__context7__resolve-library-id --libraryName="laravel"
mcp__context7__get-library-docs --context7CompatibleLibraryID="/laravel/docs" --topic="eloquent"

# Specific Laravel features
mcp__context7__get-library-docs --context7CompatibleLibraryID="/laravel/docs" --topic="queues"
mcp__context7__get-library-docs --context7CompatibleLibraryID="/laravel/docs" --topic="broadcasting"
```

**Common Laravel Topics:**
- `eloquent` - Database ORM and relationships
- `migrations` - Database schema management
- `queues` - Background job processing
- `broadcasting` - Real-time event broadcasting
- `validation` - Input validation patterns
- `authentication` - User authentication systems
- `testing` - Application testing strategies

### Livewire Framework
```bash
# Livewire component documentation
mcp__context7__resolve-library-id --libraryName="livewire"
mcp__context7__get-library-docs --context7CompatibleLibraryID="/livewire/livewire" --topic="components"

# Livewire-specific features
mcp__context7__get-library-docs --context7CompatibleLibraryID="/livewire/livewire" --topic="properties"
mcp__context7__get-library-docs --context7CompatibleLibraryID="/livewire/livewire" --topic="events"
```

**Key Livewire Topics:**
- `components` - Component creation and structure
- `properties` - Property binding and reactivity
- `actions` - User interactions and methods
- `events` - Component communication
- `lifecycle` - Component lifecycle hooks
- `testing` - Component testing approaches

### FilamentPHP Framework
```bash
# FilamentPHP administration
mcp__context7__resolve-library-id --libraryName="filamentphp"
mcp__context7__get-library-docs --context7CompatibleLibraryID="/filamentphp/filament" --topic="resources"

# Filament components
mcp__context7__get-library-docs --context7CompatibleLibraryID="/filamentphp/filament" --topic="forms"
mcp__context7__get-library-docs --context7CompatibleLibraryID="/filamentphp/filament" --topic="tables"
```

**Essential Filament Topics:**
- `resources` - Resource creation and management
- `forms` - Form builder and validation
- `tables` - Data table configuration
- `pages` - Custom page creation
- `widgets` - Dashboard widgets
- `actions` - Custom actions and bulk operations

### Tailwind CSS
```bash
# Tailwind CSS documentation
mcp__context7__resolve-library-id --libraryName="tailwindcss"
mcp__context7__get-library-docs --context7CompatibleLibraryID="/tailwindlabs/tailwindcss" --topic="utilities"

# Tailwind configuration
mcp__context7__get-library-docs --context7CompatibleLibraryID="/tailwindlabs/tailwindcss" --topic="configuration"
```

**Tailwind Focus Areas:**
- `utilities` - Utility classes and responsive design
- `components` - Component-based styling approaches
- `configuration` - Configuration and customization
- `optimization` - Production optimization strategies

## Workflow Integration Patterns

### Pre-Implementation Documentation Check
```bash
# Before implementing new feature
# 1. Verify current best practices
mcp__context7__resolve-library-id --libraryName="laravel"
mcp__context7__get-library-docs --context7CompatibleLibraryID="/laravel/docs" --topic="relevant_feature"

# 2. Check version compatibility
mcp__context7__get-library-docs --context7CompatibleLibraryID="/laravel/docs/v10.x" --topic="feature_changes"

# 3. Review implementation examples
mcp__context7__get-library-docs --context7CompatibleLibraryID="/laravel/docs" --topic="code_examples"
```

### Framework Integration Workflow
```bash
# When integrating multiple frameworks
# 1. Laravel foundation
mcp__context7__get-library-docs --context7CompatibleLibraryID="/laravel/docs" --topic="architecture"

# 2. Livewire integration
mcp__context7__get-library-docs --context7CompatibleLibraryID="/livewire/livewire" --topic="installation"

# 3. FilamentPHP integration
mcp__context7__get-library-docs --context7CompatibleLibraryID="/filamentphp/filament" --topic="installation"

# 4. Cross-framework compatibility
mcp__context7__get-library-docs --context7CompatibleLibraryID="/livewire/livewire" --topic="filament-integration"
```

### Feature Development Documentation Pattern
```bash
# Feature-specific documentation gathering
# 1. Identify required libraries
mcp__context7__resolve-library-id --libraryName="feature_related_library"

# 2. Get implementation guidance
mcp__context7__get-library-docs --context7CompatibleLibraryID="/library/docs" --topic="implementation"

# 3. Review best practices
mcp__context7__get-library-docs --context7CompatibleLibraryID="/library/docs" --topic="best_practices"

# 4. Check testing approaches
mcp__context7__get-library-docs --context7CompatibleLibraryID="/library/docs" --topic="testing"
```

## Advanced Usage Patterns

### Version-Specific Research
```bash
# When upgrading or working with specific versions
mcp__context7__get-library-docs --context7CompatibleLibraryID="/laravel/docs/v10.x"
mcp__context7__get-library-docs --context7CompatibleLibraryID="/laravel/docs/v11.x"

# Compare version differences
mcp__context7__get-library-docs --context7CompatibleLibraryID="/laravel/docs" --topic="upgrade_guide"
```

### Multi-Library Integration Research
```bash
# Understanding how libraries work together
mcp__context7__get-library-docs --context7CompatibleLibraryID="/laravel/docs" --topic="packages"
mcp__context7__get-library-docs --context7CompatibleLibraryID="/livewire/livewire" --topic="third_party"
mcp__context7__get-library-docs --context7CompatibleLibraryID="/filamentphp/filament" --topic="plugins"
```

### Problem-Specific Documentation
```bash
# When troubleshooting or solving specific problems
mcp__context7__get-library-docs --context7CompatibleLibraryID="/laravel/docs" --topic="debugging"
mcp__context7__get-library-docs --context7CompatibleLibraryID="/laravel/docs" --topic="performance"
mcp__context7__get-library-docs --context7CompatibleLibraryID="/laravel/docs" --topic="security"
```

## Integration with Other MCP Servers

### Context7 + Serena Integration
```bash
# 1. Understand current patterns with Serena
mcp__serena__search_for_pattern --substring_pattern="Laravel.*validation"

# 2. Get current best practices with Context7
mcp__context7__resolve-library-id --libraryName="laravel"
mcp__context7__get-library-docs --context7CompatibleLibraryID="/laravel/docs" --topic="validation"

# 3. Compare current implementation with best practices
mcp__serena__find_symbol --name_path="ValidationRule" --include_body=true
```

### Context7 + Zen Integration
```bash
# Use Context7 for current information in Zen workflows
mcp__zen__analyze --model="gemini-2.5-pro" --step="Analyze current Laravel best practices for the implementation"

# Within the analysis, reference:
mcp__context7__get-library-docs --context7CompatibleLibraryID="/laravel/docs" --topic="best_practices"
```

## Library-Specific Guidance

### Laravel Documentation Strategy
**Most Valuable Topics:**
- `eloquent` - For database operations and relationships
- `validation` - For form and API validation
- `queues` - For background processing
- `broadcasting` - For real-time features
- `testing` - For comprehensive test strategies
- `deployment` - For production considerations

**Workflow:**
```bash
# Start with architectural understanding
mcp__context7__get-library-docs --context7CompatibleLibraryID="/laravel/docs" --topic="architecture"

# Focus on specific implementation areas
mcp__context7__get-library-docs --context7CompatibleLibraryID="/laravel/docs" --topic="[specific_feature]"
```

### Livewire Documentation Strategy
**Critical Topics:**
- `components` - Component structure and lifecycle
- `properties` - Reactive properties and binding
- `actions` - User interactions and form handling
- `events` - Component communication patterns
- `testing` - Component testing approaches

**Best Practices Pattern:**
```bash
# Understand component fundamentals
mcp__context7__get-library-docs --context7CompatibleLibraryID="/livewire/livewire" --topic="components"

# Learn communication patterns
mcp__context7__get-library-docs --context7CompatibleLibraryID="/livewire/livewire" --topic="events"

# Implement testing strategies
mcp__context7__get-library-docs --context7CompatibleLibraryID="/livewire/livewire" --topic="testing"
```

### FilamentPHP Documentation Strategy
**Essential Areas:**
- `resources` - Core CRUD functionality
- `forms` - Form building and validation
- `tables` - Data display and interaction
- `customization` - Extending and customizing functionality

**Implementation Pattern:**
```bash
# Start with resource creation
mcp__context7__get-library-docs --context7CompatibleLibraryID="/filamentphp/filament" --topic="resources"

# Customize forms and tables
mcp__context7__get-library-docs --context7CompatibleLibraryID="/filamentphp/filament" --topic="forms"
mcp__context7__get-library-docs --context7CompatibleLibraryID="/filamentphp/filament" --topic="tables"
```

## Documentation-Driven Development Workflow

### 1. Research Phase
```bash
# Feature requirements research
mcp__context7__resolve-library-id --libraryName="[required_library]"
mcp__context7__get-library-docs --context7CompatibleLibraryID="/library/docs" --topic="overview"

# Implementation approach research
mcp__context7__get-library-docs --context7CompatibleLibraryID="/library/docs" --topic="getting_started"
mcp__context7__get-library-docs --context7CompatibleLibraryID="/library/docs" --topic="best_practices"
```

### 2. Implementation Phase
```bash
# Step-by-step implementation guidance
mcp__context7__get-library-docs --context7CompatibleLibraryID="/library/docs" --topic="installation"
mcp__context7__get-library-docs --context7CompatibleLibraryID="/library/docs" --topic="configuration"
mcp__context7__get-library-docs --context7CompatibleLibraryID="/library/docs" --topic="usage"
```

### 3. Validation Phase
```bash
# Testing and validation guidance
mcp__context7__get-library-docs --context7CompatibleLibraryID="/library/docs" --topic="testing"
mcp__context7__get-library-docs --context7CompatibleLibraryID="/library/docs" --topic="debugging"
```

## Token Management Strategy

### Efficient Documentation Retrieval
- **Start Broad**: Use general topics to understand overall approach
- **Focus Specific**: Request focused topics for implementation details
- **Optimize Tokens**: Use appropriate token limits (5000-10000 typical)
- **Cache Understanding**: Document key insights in memory system

**Token Allocation Guidelines:**
- **Overview/Architecture**: 10000 tokens for comprehensive understanding
- **Specific Features**: 5000 tokens for focused implementation
- **Code Examples**: 3000 tokens for practical implementation
- **Troubleshooting**: 7000 tokens for comprehensive problem-solving

## Common Documentation Patterns

### New Feature Implementation
```bash
# Pattern: Research → Understand → Implement → Validate
mcp__context7__get-library-docs --context7CompatibleLibraryID="/laravel/docs" --topic="feature_overview" --tokens=10000
mcp__context7__get-library-docs --context7CompatibleLibraryID="/laravel/docs" --topic="implementation" --tokens=7000
mcp__context7__get-library-docs --context7CompatibleLibraryID="/laravel/docs" --topic="testing" --tokens=5000
```

### Framework Integration
```bash
# Pattern: Individual → Integration → Best Practices
mcp__context7__get-library-docs --context7CompatibleLibraryID="/framework1/docs" --tokens=8000
mcp__context7__get-library-docs --context7CompatibleLibraryID="/framework2/docs" --tokens=8000
mcp__context7__get-library-docs --context7CompatibleLibraryID="/integration/docs" --tokens=6000
```

### Troubleshooting & Debugging
```bash
# Pattern: Problem → Documentation → Solution → Prevention
mcp__context7__get-library-docs --context7CompatibleLibraryID="/library/docs" --topic="troubleshooting" --tokens=8000
mcp__context7__get-library-docs --context7CompatibleLibraryID="/library/docs" --topic="common_issues" --tokens=6000
```

## Quality Assurance with Documentation

### Validation Against Current Standards
```bash
# Before code review, validate against current practices
mcp__context7__get-library-docs --context7CompatibleLibraryID="/laravel/docs" --topic="code_style"
mcp__context7__get-library-docs --context7CompatibleLibraryID="/laravel/docs" --topic="best_practices"

# Use in conjunction with code review
mcp__zen__codereview # (which can reference Context7 findings)
```

### Security Best Practices Verification
```bash
# Verify security practices against current recommendations
mcp__context7__get-library-docs --context7CompatibleLibraryID="/laravel/docs" --topic="security"
mcp__context7__get-library-docs --context7CompatibleLibraryID="/livewire/livewire" --topic="security"

# Cross-reference with security audit
mcp__zen__secaudit # (informed by current security documentation)
```

## Documentation Memory Integration

### Capturing Key Documentation Insights
```bash
# After reviewing documentation, capture insights
mcp__serena__write_memory --memory_name="laravel_validation_patterns" --content="# Laravel Validation Best Practices

Based on current Laravel documentation:
- Use Form Request classes for complex validation
- Implement custom validation rules for domain logic
- Use conditional validation for dynamic requirements
- Follow consistent error message patterns

Implementation examples:
[code examples from documentation]"
```

### Building Documentation-Based Knowledge Base
```bash
# Create comprehensive knowledge base
mcp__serena__write_memory --memory_name="framework_integration_guide" --content="# TALL Stack Integration Guide

## Laravel Foundation
[key points from Laravel docs]

## Livewire Integration  
[integration patterns from Livewire docs]

## FilamentPHP Administration
[administrative interface patterns]

## Cross-Framework Considerations
[compatibility and best practices]"
```

## Success Metrics

### Effective Context7 Usage
- **Current Information**: Always using up-to-date library documentation
- **Accurate Implementation**: Following current best practices and patterns
- **Version Compatibility**: Understanding version-specific requirements
- **Integration Success**: Proper multi-framework integration
- **Problem Resolution**: Efficient troubleshooting with authoritative sources

## Troubleshooting

### Library Not Found
If a library isn't found in Context7:
1. Try alternative names (e.g., "tailwind", "tailwindcss", "tailwind-css")
2. Check for organizational context (e.g., "laravel/framework", "livewire/livewire")
3. Use broader terms (e.g., "css frameworks" instead of specific framework names)

### Documentation Not Current
If documentation seems outdated:
1. Verify library ID matches current repository structure
2. Check if library has moved or been renamed
3. Try version-specific IDs if available

### Topic Not Found
If specific topics aren't available:
1. Use broader topic terms (e.g., "components" instead of "livewire-components")
2. Try general searches without topic specification
3. Use multiple smaller requests instead of one large request

## See Also

- **[Serena MCP Server Guide](serena-guide.md)** - Code analysis integration
- **[Zen MCP Server Guide](zen-guide.md)** - Analysis workflow integration
- **[AI Interaction Patterns](../reference/ai-interaction-patterns.md)** - Natural language documentation requests
- **[Feature Development Workflow](../workflows/feature-development.md)** - Documentation-driven development