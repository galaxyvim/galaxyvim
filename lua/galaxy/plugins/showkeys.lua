local M = {}

M.config = function()
  return {
    "nvzone/showkeys",
    lazy = true,
    cmd = "ShowkeysToggle",
    opts = {
      winhl = "FloatBorder:Function,Normal:Function",
      timeout = 3, -- in secs
      maxkeys = 6,
      show_count = true,
      excluded_modes = {}, -- example: {"i"}

      -- bottom-left, bottom-right, bottom-center, top-left, top-right, top-center
      position = "bottom-right",

      winopts = {
        -- focusable = false,
        relative = "editor",
        style = "minimal",
        border = "rounded",
        height = 1,
        row = 1,
        col = 0,
        zindex = 10000,
      },

      keyformat = {
        ["<BS>"] = "󰁮 ",
        ["<CR>"] = "󰘌",
        ["<Space>"] = "󱁐",
        ["<Up>"] = "󰁝",
        ["<Down>"] = "󰁅",
        ["<Left>"] = "󰁍",
        ["<Right>"] = "󰁔",
        ["<PageUp>"] = "Page 󰁝",
        ["<PageDown>"] = "Page 󰁅",
        ["<M>"] = "Alt",
        ["<C>"] = "Ctrl",
      },
    },
    config = true,
  }
end

return M
