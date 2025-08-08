# Code Conventions & Standards

This document outlines the coding standards and conventions for the Laravel TALL stack application.

## **⚠️ IMPORTANT: Current Architecture Status**

**FilamentPHP Package Status:**
- ✅ **Installed**: `filament/filament: ^3.0` in composer.json
- ❌ **Not Configured**: No admin panel setup or resources exist
- 🔄 **Migration Needed**: See [FilamentPHP Refactoring Guide](filament-refactoring-guide.md)

**Current Admin Architecture:**
- Custom Livewire components: `AgentManager.php`, `KnowledgeManager.php`
- **Temporary solution** - Will be migrated to FilamentPHP
- **Component mixing issue** - This guide provides clear boundaries

---

## Laravel Code Conventions

### File Organization
```php
<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Http\Requests\UserRequest;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class UserController extends Controller
{
    // Class organization order:
    // 1. Properties
    // 2. Constructor
    // 3. Public methods (in logical order)
    // 4. Protected methods
    // 5. Private methods
}
```

### Model Conventions
```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class Product extends Model
{
    use SoftDeletes;

    // Order: traits → fillable → casts → dates → relationships → accessors/mutators → scopes
    
    protected $fillable = [
        'name',
        'description',
        'price',
        'user_id',
    ];

    protected $casts = [
        'price' => 'decimal:2',
        'is_active' => 'boolean',
        'metadata' => 'array',
    ];

    protected $dates = [
        'published_at',
    ];

    // Relationships
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function reviews(): HasMany
    {
        return $this->hasMany(Review::class);
    }

    // Accessors & Mutators
    public function getFormattedPriceAttribute(): string
    {
        return '$' . number_format($this->price, 2);
    }

    // Scopes
    public function scopeActive($query)
    {
        return $query->where('is_active', true);
    }
}
```

### Controller Patterns
```php
<?php

namespace App\Http\Controllers;

use App\Models\Product;
use App\Http\Requests\ProductRequest;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\View\View;

class ProductController extends Controller
{
    public function index(): View
    {
        $products = Product::with('user')->active()->paginate(15);
        
        return view('products.index', compact('products'));
    }

    public function store(ProductRequest $request): RedirectResponse
    {
        $product = Product::create($request->validated());
        
        return redirect()
            ->route('products.show', $product)
            ->with('success', 'Product created successfully.');
    }

    public function show(Product $product): View
    {
        $product->load('reviews.user');
        
        return view('products.show', compact('product'));
    }
}
```

## **Architecture Decision Guidelines**

### When to Use Livewire vs FilamentPHP

#### **Use Livewire Components For:**
```php
// ✅ User-facing interactive interfaces
app/Livewire/ChatResearchInterface.php     // Main chat interface
app/Livewire/BaseChatInterface.php         // User chat base
app/Livewire/Settings/AiPersona.php        // User settings

// ✅ Real-time interactive components
app/Livewire/Components/AgentProgressBar.php
app/Livewire/Components/ChatResultTabs.php
app/Livewire/Components/EnhancedSourceLink.php

// ✅ Custom user workflows
app/Livewire/Traits/HasSessionManagement.php
app/Livewire/Traits/HasToolManagement.php
```

#### **Use FilamentPHP Resources For (Future):**
```php
// ✅ Administrative CRUD operations
app/Filament/Resources/AgentResource.php           // Admin agent management
app/Filament/Resources/KnowledgeDocumentResource.php  // Admin knowledge management
app/Filament/Resources/UserResource.php            // Admin user management

// ✅ Admin dashboards and analytics
app/Filament/Pages/Dashboard.php
app/Filament/Widgets/SystemStatsWidget.php

// ✅ System configuration interfaces
app/Filament/Pages/SystemSettings.php
```

#### **❌ AVOID: Component Mixing Anti-Patterns**
```php
// ❌ DON'T: Custom admin components when FilamentPHP should be used
app/Livewire/AgentManager.php    // Should be FilamentResource
app/Livewire/KnowledgeManager.php // Should be FilamentResource

// ❌ DON'T: Mixing Filament forms in Livewire components
// ❌ DON'T: Custom admin routes when Filament panel exists
// ❌ DON'T: Livewire for simple CRUD when FilamentPHP is better
```

