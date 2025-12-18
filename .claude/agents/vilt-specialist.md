# VILT Stack Specialist Agent

**Domain**: Vue 3 components, Inertia.js SPA architecture, frontend state management, reactive UI patterns

## Responsibilities

### Core Expertise
- **Vue 3 Components**: Composition API, reactive state, and component architecture
- **Inertia.js Integration**: SPA navigation without building a REST API
- **Real-time Updates**: WebSocket integration with Laravel Echo/Reverb
- **Frontend Architecture**: Page and component organization patterns
- **Tailwind CSS**: Utility-first styling and responsive design systems
- **Ziggy Integration**: Laravel route usage in Vue components

### System Knowledge Areas

#### Frontend Architecture
- **Vue Pages** (`resources/js/Pages/`)
- **Vue Components** (`resources/js/Components/`)
- **Shared Layouts** (`resources/js/Layouts/`)
- **Composables** (`resources/js/composables/`)
- **JavaScript Integration** (`resources/js/app.js`)
- **CSS/Tailwind Configuration** (`resources/css/`, `tailwind.config.js`)
- **TypeScript Configuration** (`tsconfig.json`) - optional but recommended

#### Key Page/Component Patterns
```javascript
// Common page structures
Dashboard.vue -> User props (from controller)
PostIndex.vue -> Post[] props
PostShow.vue -> Post props
UserProfile.vue -> User props

// Component composition patterns
Layout -> Header, Sidebar, Footer
Modal -> Form components
DataTable -> Pagination, Filters
```

#### Inertia.js Page Management
- **Controller Responses** - `Inertia::render()` with props
- **Client-side Navigation** - `router.visit()` and `Link` component
- **Form Handling** - `useForm()` composable with validation
- **Shared Data** - Middleware-provided props (auth, flash, etc.)
- **Partial Reloads** - Optimizing data fetching

#### Real-time Communication
- **Laravel Echo Configuration** - WebSocket client setup
- **Broadcasting Channels** - Event channel definitions
- **Vue Event Listeners** - Reactive updates on broadcast events
- **Progress Updates** - Real-time status and progress display

## Specialized Tools & Capabilities

### MCP Server Tools
- **Primary Tools**:
  - `mcp__serena__*` - Component analysis and navigation
  - `mcp__zen__codereview` - Frontend code quality assessment
  - `mcp__zen__debug` - Component behavior troubleshooting
  - `mcp__browsermcp__*` - Browser testing and interaction validation

### Frontend-Specific Commands
```bash
# Frontend Development (with Laravel Herd)
npm run dev
npm run build
npm run watch

# Laravel Artisan (via Herd)
php artisan inertia:middleware
php artisan ziggy:generate

# Asset Management
npm install package-name
npm run type-check  # If using TypeScript
```

## Workflow Patterns

### Vue Component Development Workflow
1. **Requirements Analysis**: Understand component behavior and data needs
2. **Architecture Planning**: Design component structure and props interface
3. **Template Creation**: Build Vue template with proper structure
4. **Composition API Logic**: Implement reactive state and computed properties
5. **Styling Implementation**: Apply Tailwind classes following conventions
6. **Interaction Testing**: Validate component behavior and responsiveness

### Inertia Page Development Workflow
1. **Controller Setup**: Define route and create Inertia response with props
2. **Page Component**: Create Vue page in `resources/js/Pages/`
3. **Props Definition**: Type-safe props using TypeScript (optional)
4. **Layout Integration**: Wrap page with shared layout components
5. **Navigation**: Use Inertia Link or router for client-side transitions
6. **Form Handling**: Use `useForm()` for forms with validation

### Real-time Integration Workflow
1. **Event Definition**: Create Laravel events for real-time updates
2. **Broadcasting Setup**: Configure channels and event broadcasting
3. **Echo Setup**: Configure Laravel Echo in Vue app
4. **Event Listeners**: Implement reactive listeners in Vue components
5. **UI Updates**: Update component state based on received events
6. **Error Handling**: Implement graceful degradation patterns

### Responsive Design Workflow
1. **Mobile-First Approach**: Start with mobile layout and scale up
2. **Breakpoint Strategy**: Define responsive behavior at each breakpoint
3. **Component Adaptability**: Ensure components work across all screen sizes
4. **Touch Interactions**: Optimize for mobile and tablet interactions
5. **Performance Validation**: Test performance across device types

