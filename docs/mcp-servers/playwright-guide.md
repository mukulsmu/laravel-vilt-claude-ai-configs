# Playwright MCP Server Guide

**Primary Purpose**: Browser automation, end-to-end testing, and visual debugging for Laravel VILT applications

## Overview

The Playwright MCP Server provides comprehensive browser automation capabilities that integrate seamlessly with Laravel's testing ecosystem. It enables AI-assisted browser testing, visual debugging, and automated user workflow validation.

## Installation & Setup

### Prerequisites

1. **Laravel Project with Playwright Integration**
```bash
# Install Laravel Playwright package (recommended)
composer require --dev hyvor/laravel-playwright

# Install frontend Playwright dependencies
npm install --save-dev @hyvor/laravel-playwright @playwright/test

# Install browsers
npx playwright install --with-deps
```

2. **Configure Playwright MCP Server**

Add to your Claude Code configuration (`~/.config/claude-code/config.json`):

```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-playwright"]
    }
  }
}
```

### Verify Installation

```bash
# Test Playwright MCP connection
claude "Use mcp__playwright__browser_navigate to open https://example.com"
```

---

## Core Capabilities

### 1. Browser Navigation & Control

#### Navigate to URLs
```bash
# Basic navigation
mcp__playwright__browser_navigate --url="https://your-app.test/login"

# Navigate with wait for network idle
mcp__playwright__browser_navigate --url="https://your-app.test/dashboard" --waitUntil="networkidle"
```

#### Navigate History
```bash
# Go back
mcp__playwright__browser_navigate_back

# Test multi-page workflows
mcp__playwright__browser_navigate --url="/posts"
mcp__playwright__browser_click --element="button" --ref="create-post"
mcp__playwright__browser_navigate_back  # Return to list
```

### 2. Page Interaction

#### Click Elements
```bash
# Simple click
mcp__playwright__browser_click --element="Login button" --ref="#login-btn"

# Double click
mcp__playwright__browser_click --element="Edit icon" --ref=".edit-icon" --doubleClick=true

# Right click for context menu
mcp__playwright__browser_click --element="Row item" --ref="tr:first-child" --button="right"
```

#### Type Text
```bash
# Type in input field
mcp__playwright__browser_type --element="Email input" --ref="#email" --text="user@example.com"

# Type slowly to trigger handlers
mcp__playwright__browser_type --element="Search" --ref="#search" --text="Laravel" --slowly=true

# Type and submit
mcp__playwright__browser_type --element="Username" --ref="#username" --text="admin" --submit=true
```

#### Fill Forms
```bash
# Fill multiple fields at once
mcp__playwright__browser_fill_form --fields='[
  {"name": "Email", "type": "textbox", "ref": "#email", "value": "user@example.com"},
  {"name": "Password", "type": "textbox", "ref": "#password", "value": "password123"},
  {"name": "Remember me", "type": "checkbox", "ref": "#remember", "value": "true"}
]'
```

### 3. Visual Inspection

#### Take Screenshots
```bash
# Full page screenshot
mcp__playwright__browser_take_screenshot --filename="dashboard.png" --fullPage=true

# Element screenshot
mcp__playwright__browser_take_screenshot --element="User profile card" --ref=".profile-card" --filename="profile.png"

# JPEG for smaller file size
mcp__playwright__browser_take_screenshot --filename="page.jpeg" --type="jpeg"
```

#### Accessibility Snapshots
```bash
# Get accessible page structure (recommended over screenshots for automation)
mcp__playwright__browser_snapshot

# Save snapshot to file
mcp__playwright__browser_snapshot --filename="page-structure.md"
```

### 4. Advanced Interactions

#### Hover & Focus
```bash
# Hover to reveal dropdown
mcp__playwright__browser_hover --element="Menu button" --ref="#user-menu"

# Combined hover and click workflow
mcp__playwright__browser_hover --element="Dropdown" --ref=".dropdown-trigger"
mcp__playwright__browser_click --element="Delete option" --ref=".dropdown-delete"
```

#### Drag and Drop
```bash
# Drag item to new position
mcp__playwright__browser_drag --startElement="Draggable card" --startRef=".card-1" --endElement="Drop zone" --endRef=".drop-target"
```

#### Select Options
```bash
# Select single option
mcp__playwright__browser_select_option --element="Country dropdown" --ref="#country" --values='["US"]'

# Select multiple options
mcp__playwright__browser_select_option --element="Tags" --ref="#tags" --values='["laravel", "vue", "inertia"]'
```

