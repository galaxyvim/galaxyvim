local wk = require "which-key"
local key = "<leader>t"

-- terminal
wk.map = {
  key,
  icon = wk.icon { "", "green" },
  cond = nvim.open.terminal,
  group = "Terminal",
  {
    key .. "h",
    "<cmd>ToggleTerm direction=horizontal<cr>",
    desc = "Open Horizontal",
  },
  {
    key .. "v",
    "<cmd>ToggleTerm direction=vertical<cr>",
    desc = "Open Vertical",
  },
  {
    key .. "f",
    "<cmd>ToggleTerm direction=float<cr>",
    desc = "Open Float",
  },
  {
    key .. "t",
    "<cmd>ToggleTerm direction=tab<cr>",
    desc = "Open Tab",
  },
  {
    key .. "o",
    "<cmd>terminal<cr>",
    desc = "Open Terminal",
  },

  {
    "<leader>tr",
    icon = wk.icon { "" },
    group = "REPL",

    { key .. "rp", "<cmd>Repl python<cr>", desc = "Python REPL" },
    { key .. "rj", "<cmd>Repl java<cr>", desc = "Java REPL" },
    { key .. "rn", "<cmd>Repl node<cr>", desc = "Node REPL" },
    { key .. "rr", "<cmd>Repl ruby<cr>", desc = "Ruby REPL" },
    { key .. "rl", "<cmd>Repl lua<cr>", desc = "Lua REPL" },
  },
}
