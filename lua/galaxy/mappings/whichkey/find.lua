local wk = require "which-key"
local key = "<leader>f"

wk.map = {
  key,
  group = "Find",
  icon = wk.icon { "󰈞", "yellow" },
  cond = nvim.open.picker,
  {
    key .. "b",
    "<cmd>lua nvim.open.picker('current_buffer_fuzzy_find')<cr>",
    icon = wk.icon { "󰉿" },
    desc = "Find in buffer",
  },

  {
    key .. "f",
    "<cmd>lua nvim.open.picker('find_files')<cr>",
    desc = "Find files",
  },

  {
    key .. "g",
    "<cmd>lua nvim.open.picker('git_files')<cr>",
    desc = "Find git files",
  },

  {
    key .. "r",
    "<cmd>lua nvim.open.picker('oldfiles')<cr>",
    desc = "Recent files",
  },

  {
    key .. "t",
    icon = wk.icon { "󰉿" },
    "<cmd>lua nvim.open.picker('live_grep')<cr>",
    desc = "Find text",
  },

  {
    key .. "w",
    icon = wk.icon { "󰉿" },
    "<cmd>lua nvim.open.picker('grep_string')<cr>",
    desc = "Find word",
  },
}
