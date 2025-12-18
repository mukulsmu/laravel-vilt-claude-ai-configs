# Migration Guide: TALL Stack to VILT Stack

This guide helps developers migrate from the TALL (Tailwind, Alpine.js, Laravel, Livewire) stack to the VILT (Vue, Inertia.js, Laravel, Tailwind CSS) stack.

## 🎯 Overview of Changes

### Technology Replacements
| TALL Stack | VILT Stack | Purpose |
|------------|------------|---------|
| **Livewire** | **Vue 3 + Inertia.js** | Reactive UI components |
| **Alpine.js** | **Vue 3 Composition API** | Client-side interactivity |
| **Blade Components** | **Vue Components** | Component structure |
| **Laravel Sail** | **Laravel Herd** | Development environment |
| **Pest (PHP only)** | **Pest + Vitest** | Testing framework |

### Key Philosophical Differences

**TALL Stack Philosophy:**
- Server-driven with server-rendered components
- Minimal JavaScript footprint
- Tight integration with Blade templates
- Real-time updates via Livewire events

**VILT Stack Philosophy:**
- SPA-style navigation without building a full REST API
- Vue-driven UI with reactive components
- Clear separation between backend (Laravel) and frontend (Vue)
- Real-time updates via Laravel Echo + Vue reactivity

---

## 📦 Installation & Setup

### 1. Install VILT Stack Dependencies

```bash
# Install Vue 3 and related packages
npm install vue@3 @vitejs/plugin-vue @inertiajs/vue3

# Install Inertia server-side adapter
composer require inertiajs/inertia-laravel

# Install Ziggy for Laravel routes in JavaScript
composer require tightenco/ziggy

# Install Vitest for Vue component testing
npm install -D vitest @vue/test-utils happy-dom

# Optional: TypeScript support
npm install -D typescript vue-tsc @types/node
```

### 2. Configure Vite for Vue

Update `vite.config.js`:

```javascript
import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
import vue from '@vitejs/plugin-vue';

export default defineConfig({
    plugins: [
        laravel({
            input: ['resources/css/app.css', 'resources/js/app.js'],
            refresh: true,
        }),
        vue({
            template: {
                transformAssetUrls: {
                    base: null,
                    includeAbsolute: false,
                },
            },
        }),
    ],
    resolve: {
        alias: {
            '@': '/resources/js',
        },
    },
});
```

### 3. Setup Inertia Middleware

```bash
php artisan inertia:middleware
```

Register the middleware in `bootstrap/app.php`:

```php
use App\Http\Middleware\HandleInertiaRequests;

->withMiddleware(function (Middleware $middleware) {
    $middleware->web(append: [
        HandleInertiaRequests::class,
    ]);
})
```

### 4. Create App Blade Template

Create `resources/views/app.blade.php`:

```blade
<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    @routes
    @vite(['resources/css/app.css', 'resources/js/app.js'])
    @inertiaHead
</head>
<body class="antialiased">
    @inertia
</body>
</html>
```

### 5. Initialize Vue App

Update `resources/js/app.js`:

```javascript
import { createApp, h } from 'vue'
import { createInertiaApp } from '@inertiajs/vue3'
import { resolvePageComponent } from 'laravel-vite-plugin/inertia-helpers'
import { ZiggyVue } from '../../vendor/tightenco/ziggy'

createInertiaApp({
    resolve: (name) => resolvePageComponent(
        `./Pages/${name}.vue`,
        import.meta.glob('./Pages/**/*.vue')
    ),
    setup({ el, App, props, plugin }) {
        return createApp({ render: () => h(App, props) })
            .use(plugin)
            .use(ZiggyVue)
            .mount(el)
    },
    progress: {
        color: '#4B5563',
    },
})
```

---

## 🔄 Component Migration Patterns

### Livewire Component → Vue + Inertia Page

**Before (Livewire):**

```php
// app/Livewire/PostsList.php
class PostsList extends Component
{
    public $posts;
    public $search = '';

    public function mount()
    {
        $this->posts = Post::all();
    }

    public function updatedSearch()
    {
        $this->posts = Post::where('title', 'like', "%{$this->search}%")->get();
    }

    public function render()
    {
        return view('livewire.posts-list');
    }
}
```

```blade
<!-- resources/views/livewire/posts-list.blade.php -->
<div>
    <input wire:model.live="search" type="text" placeholder="Search...">
    
    @foreach($posts as $post)
        <div>{{ $post->title }}</div>
    @endforeach
</div>
```

**After (Vue + Inertia):**

