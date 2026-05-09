local M = {}

M.bang = function(tbl)
  local removed = {}
  for key, value in pairs(tbl) do
    key = type(value) == "string" and value or key
    if vim.startswith(key, "!") then
      removed[key:gsub("^!", "")] = value
      tbl[key] = nil
    end
  end

  return removed
end

return M
