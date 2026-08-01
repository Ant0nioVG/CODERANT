// ============================================================
// Wlogout main panel — full-screen overlay with action buttons
// Colors loaded dynamically from colors.json, keyboard driven.
// ============================================================

import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

Variants {
  id: root
  default property list<LogoutButton> buttons

  model: Quickshell.screens

  PanelWindow {
    id: w

    // ── Model ─────────────────────────────────────────────
    property var modelData
    screen: modelData

    // ── Wayland config ────────────────────────────────────
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    color: "transparent"

    anchors {
      top: true
      left: true
      bottom: true
      right: true
    }

    // ── Keyboard shortcuts ────────────────────────────────
    contentItem {
      focus: true
      Keys.onPressed: event => {
        if (event.key == Qt.Key_Escape) Qt.quit();
        else {
          for (let i = 0; i < buttons.length; i++) {
            let button = buttons[i];
            if (event.key == button.keybind) button.exec();
          }
        }
      }
    }

    // ── Dynamic colors ────────────────────────────────────
    Item {
      id: colors
      visible: false
      property color background: "#101417"
      property color surfaceContainer: "#1c2024"
      property color surfaceText: "#e0e3e8"
      property color primary: "#8aceff"

      // ── Live palette (colors.json, hot reload) ──────────
      FileView {
        path: Quickshell.env("HOME") + "/.config/quickshell/colors.json"
        watchChanges: true
        onFileChanged: reload()
        onLoaded: {
          try {
            var c = JSON.parse(text().trim());
            if (c.background) colors.background = c.background;
            if (c.surfaceContainer) colors.surfaceContainer = c.surfaceContainer;
            if (c.surfaceText) colors.surfaceText = c.surfaceText;
            if (c.primary) colors.primary = c.primary;
          } catch (e) {}
        }
      }
    }

    // ── Content ───────────────────────────────────────────
    MouseArea {
      anchors.fill: parent
      onClicked: Qt.quit()

      // Dimmed overlay
      Rectangle {
        anchors.fill: parent
        color: Qt.rgba(colors.background.r, colors.background.g, colors.background.b, 0.6)
      }

      // Action buttons bar
      Rectangle {
        id: bar
        property int btnSize: 80
        property int pad: 10

        anchors.centerIn: parent
        width: buttons.length * btnSize + (buttons.length + 1) * pad
        height: btnSize + 2 * pad
        radius: 12
        color: "#000000"

        RowLayout {
          anchors {
            fill: parent
            margins: bar.pad
          }
          spacing: bar.pad

          Repeater {
            model: buttons

            delegate: Rectangle {
              required property LogoutButton modelData;

              Layout.preferredWidth: bar.btnSize
              Layout.preferredHeight: bar.btnSize

              color: ma.containsMouse ? colors.primary : "transparent"
              radius: 8

              MouseArea {
                id: ma
                anchors.fill: parent
                hoverEnabled: true
                onClicked: modelData.exec()
              }

              ColumnLayout {
                anchors.centerIn: parent
                spacing: 4

                Item {
                  Layout.alignment: Qt.AlignHCenter
                  Layout.preferredWidth: 26
                  Layout.preferredHeight: 26

                  Image {
                    id: iconImg
                    anchors.fill: parent
                    source: `icons/${modelData.icon}.svg`
                    sourceSize.width: 26
                    sourceSize.height: 26
                    fillMode: Image.PreserveAspectFit
                    visible: false
                  }

                  ColorOverlay {
                    anchors.fill: iconImg
                    source: iconImg
                    color: ma.containsMouse ? "#000000" : "#ffffff"
                  }
                }

                Text {
                  Layout.alignment: Qt.AlignHCenter
                  text: modelData.text
                  font.pointSize: 10
                  color: ma.containsMouse ? "#000000" : "#ffffff"
                }
              }
            }
          }
        }
      }
    }
  }
}
