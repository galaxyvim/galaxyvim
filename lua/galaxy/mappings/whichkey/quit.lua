local wk = require "which-key"
local key = "<leader>q"

wk.map = {
  key,
  mode = { "n", "v" }, -- NORMAL and VISUAL mode
  group = "Quit",
  icon = wk.icon { "", c = "red" },
  { key .. "q", ":q<CR>", desc = "Quit current window" },
  { key .. "w", ":wq<CR>", icon = "󰆓", desc = "Write & quit" },
  { key .. "a", ":qa<CR>", desc = "Quit all" },
  { key .. "!", ":q!<CR>", desc = "Quit without save" },
  { key .. "t", ":tabclose<CR>", desc = "Close current tab" },
}
