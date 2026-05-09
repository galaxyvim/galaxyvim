-- =========================================================
-- C / C++ / Rust / Object C / Zig (codelldb)
-- =========================================================

local dap = nvim.require "dap"

local binary = nvim.stdpath.data .. "/mason/bin"

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = binary .. "/codelldb",
    args = { "--port", "${port}" },
  },
}

local function pick_executable()
  return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
end

local config = {
  launch = {
    type = "codelldb",
    request = "launch",
    name = "Launch executable",
    program = pick_executable,
    cwd = vim.fn.getcwd(),
    stopOnEntry = false,
  },

  launch_args = {
    type = "codelldb",
    request = "launch",
    name = "Launch executable (args)",
    program = pick_executable,
    cwd = vim.fn.getcwd(),
    stopOnEntry = false,
    args = function()
      local input = vim.fn.input "Args: "
      if input == "" then
        return {}
      end
      return vim.split(input, " ", { trimempty = true })
    end,
  },
}

dap.configurations.c = config
dap.configurations.cpp = config
dap.configurations.rust = config
dap.configurations.zig = config
dap.configurations.objc = config
dap.configurations.objcpp = config
