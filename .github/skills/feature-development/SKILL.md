# VILT Feature Development Skill

This skill guides the creation of complete features in Laravel VILT (Vue, Inertia.js, Laravel, Tailwind CSS) stack applications.

## When to Use This Skill

Use this skill when:
- Creating a new resource/CRUD feature
- Adding a new page or section to the application
- Building interactive forms with validation
- Implementing data listings with filtering/pagination

## Feature Development Checklist

### 1. Database Layer
- [ ] Create migration with proper constraints and indexes
- [ ] Create model with fillable, casts, and relationships
- [ ] Create factory for testing
- [ ] Create seeder for demo data (optional)

### 2. Backend Layer
- [ ] Create Form Request(s) for validation
- [ ] Create Policy for authorization
- [ ] Create Controller with Inertia responses
- [ ] Register routes in web.php

### 3. Frontend Layer
- [ ] Create Vue page component(s) in `Pages/`
- [ ] Use existing `Components/ui/` for UI elements
- [ ] Apply proper layout (AuthenticatedLayout, GuestLayout)
- [ ] Handle form errors and loading states

### 4. Testing
- [ ] Create feature tests for all endpoints
- [ ] Test validation and authorization
- [ ] Test happy path and error cases

## Implementation Patterns

### Migration Pattern
```php
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('resources', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->text('content')->nullable();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->timestamps();
            $table->softDeletes();
            
            $table->index(['user_id', 'created_at']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('resources');
    }
};
```

### Model Pattern
```php
<?php

declare(strict_types=1);

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

class Resource extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'title',
        'content',
        'user_id',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }
}
```

### Form Request Pattern
```php
<?php

declare(strict_types=1);

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreResourceRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true; // Use policy for complex authorization
    }

    public function rules(): array
    {
        return [
            'title' => ['required', 'string', 'max:255'],
            'content' => ['required', 'string'],
        ];
    }
}
```

### Controller Pattern
```php
<?php

declare(strict_types=1);

namespace App\Http\Controllers;

use App\Models\Resource;
use App\Http\Requests\StoreResourceRequest;
use Inertia\{Inertia, Response};
use Illuminate\Http\RedirectResponse;

class ResourceController extends Controller
{
    public function index(): Response
    {
        return Inertia::render('Resources/Index', [
            'resources' => Resource::with('user')->latest()->paginate(15),
        ]);
    }

    public function store(StoreResourceRequest $request): RedirectResponse
    {
        Resource::create([
            ...$request->validated(),
            'user_id' => auth()->id(),
        ]);

        return redirect()->route('resources.index')
            ->with('success', 'Resource created successfully.');
    }
}
```

### Vue Page Pattern
```vue
<script setup lang="ts">
import { Head, Link, useForm } from '@inertiajs/vue3'
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue'
import { Button } from '@/Components/ui/button'
import { Input } from '@/Components/ui/input'

interface Resource {
  id: number
  title: string
  content: string
}

defineProps<{
  resources: { data: Resource[]; links: any[] }
}>()

const form = useForm({
  title: '',
  content: '',
})

const submit = () => {
  form.post(route('resources.store'), {
    onSuccess: () => form.reset(),
  })
}
</script>

<template>
  <Head title="Resources" />
  <AuthenticatedLayout>
    <!-- Page content -->
  </AuthenticatedLayout>
</template>
```

### Test Pattern
```php
<?php

use App\Models\Resource;
use App\Models\User;
use Inertia\Testing\AssertableInertia as Assert;

test('displays resources list', function () {
    $user = User::factory()->create();
    Resource::factory(3)->create();

    $this->actingAs($user)
        ->get(route('resources.index'))
        ->assertOk()
        ->assertInertia(fn (Assert $page) => $page
            ->component('Resources/Index')
            ->has('resources.data', 3)
        );
});

test('validates required fields', function () {
    $user = User::factory()->create();

    $this->actingAs($user)
        ->post(route('resources.store'), [])
        ->assertSessionHasErrors(['title', 'content']);
});
```

## Quick Commands

```bash
# Generate all resources at once
php artisan make:model Resource -mfc
php artisan make:request StoreResourceRequest
php artisan make:request UpdateResourceRequest
php artisan make:policy ResourcePolicy --model=Resource

# Run migrations
php artisan migrate

# Create test file
php artisan make:test ResourceTest
```
