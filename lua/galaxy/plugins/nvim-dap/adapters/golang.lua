-- =========================================================
-- Go (delve)
-- =========================================================

local dap = nvim.require "dap"

local binary = nvim.stdpath.data .. "/mason/bin"

dap.adapters.go = {
  type = "server",
  port = "${port}",
  executable = {
    command = binary .. "/dlv",
    args = { "dap", "-l", "127.0.0.1:${port}" },
  },
}

dap.configurations.go = {
  {
    type = "go",
    request = "launch",
    name = "Launch file",
    program = "${file}",
  },
  {
    type = "go",
    request = "launch",
    name = "Launch package",
    program = "${fileDirname}",
  },
  {
    type = "go",
    request = "launch",
    name = "Launch (args)",
    program = "${file}",
    args = function()
      local input = vim.fn.input("Args: ")
      if input == "" then
        return {}
      end
      return vim.split(input, " ", { trimempty = true })
    end,
  },
  {
    type = "go",
    request = "attach",
    name = "Attach (pick process)",
    mode = "local",
    processId = function()
      return tonumber(vim.fn.input("PID: "))
    end,
  },
}
