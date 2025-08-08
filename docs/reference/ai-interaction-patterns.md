# AI Interaction Patterns

Natural language development patterns and AI-assisted workflows for efficient development in the Marlin Laravel TALL stack application.

## Overview

This guide provides patterns for effective AI-assisted development, focusing on natural language interactions, context-rich requests, and intelligent tool usage for maximum development efficiency.

## Core AI Interaction Principles

### 1. Context-Rich Communication
**Instead of:** "Create a component"  
**Use:** "Create a Livewire component for user profile management that handles avatar uploads, validates email addresses, and integrates with our existing User model authentication system"

**Why This Works Better:**
- Provides business context for better architectural decisions
- Specifies integration requirements upfront
- Enables AI to suggest appropriate patterns and tools
- Reduces iteration cycles and miscommunication

### 2. Project-Aware Requests
```bash
# Always start with context gathering
mcp__serena__list_memories
mcp__serena__read_memory "relevant_pattern"
mcp__serena__get_symbols_overview "relevant_directory"

# Then make informed requests with context:
"Based on our existing agent system patterns in app/Services/Agents/, create a new specialized agent for document analysis that follows the same execution pipeline and status reporting patterns"
```

### 3. Progressive Refinement Pattern
1. **Initial Request**: High-level feature description with business context
2. **Clarification Loop**: AI asks for specifics about integration points, constraints
3. **Implementation**: AI provides solution with explanations
4. **Refinement**: "Adjust this to better match our existing X pattern" or "Add error handling similar to Y component"

## Natural Language Development Approaches

### Feature Development Pattern
```
"I need to implement [feature description] for [business context].

Context:
- User story: [detailed user story]
- Business requirements: [specific requirements]
- Integration points: [existing systems it needs to work with]
- Performance requirements: [any specific performance needs]
- Security considerations: [data sensitivity, access controls]

Based on our existing architecture in [relevant directories], what's the best approach?"
```

### Architecture Decision Pattern
```
"I'm considering [architectural decision] for [specific use case].

Current situation:
- [Current implementation or constraints]
- [Performance requirements]
- [Scalability needs]
- [Team expertise and maintenance considerations]

Options I'm evaluating:
- Option A: [description with pros/cons]
- Option B: [description with pros/cons]
- Option C: [alternative approach]

Based on our Laravel TALL stack architecture and existing patterns, which approach would you recommend and why?"
```

### Code Review Request Pattern
```
"Please review this [component/service/feature] implementation:

[Code or file reference]

Review focus areas:
- [Specific concerns or questions]
- [Performance considerations]
- [Security implications]
- [Integration with existing systems]
- [Adherence to our coding standards]

Consider our existing patterns in [relevant directories] and suggest improvements."
```

## Multi-Agent Coordination Patterns

### Specialist Consultation Pattern
When working with complex features that span multiple domains:

```bash
# For database-heavy features
Performance Specialist: Design the optimal schema for [feature] considering our existing models and relationships. Include migration strategy and performance considerations.

# For agent-integrated features  
DevOps Specialist: How should [feature] integrate with our agent system? Consider tool creation, workflow integration, and streaming requirements.

# For knowledge-intensive features
Security Specialist: Design the knowledge integration for [feature]. Consider document processing, vector search, and source attribution.

# For frontend-heavy features
Performance Specialist: Design the component architecture for [feature]. Consider real-time updates, responsive design, and user experience.
```

### Multi-Domain Feature Pattern
```bash
# Step 1: Architecture planning with relevant specialists
"I need to implement [complex feature] that involves [database changes], [agent integration], [frontend components], and [knowledge processing].

Let's coordinate this with our specialists:
- Performance Specialist: Schema design and migration strategy
- DevOps Specialist: AI integration and tool requirements  
- Performance Specialist: Component architecture and user experience
- Security Specialist: RAG integration and document handling

What's the best approach for coordinating this implementation?"
```

### Consensus Decision Pattern
```bash
# For critical architectural decisions
mcp__zen__consensus --models=[multiple_models] --step="Evaluate [decision] considering [trade-offs and constraints]"

# Context for consensus:
"We need to make a critical decision about [architectural choice].

Factors to consider:
- [Technical implications]
- [Performance impact]
- [Maintenance overhead]
- [Team expertise]
- [Future scalability]

Please provide multiple perspectives on the best approach."
```

## Design-to-Code Workflow Integration

