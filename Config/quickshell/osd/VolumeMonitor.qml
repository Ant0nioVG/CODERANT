// ============================================================
// Volume monitor — watches Pipewire audio sink for changes
// Emits value changes to trigger the OSD popup.
// ============================================================

import Quickshell.Services.Pipewire
import QtQuick

Item {
  id: root

  // ── Reactive state ──────────────────────────────────────
  readonly property var sink: Pipewire.defaultAudioSink
  readonly property bool hasSink: sink !== null && sink !== undefined
  readonly property bool isMuted: hasSink && sink.audio ? !!sink.audio.muted : false
  readonly property real volume: hasSink && sink.audio ? sink.audio.volume : 0.0
  property bool changed: false

  // ── Computed icon ───────────────────────────────────────
  readonly property string icon: {
    if (!hasSink) return "speaker-x-fill.svg";
    if (isMuted)  return "speaker-slash-fill.svg";
    if (volume > 0.66) return "speaker-high-fill.svg";
    if (volume > 0.33) return "speaker-low-fill.svg";
    return "speaker-none-fill.svg";
  }

  // ── Signals ─────────────────────────────────────────────
  signal valueChanged()

  // ── Tracker ─────────────────────────────────────────────
  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink]
  }

  // ── Connections ─────────────────────────────────────────
  Connections {
    target: Pipewire.defaultAudioSink?.audio
    function onVolumeChanged() {
      root.changed = true
      root.valueChanged()
    }
  }
}
