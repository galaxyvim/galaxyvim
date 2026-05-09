local M = {}

M.config = function()
  return {
    "ankushbhagats/match.nvim",
    cmd = { "Match", "MatchWord", "MatchLine" },
    config = true,
  }
end

return M
