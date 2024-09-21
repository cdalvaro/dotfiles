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

local servers = mason_lspconfig.setup {
    ensure_installed = {'bashls', 'clangd', 'cmake', 'dockerls', 'jsonls', 'lua_ls', 'perlnavigator', 'sourcery',
                        'ruby_lsp', 'salt_ls', 'yamlls'}, -- Ensure these servers are always installed
    automatic_installation = true -- Automatically detect which servers to install (based on which servers are set up via lspconfig)
}
