# GitHub Copilot Instructions

**Project Context**: Laravel 12, Vue 3, Inertia.js (VILT Stack)

## ⚡ Core Workflow Rules (Hybrid Paradigm)

### 1. Memory-First Rule
Before generating any code, check for project-specific context:
- **Routing**: Check `package.json` for `@wayfinder/routes` vs `ziggy-js`
- **Admin Panel**: Check `composer.json` for `filament/filament` vs `laravel/nova`
- **UI Components**: Check for `resources/js/Components/ui/` directory

### 2. Example-First Rule
Before generating complex patterns, reference:
- `.claude/examples/vilt-examples.md` (Frontend patterns)
- `.claude/examples/filament-examples.md` (Admin patterns)
- `.claude/examples/nova-examples.md` (Nova patterns)

### 3. Type-Safety Rule
Always prefer TypeScript and type-safe patterns over string-based alternatives.

---

## 🎯 Strict Generation Rules

### Routing

**IF** `@wayfinder/routes` is present in `package.json`:
```typescript
// ✅ CORRECT - Type-safe Wayfinder
import { posts, users } from '@wayfinder/routes'
router.visit(posts.show({ id: postId }))

// ❌ FORBIDDEN - String-based routing
router.visit(route('posts.show', postId))
```

**IF** `ziggy-js` is present instead:
```typescript
// ✅ CORRECT - Ziggy fallback
import { route } from 'ziggy-js'
router.visit(route('posts.show', postId))
```

### Vue Components

**ALWAYS** use Composition API with `<script setup>`:
```vue
<!-- ✅ CORRECT -->
<script setup lang="ts">
import { ref } from 'vue'
const count = ref(0)
</script>

<!-- ❌ FORBIDDEN - Options API -->
<script>
export default {
  data() {
    return { count: 0 }
  }
}
</script>
```

### UI Components (shadcn-vue)

**IF** `resources/js/Components/ui/` directory exists:
```vue
<!-- ✅ CORRECT - Use pre-built components -->
<script setup lang="ts">
import { Button } from '@/Components/ui/button'
import { Input } from '@/Components/ui/input'
</script>

<template>
  <Button>Click me</Button>
  <Input v-model="value" />
</template>

<!-- ❌ FORBIDDEN - Raw Tailwind HTML when shadcn exists -->
<template>
  <button class="bg-blue-500 px-4 py-2...">Click me</button>
</template>
```

### Form Handling

**ALWAYS** use Inertia's `useForm` composable:
```vue
<script setup lang="ts">
import { useForm } from '@inertiajs/vue3'

interface FormData {
  title: string
  content: string
}

const form = useForm<FormData>({
  title: '',
  content: '',
})

function submit() {
  form.post('/posts', {
    onSuccess: () => form.reset(),
  })
}
</script>
```

**FORBIDDEN** custom form state management:
```typescript
// ❌ Don't do this
const data = reactive({ title: '', content: '' })
```

### Inertia Imports

```typescript
// ✅ CORRECT - Modern Inertia
import { router, Link, useForm, usePage } from '@inertiajs/vue3'

// ❌ FORBIDDEN - Legacy import
import Inertia from '@inertiajs/inertia'
```

---

## 📚 Pattern References

When you need examples for:

- **Forms with validation**: Check `.claude/examples/vilt-examples.md` section 3
- **File uploads with progress**: Check `.claude/examples/vilt-examples.md` section 5
- **shadcn-vue components**: Check `.claude/examples/vilt-examples.md` section 9
- **Filament resources**: Check `.claude/examples/filament-examples.md`
- **Nova resources**: Check `.claude/examples/nova-examples.md`

---

## 🧪 Testing Standards

### PHP Tests (Pest)
```php
// ✅ CORRECT - Pest syntax
it('creates a post', function () {
    $post = Post::factory()->create();
    expect($post)->toBeInstanceOf(Post::class);
});

// ❌ Avoid PHPUnit syntax unless explicitly requested
public function test_creates_post() { ... }
```

### Vue Tests (Vitest)
```typescript
// ✅ CORRECT - Vitest with Vue Test Utils
import { mount } from '@vue/test-utils'
import { describe, it, expect } from 'vitest'

describe('MyComponent', () => {
  it('renders properly', () => {
    const wrapper = mount(MyComponent)
    expect(wrapper.text()).toContain('Hello')
  })
})
```

---

## 🛑 Common Mistakes to Avoid

### Import Errors
```typescript
// ❌ WRONG
import Inertia from '@inertiajs/inertia'
import { InertiaLink } from '@inertiajs/inertia-vue3'

// ✅ CORRECT
import { router, Link } from '@inertiajs/vue3'
```

### Routing Mistakes
```typescript
// ❌ WRONG - Mixing routing systems
import { route } from 'ziggy-js'
import { posts } from '@wayfinder/routes'
router.visit(route('posts.show', 1)) // Don't mix!

// ✅ CORRECT - Use one system consistently
import { posts } from '@wayfinder/routes'
router.visit(posts.show({ id: 1 }))
```

### Form Handling Mistakes
```vue
<!-- ❌ WRONG - Manual form state -->
<script setup>
const data = reactive({ name: '' })
const errors = ref({})
const submit = () => axios.post('/api', data)
</script>

<!-- ✅ CORRECT - Inertia useForm -->
<script setup>
const form = useForm({ name: '' })
const submit = () => form.post('/users')
// Errors automatically available in form.errors
</script>
```

### Component Architecture Mistakes
```vue
<!-- ❌ WRONG - Fetching data client-side -->
<script setup>
const posts = ref([])
onMounted(async () => {
  posts.value = await fetch('/api/posts').then(r => r.json())
})
</script>

<!-- ✅ CORRECT - Server-provided props via Inertia -->
<script setup lang="ts">
defineProps<{
  posts: Post[]
}>()
// Data comes from Laravel controller via Inertia::render()
</script>
```

---

## 🏗️ Project Structure Awareness

### File Organization
- **Pages**: `resources/js/Pages/` - Full Inertia page components
- **Components**: `resources/js/Components/` - Reusable Vue components
- **UI Library**: `resources/js/Components/ui/` - shadcn-vue components
- **Layouts**: `resources/js/Layouts/` - Shared layouts
- **Composables**: `resources/js/composables/` - Reusable logic
- **Types**: `resources/js/types/` - TypeScript definitions

### Admin Panel Detection
- **IF** `filament/filament` in `composer.json`: Generate Filament resources in `app/Filament/Resources/`
- **IF** `laravel/nova` in `composer.json`: Generate Nova resources in `app/Nova/`

---

## 💡 Best Practices

### Performance
- Use Inertia's partial reloads for updates: `router.reload({ only: ['posts'] })`
- Implement lazy loading for heavy components
- Use `v-once` for static content

### Accessibility
- Use semantic HTML elements
- Provide ARIA labels where needed
- Ensure keyboard navigation works

### Security
- Always validate on both client and server
- Use CSRF protection (automatic with Inertia)
- Sanitize user-generated content

### Code Quality
- Prefer TypeScript for type safety
- Use meaningful variable names
- Keep components focused and small
- Write tests for critical functionality

---

## 📖 Additional Resources

For detailed examples and patterns, always check:
- [CLAUDE.md](../CLAUDE.md) - Complete AI development guidelines
- [docs/workflows/](../docs/workflows/) - Development workflows
- [docs/reference/](../docs/reference/) - Quick references

---

**Remember**: This configuration is designed to work in harmony with Claude Code. Both tools should suggest the same patterns to maintain consistency across your codebase.
