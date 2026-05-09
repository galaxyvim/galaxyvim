local M = {}

M.config = function()
  return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    shuffle = false,
    event = "User FileReady",
    opts = {
      whitespace = {
        highlight = { "Whitespace" },
        remove_blankline_trail = false,
      },
      scope = {
        highlight = {
          "RainbowRed",
          "RainbowYellow",
          "RainbowBlue",
          "RainbowOrange",
          "RainbowGreen",
          "RainbowViolet",
          -- "RainbowCyan",
        },
        show_start = true,
        show_end = false,
        -- include = { node_type = { all = { "return_statement", "table_constructor" },} },
        include = { node_type = { ["*"] = { "*" } } },
      },
      exclude = { filetypes = { "dashboard" } },
    },
    config = function(self, opts)
      local hooks = nvim.require "ibl.hooks"

      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        if not vim.startswith(vim.g.colors_name, "pastel") then
          vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
          vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
          vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
          vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
          vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
          vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
          vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
        end
      end)

      math.randomseed(os.time())
      local function shuffle(t)
        for i = #t, 2, -1 do
          local j = math.random(i)
          t[i], t[j] = t[j], t[i]
        end
      end

      if self.shuffle then
        shuffle(opts.scope.highlight)
      end

      vim.g.rainbow_delimiters = { highlight = opts.scope.highlight }

      nvim.require("ibl").setup(opts)

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  }

  
end

return M
