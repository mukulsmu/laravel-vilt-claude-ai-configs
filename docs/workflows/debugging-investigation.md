# Debugging & Investigation Workflows

Systematic approaches to problem-solving, debugging, and root cause analysis using AI-assisted investigation workflows.

## Overview

This document provides structured methodologies for investigating issues, debugging complex problems, and conducting thorough root cause analysis in the Laravel TALL stack application.

## AI Specialist Delegation Framework

This debugging workflow coordinates with specialized AI agents for comprehensive problem investigation:

- **DevOps Specialist**: Infrastructure issues, deployment problems, Docker troubleshooting, and agent system failures
- **Security Specialist**: Security vulnerabilities, authentication issues, data breaches, and compliance violations  
- **Performance Specialist**: Performance bottlenecks, database issues, query optimization, and scalability problems
- **Testing Specialist**: Test failures, coverage issues, quality problems, and validation debugging

**Investigation Delegation**: Complex debugging tasks are systematically delegated to appropriate domain specialists for expert analysis and solution recommendations.

## General Investigation Workflow

### 1. Initial Problem Assessment
```bash
# Start systematic investigation
mcp__zen__debug

# Initial assessment includes:
# - Problem description and symptoms
# - Environment and context analysis
# - Initial hypothesis formation
# - Investigation scope definition
```

**Investigation Planning Pattern:**
```
"I'm investigating [specific problem description] that occurs when [trigger conditions].

Observed symptoms:
- [Symptom 1]: [Description and frequency]  
- [Symptom 2]: [Description and context]
- [Error messages]: [Exact error messages if any]

Environment context:
- [Development/staging/production]
- [Recent changes or deployments]
- [User actions that trigger the issue]

Expected investigation approach: [systematic analysis] focusing on [specific areas]"
```

### 2. Evidence Gathering Phase
```bash
# Gather comprehensive evidence
mcp__serena__search_for_pattern [error_patterns]
mcp__serena__find_symbol [related_components] --include-body=true

# Check application logs
./vendor/bin/sail artisan pail --filter=[issue_context]

# Review recent changes
git log --oneline -20
git diff HEAD~5..HEAD
```

### 3. Hypothesis Formation & Testing
```bash
# Formulate and test hypotheses
mcp__zen__debug --confidence=medium

# Test hypotheses systematically:
# 1. Reproduce the issue
# 2. Isolate variables
# 3. Test components individually
# 4. Validate assumptions
```

## Domain-Specific Investigation Workflows

### Database Issues Investigation

#### Query Performance Problems
```bash
# Database performance investigation
"Performance Specialist + mcp__zen__debug: Investigate database performance issue:

Problem: [Specific query performance issue]
Symptoms: [Slow response times, timeouts, etc.]
Affected queries: [Specific queries or operations]

Focus investigation on:
- Query execution plans
- Index effectiveness
- Lock contention
- Connection pool usage
- Data volume impacts"
```

**Database Debug Commands:**
```bash
# Monitor database performance
./vendor/bin/sail artisan db:monitor --long-queries

# Check migration status
./vendor/bin/sail artisan migrate:status

# Analyze specific query performance
./vendor/bin/sail artisan tinker
# >>> DB::enableQueryLog();
# >>> // Execute problematic operations
# >>> DB::getQueryLog();
```

#### Data Integrity Issues
```bash
# Data integrity investigation
"Performance Specialist + mcp__zen__debug: Investigate data consistency issue:

Problem: [Data integrity problem description]
Affected models: [Specific models involved]
Symptoms: [Inconsistent data, constraint violations, etc.]

Investigation focus:
- Foreign key constraint violations
- Model relationship integrity
- Transaction boundary issues
- Concurrent modification problems"
```

### Frontend Component Issues

#### Livewire Component Debugging
```bash
# Component behavior investigation
"Performance Specialist + mcp__zen__debug: Debug Livewire component issue:

Component: [Specific component name]
Problem: [Component behavior issue]
User actions: [Actions that trigger the problem]
Expected vs actual behavior: [Detailed comparison]

Focus areas:
- Component state management
- Event handling and dispatch
- Property binding issues
- Lifecycle hook problems
- Real-time update failures"
```

