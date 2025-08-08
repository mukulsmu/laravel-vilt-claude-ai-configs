# Quality Assurance Workflows

Comprehensive quality assurance processes for the Marlin Laravel TALL stack application using AI-assisted workflows.

## Overview

This document outlines systematic approaches to ensuring code quality, security, performance, and reliability through automated and AI-assisted quality assurance workflows.

## AI Specialist Delegation Framework

This QA workflow coordinates with specialized AI agents for comprehensive quality assurance:

- **DevOps Specialist**: Infrastructure security, deployment validation, CI/CD pipeline optimization, and agent system review
- **Security Specialist**: Security audits, vulnerability assessment, compliance validation, and threat analysis  
- **Performance Specialist**: Performance analysis, optimization recommendations, database tuning, and scalability assessment
- **Testing Specialist**: Test coverage analysis, quality validation, test automation, and comprehensive testing strategies

**Quality Assurance Delegation**: Complex QA tasks are delegated to domain specialists who provide expert analysis and recommendations integrated with MCP quality tools.

## Pre-Commit Quality Gates

### 1. Automated Code Quality Checks
```bash
# Comprehensive pre-commit validation
mcp__zen__precommit

# This workflow includes:
# - Code formatting (Laravel Pint)
# - Static analysis and type checking
# - Test suite execution
# - Security vulnerability scanning
# - Performance impact assessment
```

### 2. Manual Code Review Checklist
Before committing significant changes:

**Code Structure & Organization:**
- [ ] Code follows TALL stack conventions
- [ ] Components are properly organized and scoped
- [ ] Business logic is separated into service classes
- [ ] Database relationships are optimized
- [ ] Error handling is comprehensive

**Security Considerations:**
- [ ] Input validation is thorough
- [ ] Authorization checks are implemented
- [ ] SQL injection vulnerabilities are prevented
- [ ] XSS protection is in place
- [ ] Sensitive data is properly protected

**Performance Optimization:**
- [ ] Database queries are optimized
- [ ] N+1 query problems are prevented
- [ ] Caching is implemented where appropriate
- [ ] Asset loading is optimized
- [ ] Memory usage is reasonable

## Code Review Workflows

### 1. AI-Assisted Code Review
For comprehensive code analysis:

```bash
# Full codebase review
mcp__zen__codereview

# Focus areas for review:
# - Code quality and maintainability
# - Security vulnerabilities
# - Performance bottlenecks
# - Architectural consistency
# - Test coverage adequacy
```

**Code Review Process:**
1. **Automated Analysis**: AI reviews code structure, patterns, and potential issues
2. **Security Assessment**: Comprehensive security vulnerability analysis
3. **Performance Evaluation**: Performance impact assessment and optimization suggestions
4. **Best Practices Validation**: Adherence to TALL stack and Laravel conventions
5. **Improvement Recommendations**: Specific suggestions for code enhancement

### 2. Specialized Domain Reviews

#### Frontend Component Review (Performance Specialist)

```bash
"Performance Specialist + mcp__zen__codereview: Review all Livewire components for:
- Component architecture and organization
- Real-time update implementation
- Responsive design compliance  
- Alpine.js integration patterns
- Performance optimization opportunities"
```

#### Database & Performance Review (Performance Specialist)
```bash
# Performance specialist database review
"Performance Specialist + mcp__zen__analyze: Analyze database layer for:
- Schema design optimization
- Query performance issues
- Index effectiveness
- Relationship optimization
- Migration safety"
```

#### Agent System Review (DevOps Specialist)
```bash
# DevOps specialist agent system review
"DevOps Specialist + mcp__zen__codereview: Review agent integrations for:
- Tool implementation quality
- Prism-PHP usage patterns
- Streaming performance
- Error handling robustness
- Multi-agent coordination"
```

#### Knowledge System Review (Security Specialist)
```bash
# Security specialist knowledge system review
"Security Specialist + mcp__zen__analyze: Analyze knowledge system for:
- RAG pipeline security
- Vector search access control
- Document processing validation
- Data privacy compliance
- Search query sanitization"
```

## Security Audit Workflows

