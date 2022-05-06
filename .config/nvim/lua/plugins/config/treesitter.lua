local ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if not ok then
  return
end

treesitter.setup {
  ensure_installed = {
    'bash', 'cpp', 'cmake', 'dockerfile',
    'json', 'lua', 'perl', 'python',
    'ruby', 'swift', 'vim', 'yaml'
  },
  sync_install = false,
  ignore_install = { '' }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { '' }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,

  },
  indent = {
    enable = true,
    disable = { 'yaml' }
  },
}
