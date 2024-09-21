-- https://github.com/williamboman/nvim-lsp-installer
local ok, lsp_installer = pcall(require, 'mason-lspconfig')
if not ok then
    return
end

local servers = {'bashls', 'clangd', 'cmake', 'dockerls', 'jsonls', 'lua_ls', 'perlnavigator', 'sourcery', 'ruby_lsp',
                 'salt_ls', 'yamlls'}

lsp_installer.setup {
    ensure_installed = servers, -- Ensure these servers are always installed
    automatic_installation = true, -- Automatically detect which servers to install (based on which servers are set up via lspconfig)
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
}

local ok, lspconfig = pcall(require, 'lspconfig')
if not ok then
    return
end

for _, server in ipairs(servers) do
    lspconfig[server].setup {}
end

local signs = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " "
}
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {
        text = icon,
        texthl = hl,
        numhl = hl
    })
end
