# Laravel Vue Starter Kit Guide

Complete guide to working with the official Laravel 12 Vue Starter Kit, including directory structure, shadcn-vue components, routing solutions (Wayfinder vs Ziggy), and differences from Laravel Jetstream.

## Overview

The Laravel Vue Starter Kit is the official modern foundation for building Vue 3 + Inertia.js applications with Laravel 12. It provides a clean, minimal starting point with TypeScript, shadcn-vue components, and Vite integration.

**Official Documentation**: https://laravel.com/docs/12.x/starter-kits#vue

## Project Types Supported

This guide covers three common setups:

1. **Laravel Vue Starter Kit** (Recommended for new projects)
2. **Laravel Jetstream (Vue + Inertia)** (For apps needing auth/teams)
3. **Custom VILT Setup** (Legacy or manually configured projects)

---

## Laravel Vue Starter Kit (Recommended)

### Installation

```bash
# Create new Laravel project
composer create-project laravel/laravel my-app
cd my-app

# Install Vue starter kit
php artisan install:vue

# Install dependencies
npm install

# Generate TypeScript route definitions (Wayfinder)
php artisan routes:generate

# Start development
npm run dev
php artisan serve  # or use Herd
```

### Directory Structure

```
resources/
├── js/
│   ├── Pages/              # Inertia page components
│   │   ├── Auth/           # Authentication pages
│   │   ├── Profile/        # User profile pages
│   │   └── Welcome.vue     # Home page
│   ├── Components/         # Reusable Vue + shadcn components
│   │   ├── ui/             # shadcn-vue components
│   │   │   ├── button.vue
│   │   │   ├── card.vue
│   │   │   ├── input.vue
│   │   │   ├── dialog.vue
│   │   │   └── ...
│   │   └── ApplicationLogo.vue
│   ├── Layouts/            # Shared layout components
│   │   ├── AuthenticatedLayout.vue
│   │   └── GuestLayout.vue
│   ├── types/              # TypeScript type definitions
│   │   ├── index.d.ts      # Global types
│   │   └── generated.d.ts  # Generated route types
│   ├── lib/                # Utility functions
│   │   └── utils.ts
│   ├── app.ts              # Application entry point
│   └── ssr.ts              # SSR entry (optional)
├── css/
│   └── app.css             # Tailwind CSS imports
└── views/
    └── app.blade.php       # Main app template
```

### Key Features

1. **shadcn-vue Components** - Pre-configured, customizable UI components
2. **TypeScript Support** - Full type safety across the stack
3. **Wayfinder Integration** - Type-safe Laravel routes in TypeScript
4. **Tailwind CSS** - Utility-first styling
5. **Vite** - Fast development server and build tool
6. **Inertia.js** - SPA without building an API

---

## shadcn-vue Best Practices

### Component Usage

```vue
<script setup lang="ts">
import { Button } from '@/Components/ui/button'
import { Input } from '@/Components/ui/input'
import { Card, CardHeader, CardTitle, CardContent } from '@/Components/ui/card'
import { Dialog, DialogContent, DialogHeader, DialogTitle } from '@/Components/ui/dialog'

const props = defineProps<{
  user: User
}>()
</script>

<template>
  <Card>
    <CardHeader>
      <CardTitle>User Profile</CardTitle>
    </CardHeader>
    <CardContent>
      <div class="space-y-4">
        <Input v-model="form.name" placeholder="Name" />
        <Button @click="submit">Save Changes</Button>
      </div>
    </CardContent>
  </Card>
</template>
```

### Customizing shadcn Components

**Best Practice**: Always customize in your project, never modify node_modules

```bash
# Add a new shadcn component
npx shadcn-vue@latest add button

# Customize the component
# Edit: resources/js/Components/ui/button.vue
```

**Example Customization**:

```vue
<!-- resources/js/Components/ui/button.vue -->
<script setup lang="ts">
import { cn } from '@/lib/utils'

interface ButtonProps {
  variant?: 'default' | 'destructive' | 'outline' | 'secondary' | 'ghost' | 'link'
  size?: 'default' | 'sm' | 'lg' | 'icon'
}

const props = withDefaults(defineProps<ButtonProps>(), {
  variant: 'default',
  size: 'default'
})

const variants = {
  default: 'bg-primary text-primary-foreground hover:bg-primary/90',
  destructive: 'bg-destructive text-destructive-foreground hover:bg-destructive/90',
  outline: 'border border-input bg-background hover:bg-accent hover:text-accent-foreground',
  secondary: 'bg-secondary text-secondary-foreground hover:bg-secondary/80',
  ghost: 'hover:bg-accent hover:text-accent-foreground',
  link: 'text-primary underline-offset-4 hover:underline'
}

const sizes = {
  default: 'h-10 px-4 py-2',
  sm: 'h-9 rounded-md px-3',
  lg: 'h-11 rounded-md px-8',
  icon: 'h-10 w-10'
}
</script>

<template>
  <button
    :class="cn(
      'inline-flex items-center justify-center rounded-md text-sm font-medium transition-colors',
      'focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring',
      'disabled:pointer-events-none disabled:opacity-50',
      variants[variant],
      sizes[size]
    )"
  >
    <slot />
  </button>
</template>
```

