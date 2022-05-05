-- Help: https://github.com/nanotee/nvim-lua-guide

local cmd = vim.cmd
local fn = vim.fn

local u = require('utils')

-- filetype
u.create_augroup({
  { 'BufNewFile,BufRead', 'Rexfile', 'set', 'filetype=perl' },
  { 'BufNewFile,BufRead', '*sls', 'set', 'filetype=yaml' }
}, 'filetype')

-- Python provider
vim.g.loaded_python_provider=0
vim.g.python3_host_prog = vim.env.HOMEBREW_PREFIX .. '/bin/python3'

-- Clipboard
if fn.has 'mac' then
  vim.o.clipboard = 'unnamed'
else
  vim.o.clipboard = 'unnamedplus'
end

-- Global settings
vim.o.ignorecase = true       -- Use case insensitive search pattern matching by default
vim.o.incsearch = true        -- Incrementally highlight search pattern as it is updated
vim.o.laststatus = 2          -- Always show the status bar
vim.o.smartcase = true        -- Override 'ignorecase' setting if search pattern contains uppercase characters
vim.o.magic = true            -- Allow special characters in regex patterns
vim.o.termguicolors = true    -- enable truecolors

-- make backspace work like most other programs
-- https://vim.fandom.com/wiki/Backspace_and_delete_problems
vim.o.backspace = 2

-- tabs
vim.o.shiftwidth = 2          -- Indent by 4 spaces
vim.o.tabstop = 2             -- Hard tab stop
vim.o.softtabstop = 2         -- Soft tab stop
vim.o.smarttab = true         -- Use smart tabulation