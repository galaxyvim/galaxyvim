local M = {}

M.config = function()
  return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    name = "ts-textobjects",
    main = "nvim-treesitter-textobjects",
    enabled = nvim.opt.treesitter.textobjects,
    event = "User UIReady",
    opts = {
      select = {
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        selection_modes = {
          ["@parameter.outer"] = "v", -- charwise
          ["@function.outer"] = "V", -- linewise
          ["@class.outer"] = "<c-v>", -- blockwise
        },
        include_surrounding_whitespace = true,
      },

      move = {
        set_jumps = true, -- whether to set jumps in the jumplist
      },
    },
    config = true,
  }
end

return M