```php
// app/Http/Controllers/PostController.php
class PostController extends Controller
{
    public function index(Request $request)
    {
        $posts = Post::query()
            ->when($request->search, function ($query, $search) {
                $query->where('title', 'like', "%{$search}%");
            })
            ->get();

        return inertia('Posts/Index', [
            'posts' => $posts,
            'filters' => $request->only('search'),
        ]);
    }
}
```

```vue
<!-- resources/js/Pages/Posts/Index.vue -->
<script setup>
import { ref, watch } from 'vue'
import { router } from '@inertiajs/vue3'

const props = defineProps({
    posts: Array,
    filters: Object
})

const search = ref(props.filters.search || '')

watch(search, (value) => {
    router.get(route('posts.index'), 
        { search: value }, 
        { 
            preserveState: true,
            replace: true 
        }
    )
})
</script>

<template>
    <div>
        <input v-model="search" type="text" placeholder="Search..." />
        
        <div v-for="post in posts" :key="post.id">
            {{ post.title }}
        </div>
    </div>
</template>
```

### Alpine.js → Vue Composition API

**Before (Alpine.js):**

```html
<div x-data="{ open: false }">
    <button @click="open = !open">Toggle</button>
    <div x-show="open">Content</div>
</div>
```

**After (Vue 3):**

```vue
<script setup>
import { ref } from 'vue'

const open = ref(false)
</script>

<template>
    <div>
        <button @click="open = !open">Toggle</button>
        <div v-show="open">Content</div>
    </div>
</template>
```

### Livewire Forms → Inertia Forms

**Before (Livewire):**

```php
// app/Livewire/CreatePost.php
class CreatePost extends Component
{
    public $title = '';
    public $content = '';

    protected $rules = [
        'title' => 'required|min:3',
        'content' => 'required',
    ];

    public function submit()
    {
        $this->validate();
        Post::create($this->only(['title', 'content']));
        return redirect()->route('posts.index');
    }
}
```

**After (Vue + Inertia):**

```php
// app/Http/Controllers/PostController.php
public function store(Request $request)
{
    $validated = $request->validate([
        'title' => 'required|min:3',
        'content' => 'required',
    ]);

    Post::create($validated);

    return redirect()->route('posts.index')
        ->with('success', 'Post created successfully');
}
```

```vue
<!-- resources/js/Pages/Posts/Create.vue -->
<script setup>
import { useForm } from '@inertiajs/vue3'

const form = useForm({
    title: '',
    content: ''
})

const submit = () => {
    form.post(route('posts.store'), {
        onSuccess: () => {
            form.reset()
        }
    })
}
</script>

<template>
    <form @submit.prevent="submit">
        <div>
            <input v-model="form.title" type="text" />
            <span v-if="form.errors.title">{{ form.errors.title }}</span>
        </div>
        
        <div>
            <textarea v-model="form.content" />
            <span v-if="form.errors.content">{{ form.errors.content }}</span>
        </div>
        
        <button type="submit" :disabled="form.processing">
            {{ form.processing ? 'Saving...' : 'Save' }}
        </button>
    </form>
</template>
```

---

## 🧪 Testing Migration

### Backend Testing (Similar)

Both stacks use Pest/PHPUnit for backend testing. The main difference is the response assertions:

**TALL (Livewire):**
```php
test('can create post', function () {
    Livewire::test(CreatePost::class)
        ->set('title', 'Test Post')
        ->set('content', 'Test Content')
        ->call('submit')
        ->assertRedirect(route('posts.index'));
});
```

**VILT (Inertia):**
```php
use Inertia\Testing\AssertableInertia as Assert;

test('can create post', function () {
    $response = $this->post(route('posts.store'), [
        'title' => 'Test Post',
        'content' => 'Test Content',
    ]);

    $response->assertRedirect(route('posts.index'));
    $this->assertDatabaseHas('posts', ['title' => 'Test Post']);
});

test('shows posts index page', function () {
    $posts = Post::factory(3)->create();

    $this->get(route('posts.index'))
        ->assertInertia(fn (Assert $page) => $page
            ->component('Posts/Index')
            ->has('posts', 3)
        );
});
```

### Frontend Testing (New)

Add Vitest for Vue component testing:

```javascript
// vitest.config.js
import { defineConfig } from 'vitest/config'
import vue from '@vitejs/plugin-vue'

export default defineConfig({
    plugins: [vue()],
    test: {
        environment: 'happy-dom',
        globals: true,
    },
})
```

```javascript
// tests/vue/Components/Button.test.js
import { mount } from '@vue/test-utils'
import { describe, it, expect } from 'vitest'
import Button from '@/Components/Button.vue'

describe('Button', () => {
    it('renders with text', () => {
        const wrapper = mount(Button, {
            slots: {
                default: 'Click me'
            }
        })
        
        expect(wrapper.text()).toContain('Click me')
    })

    it('emits click event', async () => {
        const wrapper = mount(Button)
        await wrapper.trigger('click')
        
        expect(wrapper.emitted('click')).toBeTruthy()
    })
})
```

