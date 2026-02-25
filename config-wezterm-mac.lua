-- For wezterm to use similar to iTerm2 key
-- ~/.config/wezterm/wezterm.lua

local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font 'JetBrains Mono'
config.font_size = 10.0

config.color_scheme = 'Tokyo Night'
config.window_background_opacity = 0.9

config.keys = {
    -- Map Alt + 1 through 9 to switch to tabs 0 through 8
  { key = '1', mods = 'ALT', action = wezterm.action.ActivateTab(0) },
  { key = '2', mods = 'ALT', action = wezterm.action.ActivateTab(1) },
  { key = '3', mods = 'ALT', action = wezterm.action.ActivateTab(2) },
  { key = '4', mods = 'ALT', action = wezterm.action.ActivateTab(3) },
  { key = '5', mods = 'ALT', action = wezterm.action.ActivateTab(4) },
  { key = '6', mods = 'ALT', action = wezterm.action.ActivateTab(5) },
  { key = '7', mods = 'ALT', action = wezterm.action.ActivateTab(6) },
  { key = '8', mods = 'ALT', action = wezterm.action.ActivateTab(7) },
  { key = '9', mods = 'ALT', action = wezterm.action.ActivateTab(8) },  
  {
    -- Ctrl + Shift + Enter: toggle zoom
    key = 'Enter',
    mods = 'CMD|SHIFT',
    action = wezterm.action.TogglePaneZoomState,
  },
  {
    -- Command + Shift + D: split vertical
    key = 'D',
    mods = 'CMD|SHIFT',
    action = wezterm.action.SplitVertical({ domain = 'CurrentPaneDomain' })
  },
  {
    -- Command + ]: move to next pane
    key = ']',
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection('Next'),
  },
  {
    -- Command + [: move to next pane
    key = '[',
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection('Prev'),
  },
}

return config
