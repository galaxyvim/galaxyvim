local dap = nvim.require "dap"
local binary = nvim.stdpath.data .. "/mason/bin"

-- =========================================================
-- C# (netcoredbg)
-- Requires Mason: netcoredbg
-- =========================================================
dap.adapters.coreclr = {
  type = "executable",
  command = binary .. "/netcoredbg",
  args = { "--interpreter=vscode" },
}

dap.configurations.cs = {
  {
    type = "coreclr",
    request = "launch",
    name = "Launch .NET dll",
    program = function()
      return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
    end,
  },
}
