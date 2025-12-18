# GitHub Copilot Usage Guide for Laravel VILT

**Purpose**: Explain the differences between Claude Code and GitHub Copilot for Laravel VILT development

## Overview

This Laravel VILT configuration supports **both Claude Code and GitHub Copilot**, with each tool serving complementary roles in your development workflow.

---

## Tool Comparison

### Claude Code - The Architect

**Best For:**
- 🏗️ Feature planning and architecture decisions
- 🔍 Comprehensive codebase analysis
- 🐛 Complex debugging and investigation
- 📊 Performance optimization
- 🔒 Security audits
- 📝 Documentation generation
- 🧪 Test suite creation

**Capabilities:**
- Full project context awareness via MCP servers
- Multi-file refactoring
- Semantic code navigation (Serena MCP)
- Access to up-to-date documentation (Context7 MCP)
- Browser automation and testing (Playwright MCP)
- Advanced reasoning (Zen MCP)
- Memory persistence across sessions

**Usage Pattern:**
```bash
# Start Claude with specific task
claude "Implement user authentication following VILT patterns"

# Comprehensive analysis
claude "Analyze and optimize database queries in PostController"

# Architecture decisions
claude "Should we use Filament or build custom admin with Inertia?"
```

---

### GitHub Copilot - The Autocompleter

**Best For:**
- ⚡ Real-time code completion while typing
- 🔧 Quick function implementations
- 📝 Inline documentation generation
- 🎨 Vue component scaffolding
- 🔄 Repetitive code patterns
- 💡 Code suggestions based on context

**Capabilities:**
- Instant suggestions as you type
- Line and block completions
- Chat interface for quick questions
- Pattern recognition from codebase
- Language-aware completions
- Inline documentation

**Usage Pattern:**
```php
// Start typing, Copilot suggests completion
public function store(Request $request)
{
    // Copilot suggests validation rules
    
    // Copilot suggests model creation
    
    // Copilot suggests return response
}
```

---

## Complementary Workflow

### Ideal Development Flow

```
1. Planning (Claude Code)
   ↓
   claude "Plan feature: User profile editing with image upload"
   - Claude analyzes existing code
   - Suggests architecture
   - Creates implementation plan
   
2. Implementation (GitHub Copilot)
   ↓
   - Open files suggested by Claude
   - Start typing, Copilot autocompletes
   - Copilot suggests patterns from .claude/examples/
   - Quick inline fixes with Copilot
   
3. Review (Claude Code)
   ↓
   claude "Review changes with Zen code review"
   - Claude analyzes all changes
   - Provides comprehensive feedback
   - Suggests improvements
   
4. Testing (Both)
   ↓
   - Claude generates test structure
   - Copilot autocompletes test cases
   - Claude runs and debugs tests
```

---

## Configuration Differences

### Claude Code Configuration

**File:** `CLAUDE.md` (main controller)

**Features:**
- MCP server integration
- Memory system (project_context)
- Specialist agents
- Workflow documentation
- Quality gates

**Example:**
```bash
# Claude reads comprehensive context
mcp__serena__read_memory "project_context"
mcp__serena__get_symbols_overview "app/Models"
```

---

### GitHub Copilot Configuration

**File:** `.github/copilot-instructions.md`

**Features:**
- Simplified rules (no MCP)
- Same example files as Claude
- Direct file inspection
- Inline code generation

**Example:**
```typescript
// Copilot checks package.json for @wayfinder/routes
// Then suggests type-safe routing
import { posts } from '@wayfinder/routes'
router.visit(posts.show({ id: 1 }))
```

---

## Shared Knowledge Base

### Both Tools Reference Same Examples

**Location:** `.claude/examples/`

**Files:**
- `vilt-examples.md` - Vue, Inertia, Wayfinder patterns
- `filament-examples.md` - Filament admin examples
- `nova-examples.md` - Nova admin examples

**Benefit:** Consistency across both tools

```vue
<!-- Both Claude and Copilot suggest same pattern -->
<script setup lang="ts">
import { useForm } from '@inertiajs/vue3'
import { Button } from '@/Components/ui/button'

const form = useForm({
  title: '',
  content: '',
})
</script>
```

---

## When to Use Each Tool

### Use Claude Code When:

1. **Starting New Features**
   ```bash
   claude "Plan implementation of blog post system with VILT stack"
   ```
   - Need architecture decisions
   - Require multi-file coordination
   - Want quality assurance gates

