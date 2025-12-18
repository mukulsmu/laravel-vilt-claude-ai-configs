# Custom Copilot Agents

This directory contains custom GitHub Copilot agent definitions for specialized tasks.

## How to Use

Create `.agent.md` files in this directory to define custom agents:

```markdown
---
name: "Database Architect"
description: "Expert in database design, migrations, and query optimization"
tools:
  - sql
  - migrations
---

# Database Architect Agent

You are an expert in Laravel database architecture...
```

## Available Agents

Currently, this toolkit relies on the specialist agents defined in `.claude/agents/` which work with Claude Code. For Copilot, use the skills in `.github/skills/` or the main `AGENTS.md` file in the repository root.

## Creating Custom Agents

1. Create a new `.agent.md` file (e.g., `api-specialist.agent.md`)
2. Define metadata in YAML frontmatter
3. Add instructions in Markdown body
4. Reference in Copilot Chat using `@workspace`

## Resources

- [GitHub Docs: Creating Custom Agents](https://docs.github.com/en/copilot/how-tos/use-copilot-agents/coding-agent/create-custom-agents)
- [Agent Skills](../skills/) - Pre-built skill guides
