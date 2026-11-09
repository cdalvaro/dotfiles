-- Nvim Treesitter configurations and abstraction layer
---@link https://github.com/nvim-treesitter/nvim-treesitter

-- Neovim already ships its own precompiled parsers, paired with its bundled
-- queries, for: c, lua, markdown, markdown_inline, query, vim, vimdoc.
-- Installing a different (newer) copy of those via nvim-treesitter shadows
-- Neovim's version in the runtimepath and can break highlighting when the
-- grammars drift apart (e.g. renamed fields), so they're excluded here.
local ensure_installed = {
  "bash",
  "cpp",
  "cmake",
  "diff",
  "dockerfile",
  "html",
  "javascript",
  "jsdoc",
  "json",
  "jsonc",
  "luadoc",
  "luap",
  "perl",
  "printf",
  "python",
  "regex",
  "ruby",
  "swift",
  "toml",
  "tsx",
  "typescript",
  "xml",
  "yaml",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false, -- this plugin does not support lazy-loading, see the plugin's README
    build = ":TSUpdate",
    enabled = function() return vim.fn.has("nvim-0.12") == 1 end,
    dependencies = {
      "OXY2DEV/markview.nvim",
    },
    config = function()
      require("nvim-treesitter").install(ensure_installed)

      -- Highlighting and indentation are provided by Neovim/this plugin but
      -- are no longer enabled through a declarative `opts` table on `main`.
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          if pcall(vim.treesitter.start) then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  }
}
