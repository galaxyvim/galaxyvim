local wk = require "which-key"

wk.map = {
  "<leader>b",
  group = "Buffer",
  proxy = "<C-b>",
  {
    "<leader>b.",
    icon = wk.icon { "󰈤", "cyan" },
    "<cmd>lua Snacks.scratch()<cr>",
    desc = "Scratch buffer",
  },
}
