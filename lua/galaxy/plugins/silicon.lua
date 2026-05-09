local M = {}

M.config = function()
  return {
    "ankushbhagats/silicon.nvim",
    cmd = { "SiliconFile", "SiliconRange", "SiliconLine" },
    opts = {},
    config = true,
  }
end

return M
