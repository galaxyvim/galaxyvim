nvim.create_autocmd("BufEnter", {
  group = "vim_dir_ready",
  clear = true,
  once = true,
  callback = function(args)
    -- check if buffer is a directory
    if vim.fn.isdirectory(args.file) == 1 then
      vim.api.nvim_exec_autocmds("User", { pattern = "DirReady" })
      -- Fire same event after directory handling with args
      vim.api.nvim_exec_autocmds(args.event, { buffer = args.buf, data = args.data })
    end
  end,
})

nvim.create_autocmd("BufRead", {
  group = "vim_bufread",
  clear = true,
  callback = function()
    if vim.o.statuscolumn == "" then
      vim.o.statuscolumn = "%!v:lua.statuscol()"
    end
  end,
})

nvim.create_autocmd("FileType", {
  group = "vim_fileready",
  clear = true,
  callback = function(args)
    local buftype = vim.bo[args.buf].buftype
    -- check if buffer is a real file
    if args.file ~= "" and buftype ~= "nofile" then
      vim.api.nvim_exec_autocmds("User", { pattern = "FileReady" })
    end
  end,
})

nvim.create_autocmd({ "BufReadPre", "BufNewFile" }, {
  group = "vim_bufready",
  clear = true,
  once = true,
  callback = function(args)
    local buftype = vim.bo[args.buf].buftype
    -- check if buffer is a real file
    if args.file ~= "" and buftype ~= "nofile" then
      vim.api.nvim_exec_autocmds("User", { pattern = "BufReady" })
    end
  end,
})

nvim.create_autocmd({ "BufReadPost", "BufNewFile" }, {
  group = "vim_uiready",
  clear = true,
  once = true,
  callback = function()
    vim.defer_fn(function()
      vim.api.nvim_exec_autocmds("User", { pattern = "UIReady" })
    end, 300)
  end,
})

nvim.create_autocmd("WinNew", {
  group = "vim_winsplit",
  clear = true,
  callback = function()
    local win = vim.api.nvim_get_current_win()
    local cfg = vim.api.nvim_win_get_config(win)

    if cfg.relative ~= "" then
      return -- ignore floating window
    end

    vim.api.nvim_exec_autocmds("User", { pattern = "WinSplit" })
  end,
})

-- After session restore, re-detect filetypes
nvim.create_autocmd("User", {
  pattern = "SessionLoadPost",
  callback = function()
    vim.cmd.filetype "detect"
  end,
})
