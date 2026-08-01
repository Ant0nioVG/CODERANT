// ============================================================
// Workspace model — queries Hyprland workspace state
// Tracks the focused workspace, active (occupied) workspaces,
// and provides lookup by workspace ID.
// ============================================================

import Quickshell.Hyprland
import Quickshell.WindowManager
import QtQuick

QtObject {
  id: root

  // ── Readonly state ──────────────────────────────────────
  readonly property int focusedWorkspace: Hyprland.focusedWorkspace?.id ?? 1

  readonly property var activeWorkspaces: {
    var active = {};
    var wsList = Hyprland.workspaces?.values ?? [];
    for (var i = 0; i < wsList.length; i++) {
      var ws = wsList[i];
      if (ws && ws.id !== undefined && (ws.lastIpcObject?.windows ?? 0) > 0)
        active[ws.id] = true;
    }
    return active;
  }

  // ── Workspace lookup ────────────────────────────────────
  readonly property var _watcher: WindowManager.windowsets

  readonly property var _lookup: {
    var w = root._watcher;
    var result = {};
    for (var i = 0; i < (w || []).length; i++)
      result[w[i].coordinates[0]] = w[i];
    return result;
  }

  // ── Functions ───────────────────────────────────────────
  function isOccupied(id) {
    return !!root.activeWorkspaces[id];
  }

  function maxActiveWorkspace() {
    var max = 0;
    for (var id in root.activeWorkspaces) {
      var num = parseInt(id);
      if (!isNaN(num) && num > max)
        max = num;
    }
    return max;
  }

  function getWorkspace(id) {
    return root._lookup[id];
  }
}
