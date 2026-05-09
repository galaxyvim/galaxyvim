vim.api.nvim_create_user_command("Deprecated", function()
  local logs = nvim.deprecations or {}

  local grouped = {}

  for _, item in ipairs(logs) do
    local key = (item.name or "?") .. " -> " .. (item.alternative or "?")

    if not grouped[key] then
      grouped[key] = {
        count = 0,
        name = item.name,
        alternative = item.alternative,
        version = item.version,
        plugin = item.plugin,
      }
    end

    grouped[key].count = grouped[key].count + 1
  end

  local lines = { "=== Deprecation Logs ===", "" }

  for _, v in pairs(grouped) do
    table.insert(lines, string.format("%dx  %s", v.count, v.name or "?"))
    if v.alternative then
      table.insert(lines, "    -> " .. v.alternative)
    end
    if v.version then
      table.insert(lines, "    since: " .. v.version)
    end
    if v.plugin then
      table.insert(lines, "    plugin: " .. v.plugin)
    end
    table.insert(lines, "")
  end

  vim.cmd "new"
  local buf = vim.api.nvim_get_current_buf()

  vim.api.nvim_buf_set_name(buf, "Deprecated")
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "wipe"
  vim.bo.swapfile = false
  vim.bo.filetype = "vim"

  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end, {})