### **The Golden Architecture Rule:**
```
IF admin functionality AND CRUD operations:
    → Use FilamentPHP Resources

IF user-facing AND interactive/real-time:
    → Use Livewire Components

IF administrative AND complex custom workflow:
    → Use FilamentPHP Pages with custom logic
```

---

## Livewire Component Conventions

### Component Structure
```php
<?php

namespace App\Livewire;

use App\Models\Product;
use Livewire\Component;
use Livewire\WithPagination;

class ProductManager extends Component
{
    use WithPagination;

    // Organization order:
    // 1. Traits
    // 2. Public properties
    // 3. Protected properties 
    // 4. Validation rules
    // 5. Lifecycle hooks (mount, boot, etc.)
    // 6. Public methods (actions)
    // 7. Protected methods
    // 8. Computed properties
    // 9. Render method

    // Public properties
    public string $search = '';
    public array $selected = [];
    public bool $showModal = false;
    
    // Validation
    protected array $rules = [
        'product.name' => 'required|string|max:255',
        'product.price' => 'required|numeric|min:0',
    ];

    protected array $messages = [
        'product.name.required' => 'Product name is required.',
        'product.price.min' => 'Price must be positive.',
    ];

    // Lifecycle hooks
    public function mount(): void
    {
        $this->search = request('search', '');
    }

    // Actions
    public function createProduct(): void
    {
        $this->validate();
        
        Product::create($this->product);
        
        $this->dispatch('product-created');
        $this->showModal = false;
        $this->reset('product');
    }

    public function selectProduct(int $productId): void
    {
        if (in_array($productId, $this->selected)) {
            $this->selected = array_diff($this->selected, [$productId]);
        } else {
            $this->selected[] = $productId;
        }
    }

    // Computed properties
    public function getProductsProperty()
    {
        return Product::query()
            ->when($this->search, fn($query) => $query->where('name', 'like', '%' . $this->search . '%'))
            ->paginate(15);
    }

    // Render method (always last)
    public function render()
    {
        return view('livewire.product-manager');
    }
}
```

### Livewire Best Practices
```php
// ✅ Good - Use primitive types
public string $name = '';
public int $count = 0;
public bool $isActive = false;

// ❌ Avoid - Large objects in properties
public Product $product; // Only for simple objects

// ✅ Good - Component communication
$this->dispatch('product-updated', productId: $product->id);

// ✅ Good - Property binding with validation
public function updatedSearch(): void
{
    $this->resetPage();
    $this->validate(['search' => 'string|max:100']);
}
```

## Tailwind CSS Conventions

### Utility Class Order
Follow this order for utility classes:

1. **Positioning**: `absolute`, `relative`, `fixed`, `sticky`
2. **Box Model**: `block`, `flex`, `grid`, `w-*`, `h-*`, `p-*`, `m-*`
3. **Borders**: `border-*`, `rounded-*`
4. **Backgrounds**: `bg-*`
5. **Typography**: `text-*`, `font-*`, `leading-*`
6. **Visual Effects**: `shadow-*`, `opacity-*`, `transition-*`

```html
<!-- ✅ Good - Proper utility order -->
<div class="relative flex items-center justify-between w-full h-12 px-4 py-2 border border-gray-300 rounded-lg bg-white text-sm font-medium text-gray-900 shadow-sm hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-blue-500 transition-colors">
    Content
</div>

<!-- ❌ Avoid - Random utility order -->
<div class="bg-white text-sm relative px-4 shadow-sm w-full border flex text-gray-900">
    Content
</div>
```

### Responsive Design Patterns
```html
<!-- ✅ Mobile-first responsive design -->
<div class="block lg:flex lg:items-center lg:justify-between">
    <h1 class="text-xl lg:text-2xl xl:text-3xl">Title</h1>
    <nav class="mt-4 lg:mt-0">
        <!-- Navigation items -->
    </nav>
</div>

<!-- ✅ Component-based spacing -->
<div class="space-y-4 lg:space-y-6">
    <div class="bg-white rounded-lg p-6">Item 1</div>
    <div class="bg-white rounded-lg p-6">Item 2</div>
</div>
```