#### File Uploads
```bash
# Upload single file
mcp__playwright__browser_file_upload --paths='["/path/to/document.pdf"]'

# Upload multiple files
mcp__playwright__browser_file_upload --paths='["/path/to/image1.jpg", "/path/to/image2.jpg"]'

# Cancel file chooser
mcp__playwright__browser_file_upload
```

### 5. Debugging & Inspection

#### Console Logs
```bash
# Get all console messages
mcp__playwright__browser_console_messages

# Filter by level
mcp__playwright__browser_console_messages --level="error"  # Only errors
mcp__playwright__browser_console_messages --level="warning"  # Errors + warnings
```

#### Network Monitoring
```bash
# Get all network requests
mcp__playwright__browser_network_requests

# Include static resources
mcp__playwright__browser_network_requests --includeStatic=true
```

#### Execute JavaScript
```bash
# Run JS on page
mcp__playwright__browser_evaluate --function="() => { return document.title; }"

# Run JS on element
mcp__playwright__browser_evaluate --element="Form" --ref="#my-form" --function="(element) => { return element.checkValidity(); }"
```

### 6. Advanced Automation

#### Run Playwright Code
```bash
# Execute complex Playwright script
mcp__playwright__browser_run_code --code="async (page) => {
  await page.getByRole('button', { name: 'Submit' }).click();
  await page.waitForURL('**/success');
  return await page.title();
}"
```

#### Wait Strategies
```bash
# Wait for text to appear
mcp__playwright__browser_wait_for --text="Success!"

# Wait for text to disappear (loading indicators)
mcp__playwright__browser_wait_for --textGone="Loading..."

# Wait for time
mcp__playwright__browser_wait_for --time=2  # seconds
```

#### Handle Dialogs
```bash
# Accept alert/confirm
mcp__playwright__browser_handle_dialog --accept=true

# Dismiss dialog
mcp__playwright__browser_handle_dialog --accept=false

# Handle prompt with text
mcp__playwright__browser_handle_dialog --accept=true --promptText="My response"
```

---

## Laravel VILT Integration Patterns

### 1. Testing Inertia.js Pages

```bash
# Navigate to Inertia page
mcp__playwright__browser_navigate --url="https://app.test/posts/create"

# Fill Inertia form
mcp__playwright__browser_fill_form --fields='[
  {"name": "Title", "type": "textbox", "ref": "#title", "value": "New Post"},
  {"name": "Content", "type": "textbox", "ref": "#content", "value": "Post content"}
]'

# Submit form and verify redirect
mcp__playwright__browser_click --element="Submit" --ref="button[type=submit]"
mcp__playwright__browser_wait_for --text="Post created successfully"

# Verify Inertia page props
mcp__playwright__browser_evaluate --function="() => { 
  return window.page.props; 
}"
```

### 2. Testing shadcn-vue Components

```bash
# Test dialog component
mcp__playwright__browser_click --element="Open dialog" --ref="button[data-dialog-trigger]"
mcp__playwright__browser_wait_for --text="Dialog content"
mcp__playwright__browser_click --element="Close dialog" --ref="button[data-dialog-close]"

# Test select component
mcp__playwright__browser_click --element="Select trigger" --ref="[role=combobox]"
mcp__playwright__browser_click --element="Option 1" --ref="[role=option][data-value='1']"

# Test data table interactions
mcp__playwright__browser_click --element="Sort by name" --ref="th[data-column='name']"
mcp__playwright__browser_type --element="Search" --ref="input[name=search]" --text="Laravel"
```

### 3. Authentication Workflows

```bash
# Login workflow
mcp__playwright__browser_navigate --url="https://app.test/login"
mcp__playwright__browser_fill_form --fields='[
  {"name": "Email", "type": "textbox", "ref": "#email", "value": "admin@example.com"},
  {"name": "Password", "type": "textbox", "ref": "#password", "value": "password"}
]'
mcp__playwright__browser_click --element="Login" --ref="button[type=submit]"
mcp__playwright__browser_wait_for --text="Dashboard"

# Verify authenticated state
mcp__playwright__browser_evaluate --function="() => { 
  return document.cookie.includes('laravel_session'); 
}"
```

### 4. Real-time Features (Laravel Echo)