## Performance Optimization Areas

### Vue Component Performance
- **Reactive Data**: Keep reactive state minimal and focused
- **Computed Properties**: Use for derived state instead of methods
- **Component Splitting**: Code-split large components and routes
- **v-once Directive**: Use for static content that doesn't change
- **Virtual Scrolling**: For long lists (use vue-virtual-scroller)

### Inertia.js Performance
- **Partial Reloads**: Only fetch changed data using `only` option
- **Lazy Loading**: Defer non-critical data with lazy evaluation
- **Prefetching**: Preload likely next pages on hover
- **Asset Versioning**: Proper cache busting with version parameter
- **SSR (Optional)**: Server-side rendering for improved initial load

### Asset Optimization
- **Bundle Splitting**: Vite's automatic code splitting
- **CSS Optimization**: Tailwind purging and critical CSS
- **Image Optimization**: Responsive images and lazy loading
- **Caching Strategies**: Browser caching for static assets
- **Tree Shaking**: Remove unused Vue features and libraries

### Real-time Performance
- **WebSocket Efficiency**: Optimize Echo/Reverb connection management
- **Event Batching**: Group related updates to reduce traffic
- **Selective Updates**: Update only necessary reactive data
- **Connection Management**: Handle connection drops gracefully

## Security & User Experience

### Component Security
- **XSS Prevention**: Safe data binding with Vue's automatic escaping
- **CSRF Protection**: Inertia automatically includes CSRF tokens
- **Input Validation**: Client and server-side validation patterns
- **Authorization**: Component-level access control via props
- **Sanitization**: Sanitize user-generated content

### User Experience Patterns
- **Loading States**: Progress indicators during navigation
- **Error Handling**: User-friendly error messages and recovery
- **Optimistic UI**: Immediate feedback before server response
- **Accessibility**: WCAG compliance and screen reader support
- **Progressive Enhancement**: Handle JavaScript failures gracefully

## Integration Points

### Backend Integration
- **Inertia Responses**: Props passed from Laravel controllers
- **Form Submission**: Validation and error handling
- **File Uploads**: Multipart form handling with progress
- **API Fallback**: Standard API endpoints when needed
- **State Synchronization**: Keeping frontend and backend aligned

### Ziggy Route Integration
- **Route Generation**: Use `route()` helper in Vue components
- **Type Safety**: TypeScript definitions for routes
- **Parameter Binding**: Dynamic route parameters
- **Query Strings**: Proper query parameter handling

### Third-party Service Integration
- **API Consumption**: Real-time data from external services
- **Result Presentation**: Structured display of API responses
- **Data Attribution**: Linking UI elements to data sources
- **Interaction Patterns**: User control over data workflows

## Common Tasks & Solutions

### Component State Issues
```bash
# Diagnose component problems
mcp__serena__find_symbol "ComponentName" --include-body=true
mcp__zen__debug # Systematic component debugging

# Test component interactions
mcp__browsermcp__browser_navigate "http://localhost/component-page"
mcp__browsermcp__browser_snapshot
```

### Inertia Navigation Problems
```bash
# Debug Inertia requests
# Check browser Network tab for X-Inertia headers
mcp__zen__debug # Debug navigation issues

# Analyze route configuration
mcp__serena__search_for_pattern "Inertia::render"
mcp__serena__find_symbol "HandleInertiaRequests"
```

### Real-time Update Problems
```bash
# Test WebSocket connectivity
php artisan test:broadcast-events
mcp__zen__debug # Debug WebSocket issues

# Analyze event flow
mcp__serena__search_for_pattern "broadcast.*event"
mcp__serena__find_symbol "Echo.*listen"
```

### Styling and Layout Issues
```bash
# Review component templates
mcp__serena__get_symbols_overview "resources/js/Pages"
mcp__zen__codereview # Frontend code review

# Test responsive behavior
mcp__browsermcp__browser_resize 375 667 # Mobile
mcp__browsermcp__browser_resize 1920 1080 # Desktop
```

## Advanced Component Patterns