### Custom Component Classes
```css
/* Use @apply for reusable component classes */
.btn-primary {
    @apply inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-colors;
}

.card {
    @apply bg-white rounded-lg shadow-sm border border-gray-200 p-6;
}
```

## Alpine.js Conventions

### Minimal Usage Philosophy
**Prefer Livewire native functionality over Alpine.js**. Use Alpine.js only for:
- Simple UI interactions that don't require server state
- Micro-animations and transitions
- Client-side form enhancements

```html
<!-- ✅ Good - Simple dropdown -->
<div x-data="{ open: false }" class="relative">
    <button @click="open = !open" class="btn-primary">
        Options
    </button>
    <div x-show="open" @click.away="open = false" class="dropdown-menu">
        <!-- Menu items -->
    </div>
</div>

<!-- ✅ Good - Form enhancement -->
<form wire:submit="save">
    <input type="password" 
           x-data="{ show: false }" 
           :type="show ? 'text' : 'password'"
           wire:model="password">
    <button @click="show = !show" type="button">
        Toggle
    </button>
</form>
```

### Event Communication
```html
<!-- ✅ Good - Namespaced events -->
<div x-data @app:modal-opened.window="handleModalOpen">
    <!-- Component content -->
</div>

<!-- ✅ Good - Livewire integration -->
<div x-data @product-updated.window="$wire.$refresh()">
    <!-- Component content -->
</div>
```

## FilamentPHP Conventions

### **Current Status & Migration Path**

**❗ IMPORTANT:** FilamentPHP is installed but not yet configured in this project.

**Current State:**
- ✅ Package installed: `filament/filament: ^3.0`
- ❌ No admin panel configured
- ❌ No FilamentPHP resources exist yet
- 🔄 **Migration needed**: See [FilamentPHP Refactoring Guide](filament-refactoring-guide.md)

**Current Admin Components (To Be Migrated):**
```php
// These custom Livewire components should become FilamentPHP resources:
app/Livewire/AgentManager.php     → app/Filament/Resources/AgentResource.php
app/Livewire/KnowledgeManager.php → app/Filament/Resources/KnowledgeDocumentResource.php
```

### **Target FilamentPHP Architecture**

Once properly configured, FilamentPHP resources should follow this structure:

```php
<?php

namespace App\Filament\Resources;

use App\Filament\Resources\AgentResource\Pages;
use App\Models\Agent;
use Filament\Forms;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Toggle;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Columns\IconColumn;

// This resource does not exist yet - will be created during migration
class AgentResource extends Resource
{
    protected static ?string $model = Agent::class;
    protected static ?string $navigationIcon = 'heroicon-o-cpu-chip';
    protected static ?string $navigationGroup = 'AI Management';
    protected static ?int $navigationSort = 1;

    public static function form(Form $form): Form
    {
        return $form->schema([
            TextInput::make('name')
                ->required()
                ->maxLength(255),
            
            Textarea::make('description')
                ->required()
                ->columnSpanFull(),
            
            Select::make('type')
                ->options([
                    'research' => 'Research Agent',
                    'analysis' => 'Analysis Agent',
                    'writing' => 'Writing Agent',
                    'coding' => 'Coding Agent',
                ])
                ->required(),
                
            Toggle::make('is_active')
                ->default(true),
                
            Select::make('visibility')
                ->options([
                    'public' => 'Public',
                    'private' => 'Private',
                    'shared' => 'Shared',
                ])
                ->default('private'),
                
            Textarea::make('system_prompt')
                ->rows(10)
                ->columnSpanFull(),
        ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('name')
                    ->sortable()
                    ->searchable(),
                
                TextColumn::make('type')
                    ->badge(),
                
                TextColumn::make('visibility')
                    ->badge(),
                    
                IconColumn::make('is_active')
                    ->boolean(),
                
                TextColumn::make('user.name')
                    ->label('Created By'),
                
                TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable(),
            ])
            ->filters([
                // Add appropriate filters for agent management
            ])
            ->actions([
                Tables\Actions\ViewAction::make(),
                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ]);
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListAgents::route('/'),
            'create' => Pages\CreateAgent::route('/create'),
            'view' => Pages\ViewAgent::route('/{record}'),
            'edit' => Pages\EditAgent::route('/{record}/edit'),
        ];
    }
    
    // Admin-only access
    public static function canViewAny(): bool
    {
        return auth()->user()?->is_admin ?? false;
    }
}
```

