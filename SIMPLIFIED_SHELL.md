# Simplified Shell

This is a simplified version of the Caelestia shell that removes all complex panels and features a minimalist top bar.

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

The bar respects these configuration options from `~/.config/caelestia/shell.json`:

```json
{
  "bar": {
    "workspaces": {
      "shown": 5
    },
    "status": {
      "showNetwork": true,
      "showBattery": true
    }
  },
  "services": {
    "useTwelveHourClock": false
  },
  "border": {
    "thickness": 10
  },
  "background": {
    "enabled": true
  }
}
```

### Making the Bar Persistent

To make the bar always visible (no auto-hide), you can set:
```json
{
  "bar": {
    "persistent": true
  }
}
```

Note: The bar doesn't currently read this config directly, but you can modify the TopBar.qml file to set `barContent.persistent: true` if needed.

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
