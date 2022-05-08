
local utils = require('utils')

utils.create_augroup({
  { 'FileType', 'c,cpp,objc', 'nnoremap', '<buffer><Leader>cf', ':<C-u>ClangFormat<CR>' },
  { 'FileType', 'c,cpp,objc', 'vnoremap', '<buffer><Leader>cf', ':ClangFormat<CR>' },
  { 'FileType', 'c,cpp,objc', 'ClangFormatAutoEnable' },
}, 'clang-format')
