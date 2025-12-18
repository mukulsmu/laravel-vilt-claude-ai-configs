# Laravel VILT Stack - GitHub Copilot Coding Agent Instructions

This file provides instructions for GitHub Copilot's Coding Agent when working with Laravel VILT (Vue, Inertia.js, Laravel, Tailwind CSS) stack applications.

## Project Context

This is a Laravel VILT stack application with:
- **Laravel 12** - PHP backend framework
- **Vue 3** - Frontend framework with Composition API
- **Inertia.js** - SPA adapter (no REST API needed)
- **Tailwind CSS** - Utility-first CSS
- **TypeScript** - Optional type safety (recommended)
- **Laravel Herd** - Local PHP development environment

## Architecture Principles

### Separation of Concerns
- **Backend (Laravel)**: Authentication, authorization, validation, business logic, database operations
- **Frontend (Vue)**: UI rendering, user interactions, client-side state
- **Bridge (Inertia)**: Passes data from Laravel controllers to Vue pages seamlessly

### File Structure
```
app/
├── Http/Controllers/     # Inertia page controllers
├── Http/Requests/        # Form validation
├── Models/               # Eloquent models
├── Services/             # Business logic
└── Policies/             # Authorization

resources/js/
├── Pages/                # Inertia page components
├── Components/           # Reusable Vue components
│   └── ui/              # shadcn-vue components
├── Layouts/              # Layout wrappers
├── composables/          # Shared Vue logic
└── types/                # TypeScript definitions
```

## Code Generation Guidelines

### When Creating New Features

1. **Start with the backend**:
   - Create migration with proper constraints
   - Create model with fillable, casts, and relationships
   - Create Form Request for validation
   - Create Controller with Inertia responses

2. **Then create the frontend**:
   - Create Vue page component in `resources/js/Pages/`
   - Use existing UI components from `Components/ui/`
   - Follow existing layout patterns

3. **Always include**:
   - Authorization checks (policies)
   - Validation rules (Form Requests)
   - Tests (Pest feature tests)

### Controller Pattern
```php
// Always return Inertia responses for pages
return Inertia::render('Posts/Index', [
    'posts' => $posts,
    'filters' => $request->only(['search', 'status']),
]);

// Use redirects with flash messages for mutations
return redirect()->route('posts.index')
    ->with('success', 'Post created successfully.');
```

### Vue Component Pattern
```vue
<script setup lang="ts">
// Always use Composition API with TypeScript
import { ref, computed } from 'vue'
import { useForm, usePage, router } from '@inertiajs/vue3'

// Define typed props
const props = defineProps<{
  posts: App.Models.Post[]
}>()

// Use Inertia form helper for mutations
const form = useForm({ title: '', content: '' })

const submit = () => {
  form.post(route('posts.store'), {
    onSuccess: () => form.reset(),
  })
}
</script>
```

## Routing

### Detection
Check the project for routing solution:
- Look for `@wayfinder` imports → Use Wayfinder
- Look for `ziggy-js` or `ZiggyVue` → Use Ziggy

### Usage
```typescript
// Wayfinder (modern)
import { posts } from '@wayfinder/routes'
router.visit(posts.show({ id: 1 }))

// Ziggy (legacy)
import { route } from 'ziggy-js'
router.visit(route('posts.show', 1))
```

## Testing Approach

### Feature Tests (Required)
```php
test('can view posts index', function () {
    $user = User::factory()->create();
    Post::factory(3)->create();

    $this->actingAs($user)
        ->get(route('posts.index'))
        ->assertInertia(fn ($page) => $page
            ->component('Posts/Index')
            ->has('posts.data', 3)
        );
});
```

### Always Test
- Happy path (successful operations)
- Validation errors
- Authorization (forbidden for unauthorized users)
- Edge cases

## Security Requirements

- **Validation**: Always use Form Requests
- **Authorization**: Always use Policies
- **CSRF**: Handled automatically by Inertia
- **XSS**: Handled automatically by Vue's reactivity

## Performance Considerations

- Use eager loading (`with()`) to prevent N+1 queries
- Use Inertia's partial reloads (`only` parameter)
- Paginate large datasets
- Cache expensive queries

## Commands

```bash
# Generate resources
php artisan make:model Post -mfc      # Model with migration, factory, controller
php artisan make:request StorePostRequest  # Form validation

# Development
npm run dev                           # Vite dev server
php artisan serve                     # Laravel dev server (or use Herd)

# Testing
php artisan test                      # Run all tests
php artisan test --filter PostTest    # Run specific test
```

## Error Handling

### In Controllers
```php
// Use abort() for authorization
abort_unless($user->can('update', $post), 403);

// Use Form Requests for validation (automatic 422 response)
public function store(StorePostRequest $request) { ... }
```

### In Vue Components
```vue
<script setup>
const form = useForm({ ... })

const submit = () => {
  form.post(route('posts.store'), {
    onError: (errors) => {
      // Handle validation errors
      console.error(errors)
    },
    onSuccess: () => {
      // Handle success
      form.reset()
    },
  })
}
</script>

<template>
  <!-- Display validation errors -->
  <span v-if="form.errors.title" class="text-red-500 text-sm">
    {{ form.errors.title }}
  </span>
</template>
```

## Styling Guidelines

- Use Tailwind CSS utility classes
- Follow mobile-first responsive design
- Use shadcn-vue components when available
- Keep consistent spacing (4, 6, 8, 12, 16, 24)

## Important Notes for Agent

1. **Don't create REST APIs** - Use Inertia's automatic page-based routing
2. **Don't use Alpine.js** - Vue 3 handles all client-side interactions
3. **Don't use Blade components** - Use Vue components instead
4. **Always use typed PHP** - Use PHP 8.2+ features
5. **Prefer TypeScript** - For Vue components when possible
6. **Follow existing patterns** - Look at existing code before creating new patterns
