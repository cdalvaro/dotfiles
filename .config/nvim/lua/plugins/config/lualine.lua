-- https://github.com/nvim-lualine/lualine.nvim

local ok, lualine = pcall(require, 'lualine')
if not ok then
  return
end

lualine.setup {
  options = {
    theme = 'catppuccin',
    globalstatus = true,
  }
}

return lualine
