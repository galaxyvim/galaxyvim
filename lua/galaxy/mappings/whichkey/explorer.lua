local wk = require "which-key"

wk.map = {
  cond = nvim.open.explorer,
  {
    "<leader>e",
    mode = { "n", "v" },
    "<cmd>lua Snacks.explorer { cwd = '.' }<cr>",
    icon = wk.icon { "󰙅" },
    desc = "Explorer",
  },
  -- explorer root
  {
    "<leader>E",
    mode = { "n", "v" },
    hidden = true,
    "<cmd>lua Snacks.explorer { cwd = (vim.fn.expand('%:p:h')) }<cr>",
    desc = "Explorer (root)",
  },
}
