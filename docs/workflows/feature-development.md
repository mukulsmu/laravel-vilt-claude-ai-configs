# Feature Development Workflow

Complete workflow guide for developing features in Laravel TALL stack applications.

## Overview

This workflow covers the end-to-end process of developing features using AI-assisted development patterns, from initial planning through deployment.

## AI Specialist Delegation Framework

This workflow leverages specialized AI agents for domain-specific expertise:

- **DevOps Specialist**: Infrastructure, deployment, Docker, monitoring, and service integration
- **Security Specialist**: Security audits, vulnerability assessment, data protection, and compliance  
- **Performance Specialist**: Database optimization, performance analysis, frontend efficiency, and scalability
- **Testing Specialist**: Test coverage, quality assurance, test automation, and validation frameworks

**Delegation Pattern**: When complex domain-specific work is needed, delegate to the appropriate specialist: `"[SpecialistName]: [specific task with context and requirements]"`

## Pre-Development Setup

### 1. Environment Verification
```bash
# Ensure development environment is ready
./vendor/bin/sail up -d
./vendor/bin/sail artisan migrate:status
./vendor/bin/sail npm run dev

# Test application systems
./vendor/bin/sail artisan test                     # Run test suite
./vendor/bin/sail artisan queue:work --stop-when-empty  # Test queue system
```

### 2. Context Gathering
```bash
# Gather project context using MCP tools
mcp__serena__list_memories
mcp__serena__read_memory [relevant_pattern]
mcp__serena__get_symbols_overview [relevant_directory]

# Check existing similar implementations
mcp__serena__search_for_pattern [similar_functionality]
```

## Planning Phase

### 1. Feature Requirements Analysis
**AI Interaction Pattern:**
```
"I need to implement [feature description] for [business context]. 

Context:
- User story: [detailed user story]
- Business requirements: [specific requirements]
- Integration points: [existing systems it needs to work with]
- Performance requirements: [any specific performance needs]

Based on our existing architecture in [relevant directories], what's the best approach?"
```

### 2. Architecture Planning
**Use specialized agents for complex features:**

#### For Complex Database Features
```bash
# Consult performance specialist for optimal database design
"Performance Specialist: Design optimal database schema for [feature] considering query performance, indexing strategies, and scalability requirements."
```

#### For Security-Critical Features
```bash
# Consult security specialist for secure implementation
"Security Specialist: Review [feature] for security implications including input validation, authorization, and data protection requirements."
```

#### For Performance-Critical Features
```bash
# Consult performance specialist for optimization strategy
"Performance Specialist: Analyze [feature] performance requirements and design optimization strategy for database queries, caching, and resource usage."
```

#### For DevOps-Heavy Features
```bash
# Consult DevOps specialist for infrastructure requirements
"DevOps Specialist: Plan infrastructure and deployment strategy for [feature] considering Docker, scaling, and monitoring requirements."
```

### 3. Task Planning with TodoWrite
```bash
# Create comprehensive task breakdown
TodoWrite: [
  "Design database schema and migrations",
  "Create model relationships and validations", 
  "Implement backend services and logic",
  "Create Livewire components and templates",
  "Add real-time update functionality",
  "Implement agent integration (if needed)",
  "Add knowledge system integration (if needed)",
  "Create comprehensive tests",
  "Update documentation"
]
```

## Implementation Phase

### 1. Database Layer
```bash
# Generate models with relationships
./vendor/bin/sail artisan make:model FeatureName --migration --factory --controller

# Design migration with proper indexing
# Follow UUID patterns for user-facing entities
# Include soft deletes for user data
# Add composite indexes for common queries
```

**Migration Pattern:**
```php
Schema::create('feature_entities', function (Blueprint $table) {
    $table->uuid('id')->primary();
    $table->string('name');
    $table->text('description')->nullable();
    $table->json('metadata')->nullable();
    
    // Foreign keys with constraints
    $table->foreignUuid('user_id')->constrained()->cascadeOnDelete();
    
    // Performance indexes
    $table->index(['user_id', 'created_at']);
    $table->index('name');
    
    $table->timestamps();
    $table->softDeletes();
});
```

