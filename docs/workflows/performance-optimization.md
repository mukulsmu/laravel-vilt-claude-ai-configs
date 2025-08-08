# Performance Optimization Workflows

Comprehensive performance analysis and optimization strategies for the Marlin Laravel TALL stack application using AI-assisted workflows.

## Overview

This document provides systematic approaches to identifying, analyzing, and resolving performance bottlenecks across all layers of the application stack, from database queries to frontend rendering.

## AI Specialist Delegation Framework

This performance optimization workflow coordinates with specialized AI agents for comprehensive performance analysis:

- **Performance Specialist**: Database optimization, query tuning, frontend performance, caching strategies, and scalability analysis
- **DevOps Specialist**: Infrastructure performance, container optimization, deployment efficiency, and system monitoring
- **Security Specialist**: Security performance impacts, authentication efficiency, and secure optimization strategies  
- **Testing Specialist**: Performance testing, load validation, benchmark analysis, and regression testing

**Performance Optimization Delegation**: Complex performance analysis and optimization tasks are delegated to domain specialists who provide expert recommendations and implementation strategies.

## Performance Analysis Workflow

### 1. System-Wide Performance Assessment
```bash
# Comprehensive performance analysis
mcp__zen__analyze --analysis_type=performance

# Performance analysis covers:
# - Application response times
# - Database query performance
# - Frontend rendering efficiency
# - Memory usage patterns
# - Resource utilization
# - Scalability bottlenecks
```

**Performance Investigation Pattern:**
```
"Analyze system performance for [specific area/issue]:

Current performance metrics:
- [Metric 1]: [Current value] (target: [target value])
- [Metric 2]: [Current value] (target: [target value])
- User-reported issues: [Performance complaints]

Environment context:
- [Production/staging load patterns]
- [Recent changes that may impact performance]
- [Hardware/infrastructure constraints]

Focus analysis on: [specific performance areas] with priority on [user impact areas]"
```

### 2. Performance Baseline Establishment
```bash
# Establish performance baselines
./vendor/bin/sail artisan test --filter=PerformanceTest

# Key metrics to baseline:
# - Page load times
# - API response times
# - Database query times
# - Memory usage patterns
# - Concurrent user capacity
```

## Domain-Specific Performance Optimization

### Database Performance Optimization

#### Query Performance Analysis
```bash
# Database performance investigation
"Performance Specialist + mcp__zen__analyze: Optimize database performance:

Performance issues:
- [Slow queries]: [Specific queries and execution times]
- [High resource usage]: [CPU, memory, I/O patterns]
- [Lock contention]: [Blocking and deadlock issues]

Optimization focus:
- Query execution plan analysis
- Index strategy optimization
- Relationship loading efficiency
- Connection pool tuning
- Caching implementation"
```

**Database Performance Commands:**
```bash
# Monitor database performance
./vendor/bin/sail artisan db:monitor --long-queries --threshold=1000

# Analyze specific queries
./vendor/bin/sail artisan tinker
# >>> DB::listen(function ($query) {
# >>>     if ($query->time > 100) {
# >>>         Log::info('Slow Query', ['sql' => $query->sql, 'time' => $query->time]);
# >>>     }
# >>> });

# Check index usage
./vendor/bin/sail exec mysql mysql -e "SHOW PROCESSLIST;"
./vendor/bin/sail exec mysql mysql -e "SHOW ENGINE INNODB STATUS\G"
```

#### Index Optimization Strategy
```php
// Performance-optimized migration patterns
Schema::create('optimized_table', function (Blueprint $table) {
    $table->uuid('id')->primary();
    $table->string('name');
    $table->timestamp('created_at');
    
    // Single column indexes for direct lookups
    $table->index('name');
    $table->index('created_at');
    
    // Composite indexes for common query patterns
    $table->index(['user_id', 'created_at']); // For user-specific date ranges
    $table->index(['status', 'priority', 'created_at']); // For filtered lists
    
    // Partial indexes for specific conditions (PostgreSQL)
    // $table->index('email')->where('email', 'IS NOT NULL');
    
    // Full-text indexes for search functionality
    $table->fullText(['title', 'description']);
});
```

