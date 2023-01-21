-- Bootstrapping lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

-- Plugins
require("lazy").setup({
  -- Essentials
  "nvim-lua/plenary.nvim",

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPre",
    config = function ()
      require('plugins.treesitter')
    end
  },

  -- Telescope
  -- TODO: Configure Telescope
  {
    "nvim-telescope/telescope.nvim",
    config = function ()
      require('plugins.telescope')
    end
  },

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },

  'debugloop/telescope-undo.nvim',
  'jvgrootveld/telescope-zoxide',
  "nvim-telescope/telescope-file-browser.nvim",

  -- LSP 
  {
    'VonHeikemen/lsp-zero.nvim',
    dependencies = {
      -- LSP Support
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Autocompletion
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',

      -- Snippets
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
    },
    config = function ()
      require('plugins.lsp')
    end
  },

  -- Extra
  -- TODO: Finish configuration for extra plugins
  {
    'echasnovski/mini.nvim',
    config = function ()
      require("plugins.mini")
    end
  },

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
      require("plugins.whichkey")
    end
  },

  {
    'toppair/peek.nvim',
    build = 'deno task --quiet build:fast',
    config = function ()
      require('plugins.peek')
    end
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require('plugins.indent')
    end
  },

  -- Customisation
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup()
    end
  },
  {
    "folke/todo-comments.nvim",
    config = function()
      require('plugins.todo')
    end
  },

  {
    'kdheepak/tabline.nvim',
    config = function()
      require('plugins.tabline')
    end
  },

  {
    "nvim-lualine/lualine.nvim",
    config = function ()
      require('plugins.statusline')
    end
  },
  {
	  "folke/tokyonight.nvim",
	  lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('plugins.tokyonight')
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
})
