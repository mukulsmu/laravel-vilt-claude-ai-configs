# Zen MCP Server Guide

**Primary Purpose**: Advanced analysis workflows, multi-model reasoning, and structured investigation processes

## Overview

The Zen MCP Server provides sophisticated AI-powered workflows for complex analysis tasks that require systematic investigation, multi-step reasoning, or expert validation. It's designed for tasks that benefit from structured, methodical approaches rather than quick single-step operations.

## Core Philosophy

**"Systematic Excellence Through AI Collaboration"** - Zen enables:
- **Multi-step analysis workflows** that break complex problems into manageable parts
- **Expert validation** through advanced AI models for critical decisions
- **Structured investigation** that follows proven methodologies
- **Quality assurance** through systematic review processes

## Tool Categories

### 1. General Purpose Analysis

#### `mcp__zen__chat`
**Purpose**: General collaboration and brainstorming with AI assistance
```bash
# Architectural discussion
mcp__zen__chat --model="gemini-2.5-pro" --prompt="I'm designing a new feature for user preferences management. What are the key architectural considerations for a Laravel TALL stack application?"

# Code review consultation
mcp__zen__chat --model="o3" --files=["/path/to/code.php"] --prompt="Review this implementation and suggest improvements following Laravel best practices"
```

**When to Use:**
- Brainstorming new features or approaches
- Getting second opinions on architectural decisions
- Discussing implementation strategies
- Exploring alternative solutions
- General development guidance

**Model Selection:**
- `gemini-2.5-pro`: Complex problems, deep analysis, architectural decisions
- `o3`: Logical problems, code generation, systematic analysis
- `gemini-2.0-flash`: Quick analysis, rapid iterations
- `o3-mini`: Balanced performance for moderate complexity

### 2. Investigative & Analytical Workflows

#### `mcp__zen__thinkdeep`
**Purpose**: Multi-stage workflow for complex problem analysis and reasoning
```bash
# Architectural decision analysis
mcp__zen__thinkdeep --model="gemini-2.5-pro" --thinking_mode="high" --step="Analyze the trade-offs between microservices vs monolithic architecture for our AI-powered research platform" --step_number=1 --total_steps=4 --next_step_required=true --findings="Initial analysis of system requirements and scaling considerations"

# Performance bottleneck investigation
mcp__zen__thinkdeep --model="o3" --step="Deep investigation of database performance issues affecting the knowledge system" --step_number=1 --total_steps=3 --findings="Identified slow query patterns in knowledge document retrieval"
```

**Workflow Structure:**
1. **Step 1**: Define problem and investigation approach
2. **Step 2**: Gather evidence and analyze data
3. **Step 3**: Test hypotheses and validate assumptions
4. **Step 4**: Synthesize findings and recommendations

**When to Use:**
- Complex architectural decisions requiring thorough analysis
- Performance issues needing systematic investigation
- Security concerns requiring comprehensive assessment
- Multi-faceted problems with unclear solutions

#### `mcp__zen__debug`
**Purpose**: Systematic debugging and root cause analysis
```bash
# Complex bug investigation
mcp__zen__debug --model="o3" --step="Investigating agent execution failures that occur intermittently during high-load periods" --step_number=1 --total_steps=5 --findings="Identified correlation between failures and concurrent user sessions" --hypothesis="Resource contention in agent execution pipeline" --confidence="medium" --next_step_required=true
```

**Investigation Process:**
1. **Problem Description**: Clear articulation of symptoms
2. **Evidence Gathering**: Systematic collection of relevant data
3. **Hypothesis Formation**: Educated theories about root causes
4. **Testing & Validation**: Systematic verification of theories
5. **Solution Development**: Comprehensive fix recommendations

**When to Use:**
- Complex bugs with unclear root causes
- Intermittent issues difficult to reproduce
- Performance degradation requiring investigation
- Multi-system integration problems

#### `mcp__zen__analyze`
**Purpose**: Comprehensive code and system analysis
```bash
# System architecture analysis
mcp__zen__analyze --model="gemini-2.5-pro" --analysis_type="architecture" --step="Analyze the current agent system architecture for scalability and maintainability" --step_number=1 --total_steps=3 --findings="System shows good separation of concerns but has potential bottlenecks in tool execution" --confidence="high" --next_step_required=true
```

**Analysis Types:**
- `architecture`: System design and structure analysis
- `performance`: Performance characteristics and optimization
- `security`: Security posture and vulnerability assessment
- `quality`: Code quality and maintainability review
- `general`: Comprehensive multi-faceted analysis

