local M = {}

M.config = function()
  return {
    "folke/which-key.nvim",
    cmd = "WhichKey",
    event = "User UIReady",
    opts = {
      triggers = {
        { "<auto>", mode = "nixsotc" },
        { "<localleader>", mode = { "n", "v" } },
      },
      delay = function(ctx)
        return ctx.plugin and 0 or 500
      end,
      preset = nvim.opt.style.whichkey,
      win = {
        no_overlap = false,
        -- width = 100,
        border = "rounded",
        padding = { 1, 1 }, -- extra window padding [top/bottom, right/left]
      },
      layout = {
        spacing = 2, -- spacing between columns
        align = "center", -- align columns left, center or right
      },
      keys = {
        scroll_down = "<C-DOWN>", -- binding to scroll down inside the popup
        scroll_up = "<C-UP>", -- binding to scroll up inside the popup
      },
      icons = {
        separator = "",
        group = "+",
        ellipsis = "…",
        colors = nvim.opt.icons.colors,
        mappings = nvim.opt.icons.enabled, -- set to false to disable all mapping icons,
        rules = {},
        keys = {
          Up = " ",
          Down = " ",
          Left = " ",
          Right = " ",
        },
      },
    },
    config = true,
  }
end

return M