### Figma-to-Component Pipeline
```bash
# Provide full context for design implementation
"Convert this Figma design [full_figma_url] to a Livewire component that matches our existing design system.

Requirements:
- Follow our component patterns in resources/views/components/
- Use our existing Flux UI components where possible
- Ensure responsive design following our breakpoint strategy
- Match the interaction patterns from our existing components
- Include proper accessibility considerations

Integration points:
- [Backend API endpoints needed]
- [Real-time update requirements]
- [State management considerations]"
```

### Component Translation Patterns
```bash
# Design system consistency
"Match the visual design but use our existing Flux UI components where possible"

# Responsive adaptation
"Ensure the mobile layout follows our established breakpoint strategy from [existing component examples]"

# Interaction pattern matching
"Use the same hover states and transitions as our existing button components in [component directory]"
```

## Cross-Reference Development Patterns

### Documentation-Driven Implementation
```bash
# Combine current documentation with existing patterns
mcp__context7__resolve-library-id "filamentphp/filament"
mcp__context7__get-library-docs [library_id] --topic="resources"
mcp__serena__search_for_pattern "existing_filament_implementations"

# Request with combined context:
"Implement a new Filament resource following both the latest documentation patterns and our existing implementations in app/Filament/Resources/.

Specific requirements:
- [Feature-specific requirements]
- [Integration with existing resources]
- [Custom functionality needed]

Please ensure consistency with our established patterns while using current best practices."
```

### Pattern Consistency Requests
```bash
# Architecture consistency
"Implement this feature following the same architecture pattern as our existing knowledge system"

# API consistency  
"Create this API endpoint matching the structure and error handling of our other controllers in app/Http/Controllers/Api/"

# Database consistency
"Design this database migration consistent with our UUID primary key and soft delete patterns"
```

## Collaborative Decision Making Patterns

### Architectural Consultation
```bash
# Open-ended architectural questions
"What would be the best approach for implementing [feature] given our current Laravel TALL stack architecture?"

# Technology choice questions
"Should this be a Livewire component, a Filament widget, or a separate service class? Consider [specific requirements and constraints]."

# Integration questions
"How should this integrate with our existing agent execution system? Consider [performance, maintainability, and user experience]."
```

### Trade-off Analysis
```bash
# Present options for analysis
"I see three approaches for implementing [feature]:

Option A: Full Livewire component
- Pros: [specific advantages]
- Cons: [specific limitations]

Option B: Alpine.js enhancement  
- Pros: [specific advantages]
- Cons: [specific limitations]

Option C: Separate API endpoint
- Pros: [specific advantages] 
- Cons: [specific limitations]

Given our [specific constraints and requirements], which approach would work best and why?"
```

### Constraint Acknowledgment
```bash
# Provide constraints upfront
"Given our performance requirements of [specific metrics] and our existing patterns of [pattern description], recommend the best implementation approach for [feature].

Additional constraints:
- [Team expertise limitations]
- [Maintenance considerations]  
- [Integration requirements]
- [Timeline constraints]"
```

## Quality-Focused Interaction Patterns

### Pre-Implementation Quality Checks
```bash
# Security-focused requests
"Before implementing [feature], what security considerations should we address given that it handles [data types] and integrates with [systems]?"

# Performance-focused requests
"What performance implications should we consider for [feature] given our current [usage patterns] and [scaling requirements]?"

# Maintainability-focused requests
"How can we implement [feature] in a way that's maintainable and follows our established patterns while being extensible for [future requirements]?"
```

### Code Review Integration
```bash
# Comprehensive review requests
mcp__zen__codereview --model="gemini-2.5-pro" --step="Review [component/feature] for code quality, security, performance, and adherence to our TALL stack conventions"

# Specific focus reviews
"Review this implementation focusing on [specific areas] and compare it to our existing patterns in [relevant directories]"
```

## Problem-Solving Interaction Patterns

### Systematic Problem Investigation
```bash
# Clear problem description
mcp__zen__debug --step="Investigate [specific problem] that occurs when [conditions].

Symptoms observed:
- [Symptom 1]: [Description and context]
- [Symptom 2]: [Description and context]
- [Error messages]: [Exact error text]

Environment details:
- [Development/staging/production]
- [Recent changes]
- [Affected user groups or conditions]

Expected investigation approach focusing on [specific areas]"
```

### Performance Investigation
```bash
# Performance-specific investigation
mcp__zen__analyze --analysis_type="performance" --step="Analyze performance bottleneck in [specific area].

Performance metrics:
- [Current performance]: [specific measurements]
- [Expected performance]: [target metrics]
- [User impact]: [description of user experience]

Investigation should focus on [database queries/frontend rendering/API responses/etc.]"
```

