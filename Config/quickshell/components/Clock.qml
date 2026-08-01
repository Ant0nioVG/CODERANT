// ============================================================
// Digital clock — 12-hour format (HH:MM), updates every second
// ============================================================

import QtQuick

Item {
  id: root

  // ── Configuration ───────────────────────────────────────
  property var colors: QtObject { property color surfaceText: "#e0e3e8" }
  property int fontSize: 14

  // ── Size ────────────────────────────────────────────────
  width: 36
  height: 44

  // ── Display ─────────────────────────────────────────────
  Rectangle {
    anchors.fill: parent
    radius: 6
    color: "transparent"
  }

  Column {
    anchors.centerIn: parent
    spacing: -2

    Text {
      anchors.horizontalCenter: parent.horizontalCenter
      text: clockTime.hours
      color: root.colors.surfaceText
      font.pixelSize: root.fontSize
      font.weight: Font.Bold
    }

    Text {
      anchors.horizontalCenter: parent.horizontalCenter
      text: clockTime.minutes
      color: root.colors.surfaceText
      font.pixelSize: root.fontSize
      font.weight: Font.Bold
      opacity: 0.7
    }
  }

  // ── Timer ───────────────────────────────────────────────
  Timer {
    interval: 1000
    repeat: true
    running: root.visible
    onTriggered: clockTime.update()
  }

  // ── Time logic ──────────────────────────────────────────
  QtObject {
    id: clockTime
    property string hours: "00"
    property string minutes: "00"

    function update() {
      var d = new Date();
      var h = d.getHours() % 12 || 12;
      hours = h.toString().padStart(2, "0");
      minutes = d.getMinutes().toString().padStart(2, "0");
    }

    Component.onCompleted: update()
  }
}
