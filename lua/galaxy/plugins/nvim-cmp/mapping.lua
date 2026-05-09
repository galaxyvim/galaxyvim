local M = {
  cmdline = {},
}

local cmp = nvim.require "cmp"

local function validWinid(winid)
  if winid and vim.api.nvim_win_is_valid(winid) then
    return true
  end
end

local function mouseSelect()
  if not cmp.visible() then
    return
  end

  local cmpid = cmp.core.view.custom_entries_view.entries_win.win

  local pos = vim.fn.getmousepos()
  if validWinid(cmpid) and validWinid(pos.winid) then
    pcall(vim.api.nvim_win_set_cursor, pos.winid, { pos.line, 0 })
    if cmpid == pos.winid then
      cmp.confirm()
    end
  end
end

M.insert = {
  ["<C-b>"] = cmp.mapping.scroll_docs(-4),
  ["<C-f>"] = cmp.mapping.scroll_docs(4),
  ["<C-Space>"] = cmp.mapping.complete(),
  ["<C-e>"] = cmp.mapping.abort(),
  ["<Tab>"] = cmp.mapping.select_next_item(),
  ["<S-Tab>"] = cmp.mapping.select_prev_item(),
  ["<CR>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  ["<LeftMouse>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      mouseSelect()
    else
      fallback()
    end
  end, { "i", "s" }),
}

M.cmdline[":"] = {
  ["<CR>"] = {
    c = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false },
  },
  ["<Down>"] = { c = cmp.mapping.select_next_item() },
  ["<Up>"] = { c = cmp.mapping.select_prev_item() },
}

M.cmdline["/"] = {
  ["<Left>"] = {
    c = function()
      local line = vim.fn.getcmdline()
      if #line > 0 then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true), "n", false)
      end
    end,
  },
  ["<Right>"] = { c = cmp.mapping.confirm { select = true } },
  ["<Down>"] = { c = cmp.mapping.select_next_item() },
  ["<Up>"] = { c = cmp.mapping.select_prev_item() },
}

return M
