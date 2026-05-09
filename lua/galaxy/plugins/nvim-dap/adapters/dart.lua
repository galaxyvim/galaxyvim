local dap = nvim.require("dap")

dap.adapters.dart = {
  type = "executable",
  command = "dart",
  args = { "debug_adapter" },
}

dap.configurations.dart = {
  {
    type = "dart",
    request = "launch",
    name = "Launch Dart file",
    program = "${file}",
    cwd = vim.fn.getcwd(),
  },
}

dap.configurations.flutter = {
  {
    type = "dart",
    request = "launch",
    name = "Launch Flutter",
    program = "${workspaceFolder}/lib/main.dart",
    cwd = vim.fn.getcwd(),
  },
}