### 2. Business Logic Layer
```bash
# Create service classes for complex business logic
./vendor/bin/sail artisan make:class Services/FeatureName/FeatureService

# Implement following dependency injection patterns
# Use DTOs for complex data transfer
# Implement proper error handling
# Add comprehensive logging
```

**Service Pattern:**
```php
<?php

namespace App\Services\FeatureName;

use App\Models\FeatureEntity;
use App\Services\FeatureName\DTOs\FeatureData;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class FeatureService
{
    public function createFeature(FeatureData $data): FeatureEntity
    {
        return DB::transaction(function () use ($data) {
            $feature = FeatureEntity::create($data->toArray());
            
            // Additional business logic
            $this->processFeatureCreation($feature);
            
            Log::info('Feature created', ['feature_id' => $feature->id]);
            
            return $feature;
        });
    }
    
    private function processFeatureCreation(FeatureEntity $feature): void
    {
        // Implementation details
    }
}
```

### 3. Frontend Components
```bash
# Generate Livewire components
./vendor/bin/sail artisan make:livewire FeatureName/FeatureManager
./vendor/bin/sail artisan make:livewire FeatureName/FeatureList
./vendor/bin/sail artisan make:livewire FeatureName/FeatureForm

# Follow component organization patterns
# Implement proper validation
# Add real-time updates via events
# Include loading states and error handling
```

**Component Pattern:**
```php
<?php

namespace App\Livewire\FeatureName;

use App\Models\FeatureEntity;
use App\Services\FeatureName\FeatureService;
use Livewire\Component;
use Livewire\WithPagination;

class FeatureManager extends Component
{
    use WithPagination;
    
    public string $search = '';
    public bool $showCreateModal = false;
    
    protected array $rules = [
        'feature.name' => 'required|string|max:255',
        'feature.description' => 'nullable|string|max:1000',
    ];
    
    public function mount(): void
    {
        $this->search = request('search', '');
    }
    
    public function createFeature(): void
    {
        $this->validate();
        
        app(FeatureService::class)->createFeature($this->feature);
        
        $this->dispatch('feature-created');
        $this->showCreateModal = false;
        $this->reset('feature');
    }
    
    #[On('feature-updated')]
    public function refreshData(): void
    {
        $this->resetPage();
    }
    
    public function render()
    {
        return view('livewire.feature-name.feature-manager', [
            'features' => $this->getFeatures(),
        ]);
    }
    
    private function getFeatures()
    {
        return FeatureEntity::query()
            ->when($this->search, fn($query) => 
                $query->where('name', 'like', '%' . $this->search . '%'))
            ->latest()
            ->paginate(15);
    }
}
```

### 4. API Integration (if needed)
```bash
# Generate API controllers
./vendor/bin/sail artisan make:controller Api/FeatureController --api

# Follow RESTful patterns
# Implement proper authentication
# Add rate limiting
# Include comprehensive API documentation
```

### 5. Agent Integration (if needed)
```bash
# Create custom Prism tools for agent use
# Implement tool following type-safe patterns
# Add comprehensive error handling
# Include tool testing
```

**Tool Pattern:**
```php
<?php

namespace App\Tools\FeatureName;

use EchoLabs\Prism\Tool;
use EchoLabs\Prism\ValueObjects\ToolCall;
use EchoLabs\Prism\ValueObjects\ToolResult;

class FeatureTool extends Tool
{
    public function name(): string
    {
        return 'feature_tool';
    }
    
    public function description(): string
    {
        return 'Tool description for agents';
    }
    
    public function parameters(): array
    {
        return [
            'query' => [
                'type' => 'string',
                'description' => 'Query parameter',
                'required' => true,
            ],
        ];
    }
    
    public function handle(ToolCall $toolCall): ToolResult
    {
        try {
            $query = $toolCall->arguments()['query'];
            $result = $this->processQuery($query);
            
            return ToolResult::text($result);
        } catch (\Exception $e) {
            return ToolResult::error("Tool execution failed: " . $e->getMessage());
        }
    }
    
    private function processQuery(string $query): string
    {
        // Implementation logic
        return "Processed: {$query}";
    }
}
```