**Livewire Debug Techniques:**
```bash
# Enable Livewire debugging
# Add to component for debugging:
# dd($this->all()); // Dump all properties
# ray($this->property); // Ray debugging (if installed)

# Browser debugging with Playwright
mcp__browsermcp__browser_navigate \"http://localhost/problematic-page\"
mcp__browsermcp__browser_snapshot
mcp__browsermcp__browser_get_console_logs
```

#### **Real-Time Browser Debugging with BrowserMCP**
For complex UI workflows requiring authenticated sessions and interactive debugging:

```bash
# Interactive browser debugging with authenticated session
mcp__browsermcp__browser_navigate "http://localhost/dashboard/agents"
mcp__browsermcp__browser_snapshot  # Get interactive page state
mcp__browsermcp__browser_click "Create Agent button" "s1e50"  # Test interactions
mcp__browsermcp__browser_get_console_logs  # Check for JS errors
mcp__browsermcp__browser_screenshot  # Visual verification
```

**BrowserMCP Advantages:**
- **Authenticated Sessions**: Works with existing login sessions
- **Real-Time Interaction**: Test complex user workflows step-by-step
- **State Inspection**: Access to full DOM and component state
- **Console Monitoring**: Real-time JavaScript error tracking
- **Visual Verification**: Screenshots for UI regression testing

**Use BrowserMCP when:**
- Testing complex Livewire component interactions
- Debugging authentication-dependent workflows
- Reproducing user-reported UI issues
- Validating fix effectiveness in real-time
- Investigating modal, dropdown, and dynamic content issues

#### Real-time Update Issues
```bash
# WebSocket/broadcasting investigation
"Performance Specialist + mcp__zen__debug: Debug real-time update issue:

Problem: [Real-time update not working]
Events involved: [Specific Laravel events]
Broadcasting channels: [Channel names and types]
Symptoms: [Events not received, delayed updates, etc.]

Investigation focus:
- Laravel Echo configuration
- Broadcasting driver status
- Event listener implementation
- WebSocket connection stability"
```

**Broadcasting Debug Commands:**
```bash
# Test broadcasting functionality
./vendor/bin/sail artisan test:broadcast-events

# Check Redis/broadcast driver
./vendor/bin/sail redis-cli ping
./vendor/bin/sail artisan queue:listen --verbose

# Monitor WebSocket connections
./vendor/bin/sail logs reverb
```

### Agent System Issues

#### Agent Execution Problems
```bash
# Agent execution investigation
"DevOps Specialist + mcp__zen__debug: Investigate agent execution failure:

Agent: [Specific agent name]
Execution context: [User request and context]
Failure symptoms: [Timeout, error, unexpected output]
Error messages: [Exact error messages]

Investigation areas:
- Agent configuration and tools
- Prism-PHP integration issues
- Streaming response problems
- Tool execution failures
- Context and memory management"
```

**Agent Debug Commands:**
```bash
# Test agent functionality
./vendor/bin/sail artisan test:agent-execution
./vendor/bin/sail artisan debug:agent-execution --agent-id=[agent_id]

# Monitor agent job processing
./vendor/bin/sail artisan queue:work --verbose
./vendor/bin/sail artisan pail --filter=agent

# Test tool functionality
./vendor/bin/sail artisan debug:tool-execution --tool=[tool_name]
```

#### Streaming Response Issues
```bash
# Streaming investigation
"DevOps Specialist + mcp__zen__debug: Debug streaming response issue:

Problem: [Streaming not working or interrupted]
Affected endpoints: [Specific streaming endpoints]
Client behavior: [Frontend response to streaming]
Error patterns: [Connection drops, incomplete responses]

Focus areas:
- Prism-PHP streaming configuration
- HTTP connection handling
- Laravel Echo integration
- Buffer and timeout settings"
```

### Knowledge System Issues

#### Search and RAG Problems
```bash
# Knowledge system investigation
"Security Specialist + mcp__zen__debug: Debug knowledge system issue:

Problem: [Search relevance, RAG performance, etc.]
Affected operations: [Specific search or RAG operations]
Data characteristics: [Document types, volume, etc.]
Performance symptoms: [Slow searches, poor results]

Investigation focus:
- Meilisearch index status
- Embedding quality and generation
- RAG pipeline performance
- Document processing issues"
```