```bash
# Test real-time updates
mcp__playwright__browser_navigate --url="https://app.test/chat"

# Monitor console for Echo events
mcp__playwright__browser_evaluate --function="() => {
  window.echoEvents = [];
  window.Echo.channel('chat').listen('.MessageSent', (e) => {
    window.echoEvents.push(e);
  });
}"

# Trigger action that broadcasts event
mcp__playwright__browser_type --element="Message input" --ref="#message" --text="Hello"
mcp__playwright__browser_click --element="Send" --ref="button[type=submit]"

# Verify Echo received event
mcp__playwright__browser_wait_for --time=1
mcp__playwright__browser_evaluate --function="() => { return window.echoEvents; }"
```

### 5. File Upload Testing

```bash
# Test Inertia file upload with progress
mcp__playwright__browser_navigate --url="https://app.test/documents/create"

# Trigger file input
mcp__playwright__browser_click --element="Upload button" --ref="button[data-upload-trigger]"

# Upload file
mcp__playwright__browser_file_upload --paths='["/path/to/test-document.pdf"]'

# Verify upload progress
mcp__playwright__browser_wait_for --text="Uploading"
mcp__playwright__browser_wait_for --text="Upload complete"

# Verify file in list
mcp__playwright__browser_snapshot  # Check for filename in page structure
```

---

## Workflow Patterns

### Complete Feature Testing Workflow

```bash
# 1. Setup: Navigate and authenticate
mcp__playwright__browser_navigate --url="https://app.test/login"
mcp__playwright__browser_fill_form --fields='[
  {"name": "Email", "type": "textbox", "ref": "#email", "value": "test@example.com"},
  {"name": "Password", "type": "textbox", "ref": "#password", "value": "password"}
]'
mcp__playwright__browser_click --element="Login" --ref="button[type=submit]"

# 2. Test feature: Create resource
mcp__playwright__browser_navigate --url="https://app.test/posts/create"
mcp__playwright__browser_fill_form --fields='[
  {"name": "Title", "type": "textbox", "ref": "#title", "value": "Test Post"},
  {"name": "Content", "type": "textbox", "ref": "#content", "value": "Content"}
]'
mcp__playwright__browser_click --element="Publish" --ref="button[type=submit]"

# 3. Verify: Check success
mcp__playwright__browser_wait_for --text="Post published"
mcp__playwright__browser_take_screenshot --filename="success-state.png"

# 4. Cleanup: Check console for errors
mcp__playwright__browser_console_messages --level="error"
```

### Mobile Responsiveness Testing

```bash
# Test mobile viewport
mcp__playwright__browser_resize --width=375 --height=667

# Test mobile menu
mcp__playwright__browser_click --element="Hamburger menu" --ref="button[data-mobile-menu]"
mcp__playwright__browser_wait_for --text="Navigation"
mcp__playwright__browser_take_screenshot --filename="mobile-menu.png"

# Test tablet viewport
mcp__playwright__browser_resize --width=768 --height=1024
mcp__playwright__browser_take_screenshot --filename="tablet-view.png"

# Reset to desktop
mcp__playwright__browser_resize --width=1920 --height=1080
```

### Accessibility Testing

```bash
# Navigate to page
mcp__playwright__browser_navigate --url="https://app.test/dashboard"

# Get accessibility tree
mcp__playwright__browser_snapshot --filename="accessibility-tree.md"

# Test keyboard navigation
mcp__playwright__browser_press_key --key="Tab"
mcp__playwright__browser_press_key --key="Tab"
mcp__playwright__browser_press_key --key="Enter"

# Verify focus management
mcp__playwright__browser_evaluate --function="() => { 
  return document.activeElement.tagName + ' - ' + document.activeElement.getAttribute('aria-label'); 
}"
```

---

## Integration with Laravel Testing

### Combine with Laravel Test Suite

```php
// tests/Browser/UserFlowTest.php
<?php

use Tests\TestCase;

class UserFlowTest extends TestCase
{
    public function test_user_can_create_post(): void
    {
        // Use Laravel factories for data setup
        $user = User::factory()->create();
        
        // Use Playwright MCP via Claude for browser automation
        // Claude "Use Playwright to test post creation flow for {$user->email}"
        
        // Assert database state
        $this->assertDatabaseHas('posts', [
            'user_id' => $user->id,
            'title' => 'Test Post'
        ]);
    }
}
```

### Visual Regression Testing

