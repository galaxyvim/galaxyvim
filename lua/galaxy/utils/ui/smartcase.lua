local function GetVisPos()
  -- Get the "live" positions
  local pos1 = vim.fn.getpos "v" -- Where you started selecting
  local pos2 = vim.fn.getpos "." -- Where your cursor is right now

  return pos1, pos2
end

local function normalize_pos(a, b)
  if a[2] > b[2] or (a[2] == b[2] and a[3] > b[3]) then
    return b, a
  end
  return a, b
end

local function GetVisCoordinate()
  local pos1, pos2 = normalize_pos(GetVisPos())

  local start_row = pos1[2] - 1
  local start_col = pos1[3] - 1
  local end_row = pos2[2] - 1
  local end_col = pos2[3] - 1

  return start_row, start_col, end_row, end_col
end

function CapLastVis()
  vim.cmd 'normal! gv"xy'
  local txt = vim.fn.getreg "x"
  local tbl = {}
  for line in txt:gmatch "[^\n]+" do
    table.insert(tbl, line)
  end
  return tbl
end

local function CapLiveVis()
  local pos1, pos2 = GetVisPos()
  -- Get the current mode (v, V, or <C-v>)
  local mode = vim.fn.mode()

  -- Grab the selected region text
  -- getregion handles it perfectly even if pos2 is "before" pos1
  local lines = vim.fn.getregion(pos1, pos2, { type = mode })

  -- Debug: See the result in the messages (:messages)
  local text = table.concat(lines, "\n")
  return text
end

local function replace_buffer(text)
  -- get current buffer
  local buf = vim.api.nvim_get_current_buf()

  -- split text into lines (required format)

  local lines = vim.split(text, "\n", { plain = true })

  -- replace all lines in buffer
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end

local function replace_visual(text)
  local srow, scol, erow, ecol = GetVisCoordinate()
  local mode = vim.fn.mode()

  -- getregion handles it perfectly even if pos2 is "before" pos1
  -- local lines = vim.fn.getregion(pos1, pos2, { type = mode })

  local lines = vim.split(text, "\n", { plain = true })
  vim.api.nvim_buf_set_text(0, srow, scol, erow, ecol, lines)
end

local function returnCase(text)
  local result
  if text:match "^%l+$" then
    result = text:upper()
  elseif text:match "^%u+$" then
    result = text:lower()
  elseif text:match "^%u%l+$" then
    result = text:lower()
  else
    result = text:upper()
  end

  return result
end

local function smartcase()
  local mode = vim.fn.mode()

  if mode:match "[vV]" then
    local text = CapLiveVis()

    replace_visual(returnCase(text))

    -- vim.cmd('normal! gU')
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
    return
  end

  local word = vim.fn.expand "<cword>"
  if word == "" then
    return
  end

  if word:match "^%l+$" then
    vim.cmd "normal! gUiw"
  elseif word:match "^%u+$" then
    vim.cmd "normal! guiw"
  elseif word:match "^%u%l+$" then
    vim.cmd "normal! guiw"
  else
    local fixed = word:lower():gsub("^%l", string.upper)
    vim.cmd("normal! ciw" .. fixed)
  end
end

return smartcase
