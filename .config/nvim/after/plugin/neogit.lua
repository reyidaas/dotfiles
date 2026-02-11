local neogit = require('neogit');

neogit.setup({
  kind = 'floating'
})

vim.keymap.set('n', '<leader>,g', neogit.open, { desc = 'Open Neogit UI' })
