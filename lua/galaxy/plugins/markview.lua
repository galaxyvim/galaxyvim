local M = {}

M.config = function()
  return {
    "OXY2DEV/markview.nvim",
    dependencies = { "treesitter", "devicons" },
    ft = { "markdown", "yaml", "latex", "typst" },
    cmd = { "Markview" },
    opts = { -- markview setup
      markdown = {
        horizontal_rules = {
          parts = {
            {
              type = "repeating",
              direction = "left",

              repeat_amount = function(buffer)
                local utils = nvim.require "markview.utils"
                local window = utils.buf_getwin(buffer)

                local width = vim.api.nvim_win_get_width(window)
                local textoff = vim.fn.getwininfo(window)[1].textoff

                return math.floor((width - textoff - 3) / 2)
              end,

              text = "─",

              hl = {
                "MarkviewGradient1",
                "MarkviewGradient1",
                "MarkviewGradient2",
                "MarkviewGradient2",
                "MarkviewGradient3",
                "MarkviewGradient3",
                "MarkviewGradient4",
                "MarkviewGradient4",
                "MarkviewGradient5",
                "MarkviewGradient5",
                "MarkviewGradient6",
                "MarkviewGradient6",
                "MarkviewGradient7",
                "MarkviewGradient7",
                "MarkviewGradient8",
                "MarkviewGradient8",
                "MarkviewGradient9",
                "MarkviewGradient9",
              },
            },
            -- {
              -- type = "text",
              -- text = "  ",
              -- hl = "MarkviewIcon3Fg",
            -- },
            {
              type = "repeating",
              direction = "right",

              repeat_amount = function(buffer) --[[@as function]]
                local utils = nvim.require "markview.utils"
                local window = utils.buf_getwin(buffer)

                local width = vim.api.nvim_win_get_width(window)
                local textoff = vim.fn.getwininfo(window)[1].textoff

                return math.ceil((width - textoff - 3) / 2)
              end,

              text = "─",
              hl = {
                "MarkviewGradient1",
                "MarkviewGradient1",
                "MarkviewGradient2",
                "MarkviewGradient2",
                "MarkviewGradient3",
                "MarkviewGradient3",
                "MarkviewGradient4",
                "MarkviewGradient4",
                "MarkviewGradient5",
                "MarkviewGradient5",
                "MarkviewGradient6",
                "MarkviewGradient6",
                "MarkviewGradient7",
                "MarkviewGradient7",
                "MarkviewGradient8",
                "MarkviewGradient8",
                "MarkviewGradient9",
                "MarkviewGradient9",
              },
            },
          },
        },
      },
    },
    config = true,
  }
end

return M