2. **Debugging Complex Issues**
   ```bash
   claude "Debug N+1 query issue in dashboard using Serena and Boost"
   ```
   - Need to trace across files
   - Require performance analysis
   - Want systematic investigation

3. **Code Reviews**
   ```bash
   claude "Review all staged changes with Zen"
   ```
   - Need comprehensive analysis
   - Want security audit
   - Require architectural feedback

4. **Refactoring**
   ```bash
   claude "Extract service layer from UserController using Serena"
   ```
   - Multi-file changes
   - Need impact analysis
   - Want consistency checks

---

### Use GitHub Copilot When:

1. **Writing Boilerplate Code**
   ```php
   // Type: public function store(
   // Copilot autocompletes full method with validation
   ```

2. **Implementing Known Patterns**
   ```vue
   <!-- Type: <script setup lang="ts">
   <!-- Copilot suggests standard Inertia form setup
   ```

3. **Quick Documentation**
   ```php
   // Type: /**
   // Copilot generates PHPDoc from method signature
   ```

4. **Repetitive Tasks**
   ```typescript
   // Type: const form = useForm({
   // Copilot suggests form fields from nearby code
   ```

---

## Hybrid Paradigm Rules

### Both Tools Follow Same Standards

#### 1. Memory-First Rule

**Claude Code:**
```bash
mcp__serena__read_memory "project_context"
# Checks: Wayfinder vs Ziggy, Filament vs Nova
```

**GitHub Copilot:**
```typescript
// Reads package.json for @wayfinder/routes
// Reads composer.json for filament/filament
// Adapts suggestions accordingly
```

---

#### 2. Example-First Rule

**Claude Code:**
```bash
# Reads .claude/examples/vilt-examples.md
mcp__serena__read_file --path=".claude/examples/vilt-examples.md"
```

**GitHub Copilot:**
```vue
<!-- References .claude/examples/vilt-examples.md
<!-- Suggests patterns from Section 3: Forms
```

---

#### 3. Type-Safety Rule

**Both tools prefer TypeScript:**

```typescript
// ✅ Both suggest type-safe patterns
import { posts } from '@wayfinder/routes'
router.visit(posts.show({ id: postId }))

// ❌ Both avoid string-based
router.visit(route('posts.show', postId))
```

---

## Practical Examples

### Example 1: Creating a New Resource

**Claude Code (Planning):**
```bash
claude "Plan implementation of Comment resource with VILT stack"

# Claude Output:
# 1. Create Model: app/Models/Comment.php
# 2. Create Migration: database/migrations/*_create_comments_table.php
# 3. Create Controller: app/Http/Controllers/CommentController.php
# 4. Create Vue Pages: resources/js/Pages/Comments/
# 5. Add Routes: routes/web.php
# 6. Add Tests: tests/Feature/CommentTest.php
```

**GitHub Copilot (Implementation):**
```php
// Open Comment.php, start typing
class Comment extends Model
{
    // Copilot autocompletes:
    use HasFactory, SoftDeletes;
    
    protected $fillable = [
        'content',
        'post_id',
        'user_id',
    ];
    
    public function post()
    {
        return $this->belongsTo(Post::class);
    }
    
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
```

---

### Example 2: Form Implementation

**Claude Code (Structure):**
```bash
claude "Create comment form following .claude/examples/vilt-examples.md patterns"

# Claude reads examples, creates file structure
```

**GitHub Copilot (Details):**
```vue
<!-- Start typing in CommentForm.vue -->
<script setup lang="ts">
import { useForm } from '@inertiajs/vue3'
import { Button } from '@/Components/ui/button'
import { Textarea } from '@/Components/ui/textarea'

// Copilot suggests full form based on examples
interface CommentForm {
  content: string
  post_id: number
}

const props = defineProps<{
  post: Post
}>()

const form = useForm<CommentForm>({
  content: '',
  post_id: props.post.id,
})

const submit = () => {
  form.post('/comments', {
    preserveScroll: true,
    onSuccess: () => form.reset(),
  })
}
</script>

<template>
  <form @submit.prevent="submit">
    <Textarea
      v-model="form.content"
      :error="form.errors.content"
    />
    <Button type="submit" :disabled="form.processing">
      Submit Comment
    </Button>
  </form>
</template>
```

---

## Troubleshooting

### Copilot Suggests Wrong Patterns