```bash
# Take baseline screenshots
mcp__playwright__browser_navigate --url="https://app.test/dashboard"
mcp__playwright__browser_take_screenshot --filename="baseline-dashboard.png"

# After UI changes, compare
mcp__playwright__browser_navigate --url="https://app.test/dashboard"
mcp__playwright__browser_take_screenshot --filename="current-dashboard.png"

# Use external tools to compare baseline-dashboard.png vs current-dashboard.png
```

---

## Best Practices

### 1. Element Selection Strategy

```bash
# ✅ GOOD: Use semantic roles and accessible names
mcp__playwright__browser_click --element="Submit button" --ref="button[type=submit]"

# ✅ GOOD: Use data attributes for test stability
mcp__playwright__browser_click --element="Delete button" --ref="[data-testid=delete-post]"

# ❌ AVOID: Fragile CSS selectors
mcp__playwright__browser_click --element="Button" --ref=".mt-4.px-6.bg-blue-500"
```

### 2. Wait Strategies

```bash
# ✅ GOOD: Wait for specific content
mcp__playwright__browser_wait_for --text="Data loaded"

# ✅ GOOD: Wait for loading to disappear
mcp__playwright__browser_wait_for --textGone="Loading..."

# ❌ AVOID: Fixed time waits (flaky)
mcp__playwright__browser_wait_for --time=5  # Only use when necessary
```

### 3. Error Handling

```bash
# Always check console after critical operations
mcp__playwright__browser_click --element="Submit" --ref="form button"
mcp__playwright__browser_console_messages --level="error"

# Verify network requests succeeded
mcp__playwright__browser_network_requests
```

### 4. Clean Test State

```bash
# Clear application state before tests
mcp__playwright__browser_evaluate --function="() => { 
  localStorage.clear(); 
  sessionStorage.clear(); 
  document.cookie.split(';').forEach(c => { 
    document.cookie = c.split('=')[0] + '=;expires=' + new Date().toUTCString(); 
  }); 
}"
```

---

## Troubleshooting

### Browser Not Launching

```bash
# Reinstall browsers
npx playwright install --force --with-deps

# Check Playwright installation
npx playwright --version
```

### Element Not Found

```bash
# Use snapshot to see page structure
mcp__playwright__browser_snapshot

# Use evaluate to debug selector
mcp__playwright__browser_evaluate --function="() => { 
  return document.querySelector('[data-testid=my-element]') ? 'Found' : 'Not found'; 
}"
```

### Timing Issues

```bash
# Wait for network idle before interactions
mcp__playwright__browser_navigate --url="https://app.test/page" --waitUntil="networkidle"

# Wait for specific elements to be ready
mcp__playwright__browser_wait_for --text="Page loaded"
```

---

## Advanced Use Cases

### Testing Laravel Queued Jobs

```bash
# Trigger action that dispatches job
mcp__playwright__browser_click --element="Process button" --ref="button[data-action=process]"

# Poll for job completion indicator
mcp__playwright__browser_wait_for --text="Processing complete"

# Verify job result in UI
mcp__playwright__browser_snapshot
```

### Testing Real-time Notifications

```bash
# Setup notification listener
mcp__playwright__browser_evaluate --function="() => {
  window.notifications = [];
  window.Echo.private('App.Models.User.' + userId)
    .notification((notification) => {
      window.notifications.push(notification);
    });
}"

# Trigger notification via backend action
# (external action or API call)

# Verify notification received
mcp__playwright__browser_wait_for --time=2
mcp__playwright__browser_evaluate --function="() => { return window.notifications; }"
```

### Multi-Tab Testing

```bash
# Create new tab
mcp__playwright__browser_tabs --action="new"

# Switch between tabs
mcp__playwright__browser_tabs --action="list"
mcp__playwright__browser_tabs --action="select" --index=0
mcp__playwright__browser_tabs --action="select" --index=1

# Close tab
mcp__playwright__browser_tabs --action="close" --index=1
```

---

## Related Resources

- **[Laravel Playwright Package](https://github.com/hyvor/laravel-playwright)** - Official Laravel integration
- **[Playwright Documentation](https://playwright.dev)** - Complete Playwright API reference
- **[Testing Specialist Agent](.claude/agents/testing-specialist.md)** - Comprehensive testing strategies
- **[BrowserMCP Guide](browsermcp-guide.md)** - Alternative browser automation tool

---

**Pro Tip**: Combine Playwright MCP with Serena for intelligent test generation - use Serena to understand code structure, then generate comprehensive Playwright tests based on discovered patterns.
