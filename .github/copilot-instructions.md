# GitHub Copilot Instructions - Laravel VILT Stack

**Architecture**: This configuration works with Laravel Boost for optimal AI-powered development.

## How This Works

This file provides VILT stack-specific instructions for GitHub Copilot. It works alongside Laravel Boost's base Laravel configuration.

**Laravel Boost Base Instructions**: See [`.github/instructions/laravel-boost-base.instructions.md`](.github/instructions/laravel-boost-base.instructions.md) for the base Laravel conventions that Laravel Boost provides. Those instructions are automatically available when Laravel Boost is installed. This file adds VILT-specific enhancements.

**No Merging Required**: Simply copy this file to your project. Copilot will reference both this file and the Boost base instructions automatically through the path-scoped instruction system.

---

# VILT Stack Configuration

This file provides repository-wide instructions for GitHub Copilot to generate consistent, high-quality code for Laravel VILT (Vue, Inertia.js, Laravel, Tailwind CSS) stack applications.

## Technology Stack

- **Laravel 12** - Modern PHP framework with latest features
- **Vue 3** - Progressive JavaScript framework with Composition API
- **Inertia.js** - SPA adapter bridging Laravel and Vue (no REST API needed)
- **Tailwind CSS** - Utility-first CSS framework
- **TypeScript** - Optional type safety (recommended)
- **Vite** - Fast build tool and dev server
- **Laravel Herd** - Native PHP development environment
- **Pest/PHPUnit** - PHP testing framework
- **Vitest** - Vue component testing framework
- **Ziggy/Wayfinder** - Laravel routes in JavaScript

## Code Generation Guidelines

### PHP/Laravel Conventions

- Use PHP 8.2+ features (typed properties, enums, match expressions)
- Follow PSR-12 coding standards
- Use strict types declaration: `declare(strict_types=1);`
- Prefer dependency injection over facades where testable
- Use Form Requests for validation
- Use Resource classes for API responses
- Follow Laravel naming conventions (StudlyCase models, camelCase methods)

### Laravel Controller Pattern

```php
<?php

declare(strict_types=1);

namespace App\Http\Controllers;

use App\Models\Post;
use App\Http\Requests\StorePostRequest;
use Illuminate\Http\RedirectResponse;
use Inertia\Inertia;
use Inertia\Response;

class PostController extends Controller
{
    public function index(): Response
    {
        return Inertia::render('Posts/Index', [
            'posts' => Post::with('user')->latest()->paginate(15),
        ]);
    }

    public function store(StorePostRequest $request): RedirectResponse
    {
        Post::create($request->validated());

        return redirect()->route('posts.index')
            ->with('success', 'Post created successfully.');
    }
}
```

### Laravel Model Pattern

```php
<?php

declare(strict_types=1);

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

class Post extends Model
{
    use HasFactory, SoftDeletes;

    // Order: traits → fillable → casts → relationships → accessors → scopes

    protected $fillable = [
        'title',
        'content',
        'user_id',
    ];

    protected $casts = [
        'published_at' => 'datetime',
        'is_featured' => 'boolean',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function scopePublished($query)
    {
        return $query->whereNotNull('published_at');
    }
}
```

### Vue 3 Component Pattern (Composition API)

```vue
<script setup lang="ts">
import { ref, computed, watch, onMounted } from 'vue'
import { usePage, useForm, router } from '@inertiajs/vue3'
import { Button } from '@/Components/ui/button'
import { Card, CardHeader, CardTitle, CardContent } from '@/Components/ui/card'

// Define props with TypeScript
interface Post {
  id: number
  title: string
  content: string
}

const props = defineProps<{
  posts: Post[]
  filters?: { search?: string }
}>()

// Reactive state
const search = ref(props.filters?.search ?? '')
const isLoading = ref(false)

// Computed properties
const filteredPosts = computed(() =>
  props.posts.filter(post =>
    post.title.toLowerCase().includes(search.value.toLowerCase())
  )
)

// Form handling with Inertia
const form = useForm({
  title: '',
  content: '',
})

const submitForm = () => {
  form.post(route('posts.store'), {
    onSuccess: () => form.reset(),
  })
}

// Watchers for reactive updates
watch(search, (value) => {
  router.get(route('posts.index'), { search: value }, {
    preserveState: true,
    replace: true,
  })
})
</script>

<template>
  <div class="container mx-auto px-4 py-8">
    <Card>
      <CardHeader>
        <CardTitle>Posts</CardTitle>
      </CardHeader>
      <CardContent>
        <!-- Content here -->
      </CardContent>
    </Card>
  </div>
</template>
```

### Inertia.js Patterns

