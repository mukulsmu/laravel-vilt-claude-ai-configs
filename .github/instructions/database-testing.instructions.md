---
applyTo: "database/**/*.php,tests/**/*.php"
---
# Database & Testing Guidelines for Laravel VILT Stack

## Database Migrations

### Migration Pattern
```php
<?php

declare(strict_types=1);

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('posts', function (Blueprint $table) {
            // Primary key (UUID for user-facing entities)
            $table->uuid('id')->primary();
            // or: $table->id(); for auto-increment

            // Standard columns
            $table->string('title');
            $table->text('content')->nullable();
            $table->boolean('is_published')->default(false);

            // Foreign keys with constraints
            $table->foreignUuid('user_id')
                ->constrained()
                ->cascadeOnDelete();

            // JSON columns for flexible data
            $table->json('metadata')->nullable();

            // Timestamps and soft deletes
            $table->timestamps();
            $table->softDeletes();

            // Indexes for query performance
            $table->index(['is_published', 'created_at']);
            $table->index('title');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('posts');
    }
};
```

### Migration Best Practices
- Use UUID for user-facing entities, ID for internal entities
- Always define foreign key constraints
- Add indexes for frequently queried columns
- Use soft deletes for important user data
- Include proper `down()` method for rollbacks

## Model Factories

### Factory Pattern
```php
<?php

declare(strict_types=1);

namespace Database\Factories;

use App\Models\User;
use App\Models\Category;
use Illuminate\Database\Eloquent\Factories\Factory;

class PostFactory extends Factory
{
    public function definition(): array
    {
        return [
            'title' => $this->faker->sentence(),
            'content' => $this->faker->paragraphs(3, true),
            'is_published' => $this->faker->boolean(75),
            'published_at' => $this->faker->optional()->dateTimeBetween('-1 year'),
            'user_id' => User::factory(),
            'category_id' => Category::factory(),
            'metadata' => [
                'views' => $this->faker->numberBetween(0, 1000),
                'reading_time' => $this->faker->numberBetween(1, 15),
            ],
        ];
    }

    // State methods for variations
    public function published(): static
    {
        return $this->state(fn (array $attributes) => [
            'is_published' => true,
            'published_at' => now(),
        ]);
    }

    public function draft(): static
    {
        return $this->state(fn (array $attributes) => [
            'is_published' => false,
            'published_at' => null,
        ]);
    }

    public function byUser(User $user): static
    {
        return $this->state(fn (array $attributes) => [
            'user_id' => $user->id,
        ]);
    }
}
```

## Database Seeders

### Seeder Pattern
```php
<?php

declare(strict_types=1);

namespace Database\Seeders;

use App\Models\User;
use App\Models\Post;
use App\Models\Category;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        // Create admin user
        $admin = User::factory()->create([
            'name' => 'Admin User',
            'email' => 'admin@example.com',
        ]);

        // Create categories
        $categories = Category::factory(5)->create();

        // Create posts for admin
        Post::factory(10)
            ->published()
            ->byUser($admin)
            ->recycle($categories)
            ->create();

        // Create regular users with posts
        User::factory(5)
            ->has(Post::factory(3)->recycle($categories))
            ->create();
    }
}
```

## Testing with Pest

### Feature Test Pattern
```php
<?php

declare(strict_types=1);

use App\Models\Post;
use App\Models\User;
use Inertia\Testing\AssertableInertia as Assert;

describe('Post Management', function () {
    beforeEach(function () {
        $this->user = User::factory()->create();
    });

    it('displays posts index page', function () {
        $posts = Post::factory(3)->create();

        $this->actingAs($this->user)
            ->get(route('posts.index'))
            ->assertOk()
            ->assertInertia(fn (Assert $page) => $page
                ->component('Posts/Index')
                ->has('posts.data', 3)
            );
    });

    it('can create a post', function () {
        $postData = [
            'title' => 'Test Post Title',
            'content' => 'Test post content here.',
        ];

        $this->actingAs($this->user)
            ->post(route('posts.store'), $postData)
            ->assertRedirect(route('posts.index'));

        $this->assertDatabaseHas('posts', [
            'title' => 'Test Post Title',
            'user_id' => $this->user->id,
        ]);
    });

    it('validates required fields', function () {
        $this->actingAs($this->user)
            ->post(route('posts.store'), [])
            ->assertSessionHasErrors(['title', 'content']);
    });

    it('can update a post', function () {
        $post = Post::factory()->create(['user_id' => $this->user->id]);

        $this->actingAs($this->user)
            ->put(route('posts.update', $post), [
                'title' => 'Updated Title',
                'content' => 'Updated content.',
            ])
            ->assertRedirect();

        expect($post->fresh()->title)->toBe('Updated Title');
    });

    it('can delete a post', function () {
        $post = Post::factory()->create(['user_id' => $this->user->id]);

        $this->actingAs($this->user)
            ->delete(route('posts.destroy', $post))
            ->assertRedirect(route('posts.index'));

        $this->assertSoftDeleted($post);
    });
});

describe('Post Authorization', function () {
    it('prevents unauthorized users from editing others posts', function () {
        $owner = User::factory()->create();
        $otherUser = User::factory()->create();
        $post = Post::factory()->create(['user_id' => $owner->id]);

        $this->actingAs($otherUser)
            ->put(route('posts.update', $post), ['title' => 'Hacked'])
            ->assertForbidden();
    });
});
```

### Unit Test Pattern
```php
<?php

declare(strict_types=1);

use App\Models\Post;
use App\Models\User;

describe('Post Model', function () {
    it('belongs to a user', function () {
        $post = Post::factory()->create();

        expect($post->user)->toBeInstanceOf(User::class);
    });

    it('can be scoped to published', function () {
        Post::factory()->published()->create();
        Post::factory()->draft()->create();

        expect(Post::published()->count())->toBe(1);
    });

    it('casts published_at to datetime', function () {
        $post = Post::factory()->published()->create();

        expect($post->published_at)->toBeInstanceOf(Carbon\Carbon::class);
    });
});
```

### Inertia Testing Helpers
```php
// Assert specific component is rendered
->assertInertia(fn (Assert $page) => $page
    ->component('Posts/Show')
);

// Assert props exist
->assertInertia(fn (Assert $page) => $page
    ->has('post')
    ->has('comments', 5)
);

// Assert prop values
->assertInertia(fn (Assert $page) => $page
    ->where('post.title', 'Expected Title')
    ->where('post.user.id', $user->id)
);

// Assert nested data
->assertInertia(fn (Assert $page) => $page
    ->has('post', fn (Assert $post) => $post
        ->where('title', 'Expected Title')
        ->has('user', fn (Assert $user) => $user
            ->where('name', 'John Doe')
        )
    )
);
```

## Database Testing Tips

- Use `RefreshDatabase` trait for clean slate each test
- Use factories for all test data creation
- Test authorization and validation separately
- Use `assertDatabaseHas` and `assertDatabaseMissing`
- Use `assertSoftDeleted` for soft-deleted records
- Mock external services, not database operations