### 6. Real-time Updates
```bash
# Create events for real-time updates
./vendor/bin/sail artisan make:event FeatureUpdated
./vendor/bin/sail artisan make:event FeatureCreated

# Configure broadcasting channels
# Implement Livewire event listeners
# Test WebSocket connectivity
```

**Event Pattern:**
```php
<?php

namespace App\Events\FeatureName;

use App\Models\FeatureEntity;
use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class FeatureCreated implements ShouldBroadcast
{
    use Dispatchable, InteractsWithSockets, SerializesModels;
    
    public function __construct(
        public FeatureEntity $feature,
        public string $userId
    ) {}
    
    public function broadcastOn(): array
    {
        return [
            new PrivateChannel('user.' . $this->userId),
            new Channel('features'),
        ];
    }
    
    public function broadcastWith(): array
    {
        return [
            'feature' => $this->feature->toArray(),
            'message' => 'New feature created',
        ];
    }
}
```

## Testing Phase

### 1. Unit Testing
```bash
# Generate tests for models and services
./vendor/bin/sail artisan make:test FeatureServiceTest --unit
./vendor/bin/sail artisan make:test FeatureEntityTest --unit

# Test business logic
# Test model relationships
# Test validation rules
```

### 2. Feature Testing
```bash
# Generate feature tests
./vendor/bin/sail artisan make:test FeatureManagementTest

# Test complete user workflows
# Test API endpoints
# Test authentication and authorization
```

### 3. Component Testing
```bash
# Test Livewire components
# Test component interactions
# Test real-time updates
# Test error handling
```

**Component Test Pattern:**
```php
<?php

use App\Livewire\FeatureName\FeatureManager;
use App\Models\FeatureEntity;
use App\Models\User;
use Livewire\Livewire;

test('feature manager can create features', function () {
    $user = User::factory()->create();
    
    Livewire::actingAs($user)
        ->test(FeatureManager::class)
        ->set('feature.name', 'Test Feature')
        ->set('feature.description', 'Test Description')
        ->call('createFeature')
        ->assertSet('showCreateModal', false)
        ->assertDispatched('feature-created');
    
    expect(FeatureEntity::where('name', 'Test Feature'))->toExist();
});

test('feature manager handles validation errors', function () {
    $user = User::factory()->create();
    
    Livewire::actingAs($user)
        ->test(FeatureManager::class)
        ->set('feature.name', '') // Invalid empty name
        ->call('createFeature')
        ->assertHasErrors(['feature.name']);
});
```

### 4. Browser Testing (if complex UI)
```bash
# Use Playwright MCP server for browser testing
mcp__browsermcp__browser_navigate \"http://localhost/feature-page\"
mcp__browsermcp__browser_snapshot
mcp__browsermcp__browser_click \"Create Feature Button\"
mcp__browsermcp__browser_type \"Feature Name\" \"Test Feature\"
```

## Quality Assurance Phase

### 1. Code Review
```bash
# Use Zen MCP server for comprehensive code review
mcp__zen__codereview # Systematic code review workflow

# Focus areas:
# - Code quality and conventions
# - Security considerations
# - Performance implications
# - Test coverage
# - Documentation completeness
```

### 2. Security Audit
```bash
# Security assessment for sensitive features
mcp__zen__secaudit # Security audit workflow

# Check:
# - Input validation
# - Authorization controls
# - Data sanitization
# - Injection vulnerabilities
```

### 3. Performance Analysis
```bash
# Performance assessment for data-heavy features
mcp__zen__analyze # Performance analysis workflow

# Focus on:
# - Database query performance
# - Component rendering speed
# - Memory usage patterns
# - API response times
```

## Documentation Phase

### 1. Update Project Documentation
```bash
# Document architectural decisions
mcp__serena__write_memory "feature_architecture_decisions" [documentation]

# Update relevant documentation files
# Add to CHANGELOG.md if user-facing changes
# Update API documentation if applicable
```

