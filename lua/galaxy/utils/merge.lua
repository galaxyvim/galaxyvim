
  -- Deep merge that preserves nested tables correctly
  local function deep_merge(mode, target, source)
    mode = mode or "force"

    for k, v in pairs(source) do
      if type(v) == "table" and type(target[k]) == "table" then
        -- Recursively merge nested tables
        deep_merge(mode, target[k], v)
      else
        if mode == "force" or target[k] == nil then
          target[k] = v
        end
      end
    end

    return target
  end

local function merge(target, ...)
    target = target or {}
    local tables = { ... }
    local mode = "force"

    -- If first argument is a string, treat it as mode
    if type(tables[1]) == "string" then
      mode = tables[1]
      table.remove(tables, 1)
    end

    -- Merge all remaining tables into target
    for i = 1, #tables do
      local source = tables[i] or {}
      deep_merge(mode, target, source)
    end

    return target
  end
  return merge