### 3. Quality Assurance Workflows

#### `mcp__zen__codereview`
**Purpose**: Comprehensive code review with expert analysis
```bash
# Feature code review
mcp__zen__codereview --model="gemini-2.5-pro" --step="Review the new knowledge document processing feature for code quality, security, and performance" --step_number=1 --total_steps=3 --findings="Implementation follows established patterns but has potential optimization opportunities" --confidence="high" --relevant_files=["/app/Services/Knowledge/DocumentProcessor.php"]
```

**Review Process:**
1. **Code Structure Analysis**: Organization, patterns, conventions
2. **Security Assessment**: Vulnerability identification and mitigation
3. **Performance Evaluation**: Efficiency and optimization opportunities
4. **Quality Validation**: Maintainability and best practices compliance

#### `mcp__zen__secaudit`
**Purpose**: Security auditing and vulnerability assessment
```bash
# Security audit of authentication system
mcp__zen__secaudit --model="o3" --step="Comprehensive security audit of user authentication and authorization systems" --step_number=1 --total_steps=4 --findings="Authentication flow follows secure patterns but session management needs review" --audit_focus="owasp" --threat_level="medium"
```

**Security Focus Areas:**
- `owasp`: OWASP Top 10 vulnerability assessment
- `compliance`: Regulatory compliance validation
- `infrastructure`: Infrastructure security review
- `dependencies`: Third-party dependency security
- `comprehensive`: Full security posture analysis

#### `mcp__zen__precommit`
**Purpose**: Pre-commit validation and quality gates
```bash
# Pre-commit quality validation
mcp__zen__precommit --model="gemini-2.0-flash" --step="Validate all changes before committing new feature implementation" --step_number=1 --total_steps=2 --findings="Code formatting correct, tests passing, no security issues detected" --include_staged=true --include_unstaged=false
```

**Validation Areas:**
- Code formatting and style compliance
- Test coverage and quality
- Security vulnerability scanning
- Performance impact assessment
- Documentation completeness

### 4. Planning & Decision Making

#### `mcp__zen__planner`
**Purpose**: Interactive sequential planning for complex tasks
```bash
# Feature implementation planning
mcp__zen__planner --model="gemini-2.5-pro" --step="Plan implementation of multi-tenant knowledge sharing system" --step_number=1 --total_steps=6 --next_step_required=true

# Migration strategy planning
mcp__zen__planner --model="o3" --step="Design database migration strategy for adding tenant isolation to existing system" --step_number=2 --total_steps=5 --is_step_revision=false --next_step_required=true
```

**Planning Features:**
- **Sequential Development**: Build plans step-by-step
- **Dynamic Adjustment**: Modify total steps as understanding grows
- **Revision Capability**: Update earlier decisions when new insights emerge
- **Branching Support**: Explore alternative approaches

#### `mcp__zen__consensus`
**Purpose**: Multi-model consensus for critical decisions
```bash
# Architecture decision consensus
mcp__zen__consensus --models=[{"model": "o3", "stance": "neutral"}, {"model": "gemini-2.5-pro", "stance": "neutral"}] --step="Evaluate whether to migrate from Meilisearch to PostgreSQL vector extensions for our knowledge system" --step_number=1 --total_steps=2 --findings="Initial analysis shows both options have significant trade-offs that require expert evaluation"
```

**Consensus Features:**
- **Multi-Model Analysis**: Get perspectives from different AI models
- **Structured Debate**: Configure models with different stances
- **Expert Validation**: Comprehensive review of critical decisions
- **Risk Assessment**: Balanced evaluation of alternatives

### 5. Specialized Analysis Tools

#### `mcp__zen__refactor`
**Purpose**: Refactoring analysis and planning
```bash
# Code refactoring analysis
mcp__zen__refactor --model="gemini-2.5-pro" --step="Analyze opportunities to refactor the agent execution system for better maintainability" --step_number=1 --total_steps=3 --findings="System has grown organically and would benefit from extraction of common patterns" --refactor_type="organization" --confidence="incomplete"
```

**Refactoring Types:**
- `codesmells`: Identify and address code smell issues
- `decompose`: Break down large, complex components
- `modernize`: Update to current best practices and patterns
- `organization`: Improve code structure and organization

#### `mcp__zen__testgen`
**Purpose**: Comprehensive test generation and coverage analysis
```bash
# Test suite generation
mcp__zen__testgen --model="o3" --step="Generate comprehensive test suite for the knowledge document processing system" --step_number=1 --total_steps=2 --findings="Current test coverage is insufficient for complex document processing workflows" --confidence="medium"
```

