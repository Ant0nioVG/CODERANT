// ============================================================
// Quickshell panel — vertical bar (left-anchored)
// Stacked components: launcher, workspaces, network, volume,
// battery, notifications, clock, and power button.
// Colors are dynamically loaded from colors.json.
// ============================================================

import Quickshell
import QtQuick
import QtQuick.Layouts
import "components"

PanelWindow {
  id: window

  // ── Configuration ───────────────────────────────────────
  anchors {
    left: true
    top: true
    bottom: true
  }

  margins {
    left: 5
    bottom: 5
    top: 5
  }

  color: "transparent"
  implicitWidth: 44
  exclusionMode: ExclusionMode.Auto

  // ── Shared resources ────────────────────────────────────
  property string iconDir: Qt.resolvedUrl("icons/").toString()
  property var colors: ColorPalette {}

  // ── Layout ──────────────────────────────────────────────
  Rectangle {
    anchors.fill: parent
    radius: 3
    color: "#B3000000"

    ColumnLayout {
      anchors.fill: parent
      anchors.margins: 4
      spacing: 4

      AppLauncher {
        Layout.alignment: Qt.AlignHCenter
        iconDir: window.iconDir
        colors: window.colors
      }

      Workspaces {
        Layout.alignment: Qt.AlignHCenter
        colors: window.colors
      }

      Item {
        Layout.fillHeight: true
      }

      InternetIcon {
        Layout.alignment: Qt.AlignHCenter
        iconDir: window.iconDir
        colors: window.colors
      }

      VolumeIcon {
        Layout.alignment: Qt.AlignHCenter
        iconDir: window.iconDir
        colors: window.colors
      }

      BatteryIcon {
        Layout.alignment: Qt.AlignHCenter
        iconDir: window.iconDir
        colors: window.colors
      }

      NotificationIcon {
        Layout.alignment: Qt.AlignHCenter
        iconDir: window.iconDir
        colors: window.colors
      }

      Clock {
        Layout.alignment: Qt.AlignHCenter
        colors: window.colors
      }

      PowerButton {
        Layout.alignment: Qt.AlignHCenter
        iconDir: window.iconDir
        colors: window.colors
      }
    }
  }
}
