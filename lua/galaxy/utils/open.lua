local M = {}

local pickers = {
  fzf = {},
  telescope = {
    explorer = "file_browser",
    zoxide = "zoxide list",
  },
  snacks = {
    colorscheme = "colorschemes",
    find_files = "files",
    help_tags = "help",
    man_pages = "man",
    live_grep = "grep",
    oldfiles = "recent",
    grep_string = "grep_word",
    yank_history = "yanky",
    current_buffer_fuzzy_find = "grep_buffers",
  },
}

local opts = {
  snacks = {
    explorer = {
      layout = {
        preset = "default",
      },
    },
  },
}

local function lazytable(tbl)
  tbl = tbl or {} -- optional initial table

  return setmetatable(tbl, {
    __index = function(_, key)
      return key or ""
    end,
  })
end

for key, value in pairs(pickers) do
  pickers[key] = lazytable(value)
end

function M.picker(name)
  local case = nvim.opt.provider.picker

  if not name then
    return nvim.plugins[case].enabled
  end

  name = pickers[case][name]

  if case == "telescope" then
    if not pcall(nvim.require, "telescope") then
      return
    end
    return vim.cmd("Telescope " .. name)
  elseif case == "snacks" then
    local snacks = nvim.require "snacks"
    if not name then
      return snacks.picker()
    end
    local conf = opts[case][name]
    return snacks.picker[name](conf)
  end
end

return M
