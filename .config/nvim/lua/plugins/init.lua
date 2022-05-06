local packer = require('plugins.packer-init')
local use = packer.use

return packer.startup {
  function()
    use { 'wbthomason/packer.nvim' } -- Let packer manage itself
    use { 'nvim-lua/popup.nvim' } -- An implementation of the Popup API from vim in Neovim
    use { 'nvim-lua/plenary.nvim' } -- Useful lua functions used ny lots of plugins
    use { -- fuzy finder
      'nvim-telescope/telescope.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = 'require "plugins.config.telescope"'
    }
    use { --syntax highlighting
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = 'require "plugins.config.treesitter"'
    }
    use { 'xu-cheng/brew.vim' } -- Vim Syntax for Homebrew formulae
    use { 'kyazdani42/nvim-web-devicons' } -- nvim Devicons
    use { 'github/copilot.vim' } -- GitHub Copilot
    use { -- Github theme for Neovim and Terminals written in Lua
      'projekt0n/github-nvim-theme',
      config = 'require "plugins.config.github-nvim-theme"'
    }
    use { -- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
      'nvim-lualine/lualine.nvim',
      requires = { 'projekt0n/github-nvim-theme' },
      config = 'require "plugins.config.lualine"'
    }
    use { --faster commenting
      'numToStr/Comment.nvim',
      config = 'require "plugins.config.comment"'
    }
    use { -- Git integration for buffers
      "lewis6991/gitsigns.nvim",
      requires = { 'nvim-lua/plenary.nvim' },
      config = 'require "plugins.config.gitsigns"',
    }
    use { -- A highly configurable neovim startup screen
      'startup-nvim/startup.nvim',
      requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
      config = 'require "plugins.config.startup"'
    }
    use { 'folke/which-key.nvim' } -- A plugin for Neovim that shows the available keybindings

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if _sync_packer then
      vim.api.nvim_command 'PackerSync'
      _sync_packer = nil
    end
  end
}
