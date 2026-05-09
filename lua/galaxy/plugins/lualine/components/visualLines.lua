return {
  function()
    local mode = vim.fn.mode()
    if mode ~= "v" and mode ~= "V" and mode ~= "\22" then
      return ""
    end

    local start_line = vim.fn.line("v")
    local end_line = vim.fn.line(".")
    local count = math.abs(end_line - start_line) + 1

    return tostring(count)
  end,

  -- fmt = function(text)
  --   return "󰈈" .. text  -- no space
  -- end,

  icon = "󰦒",
  separator = {
    right = "",          -- the arrow separator
  },
  padding = {
    left = 0,
    right = 1,
  }
}

