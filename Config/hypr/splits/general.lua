-- ============================================================
-- General layout - gaps, borders, resize behaviour
-- Colors are loaded from the dynamic matugen palette.
-- ============================================================

local colors = require("splits.colors")

hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 5,
		border_size = 1,
		col = {
			active_border = colors.primary,
			inactive_border = colors.outline,
		},
		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},
})
