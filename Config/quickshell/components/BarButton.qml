// ============================================================
// Reusable bar button — base component for all panel icons
// Provides a rounded hover background, SVG icon with tint
// (via ColorOverlay), and a click signal.
// ============================================================

import QtQuick
import Qt5Compat.GraphicalEffects

Item {
  id: root

  // ── Configuration ───────────────────────────────────────
  property alias iconSource: icon.source
  property var colors: QtObject {
    property color surfaceText: "#e0e3e8"
    property color surfaceVariant: "#3f484f"
    property color outline: "#89929a"
    property color error: "#ffb4ab"
    property color errorContainer: "#93000a"
    property color tertiary: "#eab2ff"
  }
  property color color: colors.surfaceText
  property color hoverColor: colors.surfaceVariant
  property color bgColor: "transparent"
  property real highlightOpacity: 0.7
  property int iconSize: 18

  // ── Signals ─────────────────────────────────────────────
  signal clicked()

  // ── Size ────────────────────────────────────────────────
  width: 36
  height: 36

  // ── Hover highlight ─────────────────────────────────────
  Rectangle {
    anchors.fill: parent
    radius: 6
    color: mouse.containsMouse
      ? Qt.rgba(root.hoverColor.r, root.hoverColor.g, root.hoverColor.b, root.highlightOpacity)
      : root.bgColor
    Behavior on color { ColorAnimation { duration: 150 } }
  }

  // ── Icon ────────────────────────────────────────────────
  Image {
    id: icon
    anchors.centerIn: parent
    width: root.iconSize
    height: root.iconSize
    sourceSize.width: root.iconSize
    sourceSize.height: root.iconSize
    fillMode: Image.PreserveAspectFit
    visible: false
  }

  ColorOverlay {
    anchors.fill: icon
    source: icon
    color: root.color
  }

  // ── Interaction ─────────────────────────────────────────
  MouseArea {
    id: mouse
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: root.clicked()
  }
}