## Advanced AI Usage Patterns

### Multi-Model Consensus for Critical Decisions
```bash
# Use multiple AI models for important decisions
mcp__zen__consensus --models=[
  {"model": "o3", "stance": "neutral"},
  {"model": "gemini-2.5-pro", "stance": "neutral"},
  {"model": "gpt-4.1-2025-04-14", "stance": "neutral"}
] --step="Evaluate [critical decision] considering [all relevant factors]"
```

### Deep Analysis for Complex Issues
```bash
# Extended reasoning for architectural decisions
mcp__zen__thinkdeep --thinking_mode="high" --step="Deep analysis of [complex issue] considering [multiple dimensions and long-term implications]"
```

### Structured Planning for Large Features
```bash
# Interactive planning for complex implementations
mcp__zen__planner --step="Plan implementation of [large feature] considering [dependencies, risks, and requirements]"
```

## Tool Selection Guidelines

### When to Use Different AI Interaction Approaches

**Direct Natural Language (Claude Code):**
- Simple, well-understood requests
- Quick clarifications or explanations
- Straightforward implementations following known patterns

**MCP Tool Integration:**
- Complex analysis requiring systematic investigation
- Quality assurance and validation workflows
- Multi-step problem solving
- Code exploration and understanding

**Multi-Agent Coordination:**
- Features spanning multiple domains
- Critical architectural decisions
- Complex debugging requiring multiple perspectives
- Performance optimization across systems

## Memory-Driven Development Integration

### Capturing AI Interaction Insights
```bash
# Document effective interaction patterns
mcp__serena__write_memory --memory_name="ai_interaction_patterns" --content="# Effective AI Interaction Patterns

## Successful Request Patterns
1. [Pattern description]: [Why it works well]
2. [Pattern description]: [Context where it's most effective]

## Tool Selection Insights
- [Tool]: Best for [specific scenarios]
- [Tool combination]: Effective for [complex scenarios]

## Collaboration Patterns
- [Multi-agent pattern]: [When and how to use]
- [Consensus pattern]: [Decision-making scenarios]"
```

### Building Knowledge Base of Patterns
```bash
# Create comprehensive AI usage guide
mcp__serena__write_memory --memory_name="ai_development_strategies" --content="# AI-Assisted Development Strategies

## Context Patterns That Work
[Document successful context-setting approaches]

## Quality Integration Patterns
[Document AI-assisted quality assurance approaches]

## Problem-Solving Patterns
[Document systematic investigation approaches]

## Cross-Domain Coordination
[Document multi-specialist collaboration patterns]"
```

## Success Metrics for AI Interactions

### Effective AI Usage Indicators
- **Reduced Iteration Cycles**: Getting correct implementations faster
- **Higher Quality Outputs**: Fewer bugs and better architecture decisions
- **Improved Problem Solving**: Faster resolution of complex issues
- **Better Documentation**: More comprehensive and accurate documentation
- **Increased Learning**: Better understanding of patterns and best practices

### Optimization Opportunities
- **Context Improvement**: Better initial context leads to better responses
- **Tool Selection**: Using appropriate tools for task complexity
- **Pattern Recognition**: Identifying and reusing successful interaction patterns
- **Quality Integration**: Systematic quality assurance throughout development

## Common Anti-Patterns to Avoid

### ❌ Vague Requests
```bash
# Don't: "Fix this code"
# Do: "Review this User model implementation for performance issues, specifically the relationship loading patterns, and suggest optimizations based on our existing patterns in app/Models/"
```

### ❌ Missing Context
```bash
# Don't: "Create a form component"  
# Do: "Create a Livewire form component for user registration that integrates with our existing authentication system, follows our validation patterns, and includes real-time email availability checking"
```

### ❌ Tool Misuse
```bash
# Don't: Use heavy analysis tools for simple questions
# Do: Match tool complexity to problem complexity
```

### ❌ Ignoring Quality Gates
```bash
# Don't: Skip systematic review for critical code
# Do: Use appropriate quality assurance workflows for important changes
```

## See Also

- **[Feature Development Workflow](../workflows/feature-development.md)** - AI integration in development process
- **[Quality Assurance Workflows](../workflows/quality-assurance.md)** - AI-assisted quality processes  
- **[MCP Server Guides](../mcp-servers/)** - Tool-specific usage patterns
- **[Specialized Agent Definitions](../../.claude/agents/)** - Domain expert coordination patterns