#### Query Optimization Patterns
```php
<?php

// ✅ Optimized query patterns
class OptimizedRepository
{
    // Use specific select to avoid SELECT *
    public function getActiveUsers(): Collection
    {
        return User::select(['id', 'name', 'email', 'created_at'])
            ->where('status', 'active')
            ->where('last_login', '>=', now()->subDays(30))
            ->orderBy('last_login', 'desc')
            ->limit(100)
            ->get();
    }
    
    // Eager load relationships to prevent N+1
    public function getUsersWithPosts(): Collection
    {
        return User::with(['posts' => function ($query) {
                $query->select(['id', 'user_id', 'title', 'created_at'])
                      ->latest()
                      ->limit(5);
            }])
            ->whereHas('posts', function ($query) {
                $query->where('status', 'published');
            })
            ->get();
    }
    
    // Use chunking for large datasets
    public function processLargeDataset(): void
    {
        User::where('status', 'active')
            ->chunk(1000, function ($users) {
                foreach ($users as $user) {
                    $this->processUser($user);
                }
            });
    }
    
    // Implement query result caching
    public function getCachedPopularPosts(): Collection
    {
        return Cache::remember('popular_posts', now()->addHour(), function () {
            return Post::select(['id', 'title', 'views', 'created_at'])
                ->where('status', 'published')
                ->where('views', '>', 1000)
                ->orderBy('views', 'desc')
                ->limit(50)
                ->get();
        });
    }
}
```

### Frontend Performance Optimization

#### Component Performance Analysis
```bash
# Frontend performance investigation
"Performance Specialist + mcp__zen__analyze: Optimize frontend performance:

Performance issues:
- [Slow page loads]: [Specific pages and load times]
- [Heavy JavaScript bundles]: [Bundle sizes and loading times]
- [Slow component rendering]: [Specific components and render times]
- [Memory leaks]: [Growing memory usage patterns]

Optimization focus:
- Component rendering efficiency
- Asset bundle optimization
- Lazy loading implementation
- Memory leak prevention
- Cache utilization"
```

#### Livewire Component Optimization
```php
<?php

namespace App\Livewire;

use Livewire\Component;
use Livewire\WithPagination;
use Livewire\Attributes\Computed;

class OptimizedComponent extends Component
{
    use WithPagination;
    
    // ✅ Use primitive types for better performance
    public string $search = '';
    public int $perPage = 15;
    
    // ✅ Optimize property updates
    public function updatedSearch(): void
    {
        $this->resetPage();
        // Debounce search to prevent excessive queries
        $this->dispatch('search-updated');
    }
    
    // ✅ Use computed properties for expensive operations
    #[Computed]
    public function filteredResults()
    {
        return Cache::remember(
            "search_results_{$this->search}_{$this->getPage()}",
            300, // 5 minutes
            fn() => $this->executeSearchQuery()
        );
    }
    
    // ✅ Lazy load non-critical data
    #[Computed]
    public function statistics()
    {
        return Cache::remember('dashboard_stats', 600, function () {
            return [
                'total_users' => User::count(),
                'active_sessions' => $this->getActiveSessions(),
                'recent_activity' => $this->getRecentActivity(),
            ];
        });
    }
    
    // ✅ Optimize rendering with minimal data
    public function render()
    {
        return view('livewire.optimized-component', [
            'results' => $this->filteredResults,
            // Only load statistics when needed
            'stats' => $this->lazy ? null : $this->statistics,
        ]);
    }
    
    private function executeSearchQuery()
    {
        return Model::select(['id', 'name', 'created_at'])
            ->when($this->search, function ($query) {
                $query->where('name', 'like', '%' . $this->search . '%');
            })
            ->latest()
            ->paginate($this->perPage);
    }
}
```

#### Asset Optimization Strategy
```bash
# Frontend asset optimization
./vendor/bin/sail npm run build

# Optimize Tailwind CSS
# In tailwind.config.js:
# content: [
#     './resources/**/*.blade.php',
#     './resources/**/*.js',
#     './app/Livewire/**/*.php',
# ],
# 
# Add purge configuration for production

# JavaScript optimization
# Use dynamic imports for large components
# Implement code splitting
# Optimize image loading with lazy loading
```

### Agent System Performance Optimization

