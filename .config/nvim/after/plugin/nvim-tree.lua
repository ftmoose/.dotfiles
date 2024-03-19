vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local nvimtree = require('nvim-tree')

nvimtree.setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})


vim.keymap.set('n', '<leader>kd', vim.cmd.NvimTreeFindFileToggle)
vim.keymap.set('n', '<leader>kf', vim.cmd.NvimTreeFocus)
