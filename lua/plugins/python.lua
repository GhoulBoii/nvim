return {
  -- REPL
  {
    "Vigemus/iron.nvim",
    ft = "python",
    keys = {
      { "<leader>i", vim.cmd.IronRepl,             desc = "?? Toggle REPL" },
      { "<leader>I", vim.cmd.IronRestart,          desc = "?? Restart REPL" },

      { "+",         mode = { "n", "x" },          desc = "?? Send-to-REPL Operator" },
      { "++",        desc = "?? Send Line to REPL" },
    },
    main = "iron.core",
    opts = {
      keymaps = {
        send_line = "++",
        visual_send = "+",
        send_motion = "+",
      },
      config = {
        repl_open_cmd = "horizontal bot 10 split",

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

  -- DEBUGGING
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
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"
    },
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

  -- Docstring creation
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
  {
    "chrisgrieser/nvim-puppeteer",
    dependencies = "nvim-treesitter/nvim-treesitter",
    ft = "python",
  },

  -- better indentation behavior
  { "Vimjas/vim-python-pep8-indent" },

  -- select virtual environments
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap-python",
    },
    branch = "regexp",
    ft = "python",
    opts = {
      dap_enabled = true,
    },
    keys = {
      { "<leader>v", "<cmd>VenvSelect<cr>", desc = "Select venv" },
    },
  },
}
