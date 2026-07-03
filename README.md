# Sailing Watch — Connect IQ Data Fields

Two data fields for Garmin Instinct 2 (and similar devices) that use the watch's navigation and GPS to compute sailing metrics.

## Projects

| Project | Description |
|---------|-------------|
| `bearing-diff/` | Bearing Diff — difference between nav bearing and GPS course over ground |
| `vmg/` | VMG — Velocity Made Good toward the navigation mark |

## Formulas

- **Bearing Diff** = `navBearing - track` (degrees, normalized to ±180°)
- **VMG** = `cos(navBearing - track) × speedOverGround` (knots)

Both use `info.bearing` (bearing to navigation waypoint), `info.track` (GPS course over ground), and `info.currentSpeed` (GPS speed).

Requires an active navigation course/waypoint on the watch, otherwise fields show `---`.

## Build

1. Open `bearing-diff/` or `vmg/` in VS Code
2. `Ctrl+Shift+P` → **Monkey C: Edit Products** → select your device
3. `Ctrl+Shift+P` → **Monkey C: Build for Device**

## Install

Copy the `.prg` to `GARMIN/Apps` on the watch via USB.

## On the Watch

Start an activity → hold Menu → **Data Screens** → **Add Data Screen** → **Connect IQ** → pick **Bearing Diff** or **VMG**
