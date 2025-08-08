# Laravel Commands & Artisan Reference

Complete reference for Laravel Artisan commands used in the project. All commands must be prefixed with `./vendor/bin/sail artisan`.

## Laravel Core Commands

### Model Generation
```bash
# Generate model with all associated files
./vendor/bin/sail artisan make:model Product --migration --factory --controller --resource

# Generate model with specific options
./vendor/bin/sail artisan make:model User --migration --factory
./vendor/bin/sail artisan make:model Post --all

# Generate model in subdirectory
./vendor/bin/sail artisan make:model Admin/Settings --migration
```

### Controller Generation
```bash
# Basic controller
./vendor/bin/sail artisan make:controller ProductController

# Resource controller with all CRUD methods
./vendor/bin/sail artisan make:controller ProductController --resource

# API resource controller
./vendor/bin/sail artisan make:controller Api/ProductController --api

# Invokable single-action controller
./vendor/bin/sail artisan make:controller ProcessPaymentController --invokable
```

### Database Operations
```bash
# Migration commands
./vendor/bin/sail artisan make:migration create_products_table
./vendor/bin/sail artisan make:migration add_column_to_users_table --table=users
./vendor/bin/sail artisan migrate
./vendor/bin/sail artisan migrate:rollback
./vendor/bin/sail artisan migrate:rollback --step=3
./vendor/bin/sail artisan migrate:fresh --seed
./vendor/bin/sail artisan migrate:status

# Seeding
./vendor/bin/sail artisan make:seeder ProductSeeder
./vendor/bin/sail artisan db:seed
./vendor/bin/sail artisan db:seed --class=ProductSeeder

# Factory generation
./vendor/bin/sail artisan make:factory ProductFactory
```

## Livewire Components

### Component Generation
```bash
# Basic Livewire component
./vendor/bin/sail artisan make:livewire ProductList

# Component in subdirectory
./vendor/bin/sail artisan make:livewire Admin/Dashboard
./vendor/bin/sail artisan make:livewire Auth/LoginForm

# Inline component (single file)
./vendor/bin/sail artisan make:livewire Counter --inline

# Component with custom view path
./vendor/bin/sail artisan make:livewire Settings/Profile
```

### Livewire-Specific Commands
```bash
# Publish Livewire config
./vendor/bin/sail artisan vendor:publish --tag=livewire:config

# Clear Livewire temporary files
./vendor/bin/sail artisan livewire:clear
```

## FilamentPHP Resources

### Resource Generation
```bash
# Basic Filament resource
./vendor/bin/sail artisan make:filament-resource Product

# Resource with auto-generated form and table
./vendor/bin/sail artisan make:filament-resource Product --generate

# Resource with soft deletes support
./vendor/bin/sail artisan make:filament-resource Product --soft-deletes

# Resource with custom table name
./vendor/bin/sail artisan make:filament-resource Product --model-name=ProductModel
```

### Filament Pages & Widgets
```bash
# Custom pages
./vendor/bin/sail artisan make:filament-page Settings
./vendor/bin/sail artisan make:filament-page Dashboard --resource=ProductResource

# Widgets
./vendor/bin/sail artisan make:filament-widget StatsOverview
./vendor/bin/sail artisan make:filament-widget ProductChart --resource=ProductResource

# Relations
./vendor/bin/sail artisan make:filament-relation-manager CategoryResource products
```

## Testing Commands

### Test Execution
```bash
# Run all tests
./vendor/bin/sail artisan test

# Run specific test file
./vendor/bin/sail artisan test tests/Feature/ProductTest.php

# Run tests with filter
./vendor/bin/sail artisan test --filter ProductTest
./vendor/bin/sail artisan test --filter test_user_can_create_product

# Run tests with coverage
./vendor/bin/sail artisan test --coverage
./vendor/bin/sail artisan test --coverage --min=80

# Parallel testing
./vendor/bin/sail artisan test --parallel
```

### Test Generation
```bash
# Feature test
./vendor/bin/sail artisan make:test ProductTest

# Unit test
./vendor/bin/sail artisan make:test ProductUnitTest --unit

# Pest test (if using Pest)
./vendor/bin/sail artisan make:test ProductTest --pest
```

## Queue & Job Management

### Job Creation & Processing
```bash
# Create job
./vendor/bin/sail artisan make:job ProcessPayment
./vendor/bin/sail artisan make:job SendWelcomeEmail --sync

# Queue workers
./vendor/bin/sail artisan queue:work
./vendor/bin/sail artisan queue:work --sleep=3 --tries=3 --max-time=3600
./vendor/bin/sail artisan queue:listen
./vendor/bin/sail artisan queue:restart

# Queue monitoring
./vendor/bin/sail artisan queue:monitor
./vendor/bin/sail artisan queue:prune-batches
./vendor/bin/sail artisan queue:prune-failed
```

## Cache Management

### Cache Operations
```bash
# Clear all caches
./vendor/bin/sail artisan cache:clear
./vendor/bin/sail artisan config:clear
./vendor/bin/sail artisan route:clear
./vendor/bin/sail artisan view:clear
./vendor/bin/sail artisan event:clear

# Optimize for production
./vendor/bin/sail artisan config:cache
./vendor/bin/sail artisan route:cache
./vendor/bin/sail artisan view:cache
./vendor/bin/sail artisan event:cache
./vendor/bin/sail artisan optimize
```

