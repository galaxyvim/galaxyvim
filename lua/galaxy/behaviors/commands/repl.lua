-- REPL definitions (your requested style)
local repl = {
  python = "python3",
  java = "jshell",
  node = "node",
  ruby = "irb",
  lua = "lua",
}

-- runtime terminal cache (so toggle works properly)
local repl_terminals = {}

local function get_terminal(name, rest)
  local Terminal = nvim.require("toggleterm.terminal").Terminal

  if repl_terminals[name] then
    return repl_terminals[name]
  end

  local cmd = repl[name] or name
  if vim.fn.executable(cmd) ~= 1 then
    vim.notify(string.format("%s is not executable!", cmd))
    return nil
  end

  cmd = rest and cmd .. " " .. rest or cmd

  local term = Terminal:new {
    cmd = cmd,
    hidden = true,
    direction = "horizontal",
    close_on_exit = true,
  }

  repl_terminals[name] = term
  return term
end

local function toggle_repl(name)
  local term = get_terminal(name)

  if not term then
    vim.notify("Unknown REPL: " .. name, vim.log.levels.ERROR)
    return
  end

  term:toggle()
end

-- :Repl command
vim.api.nvim_create_user_command("Repl", function(opts)
  local name, rest = opts.args:match "^(%S+)%s*(.*)$"
  toggle_repl(name, rest)
end, {
  nargs = "*",

  -- completion from table keys (your request)
  complete = function()
    return vim.tbl_keys(repl)
  end,
})
