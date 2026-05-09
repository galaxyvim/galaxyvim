vim.api.nvim_create_user_command("RevealDir", function(opts)
  local dir = opts.args ~= "" and vim.fn.expand(opts.args) or vim.fn.expand "%:p:h"

  if vim.fn.isdirectory(dir) ~= 1 then
    vim.notify("Not a directory: " .. dir, vim.log.levels.ERROR)
    return
  end

  local cmd

  if vim.fn.has "win32" == 1 then
    cmd = { "explorer", dir }
  elseif vim.fn.has "mac" == 1 then
    cmd = { "open", dir }
  else
    cmd = { "xdg-open", dir }
  end
  vim.system(cmd)
end, {
  desc = "Reveal directory in file manager",
  nargs = "?",
  complete = "dir",
})

vim.api.nvim_create_user_command("RevealFile", function(opts)
  local file = opts.args ~= "" and vim.fn.expand(opts.args) or vim.fn.expand "%:p"

  if vim.fn.filereadable(file) ~= 1 then
    vim.notify("Not a file: " .. file, vim.log.levels.ERROR)
    return
  end

  local cmd

  if vim.fn.has "win32" == 1 then
    cmd = { "explorer", "/select,", file }
  elseif vim.fn.has "mac" == 1 then
    cmd = { "open", "-R", file }
  else
    -- Linux fallback: open directory
    cmd = { "xdg-open", file }
  end
  vim.system(cmd)
end, {
  desc = "Reveal file in file manager",
  nargs = "?",
  complete = "file",
})

vim.api.nvim_create_user_command("Reveal", function(opts)
  local target = opts.args ~= "" and opts.args or vim.fn.expand "%:p"

  if target == "" then
    vim.notify("No file to reveal", vim.log.levels.WARN)
    return
  end

  target = vim.fn.expand(target)

  if vim.fn.isdirectory(target) == 1 then
    vim.cmd.RevealDir(target)
  else
    vim.cmd.RevealFile(target)
  end
end, {
  desc = "Reveal File/Dir in File Manager",
  nargs = "?",
  complete = function()
    -- show only filenames relative to current dir
    local files = vim.fn.readdir(vim.fn.getcwd())
    return files
  end,
})
