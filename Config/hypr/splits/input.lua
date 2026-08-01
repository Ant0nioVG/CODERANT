-- ============================================================
-- Input - keyboard, mouse, touchpad
-- ============================================================

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0,
        accel_profile = "flat",
        force_no_accel = true,

        touchpad = {
            disable_while_typing = false,
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

hl.device({
    name = "",
    sensitivity = -0.4,
})
