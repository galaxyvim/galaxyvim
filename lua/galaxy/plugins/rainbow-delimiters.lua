local M = {}

M.config = function()
  return {
    "hiphish/rainbow-delimiters.nvim",
    event = "BufRead",
    opts = {
      blacklist = { "c", "cpp" },
    },
    main = "rainbow-delimiters.setup",
    config = true,
  }
end

return M
