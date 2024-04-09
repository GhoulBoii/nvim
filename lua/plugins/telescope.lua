return {
  'nvim-telescope/telescope.nvim',
  cmd = "Telescope",
  tag = '0.1.6',
  dependencies = {
    'nvim-lua/plenary.nvim',
    "nvim-telescope/telescope-fzy-native.nvim",
    'debugloop/telescope-undo.nvim',
    'jvgrootveld/telescope-zoxide',
  },
  keys = {
    {
      "<leader>,",
      "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
      desc = "Switch Buffer",
    },
    { "<leader>fg", "<cmd>Telescope git_files<cr>",                 desc = "Find Files (git-files)" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>",                  desc = "Recent" },
    -- git
    { "<leader>gc", "<cmd>Telescope git_commits<CR>",               desc = "Commits" },
    { "<leader>gs", "<cmd>Telescope git_status<CR>",                desc = "Status" },
    -- search
    { '<leader>s"', "<cmd>Telescope registers<cr>",                 desc = "Registers" },
    { "<leader>sa", "<cmd>Telescope autocommands<cr>",              desc = "Auto Commands" },
    { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
    { "<leader>sc", "<cmd>Telescope command_history<cr>",           desc = "Command History" },
    { "<leader>sC", "<cmd>Telescope commands<cr>",                  desc = "Commands" },
    { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>",       desc = "Document Diagnostics" },
    { "<leader>sD", "<cmd>Telescope diagnostics<cr>",               desc = "Workspace Diagnostics" },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>",                 desc = "Help Pages" },
    { "<leader>sH", "<cmd>Telescope highlights<cr>",                desc = "Search Highlight Groups" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>",                   desc = "Key Maps" },
    { "<leader>sM", "<cmd>Telescope man_pages<cr>",                 desc = "Man Pages" },
    { "<leader>sm", "<cmd>Telescope marks<cr>",                     desc = "Jump to Mark" },
    { "<leader>so", "<cmd>Telescope vim_options<cr>",               desc = "Options" },
    { "<leader>sR", "<cmd>Telescope resume<cr>",                    desc = "Resume" },
    { "<leader>st", "<cmd>Telescope<cr>",                           desc = "Main Window" },
    { "<leader>su", "<cmd>Telescope undo<cr>",                      desc = "Undo" },
    { "<leader>sz", "<cmd>Telescope zoxide list<cr>",               desc = "Zoxide" },
  },
  config = function()
    local z_utils = require("telescope._extensions.zoxide.utils")

    require('telescope').setup {
      defaults = {
        mappings = {
          i = {
            ['<C-p>'] = require('telescope.actions.layout').toggle_preview,
          }
        },

        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--trim"
        },

        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = { prompt_position = "top", preview_width = 0.55, results_width = 0.8 },
          vertical = { mirror = false },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 5
        },
      },
      extensions = {
        undo = {
          use_delta = true,     -- this is the default
          side_by_side = false, -- this is the default
          mappings = {          -- this whole table is the default
            i = {
              -- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
              -- you want to use the following actions. This means installing as a dependency of
              -- telescope in it's `requirements` and loading this extension from there instead of
              -- having the separate plugin definition as outlined above. See issue #6.
              ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
              ["<C-cr>"] = require("telescope-undo.actions").restore,
            },
          },
        },
        zoxide = {
          mappings = {
            default = {
              after_action = function(selection)
                print("Update to (" .. selection.z_score .. ") " .. selection.path)
              end
            },
          },
        },

        fzy_native = {
          override_generic_sorter = true,
        }
      },
    }
    require("telescope").load_extension("fzy_native")
    require("telescope").load_extension("undo")
    require("telescope").load_extension("zoxide")
  end,
}
