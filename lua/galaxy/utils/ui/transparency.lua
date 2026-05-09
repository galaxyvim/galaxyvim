local M = {}

local notify = function(msg)
  vim.notify(msg, vim.log.levels.INFO, { title = "UI" })
end

-- Transparency
local function step()
  return vim.v.count > 0 and vim.v.count or 5
end

local function clamp(v)
  return math.max(0, math.min(100, v))
end

local function change(kind, delta)
  nvim.opt.transparency[kind] = clamp(nvim.opt.transparency[kind] + delta)
  vim.notify(
    ("Transparency → float:%d popup:%d ui:%d"):format(
      nvim.opt.transparency.float,
      nvim.opt.transparency.popup,
      nvim.opt.transparency.ui
    ),
    vim.log.levels.INFO,
    { title = "UI Transparency" }
  )
end

function M.float_inc()
  change("float", step())
end
function M.float_dec()
  change("float", -step())
end
function M.float_reset()
  nvim.opt.transparency.float = 0
end

function M.popup_inc()
  change("popup", step())
end
function M.popup_dec()
  change("popup", -step())
end
function M.popup_reset()
  nvim.opt.transparency.popup = 10
end

function M.ui_inc()
  change("ui", step())
end
function M.ui_dec()
  change("ui", -step())
end
function M.ui_reset()
  nvim.opt.transparency.ui = 0
end

function M.reset()
  nvim.opt.transparency = {
    float = 0,
    popup = 10,
    ui = 0,
  }

  notify "Transparency reset"
end

return M