#### Agent Execution Efficiency
```bash
# Agent performance investigation
"DevOps Specialist + mcp__zen__analyze: Optimize agent execution performance:

Performance issues:
- [Slow agent responses]: [Execution times and bottlenecks]
- [High resource usage]: [Memory and CPU consumption]
- [Streaming delays]: [Real-time response latency]
- [Tool execution overhead]: [Individual tool performance]

Optimization focus:
- Context optimization for faster processing
- Tool execution efficiency
- Streaming response optimization
- Memory management improvements
- Concurrent execution patterns"
```

#### Agent Context Optimization
```php
<?php

namespace App\Services\Agents;

class OptimizedAgentExecutor
{
    // ✅ Optimize context building
    private function buildOptimizedContext(array $messages): array
    {
        // Limit context window for performance
        $recentMessages = collect($messages)
            ->take(-10) // Only last 10 messages
            ->map(function ($message) {
                // Trim excessive content
                return [
                    'role' => $message['role'],
                    'content' => Str::limit($message['content'], 2000),
                    'timestamp' => $message['created_at'],
                ];
            })
            ->toArray();
            
        return $recentMessages;
    }
    
    // ✅ Optimize tool selection
    private function selectOptimalTools(string $agentType): array
    {
        // Cache tool configurations
        return Cache::remember("agent_tools_{$agentType}", 3600, function () use ($agentType) {
            return $this->getToolsForAgentType($agentType);
        });
    }
    
    // ✅ Implement streaming optimizations
    private function optimizeStreamingResponse($stream): void
    {
        // Batch small chunks for better performance
        $buffer = '';
        $bufferSize = 100;
        
        foreach ($stream as $chunk) {
            $buffer .= $chunk;
            
            if (strlen($buffer) >= $bufferSize) {
                $this->sendStreamChunk($buffer);
                $buffer = '';
            }
        }
        
        // Send remaining buffer
        if ($buffer) {
            $this->sendStreamChunk($buffer);
        }
    }
}
```

### Knowledge System Performance Optimization

#### Search and RAG Performance
```bash
# Knowledge system performance investigation
"Security Specialist + mcp__zen__analyze: Optimize knowledge system performance:

Performance issues:
- [Slow search responses]: [Search latency and result quality]
- [RAG pipeline delays]: [Document retrieval and processing times]
- [Embedding generation bottlenecks]: [Vector generation performance]
- [Index update delays]: [Real-time indexing performance]

Optimization focus:
- Meilisearch configuration tuning
- Embedding generation optimization
- Document processing pipeline efficiency
- Cache layer implementation
- Batch processing strategies"
```

#### Meilisearch Optimization Configuration
```php
<?php

// Optimized Meilisearch configuration
// config/scout.php
return [
    'meilisearch' => [
        'host' => env('MEILISEARCH_HOST', 'http://localhost:7700'),
        'key' => env('MEILISEARCH_KEY'),
        'index-settings' => [
            'knowledge_documents' => [
                // Optimize searchable attributes
                'searchableAttributes' => [
                    'title',
                    'content',
                    'metadata.tags',
                ],
                
                // Configure ranking rules for relevance
                'rankingRules' => [
                    'words',
                    'typo',
                    'exactness',
                    'attribute',
                    'desc(created_at)', // Recent documents first
                    'proximity',
                ],
                
                // Optimize filterable attributes
                'filterableAttributes' => [
                    'user_id',
                    'mime_type',
                    'metadata.source',
                    'created_at',
                ],
                
                // Configure faceting for performance
                'faceting' => [
                    'maxValuesPerFacet' => 100,
                    'sortFacetValuesBy' => [
                        'mime_type' => 'count',
                    ],
                ],
                
                // Optimize pagination
                'pagination' => [
                    'maxTotalHits' => 1000,
                ],
            ],
        ],
    ],
];
```

