# Debugging Skill for Laravel VILT Stack

This skill provides systematic debugging approaches for Laravel VILT applications.

## When to Use This Skill

Use this skill when:
- Debugging HTTP/routing issues
- Troubleshooting Inertia page rendering problems
- Investigating database/query issues
- Fixing Vue component reactivity problems
- Resolving authentication/authorization errors

## Backend Debugging

### Laravel Debug Tools

```php
// Quick debugging
dd($variable);           // Dump and die
dump($variable);         // Dump without stopping
logger($message);        // Write to log file
Log::info('Message', ['context' => $data]);

// Query debugging
DB::enableQueryLog();
// ... run queries ...
dd(DB::getQueryLog());

// Or use query listener
DB::listen(function ($query) {
    Log::info('Query', [
        'sql' => $query->sql,
        'bindings' => $query->bindings,
        'time' => $query->time,
    ]);
});
```

### Debugging Inertia Responses

```php
// In controller - see what's being sent to frontend
public function index()
{
    $posts = Post::with('user')->get();
    
    // Debug the data
    dump($posts->toArray());
    
    return Inertia::render('Posts/Index', [
        'posts' => $posts,
    ]);
}

// Check Inertia middleware shared data
// app/Http/Middleware/HandleInertiaRequests.php
public function share(Request $request): array
{
    dump(parent::share($request)); // See what's shared
    
    return [
        ...parent::share($request),
        'auth' => [...],
        'flash' => [...],
    ];
}
```

### Common HTTP Issues

```php
// Route not found - check routes
php artisan route:list --name=posts

// Method not allowed - verify HTTP method
// routes/web.php
Route::get('/posts', [PostController::class, 'index']);    // GET only
Route::post('/posts', [PostController::class, 'store']);   // POST only
Route::resource('posts', PostController::class);           // All methods

// CSRF token mismatch
// Inertia handles this automatically, but check:
// - @csrf in form (for non-Inertia forms)
// - X-CSRF-TOKEN header in API requests

// 419 Page Expired
// Usually session expired - check SESSION_LIFETIME in .env
```

### Database Debugging

```php
// N+1 Query Detection (install laravel-query-detector)
composer require beyondcode/laravel-query-detector --dev

// Check eager loading
$posts = Post::with(['user', 'comments'])->get(); // Good
$posts = Post::all(); // Then $post->user triggers N+1

// Debugging relationships
$post = Post::find(1);
dump($post->user);           // Triggers query
dump($post->getRelation('user')); // Returns null if not loaded

// Model events debugging
Post::observe(new class {
    public function creating(Post $post) {
        logger('Creating post', $post->toArray());
    }
    public function created(Post $post) {
        logger('Created post', ['id' => $post->id]);
    }
});
```

### Authorization Debugging

```php
// Check policy authorization
$user = auth()->user();
$post = Post::find(1);

// Debug authorization
dump($user->can('update', $post)); // Boolean
dump(Gate::inspect('update', $post)); // Detailed response

// In controller
public function update(Post $post)
{
    $this->authorize('update', $post); // Throws 403 if fails
    
    // Or with debugging
    if (!auth()->user()->can('update', $post)) {
        logger('Authorization failed', [
            'user' => auth()->id(),
            'post' => $post->id,
            'post_owner' => $post->user_id,
        ]);
        abort(403);
    }
}

// Policy debugging
// app/Policies/PostPolicy.php
public function update(User $user, Post $post): bool
{
    $result = $user->id === $post->user_id;
    logger('PostPolicy::update', [
        'user_id' => $user->id,
        'post_user_id' => $post->user_id,
        'result' => $result,
    ]);
    return $result;
}
```

## Frontend Debugging

### Vue DevTools
1. Install Vue DevTools browser extension
2. Open browser DevTools → Vue tab
3. Inspect component tree, props, state

### Vue Component Debugging

```vue
<script setup lang="ts">
import { ref, watch, onMounted } from 'vue'
import { usePage } from '@inertiajs/vue3'

const props = defineProps<{ posts: Post[] }>()

// Debug props
onMounted(() => {
  console.log('Props received:', props)
  console.log('Page props:', usePage().props)
})

// Debug reactive state changes
const search = ref('')
watch(search, (newVal, oldVal) => {
  console.log('Search changed:', { from: oldVal, to: newVal })
})

// Debug computed
const filteredPosts = computed(() => {
  const result = props.posts.filter(/* ... */)
  console.log('Filtered posts:', result.length)
  return result
})
</script>
```

