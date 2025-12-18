# Testing Skill for Laravel VILT Stack

This skill provides comprehensive testing patterns for Laravel VILT applications using Pest (PHP) and Vitest (Vue).

## When to Use This Skill

Use this skill when:
- Writing feature tests for HTTP endpoints
- Testing Inertia page responses
- Creating unit tests for models and services
- Testing Vue components
- Setting up test data with factories

## PHP Testing with Pest

### Feature Test Structure
```php
<?php

declare(strict_types=1);

use App\Models\User;
use App\Models\Post;
use Inertia\Testing\AssertableInertia as Assert;

describe('Post Feature', function () {
    beforeEach(function () {
        $this->user = User::factory()->create();
    });

    // Group related tests
    describe('index', function () {
        it('displays posts list', function () {
            Post::factory(5)->create();

            $this->actingAs($this->user)
                ->get(route('posts.index'))
                ->assertOk()
                ->assertInertia(fn (Assert $page) => $page
                    ->component('Posts/Index')
                    ->has('posts.data', 5)
                );
        });

        it('paginates results', function () {
            Post::factory(20)->create();

            $this->actingAs($this->user)
                ->get(route('posts.index'))
                ->assertInertia(fn (Assert $page) => $page
                    ->has('posts.data', 15) // Default pagination
                    ->has('posts.links')
                );
        });
    });

    describe('store', function () {
        it('creates a new post', function () {
            $data = [
                'title' => 'Test Post',
                'content' => 'Test content',
            ];

            $this->actingAs($this->user)
                ->post(route('posts.store'), $data)
                ->assertRedirect(route('posts.index'))
                ->assertSessionHas('success');

            $this->assertDatabaseHas('posts', [
                'title' => 'Test Post',
                'user_id' => $this->user->id,
            ]);
        });

        it('validates required fields', function () {
            $this->actingAs($this->user)
                ->post(route('posts.store'), [])
                ->assertSessionHasErrors(['title', 'content']);
        });

        it('validates title max length', function () {
            $this->actingAs($this->user)
                ->post(route('posts.store'), [
                    'title' => str_repeat('a', 256),
                    'content' => 'Valid content',
                ])
                ->assertSessionHasErrors(['title']);
        });
    });

    describe('update', function () {
        it('updates own post', function () {
            $post = Post::factory()->create(['user_id' => $this->user->id]);

            $this->actingAs($this->user)
                ->put(route('posts.update', $post), [
                    'title' => 'Updated Title',
                    'content' => 'Updated content',
                ])
                ->assertRedirect();

            expect($post->fresh()->title)->toBe('Updated Title');
        });
    });

    describe('authorization', function () {
        it('prevents updating others posts', function () {
            $otherUser = User::factory()->create();
            $post = Post::factory()->create(['user_id' => $otherUser->id]);

            $this->actingAs($this->user)
                ->put(route('posts.update', $post), ['title' => 'Hacked'])
                ->assertForbidden();
        });

        it('requires authentication', function () {
            $this->get(route('posts.index'))
                ->assertRedirect(route('login'));
        });
    });
});
```

### Inertia Testing Assertions
```php
// Assert component is rendered
->assertInertia(fn (Assert $page) => $page
    ->component('Posts/Index')
)

// Assert props exist
->assertInertia(fn (Assert $page) => $page
    ->has('posts')
    ->has('filters')
)

// Assert prop values
->assertInertia(fn (Assert $page) => $page
    ->where('post.title', 'Expected Title')
)

// Assert nested data
->assertInertia(fn (Assert $page) => $page
    ->has('post', fn (Assert $post) => $post
        ->where('title', 'Test')
        ->has('user')
    )
)

// Assert array count
->assertInertia(fn (Assert $page) => $page
    ->has('posts.data', 5)
)

// Assert missing
->assertInertia(fn (Assert $page) => $page
    ->missing('secretData')
)
```

### Unit Test Patterns
```php
<?php

use App\Models\Post;
use App\Models\User;

describe('Post Model', function () {
    it('belongs to a user', function () {
        $post = Post::factory()->create();

        expect($post->user)->toBeInstanceOf(User::class);
    });

    it('has fillable attributes', function () {
        $post = new Post();

        expect($post->getFillable())->toContain('title', 'content');
    });

    it('applies published scope', function () {
        Post::factory()->published()->create();
        Post::factory()->draft()->create();

        expect(Post::published()->count())->toBe(1);
    });

    it('casts dates correctly', function () {
        $post = Post::factory()->create([
            'published_at' => '2024-01-15 10:30:00',
        ]);

        expect($post->published_at)
            ->toBeInstanceOf(Carbon\Carbon::class)
            ->and($post->published_at->format('Y-m-d'))
            ->toBe('2024-01-15');
    });
});
```

