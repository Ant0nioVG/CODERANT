-- ============================================================
-- Window decorations, shadows & blur
-- ============================================================

hl.config({
	decoration = {
		rounding = 3,
		rounding_power = 2,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		shadow = {
			enabled = false,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},
		blur = {
			enabled = true,
			size = 10,
			passes = 2,
			vibrancy = 0.1696,
		},
	},
})
