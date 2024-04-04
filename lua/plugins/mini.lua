return {
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },

  {
    'echasnovski/mini.cursorword',
    config = true,
  },

  {
    'echasnovski/mini.files',
    opts = {
      windows = {
        preview = true,
        width_preview = 75,
      },
    },
    keys = {
      {
        "<leader>e",
        function()
          if not MiniFiles.close() then MiniFiles.open() end
        end,
        desc = "Toggle File Explorer",
      },
    },
  },

  {
    "echasnovski/mini.fuzzy",
    config = true,
  },

  {
    "echasnovski/mini.indentscope",
    event = "VeryLazy",
    opts = {
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

  {
    'echasnovski/mini.hipatterns',
    config = function()
      local hipatterns = require('mini.hipatterns')
      hipatterns.setup({
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
          todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
          note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end,
  },

  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>tt",
        function()
          vim.g.minipairs_disable = not vim.g.minipairs_disable
          if vim.g.minipairs_disable then
            print("Disabled auto pairs")
          else
            print("Enabled auto pairs")
          end
        end,
        desc = "Toggle auto pairs",
      },
    },
  },

  {
    'echasnovski/mini.sessions',
    config = true
  }
}
