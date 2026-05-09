local M = {}

M.config = function()
    return {
      "neoclide/coc.nvim",
      build = "npm ci",
      enabled = nvim.opt.provider.lsp == "coc",
    }
end

return M