**Problem:** Copilot suggests Ziggy when project uses Wayfinder

**Solution:** 
1. Ensure `.github/copilot-instructions.md` is in repository root
2. Check `package.json` has `@wayfinder/routes` listed
3. Copilot learns from rejecting bad suggestions

**Fix:**
```typescript
// When Copilot suggests:
router.visit(route('posts.show', id)) // ❌

// Manually type correct pattern:
import { posts } from '@wayfinder/routes'
router.visit(posts.show({ id })) // ✅

// Copilot learns from your corrections
```

---

### Claude Can't Access Recent Changes

**Problem:** Claude references old code

**Solution:**
```bash
# Update Claude's memory
claude "Update project_context memory with recent changes"

# Or refresh Serena's cache
mcp__serena__get_symbols_overview "app/Models"
```

---

## Best Practices

### 1. Division of Labor

```
Claude Code: Think → Plan → Review → Test
GitHub Copilot: Type → Autocomplete → Suggest → Refine
```

### 2. Start with Claude, Finish with Copilot

```bash
# Morning: Plan with Claude
claude "Plan today's tasks: implement comment system"

# Day: Implement with Copilot
# Use Copilot autocomplete for all implementations

# Evening: Review with Claude
claude "Review today's changes with Zen"
```

### 3. Use Examples as Source of Truth

```
Both tools reference .claude/examples/
- Claude reads them with MCP
- Copilot learns from them via training
- Keep examples updated for consistency
```

### 4. Correct and Train

```typescript
// When tools suggest wrong patterns:
// 1. Type correct pattern manually
// 2. Both tools learn from your corrections
// 3. Future suggestions improve
```

---

## Configuration Checklist

### For Claude Code Users

- [ ] Install Claude Code CLI: `npm install -g @anthropic/claude-code`
- [ ] Configure MCP servers in `~/.config/claude-code/config.json`
- [ ] Initialize project memory: Follow `docs/setup/init-memory.md`
- [ ] Read `CLAUDE.md` for full capabilities

### For GitHub Copilot Users

- [ ] Install Copilot in VS Code/IDE
- [ ] Ensure `.github/copilot-instructions.md` exists in project
- [ ] Verify `.claude/examples/` directory present
- [ ] Configure Copilot settings in IDE

### For Both

- [ ] Review `.claude/examples/` patterns
- [ ] Check `package.json` for routing system
- [ ] Check `composer.json` for admin panel
- [ ] Verify shadcn-vue components installed

---

## Keyboard Shortcuts (VS Code)

### GitHub Copilot

```
Cmd/Ctrl + I          Open Copilot Chat
Tab                   Accept suggestion
Cmd/Ctrl + →          Accept word
Alt + [               Previous suggestion
Alt + ]               Next suggestion
Cmd/Ctrl + Enter      Show all suggestions
```

### Claude Code

```bash
# Terminal-based, no keyboard shortcuts
claude "your request"
```

---

## Cost Comparison

### Claude Code
- Pay per API usage
- More expensive per request
- Better for complex tasks
- Higher value for architecture

### GitHub Copilot
- Flat monthly subscription ($10-19/mo)
- Unlimited suggestions
- Better for repetitive work
- Higher value for coding speed

**Recommendation:** Use both - they complement each other perfectly.

---

## Summary

| Feature | Claude Code | GitHub Copilot |
|---------|-------------|----------------|
| **Purpose** | Architecture & Analysis | Autocomplete & Suggestions |
| **When to Use** | Planning, Review, Debug | Typing, Implementing |
| **Scope** | Project-wide | File/Context-aware |
| **Memory** | Persistent across sessions | Current file + nearby files |
| **Tools** | MCP servers | None (built-in) |
| **Cost** | Per-use API | Monthly subscription |
| **Best For** | Strategy | Tactics |

**Use together for maximum productivity!**

---

## Related Resources

- **[CLAUDE.md](../../CLAUDE.md)** - Complete Claude Code documentation
- **[.github/copilot-instructions.md](../../.github/copilot-instructions.md)** - Copilot configuration
- **[VILT Examples](.claude/examples/vilt-examples.md)** - Shared code patterns
- **[AI Interaction Patterns](../reference/ai-interaction-patterns.md)** - Best practices

---

**Pro Tip**: Use Claude for architecture decisions in the morning, Copilot for implementation during the day, and Claude for code review in the evening. This creates a perfect rhythm of strategic thinking and tactical execution.
