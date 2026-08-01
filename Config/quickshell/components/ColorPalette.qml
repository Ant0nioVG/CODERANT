// ============================================================
// Dynamic color palette — reads colors.json at runtime
// Watches the file for changes (live reload on wallpaper swap).
// Falls back to hardcoded colors until the file is loaded.
// ============================================================

import Quickshell
import Quickshell.Io
import QtQuick

Item {
  id: root
  visible: false

  // ── Hardcoded colors (fallback) ─────────────────────────
  property color primary: "#8aceff"
  property color primaryText: "#00344e"
  property color primaryContainer: "#48a5de"
  property color primaryContainerText: "#00101c"
  property color secondary: "#abcae4"
  property color secondaryText: "#123348"
  property color secondaryContainer: "#2e4c62"
  property color secondaryContainerText: "#cce7ff"
  property color tertiary: "#eab2ff"
  property color tertiaryText: "#4b1762"
  property color background: "#101417"
  property color backgroundText: "#e0e3e8"
  property color surface: "#101417"
  property color surfaceText: "#e0e3e8"
  property color surfaceVariant: "#3f484f"
  property color surfaceVariantText: "#bfc7d0"
  property color surfaceContainer: "#1c2024"
  property color outline: "#89929a"
  property color error: "#ffb4ab"
  property color errorText: "#690005"
  property color errorContainer: "#93000a"
  property color errorContainerText: "#ffdad6"

  // ── Palette apply helper ────────────────────────────────
  function applyPalette(c) {
    if (c.primary) root.primary = c.primary;
    if (c.primaryText) root.primaryText = c.primaryText;
    if (c.primaryContainer) root.primaryContainer = c.primaryContainer;
    if (c.primaryContainerText) root.primaryContainerText = c.primaryContainerText;
    if (c.secondary) root.secondary = c.secondary;
    if (c.secondaryText) root.secondaryText = c.secondaryText;
    if (c.secondaryContainer) root.secondaryContainer = c.secondaryContainer;
    if (c.secondaryContainerText) root.secondaryContainerText = c.secondaryContainerText;
    if (c.tertiary) root.tertiary = c.tertiary;
    if (c.tertiaryText) root.tertiaryText = c.tertiaryText;
    if (c.background) root.background = c.background;
    if (c.backgroundText) root.backgroundText = c.backgroundText;
    if (c.surface) root.surface = c.surface;
    if (c.surfaceText) root.surfaceText = c.surfaceText;
    if (c.surfaceVariant) root.surfaceVariant = c.surfaceVariant;
    if (c.surfaceVariantText) root.surfaceVariantText = c.surfaceVariantText;
    if (c.surfaceContainer) root.surfaceContainer = c.surfaceContainer;
    if (c.outline) root.outline = c.outline;
    if (c.error) root.error = c.error;
    if (c.errorText) root.errorText = c.errorText;
    if (c.errorContainer) root.errorContainer = c.errorContainer;
    if (c.errorContainerText) root.errorContainerText = c.errorContainerText;
  }

  // ── Live palette (colors.json, hot reload) ──────────────
  FileView {
    path: Quickshell.env("HOME") + "/.config/quickshell/colors.json"
    watchChanges: true
    onFileChanged: reload()

    onLoaded: {
      try {
        root.applyPalette(JSON.parse(text().trim()));
      } catch (e) {}
    }
  }
}
