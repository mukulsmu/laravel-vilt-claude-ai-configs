# Nova 4 Code Examples

This file provides reference implementations for common Nova resources.

## 1. Nova Resource Boilerplate

This is the standard structure for a Nova resource.

```php
<?php

namespace App\Nova;

use Illuminate\Http\Request;
use Laravel\Nova\Fields\ID;
use Laravel\Nova\Fields\Text;
use Laravel\Nova\Fields\Textarea;
use Laravel\Nova\Fields\DateTime;
use Laravel\Nova\Http\Requests\NovaRequest;

class Post extends Resource
{
    /**
     * The model the resource corresponds to.
     *
     * @var class-string<\App\Models\Post>
     */
    public static $model = \App\Models\Post::class;

    /**
     * The single value that should be used to represent the resource when being displayed.
     *
     * @var string
     */
    public static $title = 'title';

    /**
     * The columns that should be searched.
     *
     * @var array
     */
    public static $search = [
        'id', 'title',
    ];

    /**
     * Get the fields displayed by the resource.
     *
     * @param  \Laravel\Nova\Http\Requests\NovaRequest  $request
     * @return array
     */
    public function fields(NovaRequest $request)
    {
        return [
            ID::make()->sortable(),

            Text::make('Title')
                ->sortable()
                -
                >rules('required', 'max:255'),

            Textarea::make('Content')
                -
                >rules('required'),

            DateTime::make('Published At')
                -
                >nullable()
                -
                >help('The date and time the post should be published.'),
        ];
    }

    /**
     * Get the cards available for the request.
     *
     * @param  \Laravel\Nova\Http\Requests\NovaRequest  $request
     * @return array
     */
    public function cards(NovaRequest $request)
    {
        return [];
    }

    /**
     * Get the filters available for the resource.
     *
     * @param  \Laravel\Nova\Http\Requests\NovaRequest  $request
     * @return array
     */
    public function filters(NovaRequest $request)
    {
        return [];
    }

    /**
     * Get the lenses available for the resource.
     *
     * @param  \Laravel\Nova\Http\Requests\NovaRequest  $request
     * @return array
     */
    public function lenses(NovaRequest $request)
    {
        return [];
    }

    /**
     * Get the actions available for the resource.
     *
     * @param  \Laravel\Nova\Http\Requests\NovaRequest  $request
     * @return array
     */
    public function actions(NovaRequest $request)
    {
        return [
            new \App\Nova\Actions\PublishPost,
        ];
    }
}
```

## 2. Nova Action Boilerplate

Place actions in `app/Nova/Actions`.

```php
<?php

namespace App\Nova\Actions;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Support\Collection;
use Laravel\Nova\Actions\Action;
use Laravel\Nova\Fields\ActionFields;

class PublishPost extends Action
{
    use InteractsWithQueue, Queueable;

    public function handle(ActionFields $fields, Collection $models)
    {
        foreach ($models as $model) {
            $model->update(['published_at' => now()]);
        }

        return Action::message('The posts were published!');
    }

    public function fields(NovaRequest $request)
    {
        return [];
    }
}
```

## 3. Advanced Field Types

### Relationship Fields

```php
use Laravel\Nova\Fields\BelongsTo;
use Laravel\Nova\Fields\HasMany;
use Laravel\Nova\Fields\MorphTo;

// Belongs To with Search
BelongsTo::make('Author', 'author', User::class)
    ->searchable()
    ->withSubtitles()
    ->showCreateRelationButton()
    ->required(),

// Has Many (displays on detail view)
HasMany::make('Comments'),

// MorphTo for polymorphic relationships
MorphTo::make('Commentable')
    ->types([
        Post::class,
        Video::class,
    ])
    ->searchable(),
```

### File & Image Fields

```php
use Laravel\Nova\Fields\Image;
use Laravel\Nova\Fields\File;

Image::make('Featured Image', 'featured_image')
    ->disk('public')
    ->path('posts')
    ->prunable()
    ->thumbnail(function ($value) {
        return $value ? Storage::url($value) : null;
    })
    ->preview(function ($value) {
        return $value ? Storage::url($value) : null;
    })
    ->maxWidth(200),

File::make('Document')
    ->disk('s3')
    ->path('documents')
    ->acceptedTypes('.pdf,.doc,.docx')
    ->storeAs(function (Request $request) {
        return $request->user()->id . '/' . $request->file->getClientOriginalName();
    }),
```