**Test Generation Features:**
- **Coverage Analysis**: Identify gaps in test coverage
- **Edge Case Generation**: Create tests for boundary conditions
- **Integration Testing**: Design tests for system interactions
- **Performance Testing**: Generate load and performance tests

#### `mcp__zen__tracer`
**Purpose**: Code flow tracing and dependency analysis
```bash
# Method execution tracing
mcp__zen__tracer --model="gemini-2.0-flash" --step="Trace the execution flow of agent request processing from HTTP request to response" --step_number=1 --total_steps=3 --findings="Request flow involves multiple services and has potential optimization points" --trace_mode="precision" --target_description="Understanding agent execution pipeline for performance optimization"
```

**Trace Modes:**
- `precision`: Detailed execution flow and method call analysis
- `dependencies`: Structural relationships and dependency mapping
- `ask`: Interactive mode to choose appropriate tracing strategy

#### `mcp__zen__docgen`
**Purpose**: Documentation generation with complexity analysis
```bash
# Documentation generation
mcp__zen__docgen --step="Generate comprehensive documentation for the knowledge system components" --step_number=1 --total_steps=4 --findings="System has complex interactions that need clear documentation" --document_complexity=true --document_flow=true --update_existing=true
```

**Documentation Features:**
- **Complexity Analysis**: Big O notation and algorithmic complexity
- **Flow Documentation**: Call chains and dependency information
- **Inline Comments**: Detailed explanations for complex logic
- **API Documentation**: Comprehensive endpoint and method documentation

## Model Selection Guidelines

### Task-Appropriate Model Selection

#### For Deep Analysis & Architecture
- **gemini-2.5-pro**: Complex problems, architectural decisions, deep reasoning
- **o3-pro-2025-06-10**: Extremely complex analysis (use sparingly due to cost)
- **gpt-4.1-2025-04-14**: Large context analysis with extensive background

#### For Code Analysis & Generation
- **o3**: Systematic analysis, code generation, logical problem solving
- **o3-mini**: Balanced performance for moderate complexity
- **gemini-2.0-flash**: Quick analysis and iterations

#### For Performance & Efficiency
- **gemini-2.0-flash**: Fast analysis for time-sensitive tasks
- **o4-mini**: Optimized for shorter contexts, rapid reasoning
- **gemini-2.0-flash-lite**: Lightweight analysis for simple tasks

### Thinking Mode Guidelines

#### Thinking Depth Selection
- **minimal** (0.5%): Quick confirmations, simple analysis
- **low** (8%): Basic investigation, straightforward problems
- **medium** (33%): Standard analysis, moderate complexity (default)
- **high** (67%): Complex systems, architectural decisions
- **max** (100%): Critical systems, exhaustive analysis

## Workflow Integration Patterns

### Sequential Investigation Workflow
```bash
# Phase 1: Problem identification
mcp__zen__debug --step_number=1 --findings="Initial problem assessment"

# Phase 2: Deep analysis based on findings
mcp__zen__thinkdeep --step_number=1 --thinking_mode="high"

# Phase 3: Solution planning
mcp__zen__planner --step_number=1

# Phase 4: Quality validation
mcp__zen__precommit
```

### Multi-Domain Analysis Workflow
```bash
# Security analysis
mcp__zen__secaudit --audit_focus="comprehensive"

# Performance analysis
mcp__zen__analyze --analysis_type="performance"

# Code quality analysis
mcp__zen__codereview --review_type="full"

# Consensus on findings
mcp__zen__consensus --models=[multiple_models]
```

## Advanced Usage Patterns

### Progressive Analysis Refinement
```bash
# Start with broad analysis
mcp__zen__analyze --analysis_type="general" --confidence="exploring"

# Narrow focus based on findings
mcp__zen__thinkdeep --thinking_mode="high" --focus_areas=["identified_issues"]

# Deep dive into specific areas
mcp__zen__debug --confidence="high" --specific_investigation=true
```

### Multi-Perspective Validation
```bash
# Get multiple viewpoints
mcp__zen__consensus --models=[
  {"model": "o3", "stance": "neutral"},
  {"model": "gemini-2.5-pro", "stance": "neutral"},
  {"model": "gpt-4.1-2025-04-14", "stance": "neutral"}
]
```

### Iterative Improvement Workflow
```bash
# Initial assessment
mcp__zen__codereview --confidence="medium"

# Address findings and re-evaluate
mcp__zen__codereview --backtrack_from_step=2 --confidence="high"

# Final validation
mcp__zen__precommit --confidence="very_high"
```

