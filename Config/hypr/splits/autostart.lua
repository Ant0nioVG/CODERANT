-- ============================================================
-- Autostart - applications launched on Hyprland startup
-- ============================================================

hl.on("hyprland.start", function()
	-- Polkit authentication agent
	hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
	-- Session daemons
	hl.exec_cmd("uwsm app -- hypridle")
	hl.exec_cmd("uwsm app -- swaync")
	hl.exec_cmd("uwsm app -- quickshell")
	-- OSD volume / brightness overlay
	hl.exec_cmd("qs -p ~/.config/quickshell/osd/osd.qml")
	-- Wallpaper daemon
	hl.exec_cmd("uwsm app -- awww-daemon")
	-- Clipboard managers (text + image)
	hl.exec_cmd("uwsm app -- wl-paste --type text --watch cliphist store")
	hl.exec_cmd("uwsm app -- wl-paste --type image --watch cliphist store")
	hl.exec_cmd("uwsm app -- cliphist wipe")
end)
