# VILT Stack Code Examples

This file provides reference implementations for common patterns in a VILT (Vue, Inertia, Laravel, Tailwind) stack.

## 1. Routing: Wayfinder vs. Ziggy

### Wayfinder (Preferred, Type-Safe)
Use this pattern when `project_context` confirms Wayfinder.

```typescript
import { computed } from 'vue'
import { router } from '@inertiajs/vue3'
// Auto-generated, type-safe route definitions
import { posts, users } from '@wayfinder/routes'

// --- Navigation ---
// Link in a .vue template
// <Link :href="posts.show({ id: post.id })">View Post</Link>

// Programmatic navigation
function goToUser(userId: number) {
  router.visit(users.show({ id: userId }))
}

// --- API/Form Submission ---
// useForm hook with a type-safe URL
const form = useForm({ ... });
form.post(posts.store());
```

### Ziggy (Legacy / Fallback)
Use this pattern if Wayfinder is not available.

```typescript
import { computed } from 'vue'
import { router, useForm } from '@inertiajs/vue3'
// Global route helper
import { route } from 'ziggy-js'

// --- Navigation ---
// Link in a .vue template
// <Link :href="route('posts.show', { id: post.id })">View Post</Link>

// Programmatic navigation
function goToUser(userId: number) {
  router.visit(route('users.show', userId))
}

// --- API/Form Submission ---
const form = useForm({ ... });
form.post(route('posts.store'));
```

## 2. UI Components: shadcn-vue Pattern

When `project_context` confirms `shadcn-vue`, import and use components directly.

```vue
<script setup lang="ts">
import { Button } from '@/Components/ui/button'
import { Card, CardHeader, CardTitle, CardDescription, CardContent, CardFooter } from '@/Components/ui/card'
import { Input } from '@/Components/ui/input'
import { Label } from '@/Components/ui/label'
</script>

<template>
  <Card class="w-[350px]">
    <CardHeader>
      <CardTitle>Create project</CardTitle>
      <CardDescription>Deploy your new project in one-click.</CardDescription>
    </CardHeader>
    <CardContent>
      <div class="grid w-full items-center gap-4">
        <div class="flex flex-col space-y-1.5">
          <Label for="name">Name</Label>
          <Input id="name" placeholder="Name of your project" />
        </div>
      </div>
    </CardContent>
    <CardFooter class="flex justify-between">
      <Button variant="outline">Cancel</Button>
      <Button>Deploy</Button>
    </CardFooter>
  </Card>
</template>
```

## 3. Form Handling: `useForm` with TypeScript

This is the standard pattern for all forms.

```vue
<script setup lang="ts">
import { useForm } from '@inertiajs/vue3'
import { posts } from '@wayfinder/routes' // Using Wayfinder for the action URL

// Define a type for the form data
interface CreatePostForm {
  title: string;
  content: string | null;
  publish_at: Date | null;
}

// Initialize the form with type safety
const form = useForm<CreatePostForm>({
  title: '',
  content: null,
  publish_at: null,
});

// Submit handler
function submit() {
  form.post(posts.store(), {
    onSuccess: () => {
      // Handle successful submission (e.g., show notification, redirect)
      form.reset(); // Clear the form fields
    },
    onError: (errors) => {
      // Errors are automatically available in form.errors
      console.error('Form submission failed:', errors);
    }
  });
}
</script>

<template>
  <form @submit.prevent="submit">
    <div>
      <label for="title">Title</label>
      <Input
        id="title"
        v-model="form.title"
        type="text"
        :class="{ 'border-red-500': form.errors.title }"
      />
      <div v-if="form.errors.title" class="text-red-500 text-sm">
        {{ form.errors.title }}
      </div>
    </div>

    <!-- ... other form fields ... -->

    <Button type="submit" :disabled="form.processing">
      {{ form.processing ? 'Saving...' : 'Save Post' }}
    </Button>
  </form>
</template>
```

## 4. Layouts: Authenticated Layout Pattern

