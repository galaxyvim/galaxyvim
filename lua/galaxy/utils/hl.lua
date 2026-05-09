local M = {}

  local function to_hex(color)
    return color and string.format("#%06x", color) or nil
  end

  M.set = function(group, opts)
    vim.schedule(function ()
      vim.api.nvim_set_hl(0, group, opts)
    end)
  end

  M.get = function(group)
    local hl = vim.api.nvim_get_hl(0, { name = group })
    local tbl = {}
    local meta = {
      __index = function(tbl, key)
        if key == "fg" or key == "bg" then
          return to_hex(hl[key])
        end
        return hl[key]
      end,
      __newindex = function(tbl, key, val)
        if key == "fg" or key == "bg" then
          hl[key] = val
          M.set(group, hl)
          rawset(tbl, key, val)
        end
      end,
    }

    setmetatable(tbl, meta)

    return tbl
  end

  M.format = function(hl, text)
    return string.format("%%#%s#%s%%*", hl, text)
  end

  local hl_meta = {
    __index = function(tbl, key)
      return key and M.get(key) or "nil"
    end,
  }

  setmetatable(M, hl_meta)

return M