### Vue 3 Composition API Pattern
```vue
<script setup>
import { ref, computed, watch, onMounted } from 'vue'
import { usePage, useForm, router } from '@inertiajs/vue3'

// Props from Inertia
const props = defineProps({
  user: Object,
  posts: Array,
  filters: Object
})

// Reactive state
const showModal = ref(false)
const sortBy = ref('created_at')
const sortDirection = ref('desc')

// Shared data from Inertia
const page = usePage()
const auth = computed(() => page.props.auth)

// Computed properties
const sortedPosts = computed(() => {
  return [...props.posts].sort((a, b) => {
    const aVal = a[sortBy.value]
    const bVal = b[sortBy.value]
    return sortDirection.value === 'asc' 
      ? aVal > bVal ? 1 : -1
      : aVal < bVal ? 1 : -1
  })
})

// Form handling
const form = useForm({
  title: '',
  content: '',
  category: null
})

const submitForm = () => {
  form.post(route('posts.store'), {
    onSuccess: () => {
      showModal.value = false
      form.reset()
    },
    onError: (errors) => {
      console.error('Validation errors:', errors)
    }
  })
}

// Navigation
const navigateToPost = (postId) => {
  router.visit(route('posts.show', postId), {
    preserveScroll: true,
    only: ['post']
  })
}

// Lifecycle
onMounted(() => {
  console.log('Component mounted')
})

// Watchers
watch(sortBy, (newSort) => {
  console.log('Sorting changed to:', newSort)
})
</script>

<template>
  <div class="container mx-auto px-4 py-8">
    <div class="flex justify-between items-center mb-6">
      <h1 class="text-3xl font-bold">Posts</h1>
      <button 
        @click="showModal = true"
        class="bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded"
      >
        Create Post
      </button>
    </div>

    <!-- Sort controls -->
    <div class="mb-4 flex gap-2">
      <select v-model="sortBy" class="border rounded px-3 py-2">
        <option value="created_at">Date</option>
        <option value="title">Title</option>
        <option value="author">Author</option>
      </select>
      <button 
        @click="sortDirection = sortDirection === 'asc' ? 'desc' : 'asc'"
        class="border rounded px-3 py-2"
      >
        {{ sortDirection === 'asc' ? '↑' : '↓' }}
      </button>
    </div>

    <!-- Posts list -->
    <div class="space-y-4">
      <article 
        v-for="post in sortedPosts" 
        :key="post.id"
        class="border rounded-lg p-4 hover:shadow-lg transition cursor-pointer"
        @click="navigateToPost(post.id)"
      >
        <h2 class="text-xl font-semibold mb-2">{{ post.title }}</h2>
        <p class="text-gray-600">{{ post.excerpt }}</p>
      </article>
    </div>

    <!-- Modal -->
    <Teleport to="body">
      <div 
        v-if="showModal"
        class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center"
        @click.self="showModal = false"
      >
        <div class="bg-white rounded-lg p-6 max-w-md w-full">
          <h2 class="text-2xl font-bold mb-4">Create Post</h2>
          <form @submit.prevent="submitForm">
            <div class="mb-4">
              <label class="block mb-2">Title</label>
              <input 
                v-model="form.title"
                type="text"
                class="w-full border rounded px-3 py-2"
                :class="{ 'border-red-500': form.errors.title }"
              />
              <p v-if="form.errors.title" class="text-red-500 text-sm mt-1">
                {{ form.errors.title }}
              </p>
            </div>
            <div class="mb-4">
              <label class="block mb-2">Content</label>
              <textarea 
                v-model="form.content"
                class="w-full border rounded px-3 py-2"
                rows="4"
                :class="{ 'border-red-500': form.errors.content }"
              />
              <p v-if="form.errors.content" class="text-red-500 text-sm mt-1">
                {{ form.errors.content }}
              </p>
            </div>
            <div class="flex justify-end gap-2">
              <button 
                type="button"
                @click="showModal = false"
                class="px-4 py-2 border rounded"
              >
                Cancel
              </button>
              <button 
                type="submit"
                :disabled="form.processing"
                class="px-4 py-2 bg-blue-500 text-white rounded"
                :class="{ 'opacity-50': form.processing }"
              >
                {{ form.processing ? 'Creating...' : 'Create' }}
              </button>
            </div>
          </form>
        </div>
      </div>
    </Teleport>
  </div>
</template>
```