This demonstrates how pages are wrapped by a main layout, providing persistent navigation and structure.

```vue
<!-- resources/js/Layouts/AuthenticatedLayout.vue -->
<script setup lang="ts">
import { Link, usePage } from '@inertiajs/vue3';
import { computed } from 'vue';

// Access shared props like user information
const page = usePage();
const user = computed(() => page.props.auth.user);
</script>

<template>
  <div class="min-h-screen bg-gray-100 dark:bg-gray-900">
    <nav class="bg-white dark:bg-gray-800 border-b border-gray-100 dark:border-gray-700">
      <!-- Primary Navigation Menu -->
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-16">
          <div class="flex">
            <!-- Logo -->
            <div class="shrink-0 flex items-center">
              <Link :href="route('dashboard')">
                <ApplicationLogo class="block h-9 w-auto fill-current text-gray-800 dark:text-gray-200" />
              </Link>
            </div>
            <!-- Navigation Links -->
            <div class="hidden space-x-8 sm:-my-px sm:ml-10 sm:flex">
                <!-- Links here -->
            </div>
          </div>
        </div>
      </div>
    </nav>

    <!-- Page Heading -->
    <header v-if="$slots.header" class="bg-white dark:bg-gray-800 shadow">
        <div class="max-w-7xl mx-auto py-6 px-4 sm:px-6 lg:px-8">
            <slot name="header" />
        </div>
    </header>

    <!-- Page Content -->
    <main>
      <slot /> <!-- Page component will be injected here -->
    </main>
  </div>
</template>
```

### Usage in a Page Component

```vue
<!-- resources/js/Pages/Dashboard.vue -->
<script setup lang="ts">
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head } from '@inertiajs/vue3';

// Define props passed from the Laravel Controller
defineProps<{
  totalUsers: number;
}>();
</script>

<template>
  <Head title="Dashboard" />

  <AuthenticatedLayout>
    <template #header>
      <h2 class="font-semibold text-xl text-gray-800 leading-tight">Dashboard</h2>
    </template>

    <div class="py-12">
      <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
        <!-- Page-specific content here -->
        <p>Total users: {{ totalUsers }}</p>
      </div>
    </div>
  </AuthenticatedLayout>
</template>
```

## 5. Advanced Form Patterns

### File Uploads with Progress

```vue
<script setup lang="ts">
import { useForm } from '@inertiajs/vue3'
import { ref } from 'vue'
import { Input } from '@/Components/ui/input'
import { Button } from '@/Components/ui/button'
import { Progress } from '@/Components/ui/progress'

const uploadProgress = ref(0)

const form = useForm({
  title: '',
  document: null as File | null,
})

function submit() {
  form.post('/documents', {
    onProgress: (progress) => {
      uploadProgress.value = progress.percentage || 0
    },
    onSuccess: () => {
      form.reset()
      uploadProgress.value = 0
    },
  })
}
</script>

<template>
  <form @submit.prevent="submit" class="space-y-4">
    <div>
      <Input
        type="text"
        v-model="form.title"
        placeholder="Document title"
      />
      <span v-if="form.errors.title" class="text-red-500 text-sm">
        {{ form.errors.title }}
      </span>
    </div>

    <div>
      <Input
        type="file"
        @input="form.document = $event.target.files[0]"
      />
      <span v-if="form.errors.document" class="text-red-500 text-sm">
        {{ form.errors.document }}
      </span>
    </div>

    <Progress v-if="form.progress" :value="uploadProgress" />

    <Button type="submit" :disabled="form.processing">
      {{ form.processing ? 'Uploading...' : 'Upload' }}
    </Button>
  </form>
</template>
```

### Form with Optimistic UI

