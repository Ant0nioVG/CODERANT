// ============================================================
// Volume icon — reacts to mute state and level
// Animates on mute toggle. Opens pulsemixer on click.
// ============================================================

import Quickshell.Io
import Quickshell.Services.Pipewire
import QtQuick

BarButton {
  id: root

  // ── Configuration ───────────────────────────────────────
  property string iconDir: ""

  // ── Tracker ─────────────────────────────────────────────
  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink]
  }

  // ── Reactive state ──────────────────────────────────────
  readonly property var  sink:    Pipewire.defaultAudioSink
  readonly property bool hasSink: sink !== null && sink !== undefined
  readonly property bool isMuted: hasSink && sink.audio ? !!sink.audio.muted  : false
  readonly property real volume:  hasSink && sink.audio ?   sink.audio.volume : 0.0

  // ── Icon ────────────────────────────────────────────────
  iconSource: {
    if (!hasSink)       return iconDir + "speaker-x-fill.svg";
    if (isMuted)        return iconDir + "speaker-slash-fill.svg";
    if (volume > 0.66)  return iconDir + "speaker-high-fill.svg";
    if (volume > 0.33)  return iconDir + "speaker-low-fill.svg";
    if (volume > 0.0)   return iconDir + "speaker-none-fill.svg";
    return iconDir + "speaker-none-fill.svg";
  }

  iconSize: 18

  // ── Dynamic color ───────────────────────────────────────
  // outline   → disconnected / near-zero
  // error     → muted
  // tertiary  → overdriven (> 1.0)
  // surfaceText → normal
  color: {
    if (!hasSink)      return colors.outline;
    if (isMuted)       return colors.error;
    if (volume > 1.0)  return colors.tertiary;
    if (volume > 0.33) return colors.surfaceText;
    return colors.outline;
  }

  highlightOpacity: 0.7
  Behavior on color { ColorAnimation { duration: 200 } }

  // ── Mute bounce animation ───────────────────────────────
  onIsMutedChanged: muteFlash.restart()

  SequentialAnimation {
    id: muteFlash
    NumberAnimation { target: root; property: "scale"; to: 1.3; duration: 80  }
    NumberAnimation { target: root; property: "scale"; to: 1.0; duration: 150; easing.type: Easing.OutBounce }
  }

  // ── Process ─────────────────────────────────────────────
  Process {
    id: volProc
    command: ["kitty", "--class", "floating-tool", "-e", "pulsemixer"]
  }

  onClicked: volProc.startDetached()
}
