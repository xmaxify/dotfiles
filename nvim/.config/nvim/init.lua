require("config.lazy")
vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}
vim.keymap.set({ 'n', 'v' }, 'y', '"+y')
vim.keymap.set({ 'n', 'v' }, 'Y', '"+Y')
vim.keymap.set({ 'n', 'v' }, 'p', '"+p')
vim.keymap.set({ 'n', 'v' }, 'P', '"+P')