### **Setup Commands (When Ready for Migration)**
```bash
# Step 1: Install FilamentPHP admin panel (not yet run)
./vendor/bin/sail artisan filament:install --panels

# Step 2: Create admin user
./vendor/bin/sail artisan make:filament-user

# Step 3: Generate resources from existing models
./vendor/bin/sail artisan make:filament-resource Agent --generate
./vendor/bin/sail artisan make:filament-resource KnowledgeDocument --generate
./vendor/bin/sail artisan make:filament-resource User --generate
```

### **Form & Table Best Practices (Future Implementation)**
```php
// ✅ Good - Conditional field display
FileUpload::make('file_path')
    ->directory('knowledge-documents')
    ->visibility('private')
    ->visible(fn (Get $get) => $get('content_type') === 'file'),

// ✅ Good - Relationship management
Select::make('agent_type')
    ->relationship('agentType', 'name')
    ->required()
    ->searchable()
    ->preload(),

// ✅ Good - Table column formatting for our data
TextColumn::make('expires_at')
    ->dateTime('M j, Y')
    ->sortable()
    ->toggleable()
    ->placeholder('Never expires'),

// ✅ Good - Custom bulk actions for admin tasks
BulkAction::make('reprocess_embeddings')
    ->icon('heroicon-o-arrow-path')
    ->action(fn (Collection $records) => 
        $records->each(fn ($record) => 
            dispatch(new GenerateDocumentEmbeddings($record->id))
        )
    ),
```

### **Permission Integration**
```php
// ✅ Proper admin-only access control
class AgentResource extends Resource
{
    public static function canViewAny(): bool
    {
        return auth()->user()?->is_admin ?? false;
    }
    
    public static function canCreate(): bool
    {
        return auth()->user()?->is_admin ?? false;
    }
    
    public static function canEdit(Model $record): bool
    {
        $user = auth()->user();
        return $user?->is_admin || $record->user_id === $user?->id;
    }
}
```

## Database Conventions

### Migration Patterns
```php
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('products', function (Blueprint $table) {
            // Use UUID for user-facing entities
            $table->uuid('id')->primary();
            
            // Standard columns
            $table->string('name');
            $table->text('description')->nullable();
            $table->decimal('price', 10, 2);
            $table->boolean('is_active')->default(true);
            
            // Foreign keys with indexes
            $table->foreignUuid('user_id')->constrained()->cascadeOnDelete();
            $table->foreignUuid('category_id')->constrained()->cascadeOnDelete();
            
            // JSON columns for flexible data
            $table->json('metadata')->nullable();
            
            // Soft deletes for user data
            $table->timestamps();
            $table->softDeletes();
            
            // Indexes for performance
            $table->index(['is_active', 'created_at']);
            $table->index('name');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('products');
    }
};
```

### Model Factory Patterns
```php
<?php

namespace Database\Factories;

use App\Models\User;
use App\Models\Category;
use Illuminate\Database\Eloquent\Factories\Factory;

class ProductFactory extends Factory
{
    public function definition(): array
    {
        return [
            'name' => $this->faker->words(3, true),
            'description' => $this->faker->paragraph(),
            'price' => $this->faker->randomFloat(2, 10, 1000),
            'is_active' => $this->faker->boolean(80),
            'user_id' => User::factory(),
            'category_id' => Category::factory(),
            'metadata' => [
                'weight' => $this->faker->randomFloat(2, 0.1, 10),
                'dimensions' => [
                    'length' => $this->faker->numberBetween(1, 100),
                    'width' => $this->faker->numberBetween(1, 100),
                    'height' => $this->faker->numberBetween(1, 100),
                ],
            ],
        ];
    }

    public function inactive(): Factory
    {
        return $this->state(fn (array $attributes) => [
            'is_active' => false,
        ]);
    }
}
```

