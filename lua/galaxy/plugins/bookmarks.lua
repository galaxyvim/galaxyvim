local M = {}

M.config = function()
  return {
    "MattesGroeger/vim-bookmarks",
    cmd = {
      "BookmarkToggle",
      "BookmarkAnnotate",
      "BookmarkShowAll",
      "BookmarkNext",
      "BookmarkPrev",
      "BookmarkClear",
      "BookmarkClearAll",
      "BookmarkMoveUp",
      "BookmarkMoveDown",
      "BookmarkMoveToLine",
    },
    keys = { "mm", "mi", "mn", "mp", "ma", "mc", "mx", "mkk", "mjj", "mg" },
    branch = "master",
    modtrim = false,
    sign = nvim.icons.ui.BookMark,
    init = function(self)
      vim.g.bookmark_sign = self.sign
    end,
  }
end

return M
