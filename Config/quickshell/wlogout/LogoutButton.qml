// ============================================================
// Logout button model — stores command, label, icon, keybind
// ============================================================

import QtQuick
import Quickshell.Io

QtObject {
  id: button

  // ── Configuration ───────────────────────────────────────
  required property string command
  required property string text
  required property string icon
  property var keybind: null

  // ── Process ─────────────────────────────────────────────
  readonly property var process: Process {
    command: ["sh", "-c", button.command]
  }

  // ── Functions ───────────────────────────────────────────
  function exec() {
    process.startDetached();
    Qt.quit();
  }
}
