-- =========================================================
-- JavaScript / TypeScript (js-debug / pwa-node)
-- =========================================================

local dap = nvim.require "dap"

local binary = nvim.stdpath.data .. "/mason/bin"

dap.adapters["pwa-node"] = {
  type = "server",
  host = "127.0.0.1",
  port = "${port}",
  executable = {
    command = binary .. "/js-debug-adapter",
    args = { "${port}" },
  },
}

local config = {
  node_launch = {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    console = "integratedTerminal",
  },

  node_launch_args = {
    type = "pwa-node",
    request = "launch",
    name = "Launch file (args)",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    console = "integratedTerminal",
    args = function()
      local input = vim.fn.input "Args: "
      if input == "" then
        return {}
      end
      return vim.split(input, " ", { trimempty = true })
    end,
  },

  node_launch_npm = {
    type = "pwa-node",
    request = "launch",
    name = "Launch npm script",
    cwd = vim.fn.getcwd(),
    runtimeExecutable = "npm",
    runtimeArgs = function()
      local script = vim.fn.input "npm script (dev/start/test): "
      if script == "" then
        script = "dev"
      end
      return { "run", script }
    end,
    console = "integratedTerminal",
  },

  node_attach = {
    type = "pwa-node",
    request = "attach",
    name = "Attach (9229)",
    cwd = vim.fn.getcwd(),
    port = 9229,
  },
}

dap.configurations.javascript = config
dap.configurations.typescript = config
dap.configurations.javascriptreact = config
dap.configurations.typescriptreact = config
