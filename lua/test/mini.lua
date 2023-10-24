require('mini.comment').setup()
require('mini.cursorword').setup()
require('mini.pairs').setup()
require('mini.indentscope').setup({
  symbol = '│',
  options = { try_as_border = true },
})
