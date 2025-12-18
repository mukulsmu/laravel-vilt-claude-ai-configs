# Filament 3 Code Examples

This file provides reference implementations for common Filament resources.

## 1. Filament Resource Boilerplate

This is the standard structure for a Filament resource, generated via `php artisan make:filament-resource`.

```php
<?php

namespace App\Filament\Resources;

use App\Filament\Resources\PostResource\Pages;
use App\Filament\Resources\PostResource\RelationManagers;
use App\Models\Post;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class PostResource extends Resource
{
    protected static ?string $model = Post::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\TextInput::make('title')
                    ->required()
                    ->maxLength(255),
                Forms\Components\RichEditor::make('content')
                    ->required()
                    ->columnSpanFull(),
                Forms\Components\DateTimePicker::make('published_at'),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('title')
                    ->searchable(),
                Tables\Columns\TextColumn::make('published_at')
                    ->dateTime()
                    ->sortable(),
                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                //
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ]);
    }

    public static function getRelations(): array
    {
        return [
            // Example: RelationManagers\CommentsRelationManager::class,
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListPosts::route('/'),
            'create' => Pages\CreatePost::route('/create'),
            'edit' => Pages\EditPost::route('/{record}/edit'),
        ];
    }
}
```

## 2. Form Schema vs. Table Columns

-   **Form Schema (`form()` method)**: Defines the fields that appear when creating or editing a record. Uses components from `Filament\Forms\Components`.
-   **Table Columns (`table()` method)**: Defines the columns displayed in the resource's list view. Uses components from `Filament\Tables\Columns`.

## 3. Advanced Form Components

### Relationship Select with Search

```php
use Filament\Forms\Components\Select;

Select::make('author_id')
    ->relationship('author', 'name')
    ->searchable()
    ->preload()
    ->required()
    ->createOptionForm([
        Forms\Components\TextInput::make('name')->required(),
        Forms\Components\TextInput::make('email')->email()->required(),
    ])
```

### Repeater for Nested Data

```php
use Filament\Forms\Components\Repeater;
use Filament\Forms\Components\TextInput;

Repeater::make('items')
    ->schema([
        TextInput::make('name')->required(),
        TextInput::make('quantity')->numeric()->required(),
        TextInput::make('price')->numeric()->prefix('$')->required(),
    ])
    ->columns(3)
    ->defaultItems(1)
    ->addActionLabel('Add Item')
    ->collapsible()
```

### File Upload with Preview

```php
use Filament\Forms\Components\FileUpload;

FileUpload::make('featured_image')
    ->image()
    ->directory('posts')
    ->visibility('public')
    ->imageEditor()
    ->imageEditorAspectRatios([
        '16:9',
        '4:3',
        '1:1',
    ])
    ->maxSize(2048)
    ->helperText('Maximum file size: 2MB')
```

### Rich Editor with Media

```php
use Filament\Forms\Components\RichEditor;

RichEditor::make('content')
    ->required()
    ->fileAttachmentsDisk('public')
    ->fileAttachmentsDirectory('attachments')
    ->fileAttachmentsVisibility('public')
    ->toolbarButtons([
        'bold',
        'italic',
        'link',
        'bulletList',
        'orderedList',
        'h2',
        'h3',
        'attachFiles',
    ])
```

### Wizard for Multi-Step Forms

```php
use Filament\Forms\Components\Wizard;

public static function form(Form $form): Form
{
    return $form
        ->schema([
            Wizard::make([
                Wizard\Step::make('Basic Information')
                    ->schema([
                        TextInput::make('title')->required(),
                        TextInput::make('slug')->required(),
                    ]),
                Wizard\Step::make('Content')
                    ->schema([
                        RichEditor::make('content')->required(),
                        FileUpload::make('featured_image'),
                    ]),
                Wizard\Step::make('Settings')
                    ->schema([
                        DateTimePicker::make('published_at'),
                        Toggle::make('is_featured'),
                    ]),
            ])
            ->columnSpanFull()
        ]);
}
```

## 4. Advanced Table Features

### Custom Table Columns

```php
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Columns\BadgeColumn;
use Filament\Tables\Columns\ImageColumn;

Tables\Columns\ImageColumn::make('featured_image')
    ->circular()
    ->size(40),

Tables\Columns\TextColumn::make('title')
    ->searchable()
    ->sortable()
    ->limit(50)
    ->tooltip(function (TextColumn $column): ?string {
        $state = $column->getState();
        if (strlen($state) <= 50) {
            return null;
        }
        return $state;
    }),

Tables\Columns\BadgeColumn::make('status')
    ->colors([
        'danger' => 'draft',
        'warning' => 'reviewing',
        'success' => 'published',
    ])
    ->icons([
        'heroicon-o-document' => 'draft',
        'heroicon-o-eye' => 'reviewing',
        'heroicon-o-check-circle' => 'published',
    ]),

Tables\Columns\TextColumn::make('author.name')
    ->label('Author')
    ->searchable()
    ->sortable(),
```

