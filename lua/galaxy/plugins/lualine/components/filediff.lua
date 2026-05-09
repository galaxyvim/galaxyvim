-- check if file is inside git repo
local function in_git_repo(path)
  if path == "" then
    return false
  end

  local dir = vim.fn.fnamemodify(path, ":p:h")
  local git = vim.fn.finddir(".git", dir .. ";")

  return git ~= ""
end

-- read file from disk
local function read_file_lines(path)
  local file = io.open(path, "r")
  if not file then
    return {}
  end

  local lines = {}
  for line in file:lines() do
    table.insert(lines, line)
  end

  file:close()
  return lines
end

-- diff stats
return {
  function()
    local bufnr = vim.api.nvim_get_current_buf()
    local filepath = vim.api.nvim_buf_get_name(bufnr)

    -- ignore non-file buffers
    if filepath == "" or vim.bo[bufnr].buftype ~= "" then
      return ""
    end

    -- hide if git repo exists
    if in_git_repo(filepath) then
      return ""
    end

    local disk_lines = read_file_lines(filepath)
    local buf_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

    local diff = vim.diff(table.concat(disk_lines, "\n"), table.concat(buf_lines, "\n"), { result_type = "indices" })

    local added, removed, changed = 0, 0, 0

    for _, hunk in ipairs(diff) do
      local a_count = hunk[2]
      local b_count = hunk[4]

      if a_count > 0 and b_count == 0 then
        removed = removed + a_count
      elseif a_count > 0 and b_count > 0 then
        changed = changed + math.max(a_count, b_count)
      end
    end

    if removed == 0 and changed == 0 then
      return ""
    end

    -- return string.format("~%d -%d", changed, removed)
    local parts = {}

    -- table.insert(parts, "%#Normal#")

    if changed > 0 then
      table.insert(parts, "%#GitSignsChange#" .. nvim.icons.git.LineModified .. " " .. changed)
    end

    if removed > 0 then
      table.insert(parts, "%#GitSignsDelete#" .. nvim.icons.git.LineRemoved .. " " .. removed)
    end

    -- hide component completely if no diff
    if #parts == 0 then
      return nil
    end

    return table.concat(parts, " ")
  end,

  color = "",
  separator = "",
}