#### RAG Pipeline Optimization
```php
<?php

namespace App\Services\Knowledge\RAG;

class OptimizedRAGService
{
    // ✅ Implement multi-stage retrieval
    public function retrieveOptimized(string $query, int $maxResults = 10): array
    {
        // Stage 1: Fast keyword search
        $keywordResults = $this->performKeywordSearch($query, $maxResults * 2);
        
        // Stage 2: Semantic similarity on filtered results
        $semanticResults = $this->performSemanticSearch($query, $keywordResults, $maxResults);
        
        // Stage 3: Re-rank based on combined scores
        return $this->reRankResults($semanticResults, $query);
    }
    
    // ✅ Batch embedding generation
    public function generateEmbeddingsBatch(array $texts): array
    {
        // Process in optimal batch sizes
        $batchSize = 50;
        $batches = array_chunk($texts, $batchSize);
        $allEmbeddings = [];
        
        foreach ($batches as $batch) {
            $embeddings = $this->embeddingService->generateBatch($batch);
            $allEmbeddings = array_merge($allEmbeddings, $embeddings);
            
            // Small delay to prevent rate limiting
            usleep(100000); // 100ms
        }
        
        return $allEmbeddings;
    }
    
    // ✅ Implement result caching
    public function getCachedResults(string $query, array $filters = []): array
    {
        $cacheKey = 'rag_results_' . md5($query . serialize($filters));
        
        return Cache::remember($cacheKey, 300, function () use ($query, $filters) {
            return $this->retrieveOptimized($query, 10);
        });
    }
}
```

## Performance Monitoring and Alerting

### 1. Performance Metrics Collection
```bash
# Set up performance monitoring
./vendor/bin/sail artisan make:command MonitorPerformance

# Key metrics to monitor:
# - Response time percentiles (50th, 95th, 99th)
# - Database query performance
# - Memory usage trends
# - Error rates and types
# - User experience metrics
```

**Performance Monitoring Implementation:**
```php
<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;

class MonitorPerformance extends Command
{
    protected $signature = 'monitor:performance';
    
    public function handle(): void
    {
        // Database performance metrics
        $this->monitorDatabasePerformance();
        
        // Application response times
        $this->monitorResponseTimes();
        
        // Memory and resource usage
        $this->monitorResourceUsage();
        
        // Queue performance
        $this->monitorQueuePerformance();
    }
    
    private function monitorDatabasePerformance(): void
    {
        $slowQueries = DB::table('mysql.slow_log')
            ->where('start_time', '>=', now()->subMinutes(5))
            ->get();
            
        if ($slowQueries->count() > 10) {
            // Alert on excessive slow queries
            $this->alert('High number of slow queries detected');
        }
    }
}
```

### 2. Performance Alerting System
```php
<?php

// Performance threshold configuration
return [
    'performance_thresholds' => [
        'response_time_95th' => 200, // milliseconds
        'database_query_time' => 50, // milliseconds
        'memory_usage_percent' => 80, // percent
        'error_rate_percent' => 1, // percent
        'queue_wait_time' => 30, // seconds
    ],
    
    'alert_channels' => [
        'critical' => ['slack', 'email'],
        'warning' => ['slack'],
        'info' => ['log'],
    ],
];
```

## Performance Testing Strategies

### 1. Load Testing
```bash
# Load testing with Laravel Dusk or external tools
./vendor/bin/sail artisan test --filter=LoadTest

# Use artillery.io for API load testing
# npm install -g artillery
# artillery quick --count 100 --num 10 http://localhost/api/endpoint
```

### 2. Database Performance Testing
```php
<?php

// Database performance test examples
test('database query performance under load', function () {
    // Create test data
    User::factory()->count(10000)->create();
    
    // Measure query performance
    $startTime = microtime(true);
    
    $users = User::with('posts')
        ->where('created_at', '>=', now()->subDays(30))
        ->orderBy('created_at', 'desc')
        ->limit(100)
        ->get();
    
    $executionTime = microtime(true) - $startTime;
    
    expect($executionTime)->toBeLessThan(0.1); // Should complete in under 100ms
    expect($users->count())->toBeGreaterThan(0);
});

test('concurrent database access performance', function () {
    $processes = 10;
    $queries = 50;
    
    $startTime = microtime(true);
    
    // Simulate concurrent database access
    $pids = [];
    for ($i = 0; $i < $processes; $i++) {
        $pid = pcntl_fork();
        if ($pid === 0) {
            // Child process
            for ($j = 0; $j < $queries; $j++) {
                User::inRandomOrder()->first();
            }
            exit(0);
        } else {
            $pids[] = $pid;
        }
    }
    
    // Wait for all processes to complete
    foreach ($pids as $pid) {
        pcntl_waitpid($pid, $status);
    }
    
    $totalTime = microtime(true) - $startTime;
    $queriesPerSecond = ($processes * $queries) / $totalTime;
    
    expect($queriesPerSecond)->toBeGreaterThan(100); // Should handle 100+ queries/sec
});
```

