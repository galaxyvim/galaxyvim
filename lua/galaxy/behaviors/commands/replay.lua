vim.api.nvim_create_user_command("Replay", function(opts)
  local lines = {}
  local delay = 10
  local filepath = ""
  local fargs = opts.fargs

  if #fargs == 1 then
    if tonumber(fargs[1]) then
      delay = tonumber(fargs[1])
    else
      filepath = fargs[1]
    end
  elseif #fargs == 2 then
    filepath = fargs[1]
    delay = tonumber(fargs[2]) or 10
  end

  if delay < 1 then
    return vim.notify "Delay must be at least 1 second!"
  end

  local filename = ""
  local filetype = vim.bo.filetype

  if filepath ~= "" then
    local file = io.open(filepath, "r")
    if not file then
      vim.notify("Typewriter: Cannot open file " .. filepath, vim.log.levels.ERROR)
      return
    end
    for line in file:lines() do
      table.insert(lines, line)
    end
    file:close()
    filename = vim.fn.fnamemodify(filepath, ":t")
  else
    lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    filename = vim.fn.expand "%:t"
  end

  vim.cmd.set "nobuflisted"

  local scratch_buf = vim.api.nvim_create_buf(true, true)
  pcall(vim.api.nvim_buf_set_name, scratch_buf, "/" .. filename)
  vim.bo[scratch_buf].filetype = filetype
  vim.api.nvim_win_set_buf(0, scratch_buf)

  local row = 0
  local stop = false

  for _, line in ipairs(lines) do
    if stop then
      break
    end

    if row > 0 then
      vim.api.nvim_buf_set_lines(scratch_buf, row, row, false, { "" })
    end

    local chars = vim.fn.split(line, "\\zs")
    local current_str = ""

    for _, char in ipairs(chars) do
      local key = vim.fn.getchar(0)
      if key == 27 or key == "\27" then
        stop = true -- Stop on Escape key
      end

      current_str = current_str .. char

      vim.api.nvim_buf_set_lines(scratch_buf, row, row + 1, false, { current_str })
      vim.api.nvim_win_set_cursor(0, { row + 1, #current_str })

      vim.cmd "redraw"
      vim.cmd("sleep " .. delay .. "m")
    end
    row = row + 1
  end
end, {
  nargs = "*",
  complete = "file",
  desc = "Animate the current buffer in scratch buffer. Usage: :Replay [file] [ms]",
})
