// ============================================================
// Brightness monitor — watches brightnessctl for changes
// Emits value changes to trigger the OSD popup.
// ============================================================

import Quickshell.Io
import QtQuick

Item {
  id: root

  // ── Configuration ───────────────────────────────────────
  property real maxValue: 1

  // ── Reactive state ──────────────────────────────────────
  property real value: 0
  property bool changed: false

  readonly property real percent: maxValue > 0 ? value / maxValue : 0
  readonly property string icon: "sun-fill.svg"

  // ── Internal state ──────────────────────────────────────
  property real _lastValue: -1
  property bool _initialRead: false

  // ── Processes ───────────────────────────────────────────
  Process {
    id: maxProc
    stdout: StdioCollector {
      onStreamFinished: {
        root.maxValue = parseInt(this.text.trim())
      }
    }
  }

  Process {
    id: monitorProc
    stdout: SplitParser {
      splitMarker: "\n"
      onRead: (data) => {
        let val = parseInt(data.trim())
        if (isNaN(val)) return
        if (!root._initialRead) {
          root.value = val
          root._lastValue = val
          root._initialRead = true
          return
        }
        if (val !== root._lastValue) {
          root.value = val
          root._lastValue = val
          root.changed = true
        }
      }
    }
  }

  // ── Startup ─────────────────────────────────────────────
  Component.onCompleted: {
    maxProc.exec(["brightnessctl", "max"])
    monitorProc.exec(["sh", "-c", "while true; do brightnessctl get; sleep 0.1; done"])
  }
}
