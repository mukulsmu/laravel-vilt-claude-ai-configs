# Laravel Boost Base Instructions

**Purpose**: This file documents the base Laravel instructions that Laravel Boost creates when you run `php artisan boost:install`.

**Usage**: This file is for reference only. It shows what Laravel Boost provides so you understand the foundation our VILT enhancements build upon.

---

## Laravel Project Context

This is a Laravel application with AI-powered development tooling provided by Laravel Boost.

## Laravel Conventions

When generating code for this Laravel project:

- Follow Laravel naming conventions (StudlyCase for classes, camelCase for methods)
- Use Eloquent ORM for all database operations
- Use dependency injection where appropriate
- Follow PSR-12 coding standards
- Use type hints for parameters and return types
- Use strict types: `declare(strict_types=1);`

## MCP Server Integration

Laravel Boost MCP server is available and provides Laravel-specific tools:

- **@boost** - Access to Laravel Boost MCP tools
- Use MCP tools for Laravel introspection, configuration, and debugging

## Available MCP Tools

The Laravel Boost MCP server provides:

- `get_models` - List all Eloquent models
- `get_routes` - List all application routes  
- `get_config` - Read configuration values
- `get_logs` - Read application logs
- `run_query` - Execute database queries
- `get_migrations` - List migrations
- `get_controllers` - List controllers
- And more Laravel-specific introspection tools

## Best Practices

- Use Laravel's built-in features (validation, authorization, caching, etc.)
- Follow Laravel's MVC architecture
- Write tests for new functionality
- Use Laravel's helper functions where appropriate
- Follow the framework conventions over custom solutions

---

**Note**: Laravel Boost creates this base configuration. Our VILT toolkit enhances it with Vue 3, Inertia.js, and Tailwind CSS specific patterns. See the main `CLAUDE.md` for VILT enhancements.
