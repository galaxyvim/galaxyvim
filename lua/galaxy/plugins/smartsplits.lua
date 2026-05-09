local M = {}

M.config = function()
  return {
    "mrjones2014/smart-splits.nvim",
    main = "smart-splits",
    lazy = true,
    opts = {},
    config = true,
  }
end

return M
