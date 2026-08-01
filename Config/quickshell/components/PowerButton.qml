// ============================================================
// Power button — opens wlogout power menu on click
// Uses error colors to indicate the destructive action.
// ============================================================

import Quickshell.Io
import QtQuick

BarButton {
  id: root

  // ── Configuration ───────────────────────────────────────
  property string iconDir: ""

  iconSource: iconDir + "power-fill.svg"
  iconSize: 18
  color: colors.error
  hoverColor: colors.errorContainer
  highlightOpacity: 1.0

  // ── Process ─────────────────────────────────────────────
  Process {
    id: powerProc
    command: ["bash", "-c", "quickshell -p ~/.config/quickshell/wlogout/shell.qml"]
  }

  onClicked: powerProc.startDetached()
}
