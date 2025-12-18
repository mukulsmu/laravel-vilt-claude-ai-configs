---
applyTo: "**/*.php"
---
# PHP/Laravel Code Guidelines

## General Rules
- Use `declare(strict_types=1);` at the top of every PHP file
- Follow PSR-12 coding standards
- Use PHP 8.2+ features (typed properties, enums, match, named arguments)
- Prefer dependency injection over facades for testability
- Always use return type declarations

## Controller Guidelines
- Keep controllers thin - move business logic to Services
- Use Form Requests for validation
- Return Inertia responses for pages, JSON for API endpoints
- Use resource routing conventions

## Model Guidelines
- Order properties: traits → fillable → casts → dates → relationships → accessors → scopes
- Always define `$fillable` or `$guarded`
- Use proper relationship return types (`BelongsTo`, `HasMany`, etc.)
- Create factories for every model

## Testing Guidelines
- Use Pest for testing
- Create feature tests for HTTP endpoints
- Use Inertia testing helpers for asserting page props
- Use factories for test data

## Example Controller
```php
<?php

declare(strict_types=1);

namespace App\Http\Controllers;

use App\Models\Post;
use App\Http\Requests\StorePostRequest;
use App\Http\Requests\UpdatePostRequest;
use Inertia\Inertia;
use Inertia\Response;

class PostController extends Controller
{
    public function index(): Response
    {
        return Inertia::render('Posts/Index', [
            'posts' => Post::with('user')
                ->latest()
                ->paginate(15),
        ]);
    }

    public function store(StorePostRequest $request)
    {
        $post = Post::create($request->validated());

        return redirect()->route('posts.show', $post)
            ->with('success', 'Post created successfully.');
    }
}
```

## Example Model
```php
<?php

declare(strict_types=1);

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Post extends Model
{
    use HasFactory;

    protected $fillable = [
        'title',
        'content',
        'user_id',
    ];

    protected $casts = [
        'published_at' => 'datetime',
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
