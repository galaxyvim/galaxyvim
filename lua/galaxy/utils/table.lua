local M = {}

function M.remove(tbl, key)
  local item, idx
  for index, value in ipairs(tbl) do
    if value == key then
      item = table.remove(tbl, index)
      idx = index
    end
  end

  return item, idx
end

-- Function to move a key to a specific position for iteration
function M.pos(dict, key, position)
  -- Collect all keys
  local keys = {}
  for k, _ in pairs(dict) do
    table.insert(keys, k)
  end

  -- Remove the key if it exists
  for i, k in ipairs(keys) do
    if k == key then
      table.remove(keys, i)
      break
    end
  end

  -- Insert key at desired position
  position = math.max(1, math.min(position, #keys + 1)) -- clamp
  table.insert(keys, position, key)

  -- Return iterator
  local i = 0
  return function()
    i = i + 1
    local k = keys[i]
    if k then
      return k, dict[k]
    end
  end
end

return M