### Inertia Debugging

```vue
<script setup lang="ts">
import { router, usePage } from '@inertiajs/vue3'

// Debug page props
const page = usePage()
console.log('Current component:', page.component)
console.log('Page props:', page.props)
console.log('URL:', page.url)

// Debug navigation
router.on('start', (event) => {
  console.log('Navigation starting:', event.detail.visit.url)
})

router.on('success', (event) => {
  console.log('Navigation success:', event.detail.page)
})

router.on('error', (errors) => {
  console.error('Navigation error:', errors)
})

// Debug form submission
const form = useForm({ title: '' })

const submit = () => {
  console.log('Submitting:', form.data())
  
  form.post(route('posts.store'), {
    onBefore: () => console.log('Before request'),
    onStart: () => console.log('Request started'),
    onProgress: (progress) => console.log('Progress:', progress),
    onSuccess: (page) => console.log('Success:', page),
    onError: (errors) => console.error('Errors:', errors),
    onFinish: () => console.log('Finished'),
  })
}
</script>
```

### Network Debugging

```javascript
// Check Inertia headers in Network tab
// Request should have:
// - X-Inertia: true
// - X-Inertia-Version: [hash]

// Response should have:
// - X-Inertia: true (for Inertia responses)
// - Content-Type: application/json (for Inertia responses)
// - Or redirect with 303 status

// Common issues:
// - Missing X-Inertia header → Full page reload instead of SPA nav
// - 419 status → CSRF token expired
// - 500 status → Check Laravel logs
```

### Tailwind CSS Debugging

```html
<!-- Debug responsive breakpoints -->
<div class="block sm:hidden">Mobile</div>
<div class="hidden sm:block md:hidden">Tablet</div>
<div class="hidden md:block">Desktop</div>

<!-- Debug element dimensions -->
<div class="border border-red-500">
  <!-- Red border shows element bounds -->
</div>

<!-- Check if classes are being applied -->
<div class="bg-blue-500" style="background: red !important;">
  <!-- If red shows, Tailwind class isn't working -->
</div>
```

## Common Issues & Solutions

### Issue: "Page not found" or blank page
```bash
# Check route exists
php artisan route:list --name=posts

# Check controller method exists and returns Inertia response
# Check Vue page exists at correct path (resources/js/Pages/...)
# Check vite is running (npm run dev)
```

### Issue: Props not updating
```vue
<script setup>
// Props are readonly - don't mutate directly
const props = defineProps<{ items: Item[] }>()

// ❌ Wrong
props.items.push(newItem)

// ✅ Correct - use Inertia partial reload
router.reload({ only: ['items'] })

// Or emit to parent / use form
</script>
```

### Issue: Form validation errors not showing
```vue
<template>
  <!-- Check form.errors object -->
  <pre>{{ form.errors }}</pre>
  
  <!-- Ensure field names match validation rules -->
  <input v-model="form.title" />
  <span v-if="form.errors.title">{{ form.errors.title }}</span>
</template>
```

### Issue: Inertia redirects cause full page reload
```php
// In controller, ensure redirect uses Inertia-compatible response
return redirect()->route('posts.index'); // ✅
return Redirect::route('posts.index');   // ✅

// If using response()->json(), it won't work with Inertia
```

## Debugging Commands

```bash
# Clear all caches
php artisan optimize:clear

# Check Laravel logs
tail -f storage/logs/laravel.log

# Check PHP errors
tail -f /var/log/php-fpm.log  # Or wherever your PHP logs are

# Vite issues
npm run dev -- --debug

# Check Vite is serving assets
curl http://localhost:5173/@vite/client
```

## Debugging Checklist

- [ ] Check Laravel logs (`storage/logs/laravel.log`)
- [ ] Check browser console for JS errors
- [ ] Check Network tab for failed requests
- [ ] Verify route exists (`php artisan route:list`)
- [ ] Verify Vue page exists at correct path
- [ ] Check Inertia middleware is registered
- [ ] Verify Vite dev server is running
- [ ] Clear caches (`php artisan optimize:clear`)
- [ ] Check for N+1 queries with query logging
- [ ] Verify authorization policies are correct
