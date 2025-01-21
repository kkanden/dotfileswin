local wezterm = require("wezterm")

local config = {}

-- FONT
local default_font = {
	family = "JetBrainsMono Nerd Font",
	weight = "Regular",
	harfbuzz_features = { "zero" },
}
local default_font_italic = {
	family = "JetBrainsMono Nerd Font",
	weight = "Regular",
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
	Kanagawa = {
		foreground = "#DCD7BA",
		background = "#1F1F28",
		cursor_bg = "#DCD7BA",
		cursor_fg = "#1F1F28",
		cursor_border = "#DCD7BA",
		selection_fg = "#DCD7BA",
		selection_bg = "#2A2A37",
		ansi = {
			"#1F1F28", -- black
			"#E82424", -- red
			"#76946A", -- green
			"#FF9E3B", -- yellow
			"#658594", -- blue
			"#957FB8", -- purple
			"#9CABCA", -- cyan
			"#DCD7BA", -- white
		},
		brights = {
			"#4E4E66", -- bright black
			"#FF5D62", -- bright red
			"#98BB6C", -- bright green
			"#E6C384", -- bright yellow
			"#7FB4CA", -- bright blue
			"#D27E99", -- bright purple
			"#A3D4D5", -- bright cyan
			"#DCD7BA", -- bright white
		},
	},
}

config.color_scheme = "Kanagawa"

config.initial_rows = 24
config.initial_cols = 80
config.window_background_opacity = 0.85
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
}

-- GENERAL TERMINAL SETTINGS
config.show_tabs_in_tab_bar = true
config.window_decorations = "RESIZE"
config.adjust_window_size_when_changing_font_size = false
config.exit_behavior = "Close"
config.enable_tab_bar = false
config.enable_scroll_bar = false
config.window_close_confirmation = "NeverPrompt"

-- DEFAULT SHELL
config.default_prog = { "powershell", "-NoLogo" }

return config
