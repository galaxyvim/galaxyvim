local wk = require "which-key"

local key = "<leader>u"

wk.map = {
  key,
  icon = wk.icon { "", "yellow" },
  group = "Utility",

  {
    key .. "c",
    icon = wk.icon { "󰄄", "red" },
    group = "Snapshot",

    {
      key .. "cf",
      vim.cmd.SiliconFile,
      desc = "Snap Current File",
    },

    {
      key .. "cl",
      vim.cmd.SiliconLine,
      desc = "Snap Current Line",
    },

    {
      key .. "cv",
      ":SiliconRange<cr>",
      desc = "Snap Selected Range",
    },
  },

  {
    key .. "p",
    icon = wk.icon { "" },
    "<cmd>EasyColor<cr>",
    desc = "Colorpicker",
    cond = nvim.plugins.easycolor,
  },

  {
    key .. "l",
    icon = wk.icon { "󰘳" },
    group = "Legendary",

    {
      key .. "lp",
      "<cmd>Legendary<cr>",
      desc = "Palette",
    },
    {
      key .. "lk",
      "<cmd>Legendary<cr>",
      desc = "Palette: Keymaps",
    },
    {
      key .. "lc",
      "<cmd>Legendary<cr>",
      desc = "Palette: Commands",
    },
    {
      key .. "lf",
      "<cmd>Legendary<cr>",
      desc = "Palette: Functions",
    },
    {
      key .. "la",
      "<cmd>Legendary<cr>",
      desc = "Palette: Autocmds",
    },

    {
      key .. "lr",
      "<cmd>Legendary<cr>",
      desc = "Palette: Repeat",
    },

    {
      key .. "lR",
      "<cmd>Legendary<cr>",
      desc = "Palette: Repeat!",
    },
  },

  {
    key .. "L",
    cond = nvim.v.minor >= 12,
    icon = wk.icon { "󰆧", "purple" },
    group = "LSP",

    {
      key .. "Ls",
      "<cmd>lsp startt<cr>",
      desc = "Start",
    },

    {
      key .. "Lt",
      "<cmd>lsp stop<cr>",
      desc = "Stop",
    },
    {
      key .. "Lr",
      "<cmd>lsp restart<cr>",
      desc = "Restart",
    },

    {
      key .. "Le",
      "<cmd>lsp enable<cr>",
      desc = "Enable",
    },

    {
      key .. "Ld",
      "<cmd>lsp disable<cr>",
      desc = "Disable",
    },
  },

  {
    key .. "m",
    group = "Mason",
    {
      key .. "mp",
      "<cmd>Mason<cr>",
      desc = "Panel",
    },
    {
      key .. "mu",
      "<cmd>Mason update<cr>",
      desc = "Update",
    },
    {
      key .. "ml",
      "<cmd>MasonLog<cr>",
      desc = "Logs",
    },
  },
}