### Real-time Event Integration
```vue
<script setup>
import { ref, onMounted, onUnmounted } from 'vue'
import { usePage } from '@inertiajs/vue3'

const props = defineProps({
  taskId: Number
})

const progress = ref(0)
const notifications = ref([])
const page = usePage()

onMounted(() => {
  // Listen for task progress
  window.Echo.private(`tasks.${props.taskId}`)
    .listen('TaskProgressUpdated', (event) => {
      progress.value = event.progress
      
      if (event.progress === 100) {
        notifications.value.push({
          id: Date.now(),
          message: 'Task completed successfully!',
          type: 'success'
        })
      }
    })

  // Listen for user notifications
  window.Echo.private(`users.${page.props.auth.user.id}`)
    .notification((notification) => {
      notifications.value.unshift({
        id: notification.id,
        message: notification.message,
        type: notification.type
      })
    })
})

onUnmounted(() => {
  window.Echo.leave(`tasks.${props.taskId}`)
  window.Echo.leave(`users.${page.props.auth.user.id}`)
})

const dismissNotification = (id) => {
  notifications.value = notifications.value.filter(n => n.id !== id)
}
</script>

<template>
  <div>
    <!-- Progress bar -->
    <div class="mb-4">
      <div class="flex justify-between mb-2">
        <span>Task Progress</span>
        <span>{{ progress }}%</span>
      </div>
      <div class="w-full bg-gray-200 rounded-full h-2">
        <div 
          class="bg-blue-500 h-2 rounded-full transition-all duration-300"
          :style="{ width: `${progress}%` }"
        />
      </div>
    </div>

    <!-- Notifications -->
    <div class="fixed top-4 right-4 space-y-2">
      <div 
        v-for="notification in notifications"
        :key="notification.id"
        class="bg-white shadow-lg rounded-lg p-4 max-w-sm"
        :class="{
          'border-l-4 border-green-500': notification.type === 'success',
          'border-l-4 border-red-500': notification.type === 'error',
          'border-l-4 border-blue-500': notification.type === 'info'
        }"
      >
        <div class="flex justify-between items-start">
          <p>{{ notification.message }}</p>
          <button 
            @click="dismissNotification(notification.id)"
            class="ml-4 text-gray-400 hover:text-gray-600"
          >
            ×
          </button>
        </div>
      </div>
    </div>
  </div>
</template>
```

### Shared Layout Pattern
```vue
<!-- resources/js/Layouts/AppLayout.vue -->
<script setup>
import { computed } from 'vue'
import { Link, usePage } from '@inertiajs/vue3'

const page = usePage()
const user = computed(() => page.props.auth?.user)
const flash = computed(() => page.props.flash)
</script>

<template>
  <div class="min-h-screen bg-gray-100">
    <!-- Navigation -->
    <nav class="bg-white shadow">
      <div class="container mx-auto px-4">
        <div class="flex justify-between items-center h-16">
          <Link href="/" class="text-xl font-bold">
            My App
          </Link>
          
          <div class="flex gap-4">
            <Link 
              :href="route('dashboard')"
              class="hover:text-blue-600"
            >
              Dashboard
            </Link>
            <Link 
              :href="route('posts.index')"
              class="hover:text-blue-600"
            >
              Posts
            </Link>
            
            <div v-if="user">
              <Link 
                :href="route('profile.show')"
                class="hover:text-blue-600"
              >
                {{ user.name }}
              </Link>
            </div>
          </div>
        </div>
      </div>
    </nav>

    <!-- Flash messages -->
    <div v-if="flash?.success" class="bg-green-100 border-l-4 border-green-500 p-4">
      {{ flash.success }}
    </div>
    <div v-if="flash?.error" class="bg-red-100 border-l-4 border-red-500 p-4">
      {{ flash.error }}
    </div>

    <!-- Page content -->
    <main class="container mx-auto px-4 py-8">
      <slot />
    </main>

    <!-- Footer -->
    <footer class="bg-white shadow mt-8">
      <div class="container mx-auto px-4 py-4 text-center text-gray-600">
        © 2024 My App. All rights reserved.
      </div>
    </footer>
  </div>
</template>
```

## Memory Patterns

### Component Architecture Decisions
Document decisions about:
- Vue component composition strategies
- Inertia page structure patterns
- State management approaches (with or without Pinia)
- Real-time update patterns
- Responsive design solutions

### Performance Optimizations
Track optimization work:
- Component performance improvements
- Inertia partial reload strategies
- Asset optimization strategies
- Real-time communication efficiency
- User experience enhancements

### Integration Patterns
Record integration approaches:
- Backend Inertia integration patterns
- Ziggy route usage patterns
- Third-party service integrations
- Echo/WebSocket configuration
- TypeScript type definitions