## Integration with Project Workflows

### Feature Development Integration
```bash
# Planning phase
mcp__zen__planner --step="Design new feature architecture"

# Implementation validation
mcp__zen__codereview --review_type="full"

# Quality assurance
mcp__zen__precommit --severity_filter="high"
```

### Performance Optimization Integration
```bash
# Performance analysis
mcp__zen__analyze --analysis_type="performance"

# Deep investigation of bottlenecks
mcp__zen__thinkdeep --thinking_mode="high"

# Solution validation
mcp__zen__consensus --focus_on_performance=true
```

### Security Review Integration
```bash
# Comprehensive security audit
mcp__zen__secaudit --audit_focus="owasp" --threat_level="high"

# Deep security analysis
mcp__zen__thinkdeep --focus_areas=["security"] --thinking_mode="high"

# Multi-model security consensus
mcp__zen__consensus --models=[security_focused_models]
```

## Best Practices

### Workflow Design
1. **Start Broad, Narrow Down**: Begin with general analysis, focus on specific areas
2. **Use Appropriate Complexity**: Match thinking mode to problem complexity
3. **Document Progress**: Use findings field to track investigation progress
4. **Iterate Based on Evidence**: Adjust approach based on discoveries
5. **Validate Critical Decisions**: Use consensus for important choices

### Model Selection
1. **Match Model to Task**: Choose models based on strengths and requirements
2. **Consider Context Size**: Use models with appropriate context windows
3. **Balance Cost vs. Quality**: Reserve expensive models for critical analysis
4. **Use Multiple Models**: Get diverse perspectives for important decisions

### Quality Assurance
1. **Set Appropriate Confidence Levels**: Be honest about investigation completeness
2. **Use Systematic Approaches**: Follow structured workflows for consistency
3. **Document Methodology**: Record investigation approaches for reproducibility
4. **Validate with Experts**: Use assistant models for complex validation

## Performance Considerations

### Efficient Workflow Design
- **Batch Related Analysis**: Group similar investigations together
- **Use Incremental Approaches**: Build on previous findings rather than starting over
- **Optimize Model Selection**: Use faster models for preliminary analysis
- **Leverage Caching**: Take advantage of workflow state management

### Cost Management
- **Reserve Premium Models**: Use expensive models only for critical analysis
- **Optimize Thinking Modes**: Use appropriate depth for task complexity
- **Batch Operations**: Group related analysis to maximize efficiency
- **Use Staged Validation**: Start with less expensive validation, escalate as needed

## Common Use Cases

### Architectural Decision Making
```bash
# Comprehensive architecture analysis
mcp__zen__thinkdeep --thinking_mode="high" --focus_areas=["scalability", "maintainability"]
mcp__zen__consensus --models=[multiple_architectural_perspectives]
```

### Complex Bug Resolution
```bash
# Systematic debugging workflow
mcp__zen__debug --confidence="exploring"
mcp__zen__thinkdeep --thinking_mode="medium" --focus_areas=["root_cause_analysis"]
```

### Performance Optimization
```bash
# Performance analysis and optimization
mcp__zen__analyze --analysis_type="performance"
mcp__zen__thinkdeep --focus_areas=["bottleneck_identification"]
```

### Security Assessment
```bash
# Comprehensive security review
mcp__zen__secaudit --audit_focus="comprehensive"
mcp__zen__consensus --models=[security_expert_models]
```

### Code Quality Improvement
```bash
# Quality analysis and improvement
mcp__zen__codereview --review_type="full"
mcp__zen__refactor --refactor_type="codesmells"
```

## Success Metrics

### Effective Zen Usage
- **Systematic Problem Solving**: Using structured approaches for complex issues
- **Quality Decision Making**: Leveraging multi-model consensus for critical choices
- **Comprehensive Analysis**: Thorough investigation before implementation
- **Risk Mitigation**: Identifying and addressing potential issues proactively
- **Knowledge Synthesis**: Combining insights from multiple analytical perspectives

## See Also

- **[Serena MCP Server Guide](serena-guide.md)** - Code analysis and navigation
- **[Context7 MCP Server Guide](context7-guide.md)** - Documentation access
- **[Quality Assurance Workflows](../workflows/quality-assurance.md)** - QA integration
- **[Debugging & Investigation](../workflows/debugging-investigation.md)** - Investigation workflows
- **[Performance Optimization](../workflows/performance-optimization.md)** - Performance workflows