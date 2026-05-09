return {
  function()
    local clients = vim.lsp.get_clients { bufnr = 0 }
    if #clients == 0 then
      return ""
    end

    local names = {}
    for _, client in ipairs(clients) do
      table.insert(names, client.name)
    end

    if vim.list_contains(names, "copilot") then
      return nvim.icons.kind.Copilot
    end

    return ""
  end,

  color = function()
    return {
      fg = nvim.hex.lighten(nvim.hl.lualine_a_normal.bg, 0.5),
      gui = "bold",
    }
  end,

  padding = {
    left = 1,
    right = 0,
  },
}
