// ============================================================
// Workspace switcher — vertical list of numbered workspaces
// Highlights the active workspace, shows occupied indicators,
// and supports scrolling if more workspaces than visible.
// ============================================================

import "../lib"
import QtQuick

Item {
  id: root

  // ── Configuration ───────────────────────────────────────
  property var colors: QtObject {
    property color primary: "#8aceff"
    property color primaryText: "#00344e"
    property color surfaceVariant: "#3f484f"
    property color surfaceText: "#e0e3e8"
    property color outline: "#89929a"
  }
  property var model: WorkspaceModel {}

  property int workspaceCount: 5
  property int maxVisibleWorkspaces: 12
  property int wsSize: 36
  property int wsSpacing: 4

  // ── Computed state ──────────────────────────────────────
  property int visibleWorkspaceCount: Math.min(Math.max(workspaceCount, model.focusedWorkspace, model.maxActiveWorkspace()), maxVisibleWorkspaces)
  property int layoutWorkspaceCount: visibleWorkspaceCount
  property real stepSize: wsSize + wsSpacing

  // ── Size ────────────────────────────────────────────────
  width: wsSize
  height: layoutWorkspaceCount * wsSize + (layoutWorkspaceCount - 1) * wsSpacing

  // ── Auto-center on focus change ─────────────────────────
  onVisibleWorkspaceCountChanged: flick.centerOnFocus()

  Connections {
    target: root.model
    function onFocusedWorkspaceChanged() { flick.centerOnFocus() }
  }

  // ── Flickable container ─────────────────────────────────
  Flickable {
    id: flick
    anchors.fill: parent
    contentWidth: width
    contentHeight: root.visibleWorkspaceCount * root.wsSize + Math.max(0, root.visibleWorkspaceCount - 1) * root.wsSpacing
    clip: true
    interactive: root.visibleWorkspaceCount > root.maxVisibleWorkspaces
    boundsBehavior: Flickable.StopAtBounds

    function centerOnFocus() {
      if (contentHeight <= height) {
        contentY = 0;
        return;
      }
      var target = (root.model.focusedWorkspace - 1) * root.stepSize - height / 2 + root.stepSize / 2;
      contentY = Math.max(0, Math.min(target, contentHeight - height));
    }

    onContentHeightChanged: centerOnFocus()
    onHeightChanged: centerOnFocus()
    Component.onCompleted: centerOnFocus()

    // ── Active highlight ──────────────────────────────────
    Rectangle {
      id: activeHighlight
      width: root.wsSize
      height: root.wsSize
      radius: 6
      color: root.colors.primary
      z: 0

      property real targetY: (root.model.focusedWorkspace - 1) * root.stepSize
      y: targetY
      Behavior on y { NumberAnimation { duration: 200; easing.type: Easing.OutExpo } }
    }

    // ── Workspace indicators ──────────────────────────────
    Repeater {
      model: root.visibleWorkspaceCount

      delegate: Item {
        id: delegate
        width: root.wsSize
        height: root.wsSize
        y: index * root.stepSize

        readonly property int wsNumber: index + 1
        readonly property var ws: root.model.getWorkspace(wsNumber)
        readonly property bool isActive: wsNumber === root.model.focusedWorkspace
        readonly property bool isOccupied: root.model.isOccupied(wsNumber)
        readonly property color cv: root.colors.surfaceVariant

        Rectangle {
          anchors.fill: parent
          radius: 6
          color: isOccupied && !isActive
            ? Qt.rgba(delegate.cv.r, delegate.cv.g, delegate.cv.b, 0.4)
            : "transparent"
          Behavior on color { ColorAnimation { duration: 150 } }
          z: 1
        }

        Text {
          anchors.centerIn: parent
          text: delegate.wsNumber
          color: isActive
            ? root.colors.primaryText
            : (isOccupied
              ? root.colors.surfaceText
              : root.colors.outline)
          font.pixelSize: 10
          font.weight: isActive ? Font.Black : (isOccupied ? Font.Bold : Font.Medium)
          z: 2
          Behavior on color { ColorAnimation { duration: 150 } }
        }

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          z: 3
          onClicked: {
            if (ws) {
              ws.activate();
            }
          }
        }
      }
    }
  }
}