### Common shadcn Components

```typescript
// Import commonly used components
import { Button } from '@/Components/ui/button'
import { Input } from '@/Components/ui/input'
import { Label } from '@/Components/ui/label'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/Components/ui/select'
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from '@/Components/ui/card'
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle, DialogTrigger } from '@/Components/ui/dialog'
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/Components/ui/tabs'
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/Components/ui/table'
```

---

## Routing: Wayfinder vs Ziggy

### Decision Matrix

| Feature | Wayfinder (Recommended) | Ziggy (Legacy Compatible) |
|---------|------------------------|---------------------------|
| **Type Safety** | ✅ Full TypeScript support | ❌ No type safety |
| **IDE Support** | ✅ Autocomplete & validation | ❌ String-based |
| **Laravel 12+** | ✅ Built-in | ⚠️ Requires package |
| **Performance** | ✅ Optimized | ⚠️ Exposes all routes |
| **Security** | ✅ Only used routes | ⚠️ All routes exposed |
| **Best For** | New Laravel 12 projects | Legacy/Jetstream projects |

### Wayfinder (Recommended)

**Installation** (included in Vue starter kit):

```bash
# Generate routes
php artisan routes:generate
```

**Usage**:

```vue
<script setup lang="ts">
import { router } from '@inertiajs/vue3'
import { posts, users } from '@wayfinder/routes'

// Type-safe route generation
const navigateToPost = (id: number) => {
  router.visit(posts.show({ id }))
}

const fetchUsers = async () => {
  const response = await fetch(users.index())
  return response.json()
}
</script>

<template>
  <div>
    <!-- Using with Inertia Link -->
    <Link :href="posts.index()">All Posts</Link>
    
    <!-- Using with router.visit -->
    <button @click="router.visit(posts.create())">
      Create Post
    </button>
    
    <!-- Parameterized routes -->
    <Link :href="posts.show({ id: post.id })">
      {{ post.title }}
    </Link>
  </div>
</template>
```

**Best Practices**:

1. **Regenerate after route changes**:
   ```bash
   php artisan routes:generate
   ```

2. **Import only what you need**:
   ```typescript
   // ✅ Good
   import { posts, users } from '@wayfinder/routes'
   
   // ❌ Bad (imports everything)
   import * as routes from '@wayfinder/routes'
   ```

3. **Use with TypeScript**:
   ```typescript
   // Type-safe parameters
   const url = posts.show({ id: 123 })  // ✅ Type-checked
   const url = posts.show({ id: 'abc' }) // ❌ Type error
   ```

### Ziggy (For Legacy Projects)

**Installation**:

```bash
composer require tightenco/ziggy
```

**Configuration**:

```blade
<!-- resources/views/app.blade.php -->
<!DOCTYPE html>
<html>
<head>
    @routes
    @vite(['resources/css/app.css', 'resources/js/app.ts'])
    @inertiaHead
</head>
<body>
    @inertia
</body>
</html>
```

```typescript
// resources/js/app.ts
import { ZiggyVue } from '../../vendor/tightenco/ziggy'

createInertiaApp({
    // ...
    setup({ el, App, props, plugin }) {
        return createApp({ render: () => h(App, props) })
            .use(plugin)
            .use(ZiggyVue) // Add Ziggy
            .mount(el)
    },
})
```

**Usage**:

```vue
<script setup lang="ts">
import { router } from '@inertiajs/vue3'

// String-based routing
const navigateToPost = (id: number) => {
  router.visit(route('posts.show', id))
}
</script>

<template>
  <div>
    <!-- Using route() helper -->
    <Link :href="route('posts.index')">All Posts</Link>
    
    <!-- With parameters -->
    <Link :href="route('posts.show', post.id)">
      {{ post.title }}
    </Link>
    
    <!-- With query parameters -->
    <Link :href="route('posts.index', { filter: 'published' })">
      Published Posts
    </Link>
  </div>
</template>
```

### Migration: Ziggy → Wayfinder

```typescript
// Before (Ziggy)
route('posts.show', post.id)
route('users.index')
route('api.posts.update', { post: postId })

// After (Wayfinder)
posts.show({ id: post.id })
users.index()
api.posts.update({ post: postId })
```

**Migration Steps**:

1. Install Wayfinder:
   ```bash
   php artisan routes:generate
   ```

