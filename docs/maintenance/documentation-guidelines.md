# Documentation Maintenance Guidelines

## Documentation Ownership & Architecture

This document establishes clear ownership patterns and architectural guidelines to prevent content duplication and maintain consistency across the documentation system.

## 📚 Documentation Architecture Principles

### 1. Clear Role Separation

**Workflows** = **PROCESS AUTHORITY** (How we work)
- Step-by-step procedures applicable to any team member
- Focus on sequence of actions and decision points
- Contain delegation patterns to specialists
- **Never include detailed domain expertise**

**Agents** = **SUBJECT-MATTER AUTHORITY** (Specialized expertise) 
- Deep-dive specialist knowledge and techniques
- Domain-specific implementation patterns and examples
- Comprehensive coverage of specialty areas
- **Never include general process workflows**

### 2. Delegation-First Architecture

All workflows follow the delegation pattern:
```bash
"[SpecialistName]: [specific task with context and requirements]"
```

**Existing Specialists:**
- **DevOps Specialist**: Infrastructure, deployment, Docker, monitoring, agent system integration
- **Security Specialist**: Security audits, vulnerability assessment, data protection, compliance
- **Performance Specialist**: Database optimization, performance analysis, frontend efficiency, scalability  
- **Testing Specialist**: Test coverage, quality assurance, test automation, validation frameworks

## 🚫 Anti-Patterns to Avoid

### Content Duplication Violations
- ❌ **Never** duplicate detailed procedures between workflows and agents
- ❌ **Never** include domain-specific expertise in workflows
- ❌ **Never** include process workflows in agent files
- ❌ **Never** reference non-existent specialists or agents

### Structural Violations
- ❌ **Never** create workflows that assume specialist knowledge
- ❌ **Never** create agents without corresponding specialist expertise
- ❌ **Never** mix process and expertise in the same document

## ✅ Documentation Contribution Rules

### Before Adding Content

1. **Identify Content Type**:
   - Process/Workflow → Goes in `docs/workflows/`
   - Specialist Expertise → Goes in `.claude/agents/`
   - Reference Material → Goes in `docs/reference/`

2. **Check for Existing Coverage**:
   - Search existing documentation for similar content
   - Verify no duplication with agents or workflows
   - Confirm specialist references are valid

3. **Follow Architecture Patterns**:
   - Workflows delegate to existing specialists
   - Agents provide comprehensive domain coverage
   - Reference materials support both workflows and agents

### Content Creation Guidelines

#### For Workflow Documents
```markdown
## AI Specialist Delegation Framework

This [workflow name] coordinates with specialized AI agents for [domain coverage]:

- **DevOps Specialist**: [specific responsibilities]  
- **Security Specialist**: [specific responsibilities]
- **Performance Specialist**: [specific responsibilities]
- **Testing Specialist**: [specific responsibilities]

**Delegation Pattern**: Complex [domain] tasks are delegated to appropriate specialists for expert analysis and implementation.
```

#### For Agent Documents  
```markdown
# [Specialist Name] Agent

**Expert in [core specialization areas] for Laravel TALL stack AI applications.**

## Core Specialization
[Detailed expertise description]

## Key Expertise Areas
[Comprehensive domain coverage]

## Domain-Specific [Area] Strategies
[In-depth technical content and examples]
```

## 🔧 Maintenance Workflows

### Regular Documentation Audits

**Monthly**: Link validation and reference checking
```bash
# Validate all internal links
mcp__serena__search_for_pattern "\[.*\]\(docs/.*\.md\)" --relative_path="docs"

# Check for broken specialist references  
mcp__serena__search_for_pattern "Database Architect|Agent Architect|Knowledge Specialist|TALL Specialist" --relative_path="docs"
```

**Quarterly**: Content duplication analysis
```bash  
# Identify potential duplication between workflows and agents
mcp__zen__analyze --analysis_type=general --focus_areas=["documentation"] 

# Review delegation patterns for consistency
mcp__serena__search_for_pattern "Specialist:" --relative_path="docs/workflows"
```

### Content Review Process

#### New Content Review Checklist
- [ ] Content type correctly identified (workflow/agent/reference)
- [ ] No duplication with existing documentation
- [ ] Specialist references are valid and existing
- [ ] Delegation patterns follow established format
- [ ] Links are functional and properly formatted

#### Content Update Review Checklist  
- [ ] Changes maintain architectural consistency
- [ ] Updates don't introduce duplication
- [ ] Specialist references remain valid
- [ ] Cross-references updated appropriately

## 📋 Documentation Quality Standards

