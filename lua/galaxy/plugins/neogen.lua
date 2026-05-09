local M = {}

M.config = function()
  return {
    "danymat/neogen",
    event = "User UIReady",
    version = "*",
    opts = {
      snippet_engine = "luasnip",
    },
    config = true,
  }
end

return M
