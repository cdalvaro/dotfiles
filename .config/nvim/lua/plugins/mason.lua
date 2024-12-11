-- https://github.com/williamboman/nvim-lsp-installer

local lsps = { 'bashls', 'dockerls', 'jsonls', 'salt_ls', 'yamlls' }
if vim.fn.has('mac') == 1 then
  local extra_lsps = { 'clangd', 'cmake', 'perlnavigator', 'sourcery', 'ruby_lsp', 'lua_ls' }
  for _, v in ipairs(extra_lsps) do
    table.insert(lsps, v)
  end
end

return {
  {
    "williamboman/mason.nvim",
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
    "williamboman/mason-lspconfig.nvim",
    enabled = function() return vim.fn.has("nvim-0.9.0") == 1 end,
    opts = {
      ensure_installed = lsps,      -- Ensure these servers are always installed
      automatic_installation = true -- Automatically detect which servers to install (based on which servers are set up via lspconfig)
    }
  },
  {
    "neovim/nvim-lspconfig",
    enabled = function() return vim.fn.has("nvim-0.9.0") == 1 end,
  },
}
