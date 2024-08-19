return {
  {
    {
      'akinsho/toggleterm.nvim',
      keys = {
        { "<leader>tt", "<cmd>ToggleTerm<cr>",            desc = "Terminal" },
        { "<leader>tg", "<cmd>lua _lazygit_toggle()<CR>", desc = "Lazygit" }
      },
      config = function()
        function _G.set_terminal_keymaps()
          local opts = { buffer = 0 }
          vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
          vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
          vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
          vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
          vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
          vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
          vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
        end

        -- if you only want these mappings for toggle term use term://*toggleterm#* instead
        vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
        local Terminal = require("toggleterm.terminal").Terminal
        local lazygit = Terminal:new({ cmd = "lazygit", direction = "float", hidden = true })

        function _lazygit_toggle()
          lazygit:toggle()
        end

        local node = Terminal:new({ cmd = "node", hidden = true })

        function _NODE_TOGGLE()
          node:toggle()
        end

        local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })

        function _NCDU_TOGGLE()
          ncdu:toggle()
        end

        local htop = Terminal:new({ cmd = "htop", hidden = true })

        function _HTOP_TOGGLE()
          htop:toggle()
        end

        local python = Terminal:new({ cmd = "python", hidden = true })

        function _PYTHON_TOGGLE()
          python:toggle()
        end

        require("toggleterm").setup()
      end
    }
  },
}