---

## 🚀 Development Environment Migration

### From Laravel Sail to Laravel Herd

**Laravel Sail (TALL):**
```bash
./vendor/bin/sail up -d
./vendor/bin/sail artisan migrate
./vendor/bin/sail npm run dev
```

**Laravel Herd (VILT):**
```bash
# Herd runs automatically in the background
php artisan migrate
npm run dev

# Or use specific PHP version
herd php@8.2 artisan migrate
```

### Environment Setup

1. **Install Laravel Herd**: Download from https://herd.laravel.com/
2. **Link your project**: Herd auto-discovers Laravel projects
3. **Access your app**: `http://your-project.test`

---

## 📚 AI Agent Configuration Updates

### Update Your Claude Configuration

1. **Replace TALL Stack Specialist** with **VILT Stack Specialist**:
   - Delete `.claude/agents/tall-specialist.md`
   - Use `.claude/agents/vilt-specialist.md`

2. **Update CLAUDE.md** references:
   - Change "TALL Stack" → "VILT Stack"
   - Update component patterns
   - Update MCP tool examples

3. **Update DevOps Specialist**:
   - Change Sail commands → Herd commands
   - Update deployment strategies

---

## 🔍 Key Differences Summary

### Routing & Navigation
- **TALL**: Livewire components handle routing internally
- **VILT**: Laravel routes → Controllers → Inertia responses → Vue pages

### State Management
- **TALL**: Livewire properties + Alpine.js data
- **VILT**: Vue reactive refs/reactive + optional Pinia for complex state

### Real-time Updates
- **TALL**: Livewire events + Laravel Echo
- **VILT**: Laravel Echo + Vue reactive updates

### Form Handling
- **TALL**: Livewire wire:model + validation
- **VILT**: Inertia useForm() composable + Laravel validation

### Component Structure
- **TALL**: PHP classes + Blade templates
- **VILT**: Vue SFC (Single File Components) with `<script setup>`

---

## 💡 Best Practices for VILT Stack

1. **Separation of Concerns**: Keep business logic in Laravel controllers/services, UI logic in Vue components

2. **Inertia Partial Reloads**: Use `only` parameter to fetch only changed data:
   ```javascript
   router.visit(route('posts.index'), {
       only: ['posts'],
       preserveState: true
   })
   ```

3. **Shared Data**: Use Inertia middleware for globally shared props (auth user, flash messages)

4. **TypeScript**: Consider adding TypeScript for better type safety:
   ```bash
   npm install -D typescript vue-tsc
   npx tsc --init
   ```

5. **Code Splitting**: Leverage Vite's automatic code splitting for better performance

6. **Ziggy Routes**: Always use `route()` helper for type-safe routing:
   ```vue
   <Link :href="route('posts.show', post.id)">View Post</Link>
   ```

---

## 🆘 Common Issues & Solutions

### Issue: Inertia not detecting changes
**Solution**: Ensure proper middleware configuration and CSRF token handling

### Issue: Vue components not hot-reloading
**Solution**: Check Vite configuration and ensure dev server is running

### Issue: Props not updating
**Solution**: Use Inertia's `only` parameter or force full page reload

### Issue: Routes not found in Vue
**Solution**: Ensure Ziggy is properly configured and `@routes` is in app.blade.php

---

## 📖 Additional Resources

- **Inertia.js Documentation**: https://inertiajs.com
- **Vue 3 Documentation**: https://vuejs.org
- **Laravel Herd**: https://herd.laravel.com
- **Ziggy Documentation**: https://github.com/tighten/ziggy
- **VILT Stack Resources**: https://viltstack.dev

---

## ✅ Migration Checklist

- [ ] Install VILT dependencies (Vue, Inertia, Ziggy)
- [ ] Configure Vite for Vue
- [ ] Setup Inertia middleware
- [ ] Create app.blade.php template
- [ ] Migrate Livewire components to Vue pages
- [ ] Convert Alpine.js to Vue Composition API
- [ ] Update forms to use Inertia form handling
- [ ] Setup Vitest for Vue component testing
- [ ] Migrate from Sail to Herd
- [ ] Update AI agent configurations
- [ ] Update all documentation references
- [ ] Test all functionality thoroughly

---

**🎉 Congratulations on migrating to the VILT stack!** Enjoy the benefits of Vue 3's powerful reactivity system combined with Laravel's elegant backend architecture.
