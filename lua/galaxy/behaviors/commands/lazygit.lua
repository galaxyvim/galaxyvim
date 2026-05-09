local cmd = "lazygit"

local lazygit = function(args, dir)
  local Terminal = nvim.require("toggleterm.terminal").Terminal

  local term = Terminal:new {
    cmd = string.format("%s %s", cmd, args or ""),
    dir = dir,
    display_name = "lazygit",
    direction = "float",
    hidden = true,
    float_opts = {
      border = "none",
      width = 100000,
      height = 100000,
      zindex = 200,
    },
    close_on_exit = true,
    start_in_insert = true,
    auto_scroll = true,
    on_open = function(_)
      vim.cmd "startinsert!"
    end,
  }
  term:toggle()
end

-- get git root from any directory
local function get_git_root(path)
  local root = vim.fn.systemlist("git -C " .. vim.fn.shellescape(path) .. " rev-parse --show-toplevel")[1]

  if vim.v.shell_error ~= 0 or not root or root == "" then
    return nil
  end

  return root
end

vim.api.nvim_create_user_command("LazyGit", function()
  if vim.fn.executable(cmd) ~= 1 then
    return vim.notify "lazygit binary not found!"
  end

  local cwd = vim.fn.getcwd()
  local git_root = get_git_root(cwd)

  if not git_root then
    vim.notify("Not a git repository", vim.log.levels.ERROR)
    return
  end

  lazygit("", git_root)
end, {})

vim.api.nvim_create_user_command("LazyGitCurrentFile", function()
  if vim.fn.executable(cmd) ~= 1 then
    return vim.notify "lazygit binary not found!"
  end

  if vim.bo.buftype == "terminal" then
    vim.notify("LazyGitCurrentFile not available in terminal buffer", vim.log.levels.WARN)
    return
  end

  local file_dir = vim.fn.expand "%:p:h"
  local git_root = get_git_root(file_dir)

  if not git_root then
    vim.notify("Not a git repository", vim.log.levels.ERROR)
    return
  end

  lazygit("", git_root)
end, {})

vim.api.nvim_create_user_command("LazyGitFilter", function(opts)
  if vim.fn.executable(cmd) ~= 1 then
    return vim.notify "lazygit binary not found!"
  end

  local cwd = vim.fn.getcwd()
  local git_root = get_git_root(cwd)

  if not git_root then
    vim.notify("Not a git repository", vim.log.levels.ERROR)
    return
  end

  lazygit("-f " .. vim.fn.shellescape(opts.args), git_root)
end, { nargs = 1 })

vim.api.nvim_create_user_command("LazyGitFilterCurrentFile", function()
  if vim.fn.executable(cmd) ~= 1 then
    return vim.notify "lazygit binary not found!"
  end

  if vim.bo.buftype == "terminal" then
    vim.notify("LazyGitFilterCurrentFile not available in terminal buffer", vim.log.levels.WARN)
    return
  end

  local file_path = vim.fn.expand "%:p"
  local file_dir = vim.fn.expand "%:p:h"
  local git_root = get_git_root(file_dir)

  if not git_root then
    vim.notify("Not a git repository", vim.log.levels.ERROR)
    return
  end

  local relative_path = file_path:sub(#git_root + 2)

  lazygit("-f " .. vim.fn.shellescape(relative_path), git_root)
end, {})
