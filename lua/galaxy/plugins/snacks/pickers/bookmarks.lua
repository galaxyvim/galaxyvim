return function()
  vim.cmd "silent! BookmarkShowAll"
  vim.cmd "silent! cclose"

  Snacks.picker.qflist {
    title = "Bookmarks",
    format = "file",
    layout = {},
  }
end