### Writing Standards
- **Clarity**: Write for the intended audience (process vs. expertise)
- **Conciseness**: Avoid redundant information across documents
- **Consistency**: Follow established patterns and terminology
- **Currency**: Keep information up-to-date and relevant

### Technical Standards
- **Links**: All internal links must be functional
- **Code Examples**: All code must be tested and current
- **Commands**: All commands must work in current environment
- **References**: All specialist references must be valid

### Organizational Standards
- **Structure**: Follow established document structure patterns
- **Navigation**: Maintain clear navigation paths between documents
- **Cross-references**: Include appropriate "See Also" sections
- **Indexing**: Update main documentation index when adding content

## 🚨 Violation Resolution Process

### When Violations Are Discovered

1. **Immediate Assessment**: 
   - Assess impact on users and navigation
   - Identify all affected documents
   - Determine priority level (critical/high/medium/low)

2. **Resolution Planning**:
   - Create remediation plan following architectural principles
   - Identify content consolidation opportunities
   - Plan delegation pattern updates

3. **Implementation**:
   - Execute remediation following established patterns
   - Update cross-references and navigation
   - Validate all changes

4. **Prevention**:
   - Update guidelines to prevent similar violations
   - Improve review processes if needed
   - Document lessons learned

## 🔍 Quality Assurance Automation

### Automated Checks (Recommended)

```bash
# Create automated documentation linting script
#!/bin/bash
# docs/scripts/lint-docs.sh

# Check for broken internal links
echo "Checking for broken links..."
find docs/ -name "*.md" -exec grep -l "\[.*\](.*\.md)" {} \; | while read file; do
    grep -o "\[.*\](docs/.*\.md)" "$file" | while read link; do
        target=$(echo "$link" | sed 's/.*(\(.*\))/\1/')
        if [ ! -f "$target" ]; then
            echo "BROKEN LINK in $file: $link"
        fi
    done
done

# Check for obsolete specialist references
echo "Checking for obsolete specialist references..."
grep -r "Database Architect\|Agent Architect\|Knowledge Specialist\|TALL Specialist" docs/ && echo "ERROR: Found obsolete specialist references"

# Check for content duplication patterns
echo "Checking for potential duplication..."
grep -r "### Test Coverage\|## Performance Optimization\|## Security Audit" docs/workflows/ .claude/agents/ | sort | uniq -d
```

### CI/CD Integration

```yaml
# .github/workflows/docs-validation.yml
name: Documentation Validation
on: 
  pull_request:
    paths: ['docs/**']

jobs:
  validate-docs:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Validate Documentation Structure
        run: ./docs/scripts/lint-docs.sh
      - name: Check Link Validity  
        uses: gaurav-nelson/github-action-markdown-link-check@v1
        with:
          use-quiet-mode: 'yes'
          folder-path: 'docs/'
```

## 📚 Documentation Evolution Strategy

### Principles for Growth
- **Delegation-First**: Always prefer delegation to duplication
- **Specialist-Focused**: Build specialist expertise rather than generalist content
- **Process-Driven**: Maintain clear process workflows that leverage specialists
- **Architecture-Consistent**: Ensure all additions follow established patterns

### Future Specialist Additions
If new specialists are needed:

1. **Justification**: Clear business need for specialized domain expertise
2. **Scope Definition**: Non-overlapping domain coverage with existing specialists  
3. **Implementation**: Follow established agent pattern and documentation structure
4. **Integration**: Update all relevant workflows with appropriate delegation patterns
5. **Validation**: Ensure no conflicts with existing architecture

## 📖 Reference Materials

### Quick Reference: Documentation Types

| Type | Location | Purpose | Contains | Delegates To |
|------|----------|---------|----------|--------------|
| **Workflows** | `docs/workflows/` | Process guidance | Step-by-step procedures | Specialists |
| **Agents** | `.claude/agents/` | Domain expertise | Technical depth | N/A |
| **Reference** | `docs/reference/` | Quick lookup | Standards, patterns, commands | Both |
| **MCP Servers** | `docs/mcp-servers/` | Tool guidance | Tool usage patterns | N/A |

### Quick Reference: Existing Specialists

| Specialist | Domain | Workflow Integration |
|------------|---------|---------------------|
| **DevOps Specialist** | Infrastructure, deployment, Docker, agent systems | All infrastructure tasks |
| **Security Specialist** | Security, compliance, data protection | All security-related tasks |  
| **Performance Specialist** | Database, performance, optimization, scalability | All performance tasks |
| **Testing Specialist** | Testing, QA, validation, coverage | All testing tasks |

---

**Last Updated**: January 2025  
**Version**: 1.0 (Post-Reorganization)

By following these guidelines, we maintain a clean, efficient documentation architecture that serves both process needs and domain expertise without duplication or confusion.