local M = {}

M.config = function()
  return {
    "ankushbhagats/pastel.nvim",
    -- dir="~/pastel.nvim",
    lazy = false,
    priority = 1200,
    opts = {
      background = {
        dark = "pasteldark",
        light = "pastelsoft",
      },
      -- palette = "pastelgold",
      exclude = {
        core = {
          -- editor = true,
          -- syntax = true,
          -- lsp = true,
        },
        plugins = {},
      },

      colors = {
        common = {
          -- text = "#626fff",
        },
        global = {
          -- red = "#626262",
        },
        pasteldark = {
          -- red = "#ff66ff",
        },
      },

      highlights = {
        pasteldark = function(hl, c)
          hl.WinSeparator.fg = c.lighten(c.blue, 0.2)
          -- hl.LineNr.fg = c.blue
        end,
      },
    },

    config = true,
  }
end

return M
