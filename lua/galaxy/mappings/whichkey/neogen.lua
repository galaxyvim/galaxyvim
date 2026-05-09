local wk = require "which-key"
local key = "<leader>n"

wk.map = {
  key,
  cond = nvim.plugins.neogen.enabled,
  icon = "󰺳",
  group = "Neogen",

  {
    key .. "n",
    "<cmd>Neogen<cr>",
    desc = "Auto",
  },

  {
    key .. "c",
    "<cmd>Neogen function<cr>",
    desc = "Class",
  },

  {
    key .. "f",
    "<cmd>Neogen function<cr>",
    desc = "Function",
  },

  {
    key .. "F",
    "<cmd>Neogen file<cr>",
    desc = "File",
  },

  {
    key .. "t",
    "<cmd>Neogen type<cr>",
    desc = "Type",
  },
}
