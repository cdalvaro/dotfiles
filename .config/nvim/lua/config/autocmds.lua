-- Help: https://neovim.io/doc/user/lua-guide.html
local autocmd = vim.api.nvim_create_autocmd

-- Restore terminal cursor with vertical line on exit
autocmd({ 'VimLeave' }, {
  pattern = { '*' },
  command = 'set guicursor=a:ver25'
})
