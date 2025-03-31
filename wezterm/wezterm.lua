local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- FONT
local default_font = {
    family = "JetBrainsMono Nerd Font",
    weight = "Medium",
    harfbuzz_features = {},
}
local default_font_italic = {
    family = "JetBrainsMono Nerd Font",
    weight = "Medium",
    italic = true,
    harfbuzz_features = { "zero" },
}

config.font = wezterm.font(default_font)
config.font_size = 12
-- change appearance of italic font
config.font_rules = {
    {
        intensity = "Half",
        italic = true,
        font = wezterm.font(default_font_italic),
    },
}

-- THEME
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

config.color_schemes = {
    ["kanagawa"] = {
        foreground = "#dcd7ba",
        background = "#1f1f28",
        cursor_bg = "#c8c093",
        cursor_fg = "#c8c093",
        cursor_border = "#c8c093",
        selection_fg = "#c8c093",
        selection_bg = "#2d4f67",
        scrollbar_thumb = "#16161d",
        split = "#16161d",
        ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
        brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
        indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
    },
}

config.color_scheme = "kanagawa"
config.force_reverse_video_cursor = true

config.initial_rows = 24
config.initial_cols = 80
config.window_background_opacity = 0.75
config.win32_system_backdrop = "Acrylic"

-- KEYBINDINGS
config.disable_default_key_bindings = true
config.keys = {
    { key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
    { key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },
    { key = "t", mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
    { key = "w", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
    { key = "RightArrow", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(1) },
    { key = "LeftArrow", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },
    { key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
    { key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
    { key = "0", mods = "CTRL", action = wezterm.action.ResetFontSize },
    { key = "F6", action = wezterm.action.ShowTabNavigator },
}

-- GENERAL TERMINAL SETTINGS
config.max_fps = 120
config.show_tabs_in_tab_bar = true
config.window_decorations = "RESIZE"
config.adjust_window_size_when_changing_font_size = false
config.exit_behavior = "Close"
config.enable_tab_bar = false
config.enable_scroll_bar = false
config.window_close_confirmation = "NeverPrompt"

-- DEFAULT SHELL
config.default_prog = { "arch" }

return config
