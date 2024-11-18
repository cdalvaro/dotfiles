-- https://github.com/williamboman/nvim-lsp-installer
local ok, mason = pcall(require, 'mason')
if not ok then
    return
end

mason.setup {
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
}

local ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not ok then
    return
end

local lsps = {'bashls', 'dockerls', 'jsonls', 'lua_ls', 'salt_ls', 'yamlls'}
if vim.fh.has 'mac' then
    local extra_lsps = {'clangd', 'cmake', 'perlnavigator', 'sourcery', 'ruby_lsp'}
    for _, v in ipairs(extra_lsps) do
        table.insert(lsps, v)
    end
end

local servers = mason_lspconfig.setup {
    ensure_installed = lsps, -- Ensure these servers are always installed
    automatic_installation = true -- Automatically detect which servers to install (based on which servers are set up via lspconfig)
}
