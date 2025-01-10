-- WezTerm config
-- https://wezfurlong.org/wezterm/config/lua/config/index.html

-- Auxiliary functions
local wezterm = require 'wezterm'
local act = wezterm.action;

function get_appearance()
  -- if wezterm.gui then
  --   return wezterm.gui.get_appearance()
  -- end
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
config.font = wezterm.font_with_fallback {
  {
    family = 'MonoLisa Variable',
    harfbuzz_features = {
      'zero', 'ss01', 'ss02', 'ss06', 'ss07', 'ss08', 'ss11', 'ss12', 'ss13', 'ss14', 'ss15', 'ss16', 'ss17'
    },
  },
  'Symbols Nerd Font Mono',
  'SF Pro Display',
}

-- Mouse bndings
config.selection_word_boundary = ' \t\n{}[]()"\'`,;:'

config.mouse_bindings = {
  -- Change the default click behavior so that it only selects
  -- text and doesn't open hyperlinks
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = act.CompleteSelection 'ClipboardAndPrimarySelection',
  },

  -- and make CMD-Click open hyperlinks
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CMD',
    action = act.OpenLinkAtMouseCursor,
  },

  -- NOTE that binding only the 'Up' event can give unexpected behaviors.
  -- Read more below on the gotcha of binding an 'Up' event only.
}

-- Key bindings
config.keys = {
  {
    -- Jump to the beginning of the line
    key = 'LeftArrow',
    mods = 'CMD',
    action = act.SendString '\x01',
  },
  {
    -- Jump to the end of the line
    key = 'RightArrow',
    mods = 'CMD',
    action = act.SendString '\x05',
  },
  {
    -- Jump to the beginning of the current word
    key = 'LeftArrow',
    mods = 'OPT',
    action = act.SendString '\x1b\x62',
  },
  {
    -- Jump to the end of the current word
    key = 'RightArrow',
    mods = 'OPT',
    action = act.SendString '\x1b\x66',
  },
  {
    -- Delete line from cursor position to start of line
    key = 'Backspace',
    mods = 'CMD',
    action = act.SendString '\x15',
  },
  {
    -- Use cmd + . to cancel the current command
    key = '.',
    mods = 'CMD',
    action = act.SendString '\x03',
  },
  {
    -- Split current pane vertically
    key = '-',
    mods = 'CMD|SHIFT',
    action = act.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    -- Split current pane horizontally
    key = '|',
    mods = 'SHIFT|CMD',
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
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

-- WezTerm settings
config.automatically_reload_config = true
config.check_for_updates = true
config.show_update_window = false
config.term = 'wezterm'

return config