### 2. Code Documentation
```bash
# Add comprehensive code documentation
mcp__zen__docgen # Documentation generation workflow

# Include:
# - Method documentation
# - Complex logic explanations
# - API endpoint documentation
# - Component usage examples
```

## Pre-Commit Validation

### 1. Run Complete Test Suite
```bash
# Run all tests
./vendor/bin/sail artisan test

# Run specific feature tests
./vendor/bin/sail artisan test --filter=FeatureTest

# Ensure high test coverage
./vendor/bin/sail artisan test --coverage
```

### 2. Code Quality Checks
```bash
# Laravel Pint formatting
./vendor/bin/sail pint

# Static analysis (if configured)
./vendor/bin/sail artisan insights

# Pre-commit validation
mcp__zen__precommit # Comprehensive pre-commit workflow
```

### 3. Performance Validation
```bash
# Test feature performance under load
# Validate database query performance
# Check memory usage patterns
# Verify real-time update performance
```

## Deployment Preparation

### 1. Production Readiness
```bash
# Optimize for production
./vendor/bin/sail artisan config:cache
./vendor/bin/sail artisan route:cache
./vendor/bin/sail artisan view:cache

# Run production-like tests
./vendor/bin/sail artisan test --env=testing
```

### 2. Migration Safety
```bash
# Test migration rollback
./vendor/bin/sail artisan migrate:rollback --pretend

# Verify migration safety
./vendor/bin/sail artisan migrate:status

# Plan zero-downtime deployment if needed
```

### 3. Feature Flags (if applicable)
```bash
# Implement feature flags for gradual rollout
# Configure feature toggle systems
# Plan progressive deployment strategy
```

## Post-Deployment Monitoring

### 1. Performance Monitoring
- Monitor query performance
- Track error rates
- Validate user experience metrics
- Check real-time update functionality

### 2. User Feedback Integration
- Collect user feedback
- Monitor usage patterns
- Identify improvement opportunities
- Plan iterative enhancements

## Common Patterns & Solutions

### Complex Multi-System Features
For features requiring multiple specialists:
1. **Planning**: Multi-agent consensus workflow
2. **Implementation**: Coordinated specialist execution
3. **Integration**: Cross-system testing and validation
4. **Quality**: Comprehensive multi-domain review

### Performance-Critical Features
For features with strict performance requirements:
1. **Design**: Performance-first architecture decisions
2. **Implementation**: Continuous performance monitoring
3. **Testing**: Load testing and benchmarking
4. **Optimization**: Iterative performance improvements

### Real-time Features
For features requiring WebSocket integration:
1. **Architecture**: Event-driven design patterns
2. **Implementation**: Broadcasting and echo integration
3. **Testing**: Real-time functionality validation
4. **Monitoring**: Connection stability and performance

## Troubleshooting Common Issues

### Database Performance Problems
```bash
# Analyze slow queries
./vendor/bin/sail artisan db:monitor --long-queries

# Review indexes and relationships
mcp__zen__debug # Systematic database debugging
```

### Component State Issues
```bash
# Debug Livewire component behavior
mcp__zen__debug # Component state debugging

# Test component interactions
mcp__browsermcp__browser_navigate [component_page]
```

### Real-time Update Failures
```bash
# Test broadcasting functionality
./vendor/bin/sail artisan test:broadcast-events

# Debug WebSocket connections
mcp__zen__debug # WebSocket debugging workflow
```

## Success Criteria

A feature is considered successfully implemented when:

- ✅ All tests pass (unit, feature, component, browser)
- ✅ Code review passes quality gates
- ✅ Security audit reveals no critical issues
- ✅ Performance meets requirements
- ✅ Documentation is complete and accurate
- ✅ Pre-commit validation passes
- ✅ Production deployment succeeds
- ✅ Post-deployment monitoring shows healthy metrics

## See Also

- **[Quality Assurance Workflows](quality-assurance.md)** - Detailed QA processes
- **[Debugging & Investigation](debugging-investigation.md)** - Problem-solving workflows  
- **[Performance Optimization](performance-optimization.md)** - Performance improvement workflows
- **[Code Conventions & Standards](../reference/code-conventions.md)** - Coding standards reference