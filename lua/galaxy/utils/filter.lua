local M = {}

  function M.null(t)
    if type(t) ~= "table" then
      return t
    end

    local out = {}
    for k, v in pairs(t) do
      if v ~= nil then
        if type(v) == "table" then
          out[k] = M.null(v)
        else
          out[k] = v
        end
      end
    end
    return out
  end
return M
