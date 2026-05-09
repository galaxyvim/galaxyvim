local M = {}

M.config = function()
  return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "User UIReady",
    opts = {
      panel = {
        enabled = true,
        auto_refresh = true,
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<C-Right>",
          next = "<A-]>",
          prev = "<A-[>",
          dismiss = "<C-]>",
        },
      },
    },
    config = true,
  }
end

return M