**Knowledge System Debug Commands:**
```bash
# Test knowledge system components
./vendor/bin/sail artisan test:meilisearch-connection
./vendor/bin/sail artisan debug:meilisearch-index --detailed
./vendor/bin/sail artisan knowledge:embedding-status

# Debug specific searches
./vendor/bin/sail artisan debug:knowledge-search "test query"
./vendor/bin/sail artisan debug:rag-pipeline --document-id=123
```

#### Document Processing Issues
```bash
# Document processing investigation
"Security Specialist + mcp__zen__debug: Debug document processing failure:

Problem: [Document not processing correctly]
Document details: [File type, size, source]
Processing stage: [Where processing fails]
Error messages: [Processing error details]

Investigation areas:
- File upload and validation
- Content extraction pipeline
- Embedding generation process
- Index update procedures"
```

## Performance Investigation Workflows

### 1. System-Wide Performance Issues
```bash
# Comprehensive performance investigation
mcp__zen__analyze --analysis_type=performance

# Performance investigation covers:
# - Response time analysis
# - Resource utilization patterns
# - Bottleneck identification
# - Scalability assessment
```

### 2. Specific Performance Bottlenecks

#### Database Performance Investigation
```bash
# Database performance deep dive
"Performance Specialist + mcp__zen__thinkdeep: Analyze database performance bottleneck:

Performance issue: [Specific performance problem]
Affected operations: [Queries, transactions, etc.]
Metrics: [Response times, resource usage]
Load patterns: [User load, data volume, etc.]

Deep analysis focus:
- Query execution plan optimization
- Index strategy effectiveness
- Connection pool configuration
- Caching layer performance
- Hardware resource utilization"
```

#### Frontend Performance Investigation
```bash
# Frontend performance analysis
"Performance Specialist + mcp__zen__analyze: Investigate frontend performance:

Performance issue: [Slow rendering, large bundles, etc.]
Affected components: [Specific components or pages]
Metrics: [Load times, rendering metrics]
User experience: [Perceived performance issues]

Analysis focus:
- Component rendering efficiency
- Asset loading optimization
- JavaScript execution performance
- CSS rendering performance
- Network request optimization"
```

## Security Investigation Workflows

### 1. Security Incident Response
```bash
# Security incident investigation
mcp__zen__secaudit --threat_level=high

# Security investigation includes:
# - Threat vector analysis
# - Impact assessment
# - Vulnerability identification
# - Containment strategy development
```

### 2. Vulnerability Analysis
```bash
# Detailed vulnerability investigation
"Security focused multi-specialist analysis:

Security issue: [Specific vulnerability or incident]
Affected systems: [Components, data, users affected]
Threat indicators: [Evidence of compromise or vulnerability]
Risk level: [Assessment of potential impact]

Investigation requires:
- Performance Specialist: Database performance analysis
- DevOps Specialist: Infrastructure security review  
- Performance Specialist: Frontend performance assessment
- Security Specialist: Information security review"
```

## Advanced Investigation Techniques

### 1. Multi-Agent Investigation
For complex issues requiring multiple perspectives:

```bash
# Coordinated multi-agent investigation
mcp__zen__consensus --models=[o3,gemini-2.5-pro]

# Multi-agent investigation pattern:
# 1. Initial problem assessment by main agent
# 2. Parallel analysis by relevant specialists
# 3. Cross-validation of findings
# 4. Consensus on root cause and solution
```

### 2. Deep Analysis with Extended Reasoning
For architecturally complex issues:

```bash
# Extended reasoning investigation
mcp__zen__thinkdeep --thinking_mode=high

# Deep analysis includes:
# - Systematic hypothesis generation
# - Evidence-based reasoning
# - Alternative scenario consideration
# - Long-term impact assessment
```

### 3. Code Tracing and Flow Analysis
For understanding complex execution paths:

```bash
# Code flow tracing
mcp__zen__tracer --trace_mode=precision

# Tracing analysis covers:
# - Method execution flow
# - Data transformation pipeline
# - Dependency analysis
# - Call chain investigation
```

## Issue Resolution Workflows

### 1. Solution Development
```bash
# Develop comprehensive solutions
mcp__zen__planner

# Solution development includes:
# - Root cause addressing
# - Prevention strategy development
# - Implementation planning
# - Testing and validation approach
```

