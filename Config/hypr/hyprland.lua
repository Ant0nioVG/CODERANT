-- ============================================================
-- Hyprland entry point (Lua-based config)
-- Loads all split configuration modules in order.
-- ============================================================

require("splits.monitors")
require("splits.env")
require("splits.autostart")
require("splits.general")
require("splits.decorations")
require("splits.animations")
require("splits.input")
require("splits.layouts")
require("splits.misc")
require("splits.windowrules")
require("splits.keybinds")
require("splits.mediakeys")
