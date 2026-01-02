local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

-- default terminal
config.default_prog = { "C:\\Users\\krivanov\\AppData\\Local\\Programs\\Git\\bin\\bash.exe", "-i", "-l" }

-- scrollbar
config.enable_scroll_bar = true

-- tabs
config.enable_tab_bar = true

-- cursor
config.default_cursor_style = "SteadyBar"

-- font
config.font = wezterm.font("GeistMono Nerd Font Mono", { weight = "Medium" })
config.font_size = 14

-- sanity wezterm settings
config.warn_about_missing_glyphs = false
config.window_close_confirmation = "NeverPrompt"
config.audible_bell = "Disabled"

-- colors
config.colors = {
  background = "#1D2021",
  foreground = "#858585",
  cursor_bg = "#858585",      -- match foreground
  cursor_border = "#858585",  -- match foreground
  cursor_fg = "#1D2021",      -- background for contrast
  selection_bg = "#665C54",
  selection_fg = "#EBDBB2",
  ansi = {
    "#1B1B1B", -- black
    "#EA6962", -- red
    "#8AB485", -- green
    "#CDA668", -- yellow
    "#83A598", -- blue
    "#B16286", -- purple
    "#689D6A", -- cyan
    "#A89984", -- white
  },
  brights = {
    "#928374", -- brightBlack
    "#EA6962", -- brightRed
    "#689D6A", -- brightGreen
    "#CDA668", -- brightYellow
    "#769589", -- brightBlue
    "#D3869B", -- brightPurple
    "#898E86", -- brightCyan
    "#EBDBB2", -- brightWhite
  },
}

-- keybinds
config.keys = {
  -- Paste from clipboard
  { key = 'v', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },

  -- New tab
  { key = 'n', mods = 'CTRL|SHIFT', action = act.SpawnTab 'CurrentPaneDomain' },

  -- Close tab without confirmation
  { key = 'w', mods = 'CTRL', action = act.CloseCurrentTab { confirm = false } },

  -- Previous tab
  { key = 'h', mods = 'CTRL', action = act.ActivateTabRelative(-1) },

  -- Next tab
  { key = 'l', mods = 'CTRL', action = act.ActivateTabRelative(1) },
}

return config
