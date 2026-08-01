-- ============================================================
-- Matugen template: Hyprland colors (Lua module)
-- Used by general.lua via: local colors = require("splits.colors")
-- Fields: primary, on_primary, primary_container, secondary,
-- surface, outline.
-- ============================================================

return {
    primary             = "rgba({{colors.primary.default.hex_stripped}}ff)",
    on_primary          = "rgba({{colors.on_primary.default.hex_stripped}}ff)",
    primary_container   = "rgba({{colors.primary_container.default.hex_stripped}}ff)",
    secondary           = "rgba({{colors.secondary.default.hex_stripped}}ff)",
    surface             = "rgba({{colors.surface.default.hex_stripped}}ff)",
    outline             = "rgba({{colors.outline.default.hex_stripped}}ff)",
}
