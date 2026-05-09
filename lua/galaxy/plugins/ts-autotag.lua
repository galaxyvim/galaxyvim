local M = {}

M.config = function()
  return {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    main = "nvim-ts-autotag",
    enabled = nvim.opt.treesitter.autotag,
    opts = {
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = false,
      },
    },
    config = true,
  }
end

return M
