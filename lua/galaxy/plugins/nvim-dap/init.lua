local M = {}

M.config = function()
  return {
    "mfussenegger/nvim-dap",
    lazy = true,
    dependencies = {
      "mason",
      "nvim-nio",
      "dapui",
      { "jay-babu/mason-nvim-dap.nvim", name = "mason-dap" },
    },
    cmd = { "DapInstall", "DapUninstall", "DapShowLog" },
    opts = {
      install = {},
      autoinstall = true,
      handlers = {},
      configurations = {},
      filetypes = {},

      signs = {
        DapBreakpoint = {
          text = "",
          texthl = "DiagnosticHint",
          linehl = "",
          numhl = "",
        },
        DapBreakpointCondition = {
          text = "",
          texthl = "DiagnosticInfo",
          linehl = "",
          numhl = "",
        },
        DapBreakpointRejected = {
          text = "",
          texthl = "DiagnosticError",
          linehl = "",
          numhl = "",
        },
        DapLogPoint = {
          text = "󱧡",
          texthl = "DiagnosticWarn",
          linehl = "",
          numhl = "",
        },
        DapStopped = {
          text = "󰁕",
          texthl = "DiagnosticOk",
          linehl = "Visual",
          numhl = "DiagnosticOk",
        },

        DapBreakpointDisabled = {
          text = "",
          texthl = "Comment",
          linehl = "",
          numhl = "",
        },
        DapBreakpointUnverified = {
          text = "",
          texthl = "Comment",
          linehl = "",
          numhl = "",
        },
        DapStoppedLine = {
          text = "󰁕",
          texthl = "Comment",
          linehl = "",
          numhl = "",
        },
        DapBreakpointHit = {
          text = "󰁕",
          texthl = "DiagnosticOk",
          linehl = "",
          numhl = "",
        },

        DapBreakpointFunction = {
          text = "󰊕",
          texthl = "Function",
          linehl = "",
          numhl = "",
        },
        DapBreakpointData = {
          text = "󰛢",
          texthl = "DiagnosticInfo",
          linehl = "",
          numhl = "",
        },
        DapBreakpointException = {
          text = "󱐋",
          texthl = "DiagnosticError",
          linehl = "",
          numhl = "",
        },
      },
      log = {
        level = "info",
      },
    },
    config = function(self, opts)
      local mason_dap_ok, mason_dap = pcall(nvim.require, "mason-nvim-dap")
      if not mason_dap_ok then
        return
      end

      mason_dap.setup {
        ensure_installed = opts.install,
        automatic_installation = opts.autoinstall,
        handlers = opts.handlers,
        configurations = opts.configurations,
        filetypes = opts.filetypes,
      }

      local dap_ok, dap = pcall(nvim.require, "dap")
      if not dap_ok then
        return
      end

      for name, item in pairs(opts.signs) do
        local ok = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
        local texthl = ok and name or item.texthl

        vim.fn.sign_define(name, {
          text = item.text,
          texthl = texthl,
          linehl = item.linehl or "",
          numhl = item.numhl or "",
        })
      end

      dap.set_log_level(opts.log.level)
      nvim.autoload "plugins/nvim-dap/adapters"
    end,
  }
end

return M
