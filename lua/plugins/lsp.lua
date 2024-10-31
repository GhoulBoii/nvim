return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = "v3.x",
    lazy = true,
    config = false,
    init = function()
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },

  {
    'williamboman/mason.nvim',
    lazy = false,
    config = true,
  },

  {
    "garymjr/nvim-snippets",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = {
      friendly_snippets = true,
    },
    keys = {
      {
        "<Tab>",
        function()
          return vim.snippet.active({ direction = 1 }) and "<cmd>lua vim.snippet.jump(1)<cr>" or "<Tab>"
        end,
        expr = true,
        silent = true,
        mode = { "i", "s" },
      },
      {
        "<S-Tab>",
        function()
          return vim.snippet.active({ direction = -1 }) and "<cmd>lua vim.snippet.jump(-1)<cr>" or "<S-Tab>"
        end,
        expr = true,
        silent = true,
        mode = { "i", "s" },
      },
    },
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      "garymjr/nvim-snippets",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_cmp()

      local cmp = require('cmp')
      local cmp_action = lsp_zero.cmp_action()

      cmp.setup({
        sources = {
          { name = 'nvim_lsp' },
          { name = "snippets" },
          { name = 'buffer' },
          { name = 'path' },
        },

        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },

        formatting = lsp_zero.cmp_format({}),
        mapping = cmp.mapping.preset.insert({
          ['<Tab>'] = cmp_action.tab_complete(),
          ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          -- ['<C-f>'] = cmp_action.luasnip_jump_forward(),
          -- ['<C-b>'] = cmp_action.luasnip_jump_backward(),
        })
      })
    end
  },

  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = {
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
    },
    cmd = "Mason",
    opts = {
      ensure_installed = {
        "clangd",
        "jdtls",
        "lua_ls",
        "pyright",  -- LSP for python
        "ruff-lsp", -- linter for python (includes flake8, pep8, etc.)
        "debugpy",  -- debugger
        "black",    -- formatter
        "isort",    -- organize imports
        "taplo",    -- LSP for toml (for pyproject.toml files)
      },
    },
  },


  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'williamboman/mason-lspconfig.nvim',
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {},
      },
    },
    config = function()
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(_, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr, preserve_mappings = false })
        lsp_zero.buffer_autoformat()
      end)
      lsp_zero.set_sign_icons({
        error = '✘',
        warn = '▲',
        hint = '⚑',
        info = '»'
      })
      local opts = {
        diagnostics = {
          update_in_insert = false,
          virtual_text = {
            spacing = 4,
            source = "if_many",
            prefix = "●",
          },
        },
        inlay_hints = {
          enabled = true,
        },
      }

      vim.diagnostic.config(opts)

      require('mason-lspconfig').setup({
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
          end,
        }
      })
    end
  }
}