### Factory Best Practices
```php
<?php

namespace Database\Factories;

use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

class PostFactory extends Factory
{
    public function definition(): array
    {
        return [
            'title' => $this->faker->sentence(),
            'content' => $this->faker->paragraphs(3, true),
            'user_id' => User::factory(),
            'published_at' => null,
        ];
    }

    // State methods
    public function published(): static
    {
        return $this->state(fn (array $attrs) => [
            'published_at' => now(),
        ]);
    }

    public function draft(): static
    {
        return $this->state(fn (array $attrs) => [
            'published_at' => null,
        ]);
    }

    public function byUser(User $user): static
    {
        return $this->state(fn (array $attrs) => [
            'user_id' => $user->id,
        ]);
    }
}
```

## Vue Testing with Vitest

### Component Test Structure
```typescript
import { mount } from '@vue/test-utils'
import { describe, it, expect, vi } from 'vitest'
import MyComponent from '@/Components/MyComponent.vue'

describe('MyComponent', () => {
  it('renders with props', () => {
    const wrapper = mount(MyComponent, {
      props: {
        title: 'Test Title',
        items: [{ id: 1, name: 'Item 1' }],
      },
    })

    expect(wrapper.text()).toContain('Test Title')
    expect(wrapper.findAll('li')).toHaveLength(1)
  })

  it('emits events on interaction', async () => {
    const wrapper = mount(MyComponent)

    await wrapper.find('button').trigger('click')

    expect(wrapper.emitted('submit')).toBeTruthy()
    expect(wrapper.emitted('submit')![0]).toEqual([{ data: 'test' }])
  })

  it('updates reactive state', async () => {
    const wrapper = mount(MyComponent)

    await wrapper.find('input').setValue('new value')

    expect(wrapper.find('.preview').text()).toContain('new value')
  })

  it('conditionally renders content', () => {
    const wrapper = mount(MyComponent, {
      props: { showDetails: false },
    })

    expect(wrapper.find('.details').exists()).toBe(false)
  })
})
```

### Testing Inertia Components
```typescript
import { mount } from '@vue/test-utils'
import { describe, it, expect, vi } from 'vitest'

// Mock Inertia
vi.mock('@inertiajs/vue3', () => ({
  usePage: () => ({
    props: {
      auth: { user: { id: 1, name: 'Test User' } },
      flash: {},
    },
  }),
  useForm: (data: any) => ({
    ...data,
    processing: false,
    errors: {},
    post: vi.fn(),
    put: vi.fn(),
    delete: vi.fn(),
    reset: vi.fn(),
  }),
  router: {
    visit: vi.fn(),
    get: vi.fn(),
  },
  Link: {
    template: '<a><slot /></a>',
  },
}))

// Mock route helper
vi.mock('ziggy-js', () => ({
  route: (name: string, params?: any) => `/mocked/${name}`,
}))

describe('PostForm', () => {
  it('submits form data', async () => {
    const wrapper = mount(PostForm)

    await wrapper.find('input[name="title"]').setValue('New Post')
    await wrapper.find('textarea').setValue('Content here')
    await wrapper.find('form').trigger('submit')

    // Assert form.post was called
    expect(wrapper.vm.form.post).toHaveBeenCalled()
  })
})
```

### Testing Computed Properties
```typescript
describe('computed properties', () => {
  it('calculates filtered items', () => {
    const wrapper = mount(ItemList, {
      props: {
        items: [
          { id: 1, name: 'Apple', category: 'fruit' },
          { id: 2, name: 'Carrot', category: 'vegetable' },
        ],
      },
    })

    // Access component internals
    wrapper.vm.filterCategory = 'fruit'

    expect(wrapper.vm.filteredItems).toHaveLength(1)
    expect(wrapper.vm.filteredItems[0].name).toBe('Apple')
  })
})
```

## Test Commands

```bash
# PHP Tests
php artisan test                     # Run all tests
php artisan test --filter=PostTest   # Run specific test
php artisan test --coverage          # With coverage report
php artisan test --parallel          # Parallel execution

# Vue Tests
npm run test                         # Run Vitest
npm run test:watch                   # Watch mode
npm run test:coverage                # With coverage
npm run test:ui                      # Vitest UI
```

## Testing Checklist

- [ ] Feature tests for all HTTP endpoints
- [ ] Validation error tests
- [ ] Authorization tests (forbidden for wrong users)
- [ ] Authentication tests (redirect for guests)
- [ ] Unit tests for model relationships
- [ ] Unit tests for model scopes
- [ ] Vue component rendering tests
- [ ] Vue component interaction tests
- [ ] Edge cases (empty data, max lengths)
