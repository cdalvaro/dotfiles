
-- Auto install plugin manager

local env = vim.env
local execute = vim.api.nvim_command
local fn = vim.fn
local cmd = vim.cmd

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

return require 'packer'.startup {
  function(use)

    -- Let packer manage itself
    use {
      'wbthomason/packer.nvim',
      config = function()
        cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
      end
    }

    ---------------------

    -- nvim GitHub theme
    -- https://github.com/projekt0n/github-nvim-theme
    use {
      'projekt0n/github-nvim-theme',
      config = function()
        require 'github-theme'.setup {
          theme_style = "dimmed",
          function_style = "italic",

          -- Change the "hint" color to the "orange" color, and make the "error" color bright red
          colors = {hint = "orange", error = "#ff0000"},

          -- Overwrite the highlight groups
          overrides = function(c)
            return {
              htmlTag = {fg = c.red, bg = "#282c34", sp = c.hint, style = "underline"},
              DiagnosticHint = {link = "LspDiagnosticsDefaultHint"},
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
      config = function()
        require 'lualine'.setup {
          options = {
            theme = 'github_dimmed',
            globalstatus = true
          }
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
      python_cmd = env.HOMEBREW_PREFIX..'/bin/python3' -- Set the python command to use for running hererocks
    }
  }
}
