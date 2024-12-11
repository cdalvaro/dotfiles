-- Help: https://neovim.io/doc/user/lua-guide.html
local autocmd = vim.api.nvim_create_autocmd
local utils = require('config.utils')

-- Filetype
utils.create_augroup({
  { 'BufNewFile,BufRead', 'Rexfile', 'set', 'filetype=perl' },
  { 'BufNewFile,BufRead', '*sls',    'set', 'filetype=sls' }
}, 'filetype')

-- PackerCompile
utils.create_augroup({
  { 'BufWritePost', 'plugins.lua', 'source', '<afile>', '|', 'PackerCompile' }
}, 'packer_user_config')

-- Restore terminal cursor with vertical line on exit
autocmd({ 'VimLeave' }, {
  pattern = { '*' },
  command = 'set guicursor=a:ver25'
})
