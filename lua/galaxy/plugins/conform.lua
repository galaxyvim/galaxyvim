local M = {}

M.config = function()
  return {
    "stevearc/conform.nvim",
    event = "User UIReady",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        markdown = { "prettier" },
        python = { "black" },
        sh = { "shfmt" },
        go = { "gofmt" },
        rust = { "rustfmt" },
      },

      -- format_on_save = {
      --   timeout_ms = 3000,
      --   lsp_fallback = true,
      -- },
    },
    config = true,
  }
end

return M
