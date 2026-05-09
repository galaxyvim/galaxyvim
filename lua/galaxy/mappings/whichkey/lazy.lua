local wk = require "which-key"

local key = "<leader>z"

wk.map = {
  key,
  group = "Lazy",
  icon = "󰒲",
  { key .. "c", "<cmd>Lazy check<cr>", desc = "Check for updates" },
  { key .. "d", "<cmd>Lazy debug<cr>", desc = "Debug plugins" },
  { key .. "h", "<cmd>Lazy home<cr>", desc = "Open plugin homepage" },
  { key .. "x", "<cmd>Lazy clean<cr>", desc = "Clean unused plugins" },
  { key .. "i", "<cmd>Lazy install<cr>", desc = "Install plugins" },
  { key .. "s", "<cmd>Lazy show<cr>", desc = "Show plugin details" },
  { key .. "S", "<cmd>Lazy sync<cr>", desc = "Sync plugins" },
  { key .. "u", "<cmd>Lazy update<cr>", desc = "Update plugins" },
  { key .. "l", "<cmd>Lazy log<cr>", desc = "Show plugin logs" },
  { key .. "p", "<cmd>Lazy profile<cr>", desc = "Show plugin profiles" },
  { key .. "r", "<cmd>Lazy restore<cr>", desc = "Restore plugins" },
  { key .. "?", "<cmd>Lazy help<cr>", desc = "Show plugin help" },
}