### 1. Comprehensive Security Assessment
```bash
# Full security audit
mcp__zen__secaudit

# Security audit covers:
# - OWASP Top 10 vulnerabilities
# - Authentication and authorization
# - Input validation and sanitization
# - Data encryption and protection
# - Session management
# - API security
```

### 2. Domain-Specific Security Reviews

#### Database Security Audit
```bash
# Database security assessment
"Security Specialist + mcp__zen__secaudit: Audit database security:
- Access control and permissions
- Data encryption at rest and in transit
- SQL injection prevention
- Audit trail implementation
- Backup security"
```

#### API Security Review
```bash
# API security assessment
mcp__zen__secaudit --focus=api

# Focuses on:
# - Authentication mechanisms
# - Rate limiting implementation
# - Input validation
# - CORS configuration
# - API versioning security
```

#### Knowledge System Security
```bash
# Knowledge system security review
"Security Specialist + mcp__zen__secaudit: Review knowledge security:
- Document access control
- Vector data protection
- Search query sanitization
- Knowledge source attribution
- Content filtering"
```

## Performance Optimization Workflows

### Comprehensive Performance Analysis
```bash
# Delegate all performance optimization to Performance Specialist  
"Performance Specialist: Conduct comprehensive performance analysis for [system/feature] including database optimization, frontend performance, caching strategies, and scalability improvements."

# Key performance areas:
# - System-wide performance analysis and benchmarking
# - Database query optimization and indexing
# - Frontend component rendering efficiency  
# - Real-time update performance optimization
# - Memory usage and resource optimization
# - Agent system and API performance tuning
```

**See [Performance Specialist](../agents/performance-specialist.md) for detailed performance optimization strategies and implementation patterns.**

## Testing Quality Assurance

### Comprehensive Testing Workflows
```bash
# Delegate all testing processes to Testing Specialist
"Testing Specialist: Implement comprehensive test coverage for [feature/system] including unit tests, integration tests, browser tests, and performance validation. Ensure quality gates are met."

# Key testing areas:
# - Test coverage analysis and reporting
# - AI-assisted test quality review
# - Automated test suite generation
# - Continuous testing quality monitoring
# - Testing quality gate validation
```

**See [Testing Specialist](../agents/testing-specialist.md) for detailed testing strategies and implementation patterns.**

## Documentation Quality Assurance

### 1. Documentation Generation & Review
```bash
# Generate comprehensive documentation
mcp__zen__docgen

# Documentation review includes:
# - Code comment adequacy
# - API documentation completeness
# - Architecture decision documentation
# - User guide accuracy
# - Development guide currency
```

### 2. Documentation Maintenance
```bash
# Update project documentation
mcp__serena__write_memory "qa_processes" [qa_documentation]

# Ensure documentation covers:
# - QA process updates
# - Quality standard changes
# - Tool usage guidelines
# - Best practice evolution
```

## Continuous Quality Monitoring

### 1. Automated Quality Metrics
Set up monitoring for key quality metrics:

**Code Quality Metrics:**
- Code complexity scores
- Duplication percentages
- Test coverage percentages
- Static analysis issue counts

**Performance Metrics:**
- Response time percentiles
- Database query performance
- Memory usage patterns
- Error rates and types

**Security Metrics:**
- Vulnerability scan results
- Security policy compliance
- Access control effectiveness
- Audit trail completeness

### 2. Quality Trend Analysis
```bash
# Regular quality assessment
mcp__zen__analyze --analysis_type=quality

# Track trends in:
# - Code quality improvements/degradation
# - Performance characteristics over time
# - Security posture evolution
# - Test coverage changes
# - Documentation completeness
```

## Quality Gate Definitions

### Commit Quality Gates
Before code can be committed:
- [ ] All tests pass
- [ ] Code formatting is correct (Pint)
- [ ] No critical security issues
- [ ] Performance impact is acceptable
- [ ] Documentation is updated

### Pull Request Quality Gates
Before code can be merged:
- [ ] AI-assisted code review passes
- [ ] Security audit shows no high-risk issues
- [ ] Performance benchmarks meet requirements
- [ ] Test coverage meets minimum thresholds
- [ ] Documentation review is complete

