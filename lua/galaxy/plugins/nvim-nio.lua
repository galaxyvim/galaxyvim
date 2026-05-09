local M = {}

M.config = function()
  return {
    "nvim-neotest/nvim-nio",
    event = "User UIReady",
    opts = {
      floating = {
        border = "rounded",
      },
    },
    config = true,
  }
end

return M
