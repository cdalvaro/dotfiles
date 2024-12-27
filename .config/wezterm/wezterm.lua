local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Monokai Pro (Gogh)'

config.font = wezterm.font {
  family = 'MonoLisa Variable',
  harfbuzz_features = { 'zero', 'ss01', 'ss02', 'ss06', 'ss07', 'ss08', 'ss11', 'ss12', 'ss13', 'ss14', 'ss15', 'ss16', 'ss17' }
}

config.automatically_reload_config = true

config.default_cursor_style = 'BlinkingBar'

config.check_for_updates = true
config.show_update_window = false

return config

