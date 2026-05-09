nvim.create_autocmd({ "CursorHoldI", "CursorHold" }, {
  group = "vim_autosave",
  clear = true,
  pattern = "*",
  callback = function(args)
    if not nvim.opt.auto.save then
      return
    end
    local buf = args.buf
    local name = vim.api.nvim_buf_get_name(buf)
    local modifiable = vim.bo[buf].modifiable
    local buftype = vim.bo[buf].buftype
    local readonly = vim.bo[buf].readonly

    -- Save only if:
    -- 1. Buffer is modifiable
    -- 2. It's a real file (has a name and normal buftype)
    -- 3. Buffer is not readonly
    if modifiable and name ~= "" and buftype == "" and not readonly then
      vim.cmd "silent! write"
    end
  end,
})
