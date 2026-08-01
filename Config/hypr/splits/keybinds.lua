-- ============================================================
-- Keybinds - main keybindings for Hyprland
-- Mod key: SUPER (Windows key)
-- ============================================================

local mainMod = "SUPER"
local terminal = "kitty"
local fileManager = "thunar"
local menu = "wofi --show drun"

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(
	mainMod .. " + M",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit")
)
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("swaync-client -op"))

hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("hyprshot -m output"))

hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("skwd wall toggle"))

hl.bind(
	mainMod .. " + V",
	hl.dsp.exec_cmd(
		"cliphist list | wofi --dmenu --pre-display-cmd \"echo '%s' | cut -f2-\" | cliphist decode | wl-copy"
	)
)

hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("kitty --class floating-tool -e nvim ~/Tasks/"))

hl.bind(mainMod .. " + SHIFT + K", hl.dsp.exec_cmd("kitty --class floating-tool -e nvim ~/.config/hypr/KEYBINDS.md"))

hl.bind(mainMod .. " + MOD5 + E", hl.dsp.exec_cmd("kitty --class floating-tool -e yazi"))

hl.bind(mainMod .. " + MOD5 + RETURN", hl.dsp.exec_cmd("kitty --class floating-tool"))

for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