### Release Quality Gates
Before code can be deployed to production:
- [ ] Full regression test suite passes
- [ ] Comprehensive security audit complete
- [ ] Performance validation under load
- [ ] Documentation is production-ready
- [ ] Rollback procedures are tested

## Emergency Quality Procedures

### Critical Issue Response
For critical security or performance issues:

1. **Immediate Assessment**:
   ```bash
   mcp__zen__debug --confidence=certain
   ```

2. **Multi-Specialist Analysis**:
   ```bash
   # Coordinate multiple specialists for rapid analysis
   mcp__zen__consensus --models=[o3,gemini-2.5-pro,claude-3.5-sonnet]
   ```

3. **Rapid Fix Validation**:
   ```bash
   mcp__zen__precommit --severity_filter=critical
   ```

### Quality Incident Post-Mortem
After resolving quality issues:

1. **Root Cause Analysis**:
   ```bash
   mcp__zen__thinkdeep --thinking_mode=high
   ```

2. **Process Improvement Planning**:
   ```bash
   mcp__zen__planner --step_number=1
   ```

3. **Prevention Strategy Development**:
   ```bash
   # Document lessons learned and process improvements
   mcp__serena__write_memory "quality_incident_learnings" [analysis]
   ```

## Quality Metrics Dashboard

### Key Quality Indicators (KQIs)
Track these metrics for overall quality health:

**Code Quality KQIs:**
- Cyclomatic complexity average: < 10
- Code duplication percentage: < 5%
- Test coverage: > 85%
- Static analysis issues: < 10 per 1000 lines

**Performance KQIs:**
- API response time (95th percentile): < 200ms
- Database query time (95th percentile): < 50ms
- Frontend rendering time: < 100ms
- Memory usage growth: < 5% per month

**Security KQIs:**
- Critical vulnerabilities: 0
- High-risk vulnerabilities: < 5
- Security policy compliance: 100%
- Failed security tests: 0

## Quality Assurance Tools Integration

### MCP Server Tool Usage
- **mcp__zen__codereview**: Comprehensive code quality analysis
- **mcp__zen__secaudit**: Security vulnerability assessment
- **mcp__zen__analyze**: Performance and architecture analysis
- **mcp__zen__testgen**: Test generation and coverage improvement
- **mcp__zen__precommit**: Pre-commit validation workflows
- **mcp__zen__debug**: Issue investigation and resolution

### Laravel-Specific QA Tools
```bash
# Code formatting and style
./vendor/bin/sail pint

# Static analysis
./vendor/bin/sail artisan insights

# Performance profiling
./vendor/bin/sail artisan telescope:install

# Security scanning
./vendor/bin/sail composer audit
```

## Team Quality Practices

### Quality Culture Development
- **Quality First Mindset**: Prioritize quality over speed
- **Continuous Learning**: Stay updated with quality best practices
- **Collaborative Reviews**: Encourage team code reviews
- **Quality Metrics Awareness**: Understand and monitor quality indicators

### Quality Training & Development
- Regular quality workshop sessions
- AI-assisted quality tool training
- Security awareness programs
- Performance optimization techniques
- Testing best practices

## Quality Assurance Checklist

### Daily Quality Practices
- [ ] Run pre-commit quality checks
- [ ] Review quality metrics dashboard
- [ ] Address high-priority quality issues
- [ ] Update quality documentation

### Weekly Quality Reviews
- [ ] Comprehensive code review of recent changes
- [ ] Security vulnerability assessment
- [ ] Performance trend analysis
- [ ] Test coverage review

### Monthly Quality Assessments
- [ ] Full system security audit
- [ ] Performance benchmarking
- [ ] Quality process effectiveness review
- [ ] Quality metrics trend analysis

## See Also

- **[Feature Development Workflow](feature-development.md)** - Development process integration
- **[Debugging & Investigation](debugging-investigation.md)** - Quality issue resolution
- **[Performance Optimization](performance-optimization.md)** - Performance quality workflows
- **[Code Conventions & Standards](../reference/code-conventions.md)** - Quality standards reference