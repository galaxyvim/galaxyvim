local spinner = nvim.icons.spinner.Arc
local items = {} -- active tasks indexed by token

local ns = nvim.namespace "lsp_progress"

local function render_win(item, pos)
  item.text = (item.report .. " " .. item.message .. " " .. item.client):gsub("^%s*(.-)%s*$", "%1"):gsub("%s+", " ")
  local text = " " .. item.icon .. " " .. item.text
  local width = vim.fn.strdisplaywidth(text) + 1

  if not item.win or not vim.api.nvim_win_is_valid(item.win) then
    item.buf = vim.api.nvim_create_buf(false, true)

    item.win = vim.api.nvim_open_win(item.buf, false, {
      relative = "editor",
      anchor = "SE",
      col = pos.x,
      row = pos.y,
      width = width,
      height = 1,
      style = "minimal",
      border = "none",
      focusable = false,
    })

    -- vim.api.nvim_win_set_option(item.win, "winhl", "Normal:LspProgressText")
  else
    vim.api.nvim_win_set_config(item.win, {
      relative = "editor",
      col = pos.x,
      row = pos.y,
      width = width,
    })
  end

  vim.api.nvim_buf_set_lines(item.buf, 0, -1, false, { text })
  -- vim.api.nvim_buf_add_highlight(item.buf, -1, "LspProgressIcon", 0, 1, 2)
  -- vim.api.nvim_buf_add_highlight(item.buf, -1, "LspProgressText", 0, 3, #text - #item.client - 1)

  -- highlight icon
  vim.api.nvim_buf_set_extmark(item.buf, ns, 0, 1, {
    end_col = 2,
    hl_group = "LspProgressIcon",
  })

  -- highlight text
  vim.api.nvim_buf_set_extmark(item.buf, ns, 0, 3, {
    end_col = #text - #item.client - 1,
    hl_group = "LspProgressText",
  })

  -- highlight client
  vim.api.nvim_buf_set_extmark(item.buf, ns, 0, #text - #item.client, {
    end_col = #text,
    hl_group = "LspProgressClient",
  })
end

local function render_stack()
  local ui = vim.api.nvim_list_uis()[1]

  local pos = {
    x = ui.width,
    y = ui.height - 1,
  }

  for _, item in pairs(items) do
    render_win(item, pos)
    pos.y = pos.y - 1
  end
end

-- reposition on resize
vim.api.nvim_create_autocmd("VimResized", {
  callback = render_stack,
})

local function close_win(buf, win)
  if vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_win_close(win, true)
  end
  if vim.api.nvim_buf_is_valid(buf) then
    vim.api.nvim_buf_delete(buf, { force = true })
  end
end

local function start(token, title, client)
  local frame = 1

  local timer = vim.loop.new_timer()
  timer:start(0, 100, function()
    vim.schedule(function()
      local item = items[token]
      if not item or item.done then -- stop loop
        return
      end

      item.icon = spinner[frame]
      frame = frame % #spinner + 1
      render_stack()
    end)
  end)

  items[token] = {
    message = title,
    report = "",
    client = client,
    icon = spinner[1],
    timer = timer,
  }

  render_stack()
end

-- update text
local function report(token, message, percent)
  local item = items[token]
  if not item then
    return
  end
  percent = percent and percent .. " " or ""
  message = message or ""
  local text = item.text or ""
  item.report = (percent .. message) or text
end

-- finish task
local function finish(token, msg)
  local item = items[token]
  if not item then
    return
  end

  item.done = true
  item.icon = ""
  item.text = (msg or item.text)

  render_stack()

  vim.defer_fn(function()
    close_win(item.buf, item.win)
    items[token] = nil
    render_stack()
  end, 1500)
end

-- handler
local function handler(_, result, ctx)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  local name = client and client.name or "LSP"

  if vim.tbl_contains(nvim.opt.lsp.progress.disabled, name) then return end

  local value = result.value
  if not value then
    return
  end

  local token = result.token

  if value.kind == "begin" then
    start(token, value.title or "Initializing…", name)
  elseif value.kind == "report" then
    report(token, value.message, value.percentage and value.percentage .. "%")
  elseif value.kind == "end" then
    finish(token, value.message)
  end
end

return handler
