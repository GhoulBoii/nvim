return {
  {
    "nvim-lua/plenary.nvim",
    lazy = true
  },

  -- Telescope
  -- TODO: Configure Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      'debugloop/telescope-undo.nvim',
      'jvgrootveld/telescope-zoxide',
    },
    -- config = function ()
    --   require('plugins.telescope')
    -- end
  },

  -- Extra
  -- TODO: Finish configuration for extra plugins
  'lambdalisue/suda.vim',

  {
    "ahmedkhalf/project.nvim",
    config = function ()
      require("project_nvim").setup {}
    end
  },

  {
    "folke/which-key.nvim",
    config = function ()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      -- require("plugins.whichkey")
    end
  },

  {
    'toppair/peek.nvim',
    build = 'deno task --quiet build:fast',
    config = function ()
      -- require('plugins.peek')
    end
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      -- require('plugins.indent')
    end
  },

  -- Customisation
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      -- require('gitsigns').setup()
    end
  },
}
