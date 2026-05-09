local M = {}

M.config = function()
  return {
    "ankushbhagats/buffswitch.nvim",
    cmd = "BuffSwitch",
    opts = {
      prefix = "",
    },
    config = true,
  }
end

return M
