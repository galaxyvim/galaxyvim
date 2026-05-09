local M = {}

function M.lighten(hex, amount)
  -- amount: 0 = no change, 1 = full white
  amount = amount or 0.6

  hex = hex:gsub("#", "")

  local r = tonumber(hex:sub(1, 2), 16)
  local g = tonumber(hex:sub(3, 4), 16)
  local b = tonumber(hex:sub(5, 6), 16)

  r = math.floor(r + (255 - r) * amount + 0.5)
  g = math.floor(g + (255 - g) * amount + 0.5)
  b = math.floor(b + (255 - b) * amount + 0.5)

  return string.format("#%02X%02X%02X", r, g, b)
end

function M.darken(hex, amount)
  -- amount: 0 = no change, 1 = full black
  amount = amount or 0.8

  hex = hex:gsub("#", "")

  local r = tonumber(hex:sub(1, 2), 16)
  local g = tonumber(hex:sub(3, 4), 16)
  local b = tonumber(hex:sub(5, 6), 16)

  r = math.floor(r * (1 - amount) + 0.5)
  g = math.floor(g * (1 - amount) + 0.5)
  b = math.floor(b * (1 - amount) + 0.5)

  return string.format("#%02X%02X%02X", r, g, b)
end

return M
