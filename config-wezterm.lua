# For wezterm to use similar to iTerm2 key
# ~/.config/wezterm/wezterm.lua

local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Tokyo Night'
config.window_background_opacity = 0.9

config.keys = {
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
