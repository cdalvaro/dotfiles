-- WezTerm config
-- https://wezfurlong.org/wezterm/config/lua/config/index.html

-- Auxiliary functions
local wezterm = require 'wezterm'

function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return 'Dark'
end

function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'Monokai Pro (Octagon)'
  else
    return 'Monokai Pro Light'
  end
end

-- Main configuration
local config = wezterm.config_builder()

-- Colors
config.color_scheme = scheme_for_appearance(get_appearance())

-- Cursor
config.default_cursor_style = 'BlinkingBar'

-- Fonts
config.font = wezterm.font {
  family = 'MonoLisa Variable',
  harfbuzz_features = {
    'zero', 'ss01', 'ss02', 'ss06', 'ss07', 'ss08', 'ss11', 'ss12', 'ss13', 'ss14', 'ss15', 'ss16', 'ss17'
  }
}

-- macOS specific configuration
config.native_macos_fullscreen_mode = true

-- Tab bar settings
config.hide_tab_bar_if_only_one_tab = false

-- Window settings
config.initial_cols = 126
config.initial_rows = 67
config.window_close_confirmation = 'NeverPrompt'
config.window_decorations = 'MacOsNative'

-- WezTerm settings
config.automatically_reload_config = true
config.check_for_updates = true
config.show_update_window = false

return config
