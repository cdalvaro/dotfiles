-- ☄️ Highly customisable markdown(latex & inline html) previewer for Neovim
---@link https://github.com/OXY2DEV/markview.nvim

return {
  {
    "OXY2DEV/markview.nvim",
    lazy = false, -- Recommended
    -- ft = "markdown" -- If you decide to lazy-load anyway
    enabled = function() return vim.fn.has("mac") == 1 end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    }
  }
}