2. Update imports:
   ```typescript
   // Remove
   import { ZiggyVue } from '../../vendor/tightenco/ziggy'
   
   // Add
   import { posts, users } from '@wayfinder/routes'
   ```

3. Replace route() calls with imported functions

4. Remove Ziggy from package.json:
   ```bash
   composer remove tightenco/ziggy
   npm uninstall ziggy-js
   ```

---

## Laravel Jetstream vs Vue Starter Kit

### Feature Comparison

| Feature | Jetstream (Vue) | Vue Starter Kit |
|---------|----------------|-----------------|
| **Authentication** | ✅ Complete | ⚠️ Basic/Manual |
| **Profile Management** | ✅ Built-in | ❌ Manual |
| **Team Management** | ✅ Built-in | ❌ Manual |
| **Two-Factor Auth** | ✅ Built-in | ❌ Manual |
| **API Tokens** | ✅ Built-in | ❌ Manual |
| **UI Components** | Basic | shadcn-vue |
| **TypeScript** | Optional | ✅ Default |
| **Wayfinder** | ❌ Uses Ziggy | ✅ Default |
| **Flexibility** | Low (opinionated) | High (minimal) |

### When to Use Each

**Use Jetstream if**:
- You need user authentication out of the box
- You need team/organization management
- You want two-factor authentication
- You need API token management
- You prefer batteries-included approach

**Use Vue Starter Kit if**:
- You want full control over authentication
- You don't need team management
- You prefer modern tooling (TypeScript, shadcn-vue)
- You want type-safe routing (Wayfinder)
- You prefer minimal starting point

### Migration: Jetstream → Starter Kit

**Not recommended** unless you're willing to rebuild auth features. Instead:

1. **Keep Jetstream, add shadcn-vue**:
   ```bash
   npx shadcn-vue@latest init
   npx shadcn-vue@latest add button card input
   ```

2. **Keep Jetstream, migrate to Wayfinder**:
   ```bash
   php artisan routes:generate
   # Update components to use Wayfinder
   composer remove tightenco/ziggy
   ```

---

## TypeScript Best Practices

### Type Definitions

```typescript
// resources/js/types/index.d.ts
export interface User {
  id: number
  name: string
  email: string
  email_verified_at?: string
  created_at: string
  updated_at: string
}

export interface Post {
  id: number
  title: string
  content: string
  user: User
  published_at?: string
  created_at: string
  updated_at: string
}

export interface PaginatedResponse<T> {
  data: T[]
  links: {
    first: string
    last: string
    prev?: string
    next?: string
  }
  meta: {
    current_page: number
    from: number
    last_page: number
    per_page: number
    to: number
    total: number
  }
}

// Inertia page props
export interface PageProps {
  auth: {
    user: User
  }
  flash?: {
    success?: string
    error?: string
  }
  errors?: Record<string, string>
}
```

### Typed Page Components

```vue
<script setup lang="ts">
import type { PageProps } from '@/types'

interface Props extends PageProps {
  posts: PaginatedResponse<Post>
  filters: {
    search?: string
    status?: 'published' | 'draft'
  }
}

const props = defineProps<Props>()
</script>
```

### Typed Form Handling

```typescript
import { useForm } from '@inertiajs/vue3'
import type { Post } from '@/types'

interface PostForm {
  title: string
  content: string
  published_at?: string
}

const form = useForm<PostForm>({
  title: '',
  content: '',
  published_at: undefined
})

const submit = () => {
  form.post(posts.store(), {
    onSuccess: () => form.reset(),
    onError: (errors) => {
      console.error('Validation errors:', errors)
    }
  })
}
```

---

## AI Agent Best Practices

### Identifying Project Type

```bash
# Check for Vue starter kit
mcp__serena__search_for_pattern "@wayfinder" --relative_path="resources/js"

# Check for Jetstream
mcp__serena__search_for_pattern "jetstream" --relative_path="composer.json"

# Check for shadcn-vue
mcp__serena__list_dir --relative_path="resources/js/Components/ui"

# Check routing solution
mcp__serena__search_for_pattern "ZiggyVue" --relative_path="resources/js/app.ts"
```

### Component Generation Prompts

```
For Vue Starter Kit:
"Create a new page component in resources/js/Pages/ using shadcn-vue components and Wayfinder routing"

For Jetstream:
"Create a new page component compatible with Jetstream layouts using Ziggy routing"
```

### Directory Navigation

```bash
# Get page structure
mcp__serena__get_symbols_overview --relative_path="resources/js/Pages"

# Get component library
mcp__serena__list_dir --relative_path="resources/js/Components/ui"

# Find layout usage
mcp__serena__search_for_pattern "AuthenticatedLayout" --relative_path="resources/js/Pages"
```

---

## Common Patterns

### Page with Form (Starter Kit)

