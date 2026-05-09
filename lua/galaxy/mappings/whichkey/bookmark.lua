local wk = require "which-key"
local key = "<leader>m"

if not nvim.plugins.bookmarks.enabled then
  return
end

wk.map = {
  key,
  icon = wk.icon { "󰃅", "yellow" },
  group = "Bookmark",

  {
    key .. "a",
    nvim.load(string.format("plugins.%s.pickers.bookmarks", nvim.opt.provider.picker)),
    desc = "Bookmarks",
  },

  {
    key .. "m",
    vim.cmd.BookmarkToggle,
    desc = "Toggle",
  },

  {
    key .. "i",
    vim.cmd.BookmarkAnnotate,
    desc = "Annotate",
  },

  {
    key .. "<Up>",
    vim.cmd.BookmarkMoveUp,
    desc = "Move Up",
  },
  {
    key .. "<Down>",
    vim.cmd.BookmarkMoveDown,
    desc = "Move Down",
  },

  {
    key .. "b",
    vim.cmd.BookmarkPrev,
    desc = "Prev",
  },

  {
    key .. "n",
    vim.cmd.BookmarkNext,
    desc = "Next",
  },

  {
    key .. "c",
    vim.cmd.BookmarkClear,
    desc = "Clear",
  },

  {
    key .. "x",
    vim.cmd.BookmarkClearAll,
    desc = "Clear All",
  },
}
