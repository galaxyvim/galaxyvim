local M = {}

------------------------[ Buffer Rename ]-------------------------------

function M.rename()
  local old = vim.fn.expand "%:p"
  local new = vim.fn.input("New name: ", old, "file")

  if new == "" or new == old then
    return
  end

  vim.fn.mkdir(vim.fn.fnamemodify(new, ":h"), "p")
  os.rename(old, new)

  vim.cmd("edit " .. vim.fn.fnameescape(new))
  vim.cmd "bdelete #"
end

----------------------[ Buffer Navigation ]-------------------------------

function M.next()
  vim.cmd("bnext" .. vim.v.count1)
end

function M.previous()
  vim.cmd("bprevious" .. vim.v.count1)
end

-------------------------[ Move Buffer ]-------------------------------
-- TODO: Add Move Buffer Fearure.

------------------------[ Close Buffer  ]-------------------------------

-- stack for closed buffers
local closed_buffers = {}

function M.close(bufnr)
  local buf = bufnr or vim.api.nvim_get_current_buf()
  local name = vim.api.nvim_buf_get_name(buf)
  local bufinfo = vim.fn.getbufinfo(buf)[1]
  local listed_buffers = vim.tbl_filter(function(b)
    return vim.bo[b].buflisted
  end, vim.api.nvim_list_bufs())

  -- ignore unnamed buffers
  if name ~= "" then
    table.insert(closed_buffers, bufinfo)
    vim.cmd("bdelete!" .. bufinfo.bufnr)
  end

  if #listed_buffers == 1 then
    vim.cmd [[
      set nobuflisted
      Alpha
    ]]
  end
end

-----------------------[ Restore Buffer ]-------------------------------

function M.restore()
  local buf = table.remove(closed_buffers)

  if not buf then
    vim.notify("No closed buffer to restore", vim.log.levels.INFO)
    return
  end

  local buffer = "edit " .. vim.fn.fnameescape(buf.name)
  vim.cmd(buffer)
end

---------------------[ Close Buffer Left ]-------------------------------

function M.close_left()
  local current = vim.api.nvim_get_current_buf()
  local bufs = vim.fn.getbufinfo { buflisted = 1 }

  for _, buf in ipairs(bufs) do
    if buf.bufnr < current then
      M.close(buf.bufnr)
    end
  end
end

---------------------[ Close Buffer Right ]-------------------------------

function M.close_right()
  local current = vim.api.nvim_get_current_buf()
  local bufs = vim.fn.getbufinfo { buflisted = 1 }

  for _, buf in ipairs(bufs) do
    if buf.bufnr > current then
      M.close(buf.bufnr)
    end
  end
end

---------------------------[ Switch Buffer ]-------------------------------

function M.switch()
  local ok = pcall(require, "buffswitch")
  if ok then
    vim.cmd.BuffSwitch()
  end
  return ok
end

return M
