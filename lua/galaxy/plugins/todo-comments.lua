local M = {}

M.config = function()
  return {
    "folke/todo-comments.nvim",
    event = "User UIReady",
    dependencies = { "plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section belo
      keywords = {
        ALERT = { icon = "󰀦 ", color = "warning" },
      },
    },
    config = true,
  }
end

return M
