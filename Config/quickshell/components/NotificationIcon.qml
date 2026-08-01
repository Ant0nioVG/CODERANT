// ============================================================
// Notification icon — opens swaync control center on click
// ============================================================

import Quickshell.Io
import QtQuick

BarButton {
  id: root

  // ── Configuration ───────────────────────────────────────
  property string iconDir: ""

  iconSource: iconDir + "bell-fill.svg"
  iconSize: 18
  highlightOpacity: 0.7

  // ── Process ─────────────────────────────────────────────
  Process {
    id: notifProc
    command: ["swaync-client", "-op"]
  }

  onClicked: notifProc.startDetached()
}