```vue
<script setup lang="ts">
import { useForm } from '@inertiajs/vue3'
import { ref } from 'vue'

interface Comment {
  id: number
  content: string
  created_at: string
}

const props = defineProps<{
  post: { id: number; title: string }
  comments: Comment[]
}>()

const localComments = ref([...props.comments])

const form = useForm({
  content: '',
})

function addComment() {
  // Optimistically add comment
  const optimisticComment: Comment = {
    id: Date.now(), // Temporary ID
    content: form.content,
    created_at: new Date().toISOString(),
  }
  
  localComments.value.unshift(optimisticComment)
  const contentToSubmit = form.content
  form.reset()

  form.post(`/posts/${props.post.id}/comments`, {
    data: { content: contentToSubmit },
    preserveScroll: true,
    onSuccess: (page) => {
      // Replace with real data from server
      localComments.value = page.props.comments
    },
    onError: () => {
      // Rollback on error
      localComments.value = props.comments
      form.content = contentToSubmit
    },
  })
}
</script>
```

## 6. Partial Reloads & Performance

### Partial Reload Pattern

```vue
<script setup lang="ts">
import { router } from '@inertiajs/vue3'

// Only reload specific props instead of entire page
function refreshComments() {
  router.reload({
    only: ['comments'],
    preserveScroll: true,
  })
}

// Load only necessary data when filtering
function filterPosts(status: string) {
  router.get('/posts', 
    { filter: status }, 
    {
      only: ['posts', 'filters'],
      preserveState: true,
      preserveScroll: true,
    }
  )
}
</script>
```

### Infinite Scroll

```vue
<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'
import { router } from '@inertiajs/vue3'

const props = defineProps<{
  posts: any[]
  hasMore: boolean
  nextPage: number
}>()

const loading = ref(false)
const allPosts = ref([...props.posts])

function loadMore() {
  if (loading.value || !props.hasMore) return
  
  loading.value = true
  
  router.get(`/posts?page=${props.nextPage}`, {}, {
    preserveState: true,
    preserveScroll: true,
    only: ['posts', 'hasMore', 'nextPage'],
    onSuccess: (page) => {
      allPosts.value = [...allPosts.value, ...page.props.posts]
      loading.value = false
    },
  })
}

const handleScroll = () => {
  const scrollTop = window.pageYOffset || document.documentElement.scrollTop
  const scrollHeight = document.documentElement.scrollHeight
  const clientHeight = document.documentElement.clientHeight
  
  if (scrollTop + clientHeight >= scrollHeight - 100) {
    loadMore()
  }
}

onMounted(() => {
  window.addEventListener('scroll', handleScroll)
})

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll)
})
</script>
```

## 7. Real-time Features with Laravel Echo

### Listening to Broadcasts

```vue
<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'
import { usePage } from '@inertiajs/vue3'

const props = defineProps<{
  channel: string
  initialData: any[]
}>()

const page = usePage()
const data = ref([...props.initialData])

onMounted(() => {
  window.Echo.private(props.channel)
    .listen('DataUpdated', (event: any) => {
      data.value.unshift(event.data)
    })
    .listen('DataDeleted', (event: any) => {
      data.value = data.value.filter(item => item.id !== event.id)
    })
})

onUnmounted(() => {
  window.Echo.leave(props.channel)
})
</script>
```

### Presence Channels

```vue
<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'
import { usePage } from '@inertiajs/vue3'

const page = usePage()
const users = ref<any[]>([])
const typing = ref<Set<number>>(new Set())

onMounted(() => {
  window.Echo.join('chat')
    .here((joinedUsers: any[]) => {
      users.value = joinedUsers
    })
    .joining((user: any) => {
      users.value.push(user)
    })
    .leaving((user: any) => {
      users.value = users.value.filter(u => u.id !== user.id)
      typing.value.delete(user.id)
    })
    .listenForWhisper('typing', (event: { user_id: number, typing: boolean }) => {
      if (event.typing) {
        typing.value.add(event.user_id)
      } else {
        typing.value.delete(event.user_id)
      }
    })
})

function broadcastTyping(isTyping: boolean) {
  window.Echo.join('chat').whisper('typing', {
    user_id: page.props.auth.user.id,
    typing: isTyping,
  })
}

onUnmounted(() => {
  window.Echo.leave('chat')
})
</script>
```

