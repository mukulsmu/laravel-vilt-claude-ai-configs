# Development Environment Setup

This guide helps you set up the Marlin development environment using Laravel Sail and Docker.

## Prerequisites

- Docker Desktop installed and running
- Git for version control
- Terminal/command line access

## Initial Setup

### 1. Clone the Repository

```bash
git clone [repository-url]
cd marlin
```

### 2. Environment Configuration

```bash
# Copy environment file
cp .env.example .env

# Configure database and services in .env
# Key variables to set:
# - APP_NAME=Marlin
# - DB_DATABASE=marlin
# - MEILISEARCH_HOST=http://meilisearch:7700
```

### 3. Start Laravel Sail

```bash
# Install dependencies and start services
composer install
./vendor/bin/sail up -d

# Generate application key
./vendor/bin/sail artisan key:generate

# Run migrations and seed data
./vendor/bin/sail artisan migrate --seed
```

### 4. Frontend Setup

```bash
# Install Node dependencies
./vendor/bin/sail npm install

# Start frontend development server
./vendor/bin/sail npm run dev
```

## Docker Services

The application uses these Docker services:

- **Laravel Application** - Main PHP/Laravel app (port 80)
- **MySQL Database** - Data persistence (port 3306)
- **Redis** - Caching and sessions (port 6379)
- **Meilisearch** - Vector search engine (port 7700)
- **Mailpit** - Email testing (port 1025/8025)

## Laravel Sail Commands

**Always prefix commands with `./vendor/bin/sail`:**

### Application Management
```bash
# Start services in background
./vendor/bin/sail up -d

# Stop all services
./vendor/bin/sail down

# View logs
./vendor/bin/sail logs

# Execute shell commands
./vendor/bin/sail shell
```

### Laravel Artisan
```bash
# Database operations
./vendor/bin/sail artisan migrate
./vendor/bin/sail artisan migrate:rollback
./vendor/bin/sail artisan db:seed

# Cache management
./vendor/bin/sail artisan cache:clear
./vendor/bin/sail artisan config:clear
./vendor/bin/sail artisan route:clear
./vendor/bin/sail artisan view:clear

# Queue operations
./vendor/bin/sail artisan queue:work
./vendor/bin/sail artisan queue:restart
```

### Package Management
```bash
# Composer operations
./vendor/bin/sail composer install
./vendor/bin/sail composer require package/name
./vendor/bin/sail composer update

# NPM operations
./vendor/bin/sail npm install
./vendor/bin/sail npm run dev
./vendor/bin/sail npm run build
```

## Knowledge System Setup

### Initialize Meilisearch

```bash
# Test Meilisearch connection
./vendor/bin/sail artisan test:meilisearch-connection

# Generate embeddings for existing documents
./vendor/bin/sail artisan knowledge:generate-embeddings

# Check embedding status
./vendor/bin/sail artisan knowledge:embedding-status
```

### Agent System Initialization

```bash
# Test agent execution
./vendor/bin/sail artisan test:agent-execution

# Run multi-agent workflow tests
./vendor/bin/sail artisan test:multi-agent

# Test broadcast events
./vendor/bin/sail artisan test:broadcast-events
```

## Development Tools

### Code Quality
```bash
# Laravel Pint (code formatting)
./vendor/bin/sail pint

# Pest testing framework
./vendor/bin/sail artisan test
./vendor/bin/sail artisan test --filter=SpecificTest
```

### Debugging
```bash
# Laravel Pail (log monitoring)
./vendor/bin/sail artisan pail --timeout=0

# Tinker (interactive PHP shell)
./vendor/bin/sail artisan tinker
```

## Troubleshooting

### Common Issues

**Port conflicts:**
```bash
# Check what's using ports 80, 3306, etc.
netstat -tulpn | grep :80
lsof -i :80

# Change ports in docker-compose.yml if needed
```

**Permission issues:**
```bash
# Fix storage permissions
sudo chmod -R 775 storage bootstrap/cache
sudo chown -R $USER:www-data storage bootstrap/cache
```

**Database connection errors:**
```bash
# Restart database service
./vendor/bin/sail restart mysql

# Check database logs
./vendor/bin/sail logs mysql
```

**Meilisearch issues:**
```bash
# Restart Meilisearch
./vendor/bin/sail restart meilisearch

# Debug Meilisearch index
./vendor/bin/sail artisan debug:meilisearch-index --detailed
```

### Performance Optimization

**For better development performance:**

```bash
# Use production-optimized autoloader
./vendor/bin/sail composer dump-autoload --optimize

# Enable OPcache in development (optional)
# Add to docker-compose.yml php service environment:
# - PHP_OPCACHE_ENABLE=1
```

## Next Steps

Once your environment is running:

1. **[Project Architecture Overview](project-architecture.md)** - Understand the codebase structure
2. **[Tools & Command Aliases](tools-and-aliases.md)** - Set up development shortcuts
3. **[Feature Development Workflow](../workflows/feature-development.md)** - Start your first development task

## Environment Verification

Verify your setup with these checks:

```bash
# Application health
curl http://localhost

# Database connection
./vendor/bin/sail artisan migrate:status

# Meilisearch connection
./vendor/bin/sail artisan knowledge:embedding-status

# Queue processing
./vendor/bin/sail artisan queue:monitor

# Frontend compilation
./vendor/bin/sail npm run build
```

All checks should complete successfully before proceeding with development.