# BrowserMCP Guide

Real-time browser automation and debugging for interactive testing of Laravel TALL stack applications, especially useful for complex Livewire component workflows.

## Overview

BrowserMCP provides browser automation capabilities that work with existing authenticated sessions, making it ideal for debugging and testing complex UI workflows that require user authentication or specific application state.

## Installation & Setup

BrowserMCP is already configured in the project. The server provides browser automation through Chrome DevTools Protocol (CDP).

### Prerequisites
```bash
# Browser automation dependencies are in package.json
# chrome-remote-interface is installed for CDP communication
npm install  # Ensures all dependencies are available
```

## Core Capabilities

### 1. Page Navigation & State Inspection

```bash
# Navigate to application pages
mcp__browsermcp__browser_navigate "http://localhost/dashboard/agents"

# Capture current page state with interactive element references
mcp__browsermcp__browser_snapshot

# Navigate with authentication already in place
mcp__browsermcp__browser_navigate "http://localhost/dashboard/knowledge"
```

### 2. Interactive Element Testing

```bash
# Click buttons, links, and interactive elements
mcp__browsermcp__browser_click "Create Agent button" "s1e50"

# Type into form fields
mcp__browsermcp__browser_type "Agent Name field" "s2e103" "Test Agent Name" true

# Select dropdown options
mcp__browsermcp__browser_select_option "AI Provider dropdown" "s2e115" ["openai"]

# Hover over elements to trigger tooltips/menus
mcp__browsermcp__browser_hover "User menu" "s1e38"
```

### 3. Debugging & Monitoring

```bash
# Check JavaScript console for errors
mcp__browsermcp__browser_get_console_logs

# Take screenshots for visual verification
mcp__browsermcp__browser_screenshot

# Wait for dynamic content or async operations
mcp__browsermcp__browser_wait 2  # Wait 2 seconds
```

## Debugging Workflows

### 1. Livewire Component Debugging

**Scenario**: Debugging a broken create/edit workflow

```bash
# Start investigation
mcp__browsermcp__browser_navigate "http://localhost/dashboard/agents"
mcp__browsermcp__browser_snapshot

# Test the problematic workflow
mcp__browsermcp__browser_click "Create Agent button" "s1e50"
mcp__browsermcp__browser_snapshot  # Check modal state

# Inspect form elements and their state
mcp__browsermcp__browser_get_console_logs  # Check for JavaScript errors

# Test form interactions
mcp__browsermcp__browser_type "Agent Name" "s2e103" "Test Agent" false
mcp__browsermcp__browser_select_option "AI Provider" "s2e115" ["openai"]

# Verify changes took effect
mcp__browsermcp__browser_screenshot
```

### 2. Authentication-Dependent Testing

**Scenario**: Testing features that require specific user roles or login state

```bash
# Use existing authenticated session
mcp__browsermcp__browser_navigate "http://localhost/dashboard/admin"
mcp__browsermcp__browser_snapshot

# Test admin-only features
mcp__browsermcp__browser_click "Admin Settings" "s1e25"
mcp__browsermcp__browser_get_console_logs

# Verify proper access control
mcp__browsermcp__browser_screenshot
```

### 3. Real-Time Interaction Testing

**Scenario**: Testing complex multi-step workflows

```bash
# Multi-step workflow testing
mcp__browsermcp__browser_navigate "http://localhost/dashboard/knowledge"

# Step 1: Create document
mcp__browsermcp__browser_click "Add Knowledge" "s1e22"
mcp__browsermcp__browser_type "Title field" "s2e103" "Test Document" false
mcp__browsermcp__browser_type "Content field" "s2e112" "Test content for debugging" false

# Step 2: Save and verify
mcp__browsermcp__browser_click "Save Document" "s2e338"
mcp__browsermcp__browser_wait 1  # Wait for save operation

# Step 3: Verify document appears in list
mcp__browsermcp__browser_snapshot
mcp__browsermcp__browser_screenshot
```

## Advanced Debugging Techniques

### 1. Component State Inspection

When debugging Livewire components, use the browser's ability to inspect real DOM state:

```bash
# After triggering a component action
mcp__browsermcp__browser_click "Update Agent" "s2e338"
mcp__browsermcp__browser_wait 1

# Check console for Livewire errors
mcp__browsermcp__browser_get_console_logs

# Take snapshot to see updated state
mcp__browsermcp__browser_snapshot
```

### 2. Error Reproduction & Validation

Perfect for reproducing user-reported bugs:

```bash
# Reproduce exact user steps
mcp__browsermcp__browser_navigate "http://localhost/dashboard/agents"
mcp__browsermcp__browser_click "Create Agent" "s1e50"

# Follow exact user interaction pattern
mcp__browsermcp__browser_type "Agent Name" "s2e103" "User's Exact Input" false
mcp__browsermcp__browser_select_option "AI Model" "s2e118" ["gpt-4"]

# Attempt the action that failed
mcp__browsermcp__browser_click "Create Agent" "s2e380"

# Check for errors and state
mcp__browsermcp__browser_get_console_logs
mcp__browsermcp__browser_screenshot
```

### 3. Fix Validation

After implementing a fix, validate it works:

```bash
# Test the previously broken workflow
mcp__browsermcp__browser_navigate "http://localhost/dashboard/agents"
mcp__browsermcp__browser_click "Create Agent" "s1e50"

# Verify fix: check modal title shows "Create New Agent" not "Edit Agent"
mcp__browsermcp__browser_snapshot

# Verify dropdown population
mcp__browsermcp__browser_click "AI Model dropdown" "s2e118"
# Should show full model list now

# Test complete workflow
mcp__browsermcp__browser_type "Agent Name" "s2e103" "Fixed Workflow Test" false
mcp__browsermcp__browser_click "Create Agent" "s2e380"

# Verify success
mcp__browsermcp__browser_wait 2
mcp__browsermcp__browser_screenshot
```