```vue
<script setup lang="ts">
import { useForm } from '@inertiajs/vue3'
import { posts } from '@wayfinder/routes'
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue'
import { Button } from '@/Components/ui/button'
import { Input } from '@/Components/ui/input'
import { Label } from '@/Components/ui/label'
import { Card, CardContent, CardHeader, CardTitle } from '@/Components/ui/card'

const form = useForm({
  title: '',
  content: ''
})

const submit = () => {
  form.post(posts.store(), {
    onSuccess: () => form.reset()
  })
}
</script>

<template>
  <AuthenticatedLayout>
    <Card>
      <CardHeader>
        <CardTitle>Create Post</CardTitle>
      </CardHeader>
      <CardContent>
        <form @submit.prevent="submit" class="space-y-4">
          <div>
            <Label for="title">Title</Label>
            <Input 
              id="title"
              v-model="form.title" 
              :error="form.errors.title"
            />
            <span v-if="form.errors.title" class="text-sm text-destructive">
              {{ form.errors.title }}
            </span>
          </div>
          
          <div>
            <Label for="content">Content</Label>
            <Input 
              id="content"
              v-model="form.content"
              :error="form.errors.content"
            />
            <span v-if="form.errors.content" class="text-sm text-destructive">
              {{ form.errors.content }}
            </span>
          </div>
          
          <Button type="submit" :disabled="form.processing">
            {{ form.processing ? 'Creating...' : 'Create Post' }}
          </Button>
        </form>
      </CardContent>
    </Card>
  </AuthenticatedLayout>
</template>
```

### Data Table with Pagination

```vue
<script setup lang="ts">
import { router } from '@inertiajs/vue3'
import { posts } from '@wayfinder/routes'
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/Components/ui/table'
import { Button } from '@/Components/ui/button'
import type { PaginatedResponse, Post } from '@/types'

interface Props {
  posts: PaginatedResponse<Post>
}

const props = defineProps<Props>()

const navigateToPage = (url: string) => {
  router.visit(url, { preserveState: true })
}
</script>

<template>
  <div class="space-y-4">
    <Table>
      <TableHeader>
        <TableRow>
          <TableHead>Title</TableHead>
          <TableHead>Author</TableHead>
          <TableHead>Created</TableHead>
          <TableHead>Actions</TableHead>
        </TableRow>
      </TableHeader>
      <TableBody>
        <TableRow v-for="post in posts.data" :key="post.id">
          <TableCell>{{ post.title }}</TableCell>
          <TableCell>{{ post.user.name }}</TableCell>
          <TableCell>{{ post.created_at }}</TableCell>
          <TableCell>
            <Button 
              variant="outline" 
              size="sm"
              @click="router.visit(posts.edit({ id: post.id }))"
            >
              Edit
            </Button>
          </TableCell>
        </TableRow>
      </TableBody>
    </Table>
    
    <!-- Pagination -->
    <div class="flex justify-between items-center">
      <Button 
        :disabled="!posts.links.prev"
        @click="navigateToPage(posts.links.prev!)"
      >
        Previous
      </Button>
      
      <span class="text-sm text-muted-foreground">
        Page {{ posts.meta.current_page }} of {{ posts.meta.last_page }}
      </span>
      
      <Button 
        :disabled="!posts.links.next"
        @click="navigateToPage(posts.links.next!)"
      >
        Next
      </Button>
    </div>
  </div>
</template>
```

---

## Memory Patterns for AI Agents

```bash
# Store project type
mcp__serena__write_memory "project_structure" "Laravel Vue Starter Kit with shadcn-vue and Wayfinder"

# Store routing solution
mcp__serena__write_memory "routing_method" "Using Wayfinder for type-safe routes"

# Store component patterns
mcp__serena__write_memory "ui_library" "shadcn-vue components in resources/js/Components/ui/"

# Store authentication approach
mcp__serena__write_memory "auth_system" "Custom authentication (not Jetstream)"
```

---

## Cheat Sheet

```bash
# Project Detection
Wayfinder: Check for @wayfinder in imports
Ziggy: Check for ZiggyVue or route() helper
shadcn-vue: Check resources/js/Components/ui/
Jetstream: Check for Jetstream namespace
Starter Kit: Check for TypeScript + shadcn + Wayfinder

# Component Locations
Pages: resources/js/Pages/
Components: resources/js/Components/
shadcn UI: resources/js/Components/ui/
Layouts: resources/js/Layouts/
Types: resources/js/types/

# Common Tasks
Generate routes: php artisan routes:generate
Add shadcn component: npx shadcn-vue@latest add [component]
Type-check: npm run type-check
Build: npm run build
Dev server: npm run dev
```

---

**Remember**: Always identify the project structure first (Starter Kit vs Jetstream, Wayfinder vs Ziggy) before generating code to ensure compatibility with existing patterns.
