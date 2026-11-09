-- Git integration for buffers
---@link https://github.com/lewis6991/gitsigns.nvim

return {
  {
    "lewis6991/gitsigns.nvim",
    enabled = function() return vim.fn.has("nvim-0.11.0") == 1 end,
    opts = {}
  }
}