### 2. Fix Implementation
```bash
# Implement fixes with quality gates
# 1. Develop fix following established patterns
# 2. Comprehensive testing of solution
# 3. Quality assurance validation
mcp__zen__precommit
# 4. Deployment and monitoring
```

### 3. Post-Resolution Analysis
```bash
# Document lessons learned
mcp__serena__write_memory "debugging_case_study" [analysis]

# Post-resolution activities:
# - Root cause documentation
# - Prevention strategy implementation
# - Process improvement identification
# - Knowledge sharing with team
```

## Investigation Tools & Commands

### Laravel Debugging Tools
```bash
# Application debugging
./vendor/bin/sail artisan pail --timeout=0
./vendor/bin/sail artisan tinker
./vendor/bin/sail artisan about

# Queue debugging
./vendor/bin/sail artisan queue:monitor
./vendor/bin/sail artisan queue:failed

# Cache debugging
./vendor/bin/sail artisan cache:clear
./vendor/bin/sail artisan config:clear
./vendor/bin/sail artisan view:clear
```

### Database Investigation Tools
```bash
# Database analysis
./vendor/bin/sail artisan db:show
./vendor/bin/sail artisan db:table [table_name]
./vendor/bin/sail artisan db:monitor

# Migration debugging
./vendor/bin/sail artisan migrate:status
./vendor/bin/sail artisan migrate:rollback --pretend
```

### System Monitoring Tools
```bash
# Resource monitoring
./vendor/bin/sail exec app htop
./vendor/bin/sail logs --follow
./vendor/bin/sail ps

# Network debugging
./vendor/bin/sail exec app ping database
./vendor/bin/sail exec app netstat -tuln
```

## Investigation Documentation Patterns

### Issue Report Template
```markdown
# Issue Investigation Report

## Problem Summary
- **Issue**: [Brief description]
- **Severity**: [High/Medium/Low]
- **Affected Systems**: [Components involved]
- **First Observed**: [Timestamp]

## Investigation Process
- **Investigation Method**: [mcp__zen__debug, specialized analysis, etc.]
- **Evidence Gathered**: [Logs, metrics, user reports]
- **Hypotheses Tested**: [List of hypotheses and results]

## Root Cause Analysis
- **Primary Cause**: [Main root cause]
- **Contributing Factors**: [Additional factors]
- **System Interactions**: [How systems contributed]

## Resolution
- **Solution Implemented**: [Description of fix]
- **Testing Performed**: [Validation approach]
- **Prevention Measures**: [Future prevention strategy]

## Lessons Learned
- **Process Improvements**: [Investigation process enhancements]
- **Technical Insights**: [Technical knowledge gained]
- **Prevention Strategies**: [How to prevent similar issues]
```

### Investigation Checklist

#### Pre-Investigation
- [ ] Problem clearly defined and documented
- [ ] Symptoms and context gathered
- [ ] Investigation scope determined
- [ ] Relevant specialists identified

#### During Investigation
- [ ] Evidence systematically collected
- [ ] Hypotheses formed and tested
- [ ] Multiple perspectives considered
- [ ] Investigation progress documented

#### Post-Investigation
- [ ] Root cause clearly identified
- [ ] Solution developed and tested
- [ ] Prevention measures implemented
- [ ] Investigation documented and shared

## Escalation Procedures

### When to Escalate
- Issue persists after systematic investigation
- Multiple systems are affected
- Security or data integrity concerns
- Performance degradation impacts users
- Root cause requires architectural changes

### Escalation Process
1. **Document Investigation**: Complete investigation report
2. **Multi-Specialist Consensus**: Engage relevant specialists
3. **Extended Analysis**: Use advanced investigation tools
4. **Architectural Review**: Consider system-wide implications
5. **Solution Planning**: Develop comprehensive resolution plan

## See Also

- **[Feature Development Workflow](feature-development.md)** - Development process integration
- **[Quality Assurance Workflows](quality-assurance.md)** - QA process integration
- **[Performance Optimization](performance-optimization.md)** - Performance issue resolution
- **[MCP Server Guides](../mcp-servers/)** - Tool-specific debugging approaches
- **[BrowserMCP Guide](../mcp-servers/browsermcp-guide.md)** - Interactive browser debugging and testing