local packer = require('plugins.packer-init')
local use = packer.use

local fn = vim.fn

return packer.startup {function()
    use {'wbthomason/packer.nvim'} -- Let packer manage itself

    -- Theme
    -- use { -- Github theme for Neovim and Terminals written in Lua
    --  'projekt0n/github-nvim-theme',
    --  config = 'require "plugins.config.github-theme"'
    -- }
    use {
        'Mofiqul/dracula.nvim',
        config = 'require "plugins.config.dracula"'
    }

    use {'nvim-lua/popup.nvim'} -- An implementation of the Popup API from vim in Neovim
    use {'nvim-lua/plenary.nvim'} -- Useful lua functions used ny lots of plugins
    -- NOTE: Telescope is only available for NeoVim 0.9 and above
    if fn.has("nvim-0.9") == 1 then
        use { -- Fuzzy finder
            'nvim-telescope/telescope.nvim',
            requires = {'nvim-lua/plenary.nvim'},
            config = 'require "plugins.config.telescope"'
        }
        use { -- Syntax highlighting
            'nvim-treesitter/nvim-treesitter',
            -- To avoid :TSUpdate to fail upon first installation
            -- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation#packernvim
            run = function()
                local ts_update = require('nvim-treesitter.install').update({
                    with_sync = true
                })
                ts_update()
            end,
            config = 'require "plugins.config.treesitter"'
        }
        use { -- Git integration for buffers
            'lewis6991/gitsigns.nvim',
            requires = {'nvim-lua/plenary.nvim'},
            config = 'require "plugins.config.gitsigns"'
        }
    end
    use { -- Neovim plugin that allows you to seamlessly manage LSP servers with :LspInstall.
        'williamboman/mason.nvim',
        requires = {
            {'williamboman/mason-lspconfig.nvim'},
            {'neovim/nvim-lspconfig'},
        },
        config = 'require "plugins.config.mason"'
    }
    use {
        'jose-elias-alvarez/null-ls.nvim',
        requires = {'nvim-lua/plenary.nvim'}
    }
    use {'kyazdani42/nvim-web-devicons'} -- nvim Devicons
    use { -- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
        'nvim-lualine/lualine.nvim',
        requires = {'projekt0n/github-nvim-theme'},
        config = 'require "plugins.config.lualine"'
    }
    use { -- faster commenting
        'numToStr/Comment.nvim',
        config = 'require "plugins.config.comment"'
    }

    if fn.has 'mac' then
        use {'xu-cheng/brew.vim'} -- Vim Syntax for Homebrew formulae
        use { -- Vim plugin for clang-format
            'rhysd/vim-clang-format',
            config = 'require "plugins.config.clang-format"'
        }
        use { -- Markdown preview for neovim using pandoc and live-server
            'davidgranstrom/nvim-markdown-preview',
            config = 'require "plugins.config.markdown-preview"'
        }
    end

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if _sync_packer then
        vim.api.nvim_command 'PackerSync'
        _sync_packer = nil
    end
end}
