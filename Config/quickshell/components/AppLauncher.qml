// ============================================================
// App launcher button — opens wofi (drun mode) on click
// ============================================================

import Quickshell.Io
import QtQuick

BarButton {
  id: root

  // ── Configuration ───────────────────────────────────────
  property string iconDir: ""

  iconSource: iconDir + "grid-four-fill.svg"
  iconSize: 20
  highlightOpacity: 1.0

  // ── Process ─────────────────────────────────────────────
  Process {
    id: launcher
    command: ["wofi", "--show", "drun"]
  }

  onClicked: launcher.startDetached()
}