## Testing Conventions

### Pest Test Structure
```php
<?php

use App\Models\Product;
use App\Models\User;

describe('Product Management', function () {
    beforeEach(function () {
        $this->user = User::factory()->create();
        $this->actingAs($this->user);
    });

    it('can create a product', function () {
        $productData = [
            'name' => 'Test Product',
            'description' => 'A test product description',
            'price' => 99.99,
        ];

        $response = $this->post(route('products.store'), $productData);

        $response->assertRedirect(route('products.index'));
        expect(Product::where('name', 'Test Product'))->toExist();
    });

    it('validates required fields', function () {
        $response = $this->post(route('products.store'), []);

        $response->assertSessionHasErrors(['name', 'price']);
    });
});
```

### Livewire Testing
```php
<?php

use App\Livewire\ProductManager;
use App\Models\Product;
use Livewire\Livewire;

it('can search products', function () {
    Product::factory()->create(['name' => 'iPhone']);
    Product::factory()->create(['name' => 'Android Phone']);

    Livewire::test(ProductManager::class)
        ->set('search', 'iPhone')
        ->assertSee('iPhone')
        ->assertDontSee('Android Phone');
});

it('can select multiple products', function () {
    $products = Product::factory()->count(3)->create();

    Livewire::test(ProductManager::class)
        ->call('selectProduct', $products[0]->id)
        ->call('selectProduct', $products[1]->id)
        ->assertSet('selected', [$products[0]->id, $products[1]->id]);
});
```

## AI Development Guidelines

1. **Always use Sail prefix** for all commands
2. **Follow TALL stack conventions** for each technology
3. **Generate components** using Artisan commands first
4. **Structure Livewire components** properly with lifecycle hooks
5. **Use FilamentPHP** for admin interfaces (after migration from current Livewire admin components)
6. **Consider performance** - avoid large objects in Livewire properties
7. **Provide end-to-end solutions** including models, migrations, components, and views
8. **Follow utility class ordering** in Tailwind CSS
9. **Prefer Livewire native functionality** over Alpine.js or custom JavaScript
10. **Test components** using Livewire testing helpers
11. **Use Edit/MultiEdit tools** for simple changes; **Serena tools** for complex analysis

## Smart Tool Selection Guidelines

### When to Use Edit/MultiEdit Tools
- Simple, targeted file modifications
- Adding/removing specific lines or blocks
- Updating configuration values
- Small refactoring tasks (renaming variables, updating imports)
- When you know exactly what to change and where

### When to Use Serena Symbolic Tools
- Understanding unfamiliar code structure
- Cross-file symbol analysis and relationships
- Complex refactoring involving multiple symbols
- Finding implementation patterns across the codebase
- When you need to understand before modifying

### When to Use Zen Tools
- Quality assurance and code review workflows
- Debugging complex issues requiring systematic analysis
- Architectural decision making and consensus building
- Performance analysis and security auditing
- Multi-step complex task planning

## Performance Considerations

- **Don't pass large objects to Livewire components** - use IDs and load relationships as needed
- **Keep component nesting shallow** - avoid deep nested component hierarchies
- **Use computed properties** for derived values to avoid repeated calculations
- **Minimize Tailwind class duplication** - extract common patterns to components
- **Index database queries** - add appropriate indexes for filtered and sorted columns
- **Use pagination** for large datasets in tables and lists

## See Also

- **[FilamentPHP Refactoring Guide](filament-refactoring-guide.md)** - **REQUIRED READING** for admin interface migration
- **[Laravel Commands Reference](laravel-commands.md)** - Complete command reference
- **[AI Interaction Patterns](ai-interaction-patterns.md)** - Natural language development
- **[Feature Development Workflow](../workflows/feature-development.md)** - Development process
- **[TALL Stack Specialist](../.claude/agents/tall-specialist.md)** - Expert guidance for complex implementations