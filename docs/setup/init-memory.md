# Context Initialization

This guide helps you teach the AI about your project's specific configuration, enabling it to provide accurate, context-aware assistance.

## Why Initialize Context?

The Hybrid Paradigm relies on a `project_context` memory that contains your project's "DNA":
- **Stack** (VILT, TALL, API-only, etc.)
- **Routing** solution (Wayfinder, Ziggy)
- **Admin Panel** (Filament, Nova, None)
- **Auth** system (Breeze, Jetstream, Custom)
- **UI Library** (shadcn-vue, Tailwind UI, etc.)

This information determines which code examples, patterns, and tools the AI uses.

## Analysis Command

Run this command once in your project to create the context memory:

```
Analyze `composer.json`, `package.json`, and `vite.config.js`. Based on this, write a memory named 'project_context' containing:

1. **Stack**: (e.g., VILT / TALL / API / Hybrid)
2. **Routing**: (Wayfinder or Ziggy)
3. **Admin**: (Filament, Nova, or None)
4. **Auth**: (Jetstream, Breeze, or Custom)
5. **UI Lib**: (shadcn-vue, Tailwind UI, headless, etc.)
6. **Additional Notes**: Any other important context

Format the memory as structured key-value pairs.
```

## Expected Output Example

The AI should create a memory like this:

```
project_context:
- Stack: VILT (Vue 3, Inertia.js, Laravel 12, Tailwind CSS)
- Routing: Wayfinder (type-safe routes)
- Admin: Filament 3.x
- Auth: Laravel Breeze with Inertia
- UI Lib: shadcn-vue
- Additional Notes: Using Laravel Herd for development, Pest for testing
```

## Verification

After initialization, verify the memory was created:

```bash
mcp__serena__read_memory 'project_context'
```

## Updating Context

If your project configuration changes, update the memory:

```
Update the 'project_context' memory to reflect that we've now added Filament for the admin panel.
```

## Manual Memory Creation

If automated analysis doesn't work, create it manually:

```
Write a memory named 'project_context' with the following:
- Stack: VILT
- Routing: Wayfinder
- Admin: Filament
- Auth: Breeze
- UI Lib: shadcn-vue
```

## Common Configurations

### VILT with Filament
```
- Stack: VILT
- Routing: Wayfinder
- Admin: Filament 3.x
- Auth: Breeze
- UI Lib: shadcn-vue
```

### TALL Stack
```
- Stack: TALL (Tailwind, Alpine.js, Laravel, Livewire)
- Routing: Ziggy
- Admin: Filament 3.x
- Auth: Jetstream
- UI Lib: Tailwind UI
```

### API-Only
```
- Stack: API (Laravel API + separate frontend)
- Routing: API routes only
- Admin: Nova
- Auth: Sanctum
- UI Lib: N/A (API only)
```

## Troubleshooting

### Memory Not Found
If agents report missing `project_context`:
1. Check if memory exists: `mcp__serena__list_memories`
2. Re-run initialization command
3. Create manually as shown above

### Incorrect Configuration Detected
If the AI detects wrong tools/patterns:
1. Review memory contents
2. Update with correct information
3. Restart the session for changes to take effect

## Advanced Usage

### Multiple Configurations
For projects with both admin and frontend:
```
- Stack: Hybrid (VILT frontend + Filament admin)
- Frontend Routing: Wayfinder
- Admin: Filament 3.x with separate panel
- Auth: Breeze (frontend) + Filament auth (admin)
- UI Lib: shadcn-vue (frontend), Filament components (admin)
```

### Legacy Projects
```
- Stack: Traditional Laravel (Blade views)
- Routing: Named routes (traditional)
- Admin: Custom-built
- Auth: Custom implementation
- UI Lib: Bootstrap 5
- Additional Notes: Migrating to VILT stack incrementally
```

## Benefits

Once initialized, agents will:
- ✅ Use correct routing syntax (Wayfinder vs Ziggy)
- ✅ Generate appropriate admin panel code (Filament vs Nova)
- ✅ Apply correct UI component patterns (shadcn-vue, etc.)
- ✅ Follow project-specific conventions
- ✅ Avoid incompatible suggestions
