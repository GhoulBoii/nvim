return {
  -----------------------------------------------------------------------------
  -- PYTHON REPL
  -- A basic REPL that opens up as a horizontal split
  -- - use `<leader>i` to toggle the REPL
  -- - use `<leader>I` to restart the REPL
  -- - `+` serves as the "send to REPL" operator. That means we can use `++`
  -- to send the current line to the REPL, and `+j` to send the current and the
  -- following line to the REPL, like we would do with other vim operators.
  {
    "Vigemus/iron.nvim",
    ft = "python",
    keys = {
      { "<leader>i", vim.cmd.IronRepl,             desc = "?? Toggle REPL" },
      { "<leader>I", vim.cmd.IronRestart,          desc = "?? Restart REPL" },

      -- these keymaps need no right-hand-side, since that is defined by the
      -- plugin config further below
      { "+",         mode = { "n", "x" },          desc = "?? Send-to-REPL Operator" },
      { "++",        desc = "?? Send Line to REPL" },
    },

    -- since irons's setup call is `require("iron.core").setup`, instead of
    -- `require("iron").setup` like other plugins would do, we need to tell
    -- lazy.nvim which module to via the `main` key
    main = "iron.core",

    opts = {
      keymaps = {
        send_line = "++",
        visual_send = "+",
        send_motion = "+",
      },
      config = {
        -- this defined how the repl is opened. Here we set the REPL window
        -- to open in a horizontal split to a bottom, with a height of 10
        -- cells.
        repl_open_cmd = "horizontal bot 10 split",

        -- This defines which binary to use for the REPL. If `ipython` is
        -- available, it will use `ipython`, otherwise it will use `python3`.
        -- since the python repl does not play well with indents, it's
        -- preferable to use `ipython` or `bypython` here.
        -- (see: https://github.com/Vigemus/iron.nvim/issues/348)
        repl_definition = {
          python = {
            command = function()
              local ipythonAvailable = vim.fn.executable("ipython") == 1
              local binary = ipythonAvailable and "ipython" or "python3"
              return { binary }
            end,
          },
        },
      },
    },
  },

  -----------------------------------------------------------------------------
  -- DEBUGGING

  -- DAP Client for nvim
  -- - start the debugger with `<leader>dc`
  -- - add breakpoints with `<leader>db`
  -- - terminate the debugger `<leader>dt`
  {
    "mfussenegger/nvim-dap",
    ft = "python",
    keys = {
      {
        "<leader>dc",
        function() require("dap").continue() end,
        desc = "Start/Continue Debugger",
      },
      {
        "<leader>db",
        function() require("dap").toggle_breakpoint() end,
        desc = "Add Breakpoint",
      },
      {
        "<leader>dt",
        function() require("dap").terminate() end,
        desc = "Terminate Debugger",
      },
    },
  },

  -- UI for the debugger
  -- - the debugger UI is also automatically opened when starting/stopping the debugger
  -- - toggle debugger UI manually with `<leader>du`
  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    ft = "python",
    keys = {
      {
        "<leader>du",
        function() require("dapui").toggle() end,
        desc = "Toggle Debugger UI",
      },
    },
    -- automatically open/close the DAP UI when starting/stopping the debugger
    config = function()
      local listener = require("dap").listeners
      listener.after.event_initialized["dapui_config"] = function() require("dapui").open() end
      listener.before.event_terminated["dapui_config"] = function() require("dapui").close() end
      listener.before.event_exited["dapui_config"] = function() require("dapui").close() end
    end,
  },

  -- Configuration for the python debugger
  -- - configures debugpy for us
  -- - uses the debugpy installation from mason
  {
    "mfussenegger/nvim-dap-python",
    dependencies = "mfussenegger/nvim-dap",
    ft = "python",
    config = function()
      -- uses the debugypy installation by mason
      local debugpyPythonPath = require("mason-registry").get_package("debugpy"):get_install_path()
          .. "/venv/bin/python3"
      require("dap-python").setup(debugpyPythonPath, {})
    end,
  },

  -----------------------------------------------------------------------------
  -- EDITING SUPPORT PLUGINS
  -- some plugins that help with python-specific editing operations

  -- Docstring creation
  -- - quickly create docstrings via `<leader>a`
  {
    "danymat/neogen",
    opts = true,
    keys = {
      {
        "<leader>a",
        function() require("neogen").generate() end,
        desc = "Add Docstring",
      },
    },
  },

  -- f-strings
  -- - auto-convert strings to f-strings when typing `{}` in a string
  -- - also auto-converts f-strings back to regular strings when removing `{}`
  {
    "chrisgrieser/nvim-puppeteer",
    dependencies = "nvim-treesitter/nvim-treesitter",
    ft = "python",
  },

  -- better indentation behavior
  -- by default, vim has some weird indentation behavior in some edge cases,
  -- which this plugin fixes
  { "Vimjas/vim-python-pep8-indent" },

  -- select virtual environments
  -- - makes pyright and debugpy aware of the selected virtual environment
  -- - Select a virtual environment with `:VenvSelect`
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap-python",
    },
    branch = "regexp", -- This is the regexp branch, use this for the new version
    ft = "python",
    opts = {
      dap_enabled = true, -- makes the debugger work with venv
    },
    keys = {
      { "<leader>v", "<cmd>VenvSelect<cr>", desc = "Select venv" },
    },
  },
}
