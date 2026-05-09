local dap = nvim.require "dap"
local binary = nvim.stdpath.data .. "/mason/bin"

-- =========================================================
-- PHP (php-debug-adapter)
-- Requires Mason: php-debug-adapter
-- =========================================================
dap.adapters.php = {
  type = "executable",
  command = binary .. "/php-debug-adapter",
}

dap.configurations.php = {
  {
    type = "php",
    request = "launch",
    name = "Listen for Xdebug",
    port = 9003,
  },
}
