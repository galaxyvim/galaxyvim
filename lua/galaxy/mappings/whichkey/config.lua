local wk = require "which-key"
local key = "<leader>k"

wk.map = {
  key,
  group = "Config",
  icon = wk.icon { "", "blue" },
  {
    key .. "e",
    "<cmd>EditConf project<cr>",
    desc = "Explore",
  },

  {
    key .. "c",
    desc = "Edit Configs",
    "<cmd>EditConf configs<cr>",
  },

  {
    key .. "o",
    desc = "Edit Options",
    "<cmd>EditConf options<cr>",
  },

  {
    key .. "p",
    desc = "Edit Plugins",
    "<cmd>EditConf plugins<cr>",
  },

  {
    key .. "t",
    desc = "Edit Presets",
    "<cmd>EditConf presets<cr>",
  },

  {
    key .. "s",
    desc = "Edit Settings",
    "<cmd>EditConf settings<cr>",
  },

  {
    key .. "b",
    desc = "Edit Bootstrap",
    "<cmd>EditConf bootstrap<cr>",
  },

  {
    key .. "m",
    desc = "Edit Mappings",
    "<cmd>EditConf mappings<cr>",
  },
}
