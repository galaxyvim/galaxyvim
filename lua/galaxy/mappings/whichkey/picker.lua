local wk = require "which-key"
local key = "<leader>p"

--─────────────────────▶ wk(Picker Mappings) ◀───────────────────────────────

wk.map = {
  key,
  group = "Picker", -- group
  cond = nvim.open.picker,
  icon = "",

  {
    key .. "a",
    "<cmd>lua nvim.open.picker('man_pages')<cr>",
    desc = "Man",
  },

  {
    key .. "b",
    "<cmd>lua nvim.open.picker('buffers')<cr>",
    desc = "Buffers",
  },

  {
    key .. "c",
    "<cmd>lua nvim.open.picker('commands')<cr>",
    desc = "Commands",
  },

  {
    key .. "d",
    "<cmd>lua nvim.open.picker('command_history')<cr>",
    desc = "Command history",
  },

  {
    key .. "?",
    "<cmd>lua nvim.open.picker('help_tags')<cr>",
    icon = wk.icon { "󰋗" },
    desc = "Help",
  },

  {
    key .. "h",
    "<cmd>lua nvim.open.picker('highlights')<cr>",
    desc = "Highlights",
  },

  {
    key .. "k",
    "<cmd>lua nvim.open.picker('keymaps')<cr>",
    icon = wk.icon { "󰌌" },
    desc = "Keymaps",
  },

  {
    key .. "m",
    "<cmd>lua nvim.open.picker('marks')<cr>",
    desc = "Marks",
  },

  {
    key .. "n",
    "<cmd>Telescope notify<cr>",
    icon = "",
    cond = nvim.plugins.telescope.enabled,
    desc = "Notify",
  },

  {
    key .. "p",
    "<cmd>lua nvim.open.picker('')<cr>",
    icon = wk.icon { "󱈆" },
    desc = "Pickers",
  },

  {
    key .. "r",
    "<cmd>lua nvim.open.picker('registers')<cr>",
    desc = "Registers",
  },

  {
    key .. "s",
    cond = nvim.plugins.snacks.enabled,
    "<cmd>lua Snacks.picker.projects()<cr>",
    icon = wk.icon { "" },
    desc = "Projects",
  },

  {
    key .. ".",
    "<cmd>lua nvim.open.picker('resume')<cr>",
    desc = "Resume",
  },
}
