-- ============================================================
-- Window and layer rules
-- Floats, blur, and behaviour overrides for specific apps.
-- ============================================================

-- Floating tool windows (e.g. btop, pulsemixer)
hl.window_rule({
	match = {
		class = "floating-tool",
	},
	float = true,
	size = { 800, 600 },
	center = true,
})

-- Suppress maximize events globally to prevent issues
local suppressMaximizeRule = hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

-- Fix empty XWayland drag windows (no class/title)
hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

-- ── Layer rules (background blur for UI panels) ───────────

hl.layer_rule({
	name = "quickshell-blur",
	match = { namespace = "quickshell" },
	blur = true,
	ignore_alpha = 0,
})

hl.layer_rule({
	match = { namespace = "swaync-control-center" },
	name = "swaync-control-center",
	blur = true,
	ignore_alpha = 0,
})

hl.layer_rule({
	match = { namespace = "swaync-notification-window" },
	name = "swaync-notification-window",
	blur = true,
	ignore_alpha = 0,
})

hl.layer_rule({
	match = { namespace = "wofi" },
	name = "wofi",
	blur = true,
	ignore_alpha = 0,
})

hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },
	move = "20 monitor_h-120",
	float = true,
})
