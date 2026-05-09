local wk = require "which-key"
local key = "<leader>d"

wk.map = {
  key,
  cond = nvim.plugins.nvim_dap.enabled,
  group = "Debug",
  {
    key .. "b",
    "<cmd>lua require'dap'.toggle_breakpoint()<cr>",
    desc = "Breakpoint",
  },
  {
    key .. "B",
    function()
      vim.ui.input({ prompt = "Condition: " }, function(cond)
        if cond then
          require("dap").set_breakpoint(cond)
        end
      end)
    end,
    desc = "Set Breakpoint",
  },
  {
    key .. "c",
    "<cmd>lua require'dap'.continue()<cr>",
    desc = "Continue",
  },
  {
    key .. "C",
    "<cmd>lua require'dap'.run_to_cursor()<cr>",
    desc = "Run To Cursor",
  },

  {
    key .. "s",
    group = "Steps",
    {
      key .. "sb",
      "<cmd>lua require'dap'.step_back()<cr>",
      desc = "Step Back",
    },
    {
      key .. "si",
      "<cmd>lua require'dap'.step_into()<cr>",
      desc = "Step Into",
    },
    {
      key .. "so",
      "<cmd>lua require'dap'.step_over()<cr>",
      desc = "Step Over",
    },
    {
      key .. "sO",
      "<cmd>lua require'dap'.step_out()<cr>",
      desc = "Step Out",
    },
  },
  {
    key .. "d",
    "<cmd>lua require'dap'.disconnect()<cr>",
    desc = "Disconnect",
  },
  {
    key .. "S",
    "<cmd>lua require'dap'.session()<cr>",
    desc = "Session",
  },
  {
    key .. "p",
    "<cmd>lua require'dap'.pause()<cr>",
    desc = "Pause",
  },
  {
    key .. "r",
    "<cmd>lua require'dap'.repl.toggle()<cr>",
    desc = "Repl",
  },
  {
    key .. "R",
    "<cmd>lua require'dap'.restart_frame()<cr>",
    desc = "Restart",
  },

  {
    key .. "T",
    "<cmd>lua require 'dap'.terminate()<cr>",
    desc = "Terminate",
  },

  {
    key .. "q",
    "<cmd>lua require'dap'.close()<cr>",
    desc = "Quit",
  },
  {
    key .. "u",
    icon = wk.icon { "󰙵", "cyan" },
    desc = "Interface",
    {
      key .. "ui",
      "<cmd>lua require'dapui'.toggle()<cr>",
      desc = "Open Interface",
    },
    {
      key .. "uh",
      "<cmd>lua require'dapui.widgets'.hover()<cr>",
      desc = "Debugger Hover",
    },
    {
      key .. "ue",
      "<cmd>lua require'dapui'.eval()<cr>",
      desc = "Evaluate Input",
    },
  },
}