- Use `Inertia::render()` in controllers for page responses
- Use `router.visit()` or `<Link>` component for navigation
- Use `useForm()` composable for form handling with validation
- Use `usePage()` to access shared props (auth, flash, etc.)
- Use `only` parameter for partial reloads to optimize data fetching

### Routing Solutions

**Wayfinder (Recommended for Laravel 12+):**
```typescript
import { posts, users } from '@wayfinder/routes'
router.visit(posts.show({ id: postId }))
```

**Ziggy (Legacy/Jetstream Projects):**
```typescript
import { route } from 'ziggy-js'
router.visit(route('posts.show', postId))
```

### Tailwind CSS Guidelines

- Use utility-first approach
- Follow mobile-first responsive design (sm → md → lg → xl)
- Use consistent spacing scale (4, 6, 8, 12, 16, etc.)
- Prefer component classes for repeated patterns
- Use Tailwind's color palette consistently

**Utility class order:**
1. Positioning: `relative`, `absolute`, `fixed`
2. Box Model: `flex`, `grid`, `w-*`, `h-*`, `p-*`, `m-*`
3. Borders: `border-*`, `rounded-*`
4. Backgrounds: `bg-*`
5. Typography: `text-*`, `font-*`
6. Visual Effects: `shadow-*`, `opacity-*`, `transition-*`

### TypeScript Guidelines

- Use strict mode in tsconfig.json
- Define interfaces for props and data structures
- Use type inference where possible
- Export types from dedicated type files (`resources/js/types/`)
- Use `defineProps<T>()` for typed Vue component props

## Testing Guidelines

### PHP Testing (Pest)

```php
<?php

use App\Models\Post;
use App\Models\User;
use Inertia\Testing\AssertableInertia as Assert;

test('can view posts index', function () {
    $user = User::factory()->create();
    Post::factory(3)->create();

    $this->actingAs($user)
        ->get(route('posts.index'))
        ->assertInertia(fn (Assert $page) => $page
            ->component('Posts/Index')
            ->has('posts.data', 3)
        );
});

test('validates required fields when creating post', function () {
    $user = User::factory()->create();

    $this->actingAs($user)
        ->post(route('posts.store'), [])
        ->assertSessionHasErrors(['title', 'content']);
});
```

### Vue Testing (Vitest)

```typescript
import { mount } from '@vue/test-utils'
import { describe, it, expect } from 'vitest'
import MyComponent from '@/Components/MyComponent.vue'

describe('MyComponent', () => {
  it('renders correctly', () => {
    const wrapper = mount(MyComponent, {
      props: { title: 'Test Title' }
    })

    expect(wrapper.text()).toContain('Test Title')
  })

  it('handles user interactions', async () => {
    const wrapper = mount(MyComponent)
    await wrapper.find('button').trigger('click')

    expect(wrapper.emitted('submit')).toBeTruthy()
  })
})
```

## Security Guidelines

- Always validate and sanitize user input
- Use Laravel's CSRF protection (automatic with Inertia)
- Use prepared statements (Eloquent handles this automatically)
- Never expose sensitive data in Inertia props
- Use proper authorization with Gates and Policies
- Escape output with Vue's automatic XSS protection

## Performance Guidelines

- Use Eloquent eager loading to prevent N+1 queries
- Use Inertia partial reloads (`only` parameter)
- Implement pagination for large datasets
- Use Laravel caching for expensive queries
- Lazy-load Vue components for code splitting
- Use proper database indexes

## File Organization

```
app/
├── Http/
│   ├── Controllers/         # Controllers with Inertia responses
│   └── Requests/            # Form Request validation
├── Models/                  # Eloquent models
└── Services/                # Business logic services

resources/js/
├── Components/              # Reusable Vue components
│   └── ui/                  # shadcn-vue components
├── Layouts/                 # Layout components
├── Pages/                   # Inertia page components
├── composables/             # Vue composables
├── types/                   # TypeScript type definitions
└── app.ts                   # Vue app initialization
```

## Common Commands

```bash
# Development
php artisan serve           # Start dev server (or use Herd)
npm run dev                 # Start Vite dev server

# Testing
php artisan test            # Run PHP tests
npm run test                # Run Vue tests

# Database
php artisan migrate         # Run migrations
php artisan db:seed         # Run seeders

# Code Generation
php artisan make:model Post -mfc    # Model with migration, factory, controller
php artisan make:request StorePostRequest  # Form Request

# Assets
npm run build               # Production build
```

## Documentation Resources

- **CLAUDE.md** - Detailed AI development guidelines
- **docs/reference/** - Code conventions and patterns
- **docs/workflows/** - Development workflow guides
- **.claude/agents/** - Specialist agent configurations
