local M = {}

M.config = function()
  return {
    "nvim-treesitter/nvim-treesitter-context",
    main = "treesitter-context",
    enabled = nvim.opt.treesitter.context,
    event = "User UIReady",
    opts = {
      enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
      multiwindow = false, -- Enable multiwindow support.
      max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 20, -- Maximum number of lines to show for a single context
      trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
      -- Separator between context and content. Should be a single character string, like '-'.
      -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
      separator = "—",
      zindex = 20, -- The Z-index of the context window
      on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    },
    config = function(_, opts)
      local tsc = nvim.require "treesitter-context"
      tsc.setup(opts)
      vim.keymap.set("n", "<c", function()
        tsc.go_to_context(vim.v.count1)
      end, { silent = true, desc = "Go to context" })
    end,
  }
end

return M
