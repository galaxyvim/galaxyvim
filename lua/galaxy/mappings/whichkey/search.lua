local wk = require "which-key"
local key = "<leader>s"

local function grugfar(name)
  local paths = 'paths = vim.fn.expand("%")'
  local search = 'search = vim.fn.expand("<cword>")'

  local commands = {
    project = "toggle_instance({})",
    VISUAL = "with_visual_selection()",
    visual = string.format("with_visual_selection({ prefills = { %s } })", paths),
    file = string.format("toggle_instance({ prefills = { %s } })", paths),
    CWORD = string.format("toggle_instance({ prefills = { %s } })", search),
    cword = string.format("toggle_instance({ prefills = { %s, %s } })", search, paths),
  }

  return function()
    local command = 'lua require("grug-far").' .. commands[name]
    vim.cmd(command)
  end
end

wk.map = {
  key,
  group = "Search",
  cond = nvim.open.search,

  -- word
  {
    key .. "W",
    grugfar "CWORD",
    desc = "Search Word in Project",
  },
  {
    key .. "w",
    grugfar "cword",
    desc = "Search Word in File",
  },

  -- visual
  {
    key .. "V",
    mode = "v",
    grugfar "VISUAL",
    desc = "Search Selection in Project",
  },
  {
    key .. "v",
    mode = "v",
    grugfar "visual",
    desc = "Search Selection in File",
  },

  -- file / project
  {
    key .. "f",
    grugfar "file",
    desc = "Search in File",
  },
  {
    key .. "p",
    grugfar "project",
    desc = "Search in Project",
  },

  {
    key .. "r",
    "<cmd>Match<cr>",
    desc = "Search and Replace",
  },
  {
    key .. "c",
    "<cmd>MatchWord<cr>",
    desc = "Match Current Word",
  },
  {
    key .. "l",
    "<cmd>MatchLine<cr>",
    desc = "Match Current Line",
  },
}
