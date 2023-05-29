-- https://github.com/Mofiqul/dracula.nvim

local ok, dracula = pcall(require, 'dracula')
dracula.setup({
  -- show the '~' characters after the end of buffers
  show_end_of_buffer = false,
  -- use transparent background
  transparent_bg = true,
  -- set custom lualine background color
  lualine_bg_color = "#44475a",
  -- set italic comment
  italic_comment = true,
})

vim.cmd[[colorscheme dracula]]
