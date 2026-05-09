local M = {}

M.config = function()
  return {
    "rcarriga/nvim-dap-ui",
    lazy = true,
    dependencies = {
      "nvim-nio",
      "nvim-dap",
    },
    opts = {
      auto_open = false,
      auto_close = false,
      icons = {
        expanded = nvim.icons.caret.Down,
        collapsed = nvim.icons.caret.Right,
        circular = nvim.icons.ui.Circular,
      },
      mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },
      -- Use this to override mappings for specific elements
      element_mappings = {},
      expand_lines = true,
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.33 },
            { id = "breakpoints", size = 0.17 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          size = 0.33,
          position = "right",
        },
        {
          elements = {
            { id = "repl", size = 0.45 },
            { id = "console", size = 0.55 },
          },
          size = 0.27,
          position = "bottom",
        },
      },
      controls = {
        enabled = true,
        -- Display controls in this element
        element = "repl",
        icons = {
          pause = nvim.icons.debug.Pause,
          play = nvim.icons.debug.Start,
          step_into = nvim.icons.debug.StepInto,
          step_over = nvim.icons.debug.StepOver,
          step_out = nvim.icons.debug.StepOut,
          step_back = nvim.icons.debug.StepBack,
          run_last = nvim.icons.debug.RunLast,
          terminate = nvim.icons.debug.Terminate,
        },
      },
      floating = {
        max_height = 0.9,
        max_width = 0.5, -- Floats will be treated as percentage of your screen.
        border = "rounded",
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      windows = { indent = 1 },
      render = {
        max_type_length = nil, -- Can be integer or nil.
        max_value_lines = 100, -- Can be integer or nil.
      },
    },
    config = function(_, opts)
      local dap_ok, dap = pcall(nvim.require, "dap")
      if not dap_ok then
        return
      end

      local dapui_ok, dapui = pcall(nvim.require, "dapui")
      if not dapui_ok then
        return
      end

      dapui.setup(opts)

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end

      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  }
end

return M
