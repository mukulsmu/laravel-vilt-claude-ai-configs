---
applyTo: "resources/js/**/*.{vue,ts,js}"
---
# Vue 3 & Inertia.js Code Guidelines

## General Rules
- Use Vue 3 Composition API with `<script setup>`
- Prefer TypeScript for type safety
- Use Inertia.js for page routing and form handling
- Follow single responsibility principle for components

## Component Structure
```vue
<script setup lang="ts">
// 1. Imports
import { ref, computed, watch, onMounted } from 'vue'
import { usePage, useForm, router, Link } from '@inertiajs/vue3'

// 2. Type definitions
interface Props {
  item: Item
  items: Item[]
}

// 3. Props and emits
const props = defineProps<Props>()
const emit = defineEmits<{
  (e: 'update', id: number): void
}>()

// 4. Reactive state
const isLoading = ref(false)
const search = ref('')

// 5. Computed properties
const filteredItems = computed(() => /* ... */)

// 6. Functions
const handleSubmit = () => { /* ... */ }

// 7. Watchers
watch(search, (newValue) => { /* ... */ })

// 8. Lifecycle hooks
onMounted(() => { /* ... */ })
</script>

<template>
  <!-- Template content -->
</template>
```

## Inertia.js Patterns

### Page Components
```vue
<script setup lang="ts">
import { Head } from '@inertiajs/vue3'
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue'

defineProps<{
  posts: App.Models.Post[]
}>()
</script>

<template>
  <Head title="Posts" />
  <AuthenticatedLayout>
    <!-- Page content -->
  </AuthenticatedLayout>
</template>
```

### Form Handling
```vue
<script setup lang="ts">
import { useForm } from '@inertiajs/vue3'

const form = useForm({
  title: '',
  content: '',
})

const submit = () => {
  form.post(route('posts.store'), {
    onSuccess: () => form.reset(),
    preserveScroll: true,
  })
}
</script>

<template>
  <form @submit.prevent="submit">
    <input v-model="form.title" />
    <span v-if="form.errors.title">{{ form.errors.title }}</span>
    <button :disabled="form.processing">Submit</button>
  </form>
</template>
```

### Navigation
```vue
<script setup lang="ts">
import { Link, router } from '@inertiajs/vue3'

// Programmatic navigation
const goToPost = (id: number) => {
  router.visit(route('posts.show', id), {
    preserveState: true,
    only: ['post'],
  })
}
</script>

<template>
  <!-- Declarative navigation -->
  <Link :href="route('posts.index')">View Posts</Link>
</template>
```

## shadcn-vue Components

When using shadcn-vue components:
```vue
<script setup lang="ts">
import { Button } from '@/Components/ui/button'
import { Card, CardHeader, CardTitle, CardContent } from '@/Components/ui/card'
import { Input } from '@/Components/ui/input'
import { Label } from '@/Components/ui/label'
</script>

<template>
  <Card>
    <CardHeader>
      <CardTitle>Form Title</CardTitle>
    </CardHeader>
    <CardContent>
      <div class="space-y-4">
        <div>
          <Label for="name">Name</Label>
          <Input id="name" v-model="form.name" />
        </div>
        <Button @click="submit">Save</Button>
      </div>
    </CardContent>
  </Card>
</template>
```

## Routing

### Wayfinder (Recommended)
```typescript
import { posts, users } from '@wayfinder/routes'

router.visit(posts.show({ id: 1 }))
router.visit(users.index())
```

### Ziggy (Legacy)
```typescript
import { route } from 'ziggy-js'

router.visit(route('posts.show', { id: 1 }))
router.visit(route('users.index'))
```

## Tailwind CSS in Vue

- Use utility classes directly in templates
- Use `class` attribute with template literals for dynamic classes
- Extract repeated patterns to component classes

```vue
<template>
  <div
    :class="[
      'rounded-lg border p-4',
      isActive ? 'bg-blue-50 border-blue-500' : 'bg-white border-gray-200'
    ]"
  >
    <h2 class="text-lg font-semibold text-gray-900">Title</h2>
    <p class="mt-2 text-sm text-gray-600">Description</p>
  </div>
</template>
```

## Testing Vue Components

```typescript
import { mount } from '@vue/test-utils'
import { describe, it, expect } from 'vitest'
import MyComponent from '@/Components/MyComponent.vue'

describe('MyComponent', () => {
  it('renders correctly', () => {
    const wrapper = mount(MyComponent, {
      props: { title: 'Test' }
    })
    expect(wrapper.text()).toContain('Test')
  })

  it('handles interactions', async () => {
    const wrapper = mount(MyComponent)
    await wrapper.find('button').trigger('click')
    expect(wrapper.emitted('submit')).toBeTruthy()
  })
})
```