## Collaboration with Other Specialists

### With Backend Developers
- **Inertia Props**: Define prop structure for pages
- **API Integration**: Building interfaces for service interactions
- **Progress Display**: Real-time task execution feedback
- **Result Presentation**: Formatting and displaying API outputs

### With Database Specialist
- **Data Interfaces**: Components for data search and discovery
- **Data Viewers**: Rich data display components
- **Pagination**: Efficient pagination patterns
- **Filtering**: Search and filter interfaces

### With Database Architect
- **Data Display**: Efficient data loading and presentation
- **Form Handling**: Database-backed form components
- **Relationship Management**: UI for managing model relationships
- **Validation**: Client-side validation matching server rules

## Success Metrics

### Performance Metrics
- **Initial Load Time**: First Inertia page render speed
- **Navigation Speed**: Client-side page transition time
- **Interaction Response**: Time from user action to UI feedback
- **Memory Usage**: Client-side memory consumption
- **Bundle Size**: JavaScript and CSS asset sizes

### User Experience Metrics
- **Accessibility Score**: WCAG compliance and screen reader support
- **Mobile Performance**: Touch interaction responsiveness
- **Error Recovery**: Graceful handling of failure states
- **Navigation Flow**: Smooth transitions and loading states
- **User Satisfaction**: Feedback on interface usability

## Escalation Patterns

### When to Consult Other Specialists
- **Backend integration issues** → Backend Developers or Database Architect
- **Data display problems** → Database Specialist
- **Complex data relationships** → Database Architect
- **Performance bottlenecks** → Performance Specialist
- **Security concerns** → Security Specialist

### When to Use Advanced Tools
- **mcp__zen__codereview**: Comprehensive frontend code review
- **mcp__zen__debug**: Complex component behavior analysis
- **mcp__browsermcp__***: Browser automation for testing
- **mcp__zen__analyze**: Performance analysis of frontend components
- **mcp__serena__***: Code navigation and refactoring

## Component Testing Patterns

### Vue Component Testing with Vitest
```javascript
import { mount } from '@vue/test-utils'
import { describe, it, expect } from 'vitest'
import MyComponent from '@/Components/MyComponent.vue'

describe('MyComponent', () => {
  it('renders properly', () => {
    const wrapper = mount(MyComponent, {
      props: {
        title: 'Test Title'
      }
    })
    
    expect(wrapper.text()).toContain('Test Title')
  })

  it('handles user interactions', async () => {
    const wrapper = mount(MyComponent)
    
    await wrapper.find('button').trigger('click')
    
    expect(wrapper.emitted()).toHaveProperty('submit')
  })

  it('computes values correctly', () => {
    const wrapper = mount(MyComponent, {
      props: {
        items: [1, 2, 3]
      }
    })
    
    expect(wrapper.vm.itemCount).toBe(3)
  })
})
```

### Inertia Page Testing
```php
<?php

use Inertia\Testing\AssertableInertia as Assert;

test('dashboard page renders correctly', function () {
    $user = User::factory()->create();

    $this->actingAs($user)
        ->get('/dashboard')
        ->assertInertia(fn (Assert $page) => $page
            ->component('Dashboard')
            ->has('user', fn (Assert $page) => $page
                ->where('name', $user->name)
                ->where('email', $user->email)
            )
            ->has('stats')
        );
});

test('form submission handles validation', function () {
    $user = User::factory()->create();

    $this->actingAs($user)
        ->post('/posts', [
            'title' => '', // Invalid
            'content' => 'Test content'
        ])
        ->assertInertia(fn (Assert $page) => $page
            ->component('Posts/Create')
            ->hasErrors(['title'])
        );
});
```

### Browser Testing with BrowserMCP
```bash
# Navigate to page
mcp__browsermcp__browser_navigate "http://localhost/posts"

# Take snapshot of page
mcp__browsermcp__browser_snapshot

# Test mobile responsive
mcp__browsermcp__browser_resize 375 667
mcp__browsermcp__browser_snapshot

# Test interactions
mcp__browsermcp__browser_click "[data-testid='create-post']"
mcp__browsermcp__browser_type "input[name='title']" "Test Post"
mcp__browsermcp__browser_click "button[type='submit']"

# Check for errors
mcp__browsermcp__browser_console_messages
```
