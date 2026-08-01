// ============================================================
// Network / internet icon — shows connectivity state
// Opens gazelle (network manager) on click.
// ============================================================

import Quickshell.Io
import Quickshell.Networking
import QtQuick

BarButton {
  id: root

  // ── Configuration ───────────────────────────────────────
  property string iconDir: ""

  // ── Computed icon ───────────────────────────────────────
  iconSource: {
    if (!Networking) return iconDir + "wifi-slash-fill.svg";
    if (Networking.connectivity === NetworkConnectivity.Full) return iconDir + "wifi-high-fill.svg";
    return iconDir + "wifi-x-fill.svg";
  }

  iconSize: 18
  highlightOpacity: 0.7

  // ── Process ─────────────────────────────────────────────
  Process {
    id: netProc
    command: ["kitty", "--class", "floating-tool", "-e", "wlctl"]
  }

  onClicked: netProc.startDetached()
}
