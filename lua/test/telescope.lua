local z_utils = require("telescope._extensions.zoxide.utils")

require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key",
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
    generic_sorter = require('mini.fuzzy').get_telescope_sorter,
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
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
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
      prompt_title = "[ Walking on the shoulders of TJ ]",
      mappings = {
        default = {
          after_action = function(selection)
            print("Update to (" .. selection.z_score .. ") " .. selection.path)
          end
        },
        ["<C-s>"] = {
          before_action = function(selection) print("before C-s") end,
          action = function(selection)
            vim.cmd("edit " .. selection.path)
          end
        },
        -- Opens the selected entry in a new split
        ["<C-q>"] = { action = z_utils.create_basic_command("split") },
      },
    },
  },
}

require("telescope").load_extension("undo")
require("telescope").load_extension("zoxide")
require('telescope').load_extension('projects')
