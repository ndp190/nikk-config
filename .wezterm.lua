-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Gruvbox Dark'

config.keys = {
  -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
  {key="LeftArrow", mods="OPT", action=wezterm.action{SendString="\x1bb"}},
  -- Make Option-Right equivalent to Alt-f; forward-word
  {key="RightArrow", mods="OPT", action=wezterm.action{SendString="\x1bf"}},
}

config.window_decorations = "RESIZE | INTEGRATED_BUTTONS | MACOS_FORCE_DISABLE_SHADOW"

config.font =
  -- wezterm.font 'Ac437 Verite 8x8'
  -- wezterm.font 'ProggyClean Nerd Font'
  -- wezterm.font 'Hack Nerd Font'
  -- wezterm.font 'JetBrains Mono'
  -- wezterm.font 'Iosevka Term'
  -- wezterm.font('Terminess Nerd Font', {bold=false, italic=false})
  -- wezterm.font('GohuFont uni11 Nerd Font', {bold=false, italic=false})
  -- wezterm.font('3270 Nerd Font Propo', {bold=false, italic=false})
  -- wezterm.font('DaddyTimeMono Nerd Font', {bold=false, italic=false})
  wezterm.font_with_fallback {
    'Iosevka Term',
    'JetBrains Mono',
    'Hack Nerd Font',
  }

-- and finally, return the configuration to wezterm
return config
