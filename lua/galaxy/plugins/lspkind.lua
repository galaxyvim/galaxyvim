local M = {}

M.config = function()
  return {
    "onsails/lspkind.nvim",
    lazy = true,
    opts = {
      symbol_map = nvim.icons.kind,
    },
    config = true,
  }



end

return M
