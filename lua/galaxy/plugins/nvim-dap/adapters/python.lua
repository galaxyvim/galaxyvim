-- =========================================================
-- Python (debugpy)
-- =========================================================

local dap = nvim.require "dap"

local binary = nvim.stdpath.data .. "/mason/bin"

local pythonPath = function()
  local venv = os.getenv "VIRTUAL_ENV"
  if venv and venv ~= "" then
    local py = venv .. "/bin/python"
    if vim.fn.executable(py) == 1 then
      return py
    end
  end
  return "python"
end

dap.adapters.python = {
  type = "executable",
  command = binary .. "/debugpy-adapter",
}

dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    pythonPath = pythonPath,
  },
  {
    type = "python",
    request = "launch",
    name = "Launch file (args)",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    pythonPath = pythonPath,
    args = function()
      local input = vim.fn.input "Args: "
      if input == "" then
        return {}
      end
      return vim.split(input, " ", { trimempty = true })
    end,
  },
  {
    type = "python",
    request = "launch",
    name = "Launch module",
    module = function()
      return vim.fn.input "Module: "
    end,
    cwd = vim.fn.getcwd(),
    pythonPath = pythonPath,
  },
  {
    type = "python",
    request = "attach",
    name = "Attach (host:port)",
    connect = function()
      local host = vim.fn.input "Host [127.0.0.1]: "
      if host == "" then
        host = "127.0.0.1"
      end

      local port = tonumber(vim.fn.input "Port [5678]: ") or 5678
      return { host = host, port = port }
    end,
  },
}
