return {
  {
    -- An implementation of the Popup API from vim in Neovim
    "nvim-lua/popup.nvim",
  },
  {
    -- Useful lua functions used by lots of plugins
    ---@link https://github.com/nvim-lua/plenary.nvim
    "nvim-lua/plenary.nvim",
  },
  {
    -- Provides Nerd Font icons (glyphs) for use by neovim plugins
    ---@link https://github.com/nvim-tree/nvim-web-devicons
    "kyazdani42/nvim-web-devicons"
  },
  {
    -- A plugin for Neovim that shows the available keybindings
    ---@link https://github.com/folke/which-key.nvim
    "folke/which-key.nvim",
    event = "VeryLazy",
    enabled = function() return vim.fn.has("nvim-0.9.4") == 1 end,
  },
  {
    -- Vim Syntax for Homebrew formulae
    "xu-cheng/brew.vim",
    enabled = function() return vim.fn.has("mac") == 1 end,
  },
}