## Integration with Other MCP Tools

### Combining with Zen Tools

```bash
# Use BrowserMCP for evidence gathering during zen debugging
mcp__zen__debug "step": "Investigating agent creation 404 error"

# Gather evidence with BrowserMCP
mcp__browsermcp__browser_navigate "http://localhost/dashboard/agents"
mcp__browsermcp__browser_click "Create Agent" "s1e50"
mcp__browsermcp__browser_get_console_logs

# Continue zen debugging with concrete evidence
mcp__zen__debug "findings": "Console shows Livewire component mount error..."
```

### Combining with Serena Code Analysis

```bash
# Investigate code while testing in browser
mcp__serena__find_symbol "AgentEditor/mount" --include-body=true

# Test the identified issue in browser
mcp__browsermcp__browser_navigate "http://localhost/dashboard/agents"
mcp__browsermcp__browser_click "Create Agent" "s1e50"

# Verify component behavior matches code analysis
mcp__browsermcp__browser_snapshot
```

## Best Practices

### 1. Element Reference Management

- Always use the most recent snapshot element references (e.g., `s1e50`)
- Element references change after page interactions
- Take new snapshots after significant DOM changes

### 2. Authenticated Session Handling

- BrowserMCP works with existing browser sessions
- No need to re-authenticate during debugging
- Perfect for testing role-based functionality

### 3. Error Detection Patterns

```bash
# Standard error checking pattern
mcp__browsermcp__browser_get_console_logs
# Look for:
# - JavaScript errors
# - Livewire component errors  
# - AJAX/fetch failures
# - 404/500 responses
```

### 4. Visual Regression Testing

```bash
# Before/after screenshot comparison
mcp__browsermcp__browser_screenshot  # Before change
# ... make changes ...
mcp__browsermcp__browser_screenshot  # After change
# Compare screenshots for visual regressions
```

### 5. Systematic Testing Approach

```bash
# Follow a systematic pattern:
# 1. Navigate to page
# 2. Take baseline snapshot
# 3. Perform interaction
# 4. Check console logs
# 5. Take verification snapshot
# 6. Screenshot for visual record
```

## Common Use Cases

### UI Component Development
- Testing new Livewire components
- Verifying responsive design
- Validating user interaction flows

### Bug Investigation
- Reproducing user-reported issues
- Testing fix effectiveness
- Documenting bug reproduction steps

### Integration Testing
- Testing multi-step workflows
- Validating form submissions
- Testing real-time features

### Regression Testing
- Verifying existing functionality after changes
- Testing across different user roles
- Validating UI consistency

## Troubleshooting

### Common Issues

**Element references become stale**
```bash
# Solution: Take fresh snapshot
mcp__browsermcp__browser_snapshot
# Use new element references from fresh snapshot
```

**Page not loading properly**
```bash
# Check console for errors
mcp__browsermcp__browser_get_console_logs

# Take screenshot to verify state
mcp__browsermcp__browser_screenshot

# Wait for async operations
mcp__browsermcp__browser_wait 3
```

**Interactions not working**
```bash
# Verify element is visible and clickable
mcp__browsermcp__browser_snapshot

# Check for JavaScript errors
mcp__browsermcp__browser_get_console_logs

# Try hovering first to activate element
mcp__browsermcp__browser_hover "element" "ref"
mcp__browsermcp__browser_click "element" "ref"
```

## Integration Examples

### Example 1: Complete Agent Creation Testing

```bash
# Full workflow test for agent creation fix
mcp__browsermcp__browser_navigate "http://localhost/dashboard/agents"
mcp__browsermcp__browser_snapshot

# Verify create button works
mcp__browsermcp__browser_click "Create Agent" "s1e50"
mcp__browsermcp__browser_snapshot

# Verify modal shows correct title and fields
# Should show "Create New Agent" not "Edit Agent"
# Should show full AI model dropdown

# Test form filling
mcp__browsermcp__browser_type "Agent Name" "s2e103" "BrowserMCP Test Agent" false
mcp__browsermcp__browser_select_option "AI Model" "s2e118" ["gpt-4o"]

# Add a tool
mcp__browsermcp__browser_click "Add Knowledge Search" "s2e161"

# Submit form
mcp__browsermcp__browser_click "Create Agent" "s2e380"

# Verify success
mcp__browsermcp__browser_wait 3
mcp__browsermcp__browser_screenshot
mcp__browsermcp__browser_get_console_logs
```

### Example 2: Knowledge System Testing

```bash
# Test knowledge document creation workflow
mcp__browsermcp__browser_navigate "http://localhost/dashboard/knowledge"
mcp__browsermcp__browser_click "Add Knowledge" "s1e22"

# Test different content types
mcp__browsermcp__browser_select_option "Content Type" "s2e140" ["file"]
mcp__browsermcp__browser_type "Title" "s2e103" "Test Upload" false

# File upload would require special handling
# mcp__browsermcp__browser_file_upload ["/path/to/test/file.pdf"]

# Switch back to text
mcp__browsermcp__browser_select_option "Content Type" "s2e140" ["text"]
mcp__browsermcp__browser_type "Content" "s2e112" "Test content for knowledge system" false

mcp__browsermcp__browser_click "Save Document" "s2e338"
mcp__browsermcp__browser_wait 2
mcp__browsermcp__browser_screenshot
```

## See Also

- **[Debugging & Investigation Workflows](../workflows/debugging-investigation.md)** - General debugging approaches

- **[Zen Guide](zen-guide.md)** - Advanced analysis workflows
- **[Serena Guide](serena-guide.md)** - Code analysis integration