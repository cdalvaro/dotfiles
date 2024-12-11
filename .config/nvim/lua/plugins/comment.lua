-- 🧠 💪 // Smart and powerful comment plugin for neovim.
-- Supports treesitter, dot repeat, left-right/up-down motions, hooks, and more
---@link https://github.com/numToStr/Comment.nvim

return {
  {
    "numToStr/Comment.nvim",
    opts = {
      padding = true,
      sticky = true,
      ignore = nil,
      toggler = {
        line = 'gcc',
        block = 'gbc'
      },
      opleader = {
        line = 'gc',
        block = 'gb'
      },
      mappings = {
        basic = true,
        extra = true,
        extended = false
      },
      pre_hook = nil,
      post_hook = nil
    }
  }
}
