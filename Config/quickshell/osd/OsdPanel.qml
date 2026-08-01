// ============================================================
// OSD panel item — icon + progress bar used by the OSD overlay
// ============================================================

import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Item {
  id: root

  // ── Configuration ───────────────────────────────────────
  property url iconSource: ""
  property real progress: 0.0
  property var colors: QtObject {
    property color surfaceContainer: "#1c2024"
    property color surfaceText: "#e0e3e8"
    property color surfaceVariant: "#3f484f"
    property color primary: "#8aceff"
  }

  // ── Size ────────────────────────────────────────────────
  implicitWidth: 120
  implicitHeight: 66

  // ── Layout ──────────────────────────────────────────────
  ColumnLayout {
    anchors.centerIn: parent
    spacing: 12

    // ── Icon ──────────────────────────────────────────────
    Item {
      Layout.alignment: Qt.AlignHCenter
      width: 64
      height: 64

      Image {
        id: osdIcon
        anchors.centerIn: parent
        width: 64
        height: 64
        sourceSize.width: 64
        sourceSize.height: 64
        fillMode: Image.PreserveAspectFit
        source: root.iconSource
        visible: false
      }

      ColorOverlay {
        anchors.fill: osdIcon
        source: osdIcon
        color: root.colors.surfaceText
      }
    }

    // ── Progress bar ──────────────────────────────────────
    Rectangle {
      Layout.alignment: Qt.AlignHCenter
      Layout.preferredWidth: 120
      Layout.preferredHeight: 12
      radius: 6
      color: Qt.rgba(root.colors.surfaceVariant.r, root.colors.surfaceVariant.g, root.colors.surfaceVariant.b, 0.5)

      Rectangle {
        anchors {
          left: parent.left
          top: parent.top
          bottom: parent.bottom
        }
        width: parent.width * Math.min(root.progress, 1)
        radius: parent.radius
        color: root.colors.primary
      }
    }
  }
}