## Project-Specific Commands

### Knowledge System
```bash
# Embedding management
./vendor/bin/sail artisan knowledge:generate-embeddings
./vendor/bin/sail artisan knowledge:embedding-status
./vendor/bin/sail artisan knowledge:regenerate-missing-embeddings

# Debug knowledge system
./vendor/bin/sail artisan debug:knowledge-search "search query"
./vendor/bin/sail artisan debug:rag-pipeline --document-id=123
```

### Agent System
```bash
# Agent testing
./vendor/bin/sail artisan test:agent-execution
./vendor/bin/sail artisan test:multi-agent
./vendor/bin/sail artisan test:streaming
./vendor/bin/sail artisan test:broadcast-events

# Agent debugging
./vendor/bin/sail artisan debug:agent-execution --agent-id=research-agent
./vendor/bin/sail artisan debug:tool-execution --tool=KnowledgeRAGTool
```

### Meilisearch Integration
```bash
# Meilisearch operations
./vendor/bin/sail artisan test:meilisearch-connection
./vendor/bin/sail artisan debug:meilisearch-index
./vendor/bin/sail artisan debug:meilisearch-index --detailed
./vendor/bin/sail artisan cleanup:meilisearch-index

# Scout operations
./vendor/bin/sail artisan scout:import "App\Models\KnowledgeDocument"
./vendor/bin/sail artisan scout:flush "App\Models\KnowledgeDocument"
```

### Document Processing
```bash
# Document lifecycle testing
./vendor/bin/sail artisan test:document-lifecycle
./vendor/bin/sail artisan test:embedding-update

# File processing
./vendor/bin/sail artisan process:pending-documents
./vendor/bin/sail artisan cleanup:expired-documents
```

## Development Utilities

### Code Generation
```bash
# Custom Artisan commands
./vendor/bin/sail artisan make:command ProcessDocuments
./vendor/bin/sail artisan make:command --command=process:documents ProcessDocumentsCommand

# Events and listeners
./vendor/bin/sail artisan make:event UserRegistered
./vendor/bin/sail artisan make:listener SendWelcomeEmail --event=UserRegistered

# Observers
./vendor/bin/sail artisan make:observer ProductObserver --model=Product

# Policies
./vendor/bin/sail artisan make:policy ProductPolicy --model=Product
```

### Debugging & Monitoring
```bash
# Laravel Pail (log monitoring)
./vendor/bin/sail artisan pail
./vendor/bin/sail artisan pail --timeout=0

# Tinker (interactive shell)
./vendor/bin/sail artisan tinker

# Route debugging
./vendor/bin/sail artisan route:list
./vendor/bin/sail artisan route:list --path=api/knowledge

# Application info
./vendor/bin/sail artisan about
./vendor/bin/sail artisan env
```

## Security & Maintenance

### Security Commands
```bash
# Generate application key
./vendor/bin/sail artisan key:generate

# Password resets
./vendor/bin/sail artisan auth:clear-resets

# Storage linking
./vendor/bin/sail artisan storage:link
```

### Maintenance Mode
```bash
# Enable maintenance mode
./vendor/bin/sail artisan down
./vendor/bin/sail artisan down --secret=temporary-secret

# Disable maintenance mode
./vendor/bin/sail artisan up
```

## Custom Command Aliases

For frequently used commands, consider adding these to your shell profile:

```bash
# Add to ~/.bashrc or ~/.zshrc
alias sail="./vendor/bin/sail"
alias sa="./vendor/bin/sail artisan"
alias sam="./vendor/bin/sail artisan migrate"
alias sat="./vendor/bin/sail artisan test"
alias sac="./vendor/bin/sail artisan cache:clear"
```

## Command Chaining Examples

### Complete Feature Development Cycle
```bash
# Create complete feature set
./vendor/bin/sail artisan make:model Product --migration --factory --resource
./vendor/bin/sail artisan make:livewire ProductManager
./vendor/bin/sail artisan make:filament-resource Product --generate
./vendor/bin/sail artisan migrate
./vendor/bin/sail artisan test:feature ProductTest
```

### Database Reset & Refresh
```bash
# Complete database refresh
./vendor/bin/sail artisan migrate:fresh
./vendor/bin/sail artisan db:seed
./vendor/bin/sail artisan knowledge:generate-embeddings
./vendor/bin/sail artisan cache:clear
```

### Production Deployment Preparation
```bash
# Optimize application
./vendor/bin/sail artisan config:cache
./vendor/bin/sail artisan route:cache
./vendor/bin/sail artisan view:cache
./vendor/bin/sail artisan optimize
./vendor/bin/sail artisan test
```

## Error Troubleshooting

### Common Issues & Solutions
```bash
# Fix permission issues
sudo chown -R $USER:www-data storage bootstrap/cache
sudo chmod -R 775 storage bootstrap/cache

# Clear problematic caches
./vendor/bin/sail artisan optimize:clear
./vendor/bin/sail artisan config:clear
./vendor/bin/sail artisan view:clear

# Reset application state
./vendor/bin/sail artisan migrate:fresh --seed
./vendor/bin/sail artisan queue:restart
```

## See Also

- **[Development Environment Setup](../setup/development-environment.md)** - Environment configuration
- **[Code Conventions & Standards](code-conventions.md)** - Coding standards
- **[Feature Development Workflow](../workflows/feature-development.md)** - Development process