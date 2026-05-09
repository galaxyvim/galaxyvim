local M = {}

M.config = function()
  return {
    "nvim-treesitter/nvim-treesitter",
    commit = "90cd658",
    main = "nvim-treesitter",
    -- build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      install = {
        "lua",
        "css",
        "comment",
        "javascript",
        "markdown",
        "markdown_inline",
        "regex",
        "vimdoc",
      },
      install_dir = nvim.fs.treesitter,
    },
    config = function(_, opts)
      local treesitter = nvim.require "nvim-treesitter"
      treesitter.setup(opts)
      if vim.fn.executable "tree-sitter" ~= 1 then
        vim.api.nvim_echo(
          {
            {
              "tree-sitter CLI not found. Parsers cannot be installed.",
              "ErrorMsg",
            },
          },
          true,
          {}
        )
        return false
      end
      treesitter.install(opts.install)
    end,
  }
end

return M
