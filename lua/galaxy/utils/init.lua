local M = {}

function M.callback(self, opts, func)
  local values = {}
  if type(self[func]) == "function" then
    table.insert(values, self[func](self, opts) or {})
  elseif type(self[func]) == "table" then
    for _, f in ipairs(self[func]) do
      table.insert(values, f(self, opts) or {})
    end
  end

  return values
end

-- recursive autocreate proxy table
function M.lazytable(tbl)
  tbl = tbl or {} -- optional initial table

  return setmetatable(tbl, {
    __index = function(t, k)
      local v = M.lazytable()
      rawset(t, k, v)
      return v
    end,
  })
end

-- proxy to a module (reads/writes go directly to the real module)
function M.lazyload(require_path)
  return setmetatable({}, {
    __index = function(_, key)
      return require(require_path)[key]
    end,
    __newindex = function(_, key, value)
      require(require_path)[key] = value
    end,
  })
end

function M.lazyfreeze(tbl)
  return setmetatable(tbl, {
    __newindex = function(_, k)
      error("Config is frozen. Cannot set: " .. tostring(k))
    end,
  })
end

return M
