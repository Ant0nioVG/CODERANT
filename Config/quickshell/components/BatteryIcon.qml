// ============================================================
// Battery status icon — reacts to charge level and state
// Shows different icons and colors based on battery status.
// Opens btop on click.
// ============================================================

import Quickshell.Io
import Quickshell.Services.UPower
import QtQuick

BarButton {
  id: root

  // ── Configuration ───────────────────────────────────────
  property string iconDir: ""

  // ── Reactive state ──────────────────────────────────────
  readonly property var    bat:      UPower.displayDevice
  readonly property bool   ready:    bat.ready && bat.isLaptopBattery
  readonly property real   level:    ready ? bat.percentage : 0.0
  readonly property int    state:    ready ? bat.state : UPowerDeviceState.Unknown
  readonly property bool   charging: state === UPowerDeviceState.Charging
  readonly property bool   full:     state === UPowerDeviceState.FullyCharged
  readonly property bool   critical: ready && level <= 0.10 && !charging && !full

  // ── Icon ────────────────────────────────────────────────
  iconSource: {
    if (!ready)              return iconDir + "battery-vertical-empty-fill.svg";
    if (full)                return iconDir + "battery-vertical-full-fill.svg";
    if (charging)            return iconDir + "battery-plus-vertical-fill.svg";
    if (level >= 0.75)       return iconDir + "battery-vertical-full-fill.svg";
    if (level >= 0.50)       return iconDir + "battery-vertical-high-fill.svg";
    if (level >= 0.25)       return iconDir + "battery-vertical-medium-fill.svg";
    if (level >= 0.10)       return iconDir + "battery-vertical-low-fill.svg";
    return iconDir + "battery-vertical-empty-fill.svg";
  }

  iconSize: 18

  // ── Dynamic color ───────────────────────────────────────
  // outline      → not ready
  // tertiary     → charging / full
  // error        → critical (< 10 %)
  // errorContainer → low (< 25 %)
  // surfaceText  → normal
  color: {
    if (!ready)              return colors.outline;
    if (charging || full)    return colors.tertiary;
    if (critical)            return colors.error;
    if (level <= 0.25)       return colors.errorContainer;
    return colors.surfaceText;
  }

  highlightOpacity: 0.7

  // ── Process ─────────────────────────────────────────────
  Process {
    id: btopProc
    command: ["kitty", "--class", "floating-tool", "-e", "btop"]
  }

  onClicked: btopProc.startDetached()
}
