-- Help: https://github.com/nanotee/nvim-lua-guide

local autocmd = vim.api.nvim_create_autocmd
local utils = require('utils')

-- Filetype
utils.create_augroup({
  { 'BufNewFile,BufRead', 'Rexfile', 'set', 'filetype=perl' },
  { 'BufNewFile,BufRead', '*sls', 'set', 'filetype=sls' }
}, 'filetype')

-- Restore terminal cursor with vertical line on exit
autocmd({ 'VimLeave' }, {
  pattern = { '*' },
  command = 'set guicursor=a:ver25'
})