## 8. Composables for Shared Logic

### useConfirmDialog Composable

```typescript
// resources/js/composables/useConfirmDialog.ts
import { ref } from 'vue'

export function useConfirmDialog() {
  const isOpen = ref(false)
  const title = ref('')
  const message = ref('')
  const resolveCallback = ref<((value: boolean) => void) | null>(null)

  function confirm(dialogTitle: string, dialogMessage: string): Promise<boolean> {
    title.value = dialogTitle
    message.value = dialogMessage
    isOpen.value = true

    return new Promise((resolve) => {
      resolveCallback.value = resolve
    })
  }

  function handleConfirm() {
    resolveCallback.value?.(true)
    isOpen.value = false
  }

  function handleCancel() {
    resolveCallback.value?.(false)
    isOpen.value = false
  }

  return {
    isOpen,
    title,
    message,
    confirm,
    handleConfirm,
    handleCancel,
  }
}
```

### useDebounce Composable

```typescript
// resources/js/composables/useDebounce.ts
import { ref, watch } from 'vue'

export function useDebounce<T>(value: T, delay = 300) {
  const debouncedValue = ref(value)
  let timeout: NodeJS.Timeout

  watch(() => value, (newValue) => {
    clearTimeout(timeout)
    timeout = setTimeout(() => {
      debouncedValue.value = newValue as T
    }, delay)
  })

  return debouncedValue
}
```

## 9. Complex shadcn-vue Patterns

### Data Table with Sorting and Filtering

```vue
<script setup lang="ts">
import { ref, computed } from 'vue'
import { router } from '@inertiajs/vue3'
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/Components/ui/table'
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/Components/ui/select'
import { Input } from '@/Components/ui/input'
import { Button } from '@/Components/ui/button'
import { useDebounce } from '@/composables/useDebounce'

const props = defineProps<{
  users: any[]
  filters: {
    search: string
    role: string
    sort: string
  }
}>()

const search = ref(props.filters.search)
const debouncedSearch = useDebounce(search, 500)

watch(debouncedSearch, (value) => {
  router.get('/users', {
    search: value,
    role: props.filters.role,
    sort: props.filters.sort,
  }, {
    preserveState: true,
    preserveScroll: true,
    only: ['users'],
  })
})

function updateSort(column: string) {
  const currentSort = props.filters.sort
  let newSort = column

  if (currentSort === column) {
    newSort = `-${column}` // Descending
  } else if (currentSort === `-${column}`) {
    newSort = '' // No sort
  }

  router.get('/users', {
    ...props.filters,
    sort: newSort,
  }, {
    preserveState: true,
    only: ['users'],
  })
}
</script>

<template>
  <div class="space-y-4">
    <div class="flex gap-4">
      <Input
        v-model="search"
        placeholder="Search users..."
        class="max-w-sm"
      />
      
      <Select
        :value="filters.role"
        @update:value="(value) => router.get('/users', { ...filters, role: value })"
      >
        <SelectTrigger class="w-[180px]">
          <SelectValue placeholder="Filter by role" />
        </SelectTrigger>
        <SelectContent>
          <SelectItem value="all">All Roles</SelectItem>
          <SelectItem value="admin">Admin</SelectItem>
          <SelectItem value="user">User</SelectItem>
        </SelectContent>
      </Select>
    </div>

    <Table>
      <TableHeader>
        <TableRow>
          <TableHead>
            <Button variant="ghost" @click="updateSort('name')">
              Name
              <span v-if="filters.sort === 'name'">↑</span>
              <span v-if="filters.sort === '-name'">↓</span>
            </Button>
          </TableHead>
          <TableHead>Email</TableHead>
          <TableHead>Role</TableHead>
          <TableHead>Actions</TableHead>
        </TableRow>
      </TableHeader>
      <TableBody>
        <TableRow v-for="user in users" :key="user.id">
          <TableCell>{{ user.name }}</TableCell>
          <TableCell>{{ user.email }}</TableCell>
          <TableCell>{{ user.role }}</TableCell>
          <TableCell>
            <Button size="sm" variant="outline">Edit</Button>
          </TableCell>
        </TableRow>
      </TableBody>
    </Table>
  </div>
</template>
```

