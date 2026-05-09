local function component()
  return {
    function()
      local file = vim.fn.expand "%:p"

      -- If no file or buffer is not associated with a file
      if file == "" or vim.fn.filereadable(file) == 0 then
        return ""
      end

      local size = vim.fn.getfsize(file)

      -- If size is invalid
      if size <= 0 then
        return "0B"
      end

      local units = { "B", "KB", "MB", "GB" }
      local i = 1

      while size > 1024 and i < #units do
        size = size / 1024
        i = i + 1
      end

      return string.format("%.1f%s", size, units[i])
    end,
  }
end

return component()
