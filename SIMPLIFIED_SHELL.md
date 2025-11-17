# Simplified Shell

This is a simplified version of the Caelestia shell that removes all complex panels and features a clean, minimalist top bar that appears on hover.

## What Changed

The shell has been simplified to include only:

- **Top Bar**: A horizontal bar at the top of the screen that shows on hover
- **Background**: Wallpaper display (can be disabled via config)
- **Essential Services**: Battery monitoring and basic IPC handlers

### Removed Components

The following components have been removed:
- Dashboard (full panel with system info, calendar, weather, etc.)
- Launcher (application launcher)
- Session menu (power management options)
- Sidebar (notifications panel)
- Control center
- Utilities panel
- OSD (on-screen display for volume/brightness)
- Lock screen
- Notifications
- Area picker
- Window info

## Top Bar Features

The top bar includes:

```
┌──────────────────────────────────────────────────────────────────┐
│ [Border: Primary Color - configurable thickness]                 │
├──────────────────────────────────────────────────────────────────┤
│  [1] [2] [3] [4] [5]              14:30  Mon Nov 17  📶  🔋 85%  │
│   ^                                 ^        ^         ^     ^    │
│   Workspaces                      Time     Date    Network Battery│
└──────────────────────────────────────────────────────────────────┘
```

### Left Section
- **Workspaces**: Shows 5 workspace indicators (configurable)
  - Active workspace is highlighted in primary color
  - Occupied workspaces shown with darker background
  - Click to switch workspaces

### Right Section
- **Clock**: Shows current time and date
  - Format: HH:mm (or 12-hour if configured)
  - Date: ddd MMM dd (e.g., "Mon Nov 17")
  
- **Status Icons**:
  - **Network**: WiFi signal strength indicator
  - **Battery**: Battery icon and percentage (for laptops)

## Behavior

- The top bar **automatically hides** when not in use
- **Hover** your mouse at the **top edge** of the screen to reveal the bar
- Smooth animation similar to the original OSD behavior
- Border color at the top indicates the bar's presence

## Configuration

The bar respects these configuration options from `~/.config/caelestia/shell.json`.

A minimal example configuration is provided in `config-example-simple.json`. To use it:

```bash
cp config-example-simple.json ~/.config/caelestia/shell.json
```

### Key Configuration Options

```json
{
  "bar": {
    "persistent": false,        // Set to true to keep bar always visible (no auto-hide)
    "workspaces": {
      "shown": 5,               // Number of workspaces to display
      "perMonitorWorkspaces": true
    },
    "status": {
      "showNetwork": true,      // Show/hide network icon
      "showBattery": true       // Show/hide battery icon
    }
  },
  "services": {
    "useTwelveHourClock": false // Set to true for 12-hour time format
  },
  "border": {
    "thickness": 3              // Border thickness at top in pixels
  },
  "background": {
    "enabled": true             // Set to false to disable wallpaper
  },
  "appearance": {
    "transparency": {
      "enabled": true,          // Enable/disable transparency
      "base": 0.9               // Transparency level (0.0-1.0)
    }
  }
}
```

## Restoring Removed Features

If you need any of the removed features back, you can:

1. Check the git history to see what was removed:
   ```bash
   git log --all --full-history -- "modules/launcher/*"
   ```

2. Restore specific components from previous commits
3. Re-add the imports to `shell.qml`

## File Structure

```
modules/
  topbar/
    TopBar.qml          # Main top bar window
    Workspaces.qml      # Workspace indicators
    Clock.qml           # Time and date display
    StatusIcons.qml     # Network and battery status
  SimpleShortcuts.qml   # Minimal IPC handlers
  BatteryMonitor.qml    # Battery monitoring service
  background/           # Wallpaper components
shell.qml               # Main entry point
```

## Dependencies

The simplified shell requires:
- `quickshell-git`
- `hyprland`
- Basic system utilities for network and power management
  - `networkmanager`
  - `upower`

Many of the original dependencies (brightnessctl, ddcutil, cava, etc.) are no longer needed.