### Modal Dialog with Form

```vue
<script setup lang="ts">
import { ref } from 'vue'
import { useForm } from '@inertiajs/vue3'
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from '@/Components/ui/dialog'
import { Button } from '@/Components/ui/button'
import { Input } from '@/Components/ui/input'
import { Label } from '@/Components/ui/label'

const isOpen = ref(false)

const form = useForm({
  name: '',
  email: '',
})

function submit() {
  form.post('/users', {
    onSuccess: () => {
      isOpen.value = false
      form.reset()
    },
  })
}
</script>

<template>
  <Dialog v-model:open="isOpen">
    <DialogTrigger as-child>
      <Button>Create User</Button>
    </DialogTrigger>
    <DialogContent>
      <DialogHeader>
        <DialogTitle>Create New User</DialogTitle>
        <DialogDescription>
          Add a new user to your system. Click save when you're done.
        </DialogDescription>
      </DialogHeader>
      
      <form @submit.prevent="submit" class="space-y-4">
        <div>
          <Label for="name">Name</Label>
          <Input
            id="name"
            v-model="form.name"
            :class="{ 'border-red-500': form.errors.name }"
          />
          <span v-if="form.errors.name" class="text-red-500 text-sm">
            {{ form.errors.name }}
          </span>
        </div>

        <div>
          <Label for="email">Email</Label>
          <Input
            id="email"
            type="email"
            v-model="form.email"
            :class="{ 'border-red-500': form.errors.email }"
          />
          <span v-if="form.errors.email" class="text-red-500 text-sm">
            {{ form.errors.email }}
          </span>
        </div>

        <DialogFooter>
          <Button type="button" variant="outline" @click="isOpen = false">
            Cancel
          </Button>
          <Button type="submit" :disabled="form.processing">
            {{ form.processing ? 'Creating...' : 'Create User' }}
          </Button>
        </DialogFooter>
      </form>
    </DialogContent>
  </Dialog>
</template>
```

## 10. Laravel Controller Patterns

### Basic Inertia Response

```php
<?php

namespace App\Http\Controllers;

use App\Models\Post;
use Inertia\Inertia;
use Inertia\Response;

class PostController extends Controller
{
    public function index(): Response
    {
        return Inertia::render('Posts/Index', [
            'posts' => Post::with('author')
                ->latest()
                ->paginate(15)
                ->through(fn ($post) => [
                    'id' => $post->id,
                    'title' => $post->title,
                    'excerpt' => $post->excerpt,
                    'author' => [
                        'name' => $post->author->name,
                    ],
                    'created_at' => $post->created_at->diffForHumans(),
                ]),
            'filters' => request()->only(['search', 'status']),
        ]);
    }
}
```

### Form Validation & Error Handling

```php
public function store(Request $request)
{
    $validated = $request->validate([
        'title' => 'required|max:255',
        'content' => 'required',
        'published_at' => 'nullable|date',
    ]);

    $post = Post::create($validated);

    return redirect()->route('posts.show', $post)
        ->with('message', 'Post created successfully!');
}
```

### Sharing Data Globally

```php
// app/Http/Middleware/HandleInertiaRequests.php

public function share(Request $request): array
{
    return array_merge(parent::share($request), [
        'auth' => [
            'user' => $request->user() ? [
                'id' => $request->user()->id,
                'name' => $request->user()->name,
                'email' => $request->user()->email,
                'roles' => $request->user()->roles->pluck('name'),
            ] : null,
        ],
        'flash' => [
            'message' => fn () => $request->session()->get('message'),
            'error' => fn () => $request->session()->get('error'),
        ],
        'ziggy' => function () use ($request) {
            return array_merge((new Ziggy)->toArray(), [
                'location' => $request->url(),
            ]);
        },
    ]);
}
```

````