### Rich Text & Code Editors

```php
use Laravel\Nova\Fields\Markdown;
use Laravel\Nova\Fields\Trix;
use Laravel\Nova\Fields\Code;

Markdown::make('Content')
    ->help('Markdown supported')
    ->rules('required'),

Trix::make('Description')
    ->withFiles('public')
    ->alwaysShow(),

Code::make('Custom CSS')
    ->language('css')
    ->rules('nullable'),
```

### Custom Field Options

```php
use Laravel\Nova\Fields\Select;
use Laravel\Nova\Fields\Boolean;
use Laravel\Nova\Fields\Badge;

Select::make('Status')
    ->options([
        'draft' => 'Draft',
        'published' => 'Published',
        'archived' => 'Archived',
    ])
    ->displayUsingLabels()
    ->rules('required'),

Boolean::make('Is Featured')
    ->trueValue('yes')
    ->falseValue('no'),

Badge::make('Status')
    ->map([
        'draft' => 'warning',
        'published' => 'success',
        'archived' => 'danger',
    ])
    ->icons([
        'draft' => 'document',
        'published' => 'check-circle',
        'archived' => 'archive',
    ]),
```

## 4. Nova Filters

### Basic Select Filter

```php
<?php

namespace App\Nova\Filters;

use Illuminate\Database\Eloquent\Builder;
use Laravel\Nova\Filters\Filter;
use Laravel\Nova\Http\Requests\NovaRequest;

class PostStatus extends Filter
{
    public $component = 'select-filter';

    public function apply(NovaRequest $request, $query, $value)
    {
        return $query->where('status', $value);
    }

    public function options(NovaRequest $request)
    {
        return [
            'Published' => 'published',
            'Draft' => 'draft',
            'Archived' => 'archived',
        ];
    }

    public function default()
    {
        return 'published';
    }
}
```

### Date Filter

```php
<?php

namespace App\Nova\Filters;

use Laravel\Nova\Filters\DateFilter;
use Laravel\Nova\Http\Requests\NovaRequest;

class PublishedAfter extends DateFilter
{
    public function apply(NovaRequest $request, $query, $value)
    {
        return $query->whereDate('published_at', '>=', $value);
    }
}
```

### Boolean Filter

```php
<?php

namespace App\Nova\Filters;

use Illuminate\Database\Eloquent\Builder;
use Laravel\Nova\Filters\BooleanFilter;
use Laravel\Nova\Http\Requests\NovaRequest;

class PostFilters extends BooleanFilter
{
    public function apply(NovaRequest $request, $query, $value)
    {
        if ($value['featured']) {
            $query->where('is_featured', true);
        }

        if ($value['has_comments']) {
            $query->has('comments');
        }

        return $query;
    }

    public function options(NovaRequest $request)
    {
        return [
            'Featured Posts' => 'featured',
            'Has Comments' => 'has_comments',
        ];
    }
}
```

## 5. Nova Lenses & Metrics

```php
<?php

namespace App\Nova\Lenses;

use Laravel\Nova\Fields\ID;
use Laravel\Nova\Fields\Text;
use Laravel\Nova\Fields\Number;
use Laravel\Nova\Http\Requests\LensRequest;
use Laravel\Nova\Http\Requests\NovaRequest;
use Laravel\Nova\Lenses\Lens;

class MostValuablePosts extends Lens
{
    public function query(LensRequest $request, $query)
    {
        return $request->withOrdering($request->withFilters(
            $query
                ->select(['posts.*'])
                ->withCount('comments')
                ->orderBy('comments_count', 'desc')
        ));
    }

    public function fields(NovaRequest $request)
    {
        return [
            ID::make()->sortable(),
            Text::make('Title')->sortable(),
            Number::make('Comments', 'comments_count')->sortable(),
        ];
    }

    public function uriKey()
    {
        return 'most-valuable-posts';
    }
}
```
