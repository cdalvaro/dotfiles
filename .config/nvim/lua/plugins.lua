-- Auto install plugin manager

local cmd = vim.cmd
local env = vim.env
local execute = vim.api.nvim_command
local fn = vim.fn
local keymap = vim.api.nvim_set_keymap

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
  execute 'packadd packer.nvim'
end

cmd 'packadd packer.nvim'

local utils = require('utils')
utils.create_augroup({
  { 'BufWritePost', 'plugins.lua', 'source', '<afile>', '|', 'PackerCompile' }
}, 'packer_user_config')

require 'packer'.startup {
  function(use)

    -- Let packer manage itself
    use 'wbthomason/packer.nvim'

    ---------------------

    -- Load on a combination of conditions: specific filetypes or commands
    -- Also run code after load (see the "config" key)
    use {
      'w0rp/ale',
      cmd = 'ALEEnable',
      config = 'vim.cmd[[ALEEnable]]',
      setup = function()
        -- ALE linter - https://github.com/w0rp/ale
        -- Enable completion where available
        vim.g.ale_completion_enabled = 1
        vim.g.ale_completion_autoimport = 1
        vim.g.ale_sign_error = '❌'
        vim.g.ale_sign_warning = '⚠️'
        vim.g.ale_fix_on_save = 1
        vim.g.ale_linters_explicit = 1
        vim.g.ale_linters = {
          ruby = { 'rubocop' }
        }
        vim.g.ale_fixers = {
          ['*'] = { 'remove_trailing_lines', 'trim_whitespace' },
          ruby = { 'rubocop' }
        }
      end
    }

    -- Vim Syntax for Homebrew formulae
    use {
      'xu-cheng/brew.vim'
    }

    -- GitHub Copilot
    use {
      'github/copilot.vim'
    }

    -- GitHub nvim theme
    -- https://github.com/projekt0n/github-nvim-theme
    use {
      'projekt0n/github-nvim-theme',
      config = function()
        require 'github-theme'.setup {
          theme_style = "dimmed",
          function_style = "italic",

          -- Change the "hint" color to the "orange" color, and make the "error" color bright red
          colors = { hint = "orange", error = "#ff0000" },

          -- Overwrite the highlight groups
          overrides = function(c)
            return {
              htmlTag = { fg = c.red, bg = "#282c34", sp = c.hint, style = "underline" },
              DiagnosticHint = { link = "LspDiagnosticsDefaultHint" },
              -- this will remove the highlight groups
              TSField = {},
            }
          end
        }
      end
    }

    -- Status line
    -- https://github.com/nvim-lualine/lualine.nvim
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'projekt0n/github-nvim-theme' },
      config = function()
        require 'lualine'.setup {
          options = {
            theme = 'github_dimmed',
            globalstatus = true
          }
        }
      end
    }

    -- Comment
    use {
      'tpope/vim-commentary',
      keys = {
        { 'n', 'gc' },
        { 'v', 'gc' }
      },
      cmd = {
        'Commentary'
      }
    }

    -- nvim Devicons
    use {
      'kyazdani42/nvim-web-devicons'
    }

    -- Fugitive is the premier Vim plugin for Git
    use {
      'tpope/vim-fugitive'
    }

    -- Things you can do with fzf and Vim
    use {
      'ibhagwan/fzf-lua',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = function()
        vim.api.nvim_set_keymap('n', '<c-P>', ":FzfLua files<CR>", { noremap = true, silent = true })
      end
    }

    -- A collection of language packs for Vim
    use {
      'sheerun/vim-polyglot'
    }

    -- This plugin provides a start screen for Vim and Neovim
    use {
      'mhinz/vim-startify'
    }

    use {
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    }

    ---------------------

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      execute 'PackerSync'
    end
  end,
  config = {
    luarocks = {
      python_cmd = env.HOMEBREW_PREFIX .. '/bin/python3' -- Set the python command to use for running hererocks
    }
  }
}
