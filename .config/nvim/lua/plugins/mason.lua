-- https://github.com/mason-org/mason-lspconfig.nvim

local lsps = { 'bashls', 'dockerls', 'jsonls', 'yamlls' }
if vim.fn.has('mac') == 1 then
  local extra_lsps = { 'clangd', 'perlnavigator', 'sourcery', 'ruby_lsp', 'lua_ls' }
  for _, v in ipairs(extra_lsps) do
    table.insert(lsps, v)
  end
end

return {
  {
    "mason-org/mason.nvim",
    enabled = function() return vim.fn.has("nvim-0.9.0") == 1 end,
    opts = {
      ui = {
        icons = {
          server_installed = "✓",
          server_pending = "➜",
          server_uninstalled = "✗"
        }
      }
    }
  },
  {
    ---@link https://github.com/williamboman/mason-lspconfig.nvim
    "mason-org/mason-lspconfig.nvim",
    enabled = function() return vim.fn.has("nvim-0.11.0") == 1 end,
    opts = {
      ensure_installed = lsps -- Ensure these servers are always installed
    }
  },
  {
    "neovim/nvim-lspconfig",
    enabled = function() return vim.fn.has("nvim-0.11.3") == 1 end,
  },
}
