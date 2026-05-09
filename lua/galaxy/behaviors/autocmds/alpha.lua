local function alpha()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local cfg = vim.api.nvim_win_get_config(win)
    if cfg.relative == "" then
      local buf = vim.api.nvim_win_get_buf(win)
      if vim.bo[buf].filetype == "alpha" then
        return true
      end
    end
  end
  vim.api.nvim_exec_autocmds("User", { pattern = "BufWindow" })
  return false
end

-- Hide tabline when Alpha is active
nvim.create_autocmd({
  "VimEnter",
  "BufEnter",
  "WinEnter",
  "WinNew",
  "BufWinEnter",
  "BufDelete",
  "WinClosed",
  "TabEnter",
  "BufNewFile",
}, {
  callback = function()
    -- update tabline when alpha is active
    vim.schedule(function()
      vim.o.showtabline = alpha() and 0 or 2
    end)
  end,
})
