-- Help: https://neovim.io/doc/user/lua-guide.html
local autocmd = vim.api.nvim_create_autocmd
local utils = require('config.utils')

-- Filetype
utils.create_augroup({
  { 'BufNewFile,BufRead', 'Rexfile', 'set', 'filetype=perl' },
  { 'BufNewFile,BufRead', '*sls',    'set', 'filetype=sls' }
}, 'filetype')

-- Lazy.nvim autoupdate
-- https://github.com/folke/lazy.nvim/issues/702
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

autocmd("VimEnter", {
  group = augroup("autoupdate"),
  callback = function()
    if require("lazy.status").has_updates then
      require("lazy").update({ show = false, })
    end
  end,
})

-- Restore terminal cursor with vertical line on exit
autocmd({ 'VimLeave' }, {
  pattern = { '*' },
  command = 'set guicursor=a:ver25'
})
