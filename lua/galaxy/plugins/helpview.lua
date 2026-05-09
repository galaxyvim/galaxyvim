local M = {}

M.config = function()
  return {
    "OXY2DEV/helpview.nvim",
    event = "User BufReady",
    opts = {
      vimdoc = {
        horizontal_rules = {
          parts = {
            {
              type = "repeating",
              repeat_amount = function(buffer)
                return math.ceil((vim.bo[buffer].tw - 3) / 2)
              end,
              text = "─",
              hl = {
                "HelpviewGradient1",
                "HelpviewGradient1",
                "HelpviewGradient2",
                "HelpviewGradient2",
                "HelpviewGradient3",
                "HelpviewGradient3",
                "HelpviewGradient4",
                "HelpviewGradient4",
                "HelpviewGradient5",
                "HelpviewGradient5",
                "HelpviewGradient6",
                "HelpviewGradient6",
                "HelpviewGradient7",
                "HelpviewGradient7",
                "HelpviewGradient8",
                "HelpviewGradient8",
                "HelpviewGradient8",
                "HelpviewGradient8",
              },
            },

            -- {
            --   type = "text",
            --   text = " ◈ ",
            -- },

            {
              type = "repeating",
              repeat_amount = function(buffer)
                return math.floor((vim.bo[buffer].tw - 3) / 2)
              end,
              direction = "right",
              text = "─",
              hl = {
                "HelpviewGradient1",
                "HelpviewGradient1",
                "HelpviewGradient2",
                "HelpviewGradient2",
                "HelpviewGradient3",
                "HelpviewGradient3",
                "HelpviewGradient4",
                "HelpviewGradient4",
                "HelpviewGradient5",
                "HelpviewGradient5",
                "HelpviewGradient6",
                "HelpviewGradient6",
                "HelpviewGradient7",
                "HelpviewGradient7",
                "HelpviewGradient8",
                "HelpviewGradient8",
                "HelpviewGradient8",
                "HelpviewGradient8",
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
