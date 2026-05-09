local M = {}

-- returns count prefix or default resize step
function M.step(default)
  return vim.v.count > 0 and vim.v.count or (default or 2)
end

function M.left()
  local s = M.step()
  vim.cmd("vertical resize -" .. s)
end

function M.right()
  local s = M.step()
  vim.cmd("vertical resize +" .. s)
end

function M.up()
  local s = M.step()
  vim.cmd("resize +" .. s)
end

function M.down()
  local s = M.step()
  vim.cmd("resize -" .. s)
end

return M