### 3. Frontend Performance Testing
```bash
# Frontend performance testing with BrowserMCP
mcp__browsermcp__browser_navigate "http://localhost/dashboard"

# Measure performance metrics
mcp__browsermcp__browser_evaluate "() => {
    return {
        loadTime: performance.timing.loadEventEnd - performance.timing.navigationStart,
        domReady: performance.timing.domContentLoadedEventEnd - performance.timing.navigationStart,
        firstPaint: performance.getEntriesByName('first-paint')[0]?.startTime || 0
    };
}"
```

## Performance Optimization Checklist

### Database Optimization
- [ ] Slow query analysis completed
- [ ] Appropriate indexes created
- [ ] N+1 query issues resolved
- [ ] Query result caching implemented
- [ ] Connection pool optimized
- [ ] Database configuration tuned

### Frontend Optimization
- [ ] Bundle size analysis completed
- [ ] Code splitting implemented
- [ ] Image optimization configured
- [ ] Lazy loading implemented
- [ ] Component rendering optimized
- [ ] Memory leaks addressed

### Agent System Optimization
- [ ] Context size optimized
- [ ] Tool selection efficiency improved
- [ ] Streaming response optimized
- [ ] Concurrent execution patterns implemented
- [ ] Resource usage monitored

### Knowledge System Optimization
- [ ] Search performance tuned
- [ ] RAG pipeline optimized
- [ ] Embedding generation efficiency improved
- [ ] Index configuration optimized
- [ ] Batch processing implemented

## Performance Optimization Documentation

### Performance Improvement Record
```markdown
# Performance Optimization Record

## Optimization Summary
- **Area**: [Database/Frontend/Agent/Knowledge System]
- **Issue**: [Specific performance problem]
- **Impact**: [User experience impact]
- **Date**: [Implementation date]

## Baseline Metrics
- **Before**: [Performance metrics before optimization]
- **Target**: [Performance improvement goals]
- **After**: [Performance metrics after optimization]

## Implementation Details
- **Changes Made**: [Specific optimizations implemented]
- **Tools Used**: [MCP tools and analysis methods]
- **Testing Approach**: [Performance validation methods]

## Results
- **Performance Improvement**: [Quantified improvements]
- **User Experience Impact**: [Measured UX improvements]
- **Resource Usage Impact**: [Resource consumption changes]

## Monitoring
- **Metrics Tracked**: [Ongoing performance monitoring]
- **Alert Thresholds**: [Performance degradation alerts]
- **Review Schedule**: [Regular performance review cadence]
```

## Continuous Performance Improvement

### 1. Regular Performance Reviews
```bash
# Monthly performance assessment
mcp__zen__analyze --analysis_type=performance --output_format=actionable

# Quarterly deep performance analysis
mcp__zen__thinkdeep --thinking_mode=high
```

### 2. Performance Culture Development
- **Performance-First Mindset**: Consider performance in all development decisions
- **Continuous Monitoring**: Regular performance metric reviews
- **Optimization Opportunities**: Proactive identification of improvement areas
- **Knowledge Sharing**: Team education on performance best practices

### 3. Performance Innovation
- **New Technology Evaluation**: Assess performance impact of new technologies
- **Architecture Evolution**: Consider performance in architectural decisions
- **Scalability Planning**: Design for future performance requirements
- **Performance Research**: Stay current with performance optimization techniques

## See Also

- **[Feature Development Workflow](feature-development.md)** - Performance integration in development
- **[Quality Assurance Workflows](quality-assurance.md)** - Performance quality gates
- **[Debugging & Investigation](debugging-investigation.md)** - Performance issue resolution
- **[Performance Specialist](../agents/performance-specialist.md)** - Database and system performance expertise