### Table Filters

```php
use Filament\Tables\Filters\SelectFilter;
use Filament\Tables\Filters\Filter;
use Filament\Tables\Filters\TernaryFilter;
use Illuminate\Database\Eloquent\Builder;

// Simple Select Filter
SelectFilter::make('status')
    ->options([
        'draft' => 'Draft',
        'reviewing' => 'Reviewing',
        'published' => 'Published',
    ])
    ->multiple(),

// Custom Query Filter
Filter::make('featured')
    ->query(fn (Builder $query): Builder => $query->where('is_featured', true))
    ->toggle(),

// Ternary Filter (Yes/No/All)
TernaryFilter::make('is_featured')
    ->label('Featured')
    ->placeholder('All posts')
    ->trueLabel('Featured only')
    ->falseLabel('Not featured'),

// Date Range Filter
Filter::make('created_at')
    ->form([
        Forms\Components\DatePicker::make('created_from'),
        Forms\Components\DatePicker::make('created_until'),
    ])
    ->query(function (Builder $query, array $data): Builder {
        return $query
            ->when(
                $data['created_from'],
                fn (Builder $query, $date): Builder => $query->whereDate('created_at', '>=', $date),
            )
            ->when(
                $data['created_until'],
                fn (Builder $query, $date): Builder => $query->whereDate('created_at', '<=', $date),
            );
    })
```

### Table Actions

```php
use Filament\Tables\Actions\Action;
use Filament\Tables\Actions\ActionGroup;
use Filament\Tables\Actions\DeleteAction;
use Filament\Tables\Actions\EditAction;
use Filament\Notifications\Notification;

Tables\Actions\ActionGroup::make([
    Tables\Actions\ViewAction::make(),
    Tables\Actions\EditAction::make(),
    Action::make('publish')
        ->icon('heroicon-o-check-circle')
        ->color('success')
        ->requiresConfirmation()
        ->action(function (Post $record) {
            $record->update(['status' => 'published']);
            
            Notification::make()
                ->title('Post published')
                ->success()
                ->send();
        })
        ->visible(fn (Post $record) => $record->status !== 'published'),
    Action::make('feature')
        ->icon('heroicon-o-star')
        ->action(fn (Post $record) => $record->update(['is_featured' => !$record->is_featured]))
        ->label(fn (Post $record) => $record->is_featured ? 'Unfeature' : 'Feature'),
    Tables\Actions\DeleteAction::make(),
])
```

### Bulk Actions

```php
use Filament\Tables\Actions\BulkAction;
use Illuminate\Database\Eloquent\Collection;

Tables\Actions\BulkActionGroup::make([
    Tables\Actions\DeleteBulkAction::make(),
    
    BulkAction::make('publish')
        ->label('Publish selected')
        ->icon('heroicon-o-check-circle')
        ->color('success')
        ->requiresConfirmation()
        ->action(function (Collection $records) {
            $records->each->update(['status' => 'published']);
            
            Notification::make()
                ->title(count($records) . ' posts published')
                ->success()
                ->send();
        }),
    
    BulkAction::make('export')
        ->label('Export selected')
        ->icon('heroicon-o-arrow-down-tray')
        ->action(function (Collection $records) {
            return response()->streamDownload(function () use ($records) {
                echo $records->toCsv();
            }, 'posts.csv');
        }),
])
```

## 5. Relation Managers

### Basic Relation Manager

```php
<?php

namespace App\Filament\Resources\PostResource\RelationManagers;

use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\RelationManagers\RelationManager;
use Filament\Tables;
use Filament\Tables\Table;

class CommentsRelationManager extends RelationManager
{
    protected static string $relationship = 'comments';

    protected static ?string $recordTitleAttribute = 'content';

    public function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Textarea::make('content')
                    ->required()
                    ->maxLength(1000),
                Forms\Components\Toggle::make('is_approved')
                    ->default(false),
            ]);
    }

    public function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('author.name'),
                Tables\Columns\TextColumn::make('content')
                    ->limit(50),
                Tables\Columns\IconColumn::make('is_approved')
                    ->boolean(),
                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable(),
            ])
            ->filters([
                Tables\Filters\TernaryFilter::make('is_approved'),
            ])
            ->headerActions([
                Tables\Actions\CreateAction::make(),
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ]);
    }
}
```

## 6. Custom Pages & Widgets

### Dashboard Widget

