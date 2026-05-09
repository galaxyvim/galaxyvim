local wk = require "which-key"
local key = "<leader>i"

wk.map = {
  key,
  group = "Interface",
  icon = wk.icon { "󰙵", "cyan" },

  {
    key .. "b",
    icon = wk.icon { "󰔎", "purple" },
    "<cmd>lua nvim.ui.background()<cr>",
    desc = "Background",
  },

  {
    key .. "c",
    "<cmd>lua nvim.open.picker('colorscheme')<cr>",
    icon = wk.icon { "", "blue" },
    desc = "Colorscheme",
  },

  {
    key .. "h",
    icon = wk.icon { "󰛔", "cyan" },
    "<cmd>lua nvim.ui.reload_highlights()<cr>",
    desc = "Reload highlights",
  },

  {
    key .. "r",
    icon = wk.icon { "󰑐", "cyan" },
    "<cmd>lua nvim.ui.clear_highlights()<cr>",
    desc = "Clear highlights",
  },

  {
    key .. "w",
    icon = wk.icon { "󰖲", "blue" },
    "<cmd>lua nvim.ui.window()<cr>",
    desc = "Window UI",
  },

  {
    key .. "p",
    icon = wk.icon { "󰆍", "yellow" },
    "<cmd>lua nvim.ui.popup()<cr>",
    desc = "Popup menu",
  },

  {
    key .. "n",
    icon = wk.icon { "󰎟", "orange" },
    "<cmd>Notifications<cr>",
    desc = "Notifications",
  },

  {
    key .. "t",
    group = "Transparency",
    icon = "󰖨",

    {
      key .. "t0",
      icon = wk.icon { "󱦥", "yellow" },
      "<cmd>lua nvim.ui.transparency.reset()<cr>",
      desc = "Transparency reset",
    },

    {
      key .. "tf",
      group = "Float",
      icon = "󰖲",

      { key .. "tf+", icon = "󰖨", "<cmd>lua nvim.ui.transparency.float_inc()<cr>", desc = "Increase float" },
      { key .. "tf-", icon = "", "<cmd>lua nvim.ui.transparency.float_dec()<cr>", desc = "Decrease float" },
      { key .. "tf0", icon = "󱦥", "<cmd>lua nvim.ui.transparency.float_reset()<cr>", desc = "Reset float" },
    },

    {
      key .. "tp",
      group = "Popup",
      icon = "󰆍",

      { key .. "tp+", icon = "󰖨", "<cmd>lua nvim.ui.transparency.popup_inc()<cr>", desc = "Increase popup" },
      { key .. "tp-", icon = "", "<cmd>lua nvim.ui.transparency.popup_dec()<cr>", desc = "Decrease popup" },
      { key .. "tp0", icon = "󱦥", "<cmd>lua nvim.ui.transparency.popup_reset()<cr>", desc = "Reset popup" },
    },

    {
      key .. "tu",
      group = "UI",
      icon = "󰙵",

      { key .. "tu+", icon = "󰖨", "<cmd>lua nvim.ui.transparency.ui_inc()<cr>", desc = "Increase UI" },
      { key .. "tu-", icon = "", "<cmd>lua nvim.ui.transparency.ui_dec()<cr>", desc = "Decrease UI" },
      { key .. "tu0", icon = "󱦥", "<cmd>lua nvim.ui.ui_reset()<cr>", desc = "Reset UI" },
    },
  },
}
