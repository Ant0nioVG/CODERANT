// ============================================================
// OSD overlay — shows volume / brightness popup
// Appears automatically when volume or brightness changes,
// then auto-hides after 1 second.
// ============================================================

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import QtCore

Scope {
  id: root

  // ── Configuration ───────────────────────────────────────
  readonly property string iconDir: StandardPaths.writableLocation(StandardPaths.HomeLocation)
    + "/.config/quickshell/icons/"

  // ── Monitors ────────────────────────────────────────────
  VolumeMonitor {
    id: volumeMon
    onValueChanged: {
      brightnessMon.changed = false
      showOsd()
    }
  }

  BrightnessMonitor {
    id: brightnessMon
    onValueChanged: {
      volumeMon.changed = false
      showOsd()
    }
  }

  // ── OSD visibility ──────────────────────────────────────
  property bool osdVisible: false
  property bool _ready: false

  function showOsd() {
    if (!_ready) return
    osdVisible = true
    hideTimer.restart()
  }

  Timer {
    id: hideTimer
    interval: 1000
    onTriggered: {
      osdVisible = false
      volumeMon.changed = false
      brightnessMon.changed = false
    }
  }

  Timer {
    id: readyTimer
    interval: 2000
    onTriggered: {
      _ready = true
      volumeMon.changed = false
      brightnessMon.changed = false
    }
  }

  Component.onCompleted: readyTimer.start()

  // ── Dynamic colors ──────────────────────────────────────
  property var colors: QtObject {
    property color surfaceContainer: "#1c2024"
    property color surfaceText: "#e0e3e8"
    property color surfaceVariant: "#3f484f"
    property color primary: "#8aceff"
  }

  // ── Live palette (colors.json, hot reload) ──────────────
  FileView {
    path: Quickshell.env("HOME") + "/.config/quickshell/colors.json"
    watchChanges: true
    onFileChanged: reload()
    onLoaded: {
      try {
        var c = JSON.parse(text().trim());
        if (c.surfaceContainer) root.colors.surfaceContainer = c.surfaceContainer;
        if (c.surfaceText) root.colors.surfaceText = c.surfaceText;
        if (c.surfaceVariant) root.colors.surfaceVariant = c.surfaceVariant;
        if (c.primary) root.colors.primary = c.primary;
      } catch (e) {}
    }
  }

  // ── OSD window ──────────────────────────────────────────
  PanelWindow {
    anchors.bottom: true
    margins.bottom: screen.height / 100
    exclusiveZone: 0
    visible: root.osdVisible

    implicitWidth: 140
    implicitHeight: 140

    color: "transparent"
    mask: Region {}

    Rectangle {
      anchors.fill: parent
      radius: 10
      color: "#b3000000"

      ColumnLayout {
        anchors.centerIn: parent
        spacing: 16

        OsdPanel {
          visible: volumeMon.changed
          iconSource: root.iconDir + volumeMon.icon
          progress: volumeMon.volume
          colors: root.colors
        }

        OsdPanel {
          visible: brightnessMon.changed
          iconSource: root.iconDir + brightnessMon.icon
          progress: brightnessMon.percent
          colors: root.colors
        }
      }
    }
  }
}