```php
<?php

namespace App\Filament\Widgets;

use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;
use App\Models\Post;
use App\Models\User;

class StatsOverview extends BaseWidget
{
    protected function getStats(): array
    {
        return [
            Stat::make('Total Posts', Post::count())
                ->description('All time posts')
                ->descriptionIcon('heroicon-m-document-text')
                ->color('success')
                ->chart([7, 2, 10, 3, 15, 4, 17]),
            
            Stat::make('Published', Post::where('status', 'published')->count())
                ->description('Live posts')
                ->descriptionIcon('heroicon-m-check-circle')
                ->color('success'),
            
            Stat::make('Draft', Post::where('status', 'draft')->count())
                ->description('Pending posts')
                ->descriptionIcon('heroicon-m-document')
                ->color('warning'),
            
            Stat::make('Users', User::count())
                ->description('Registered users')
                ->descriptionIcon('heroicon-m-users')
                ->color('primary'),
        ];
    }
}
```

### Chart Widget

```php
<?php

namespace App\Filament\Widgets;

use Filament\Widgets\ChartWidget;
use App\Models\Post;
use Illuminate\Support\Carbon;

class PostsChart extends ChartWidget
{
    protected static ?string $heading = 'Posts Created';

    protected function getData(): array
    {
        $data = [];
        $labels = [];
        
        for ($i = 6; $i >= 0; $i--) {
            $date = Carbon::now()->subDays($i);
            $labels[] = $date->format('M d');
            $data[] = Post::whereDate('created_at', $date)->count();
        }

        return [
            'datasets' => [
                [
                    'label' => 'Posts created',
                    'data' => $data,
                    'backgroundColor' => 'rgba(59, 130, 246, 0.1)',
                    'borderColor' => 'rgb(59, 130, 246)',
                ],
            ],
            'labels' => $labels,
        ];
    }

    protected function getType(): string
    {
        return 'line';
    }
}
```

## 7. Authorization & Policies

### Resource Authorization

```php
// In your Resource class
public static function canCreate(): bool
{
    return auth()->user()->can('create_posts');
}

public static function canEdit(Model $record): bool
{
    return auth()->user()->can('edit_posts') 
        || $record->author_id === auth()->id();
}

public static function canDelete(Model $record): bool
{
    return auth()->user()->can('delete_posts');
}

public static function canViewAny(): bool
{
    return auth()->user()->can('view_posts');
}

// Using policies
protected static ?string $policy = PostPolicy::class;
```

### Action Authorization

```php
Action::make('publish')
    ->authorize('publish', $this->getRecord())
    ->action(function () {
        // Action logic
    })
```

## 8. Navigation & Grouping

### Custom Navigation

```php
protected static ?string $navigationLabel = 'Blog Posts';

protected static ?string $navigationIcon = 'heroicon-o-document-text';

protected static ?string $navigationGroup = 'Content';

protected static ?int $navigationSort = 1;

protected static ?string $slug = 'blog-posts';

public static function getNavigationBadge(): ?string
{
    return static::getModel()::where('status', 'draft')->count();
}

public static function getNavigationBadgeColor(): ?string
{
    return 'warning';
}
```

## 9. Global Search

```php
public static function getGloballySearchableAttributes(): array
{
    return ['title', 'content', 'author.name'];
}

public static function getGlobalSearchResultTitle(Model $record): string
{
    return $record->title;
}

public static function getGlobalSearchResultDetails(Model $record): array
{
    return [
        'Author' => $record->author->name,
        'Status' => $record->status,
    ];
}

public static function getGlobalSearchEloquentQuery(): Builder
{
    return parent::getGlobalSearchEloquentQuery()->with(['author']);
}
```

## 10. Custom Resource Pages

### Custom List Page with Tabs

```php
<?php

namespace App\Filament\Resources\PostResource\Pages;

use App\Filament\Resources\PostResource;
use Filament\Resources\Pages\ListRecords;
use Filament\Resources\Components\Tab;
use Illuminate\Database\Eloquent\Builder;

class ListPosts extends ListRecords
{
    protected static string $resource = PostResource::class;

    public function getTabs(): array
    {
        return [
            'all' => Tab::make('All Posts')
                ->badge(Post::count()),
            
            'published' => Tab::make('Published')
                ->modifyQueryUsing(fn (Builder $query) => $query->where('status', 'published'))
                ->badge(Post::where('status', 'published')->count())
                ->badgeColor('success'),
            
            'draft' => Tab::make('Draft')
                ->modifyQueryUsing(fn (Builder $query) => $query->where('status', 'draft'))
                ->badge(Post::where('status', 'draft')->count())
                ->badgeColor('warning'),
            
            'featured' => Tab::make('Featured')
                ->modifyQueryUsing(fn (Builder $query) => $query->where('is_featured', true))
                ->badge(Post::where('is_featured', true)->count())
                ->badgeColor('primary'),
        ];
    }
}
```
