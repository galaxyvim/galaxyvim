return function()
  local builtin = nvim.require "telescope.builtin"

  vim.cmd "silent! BookmarkShowAll"
  vim.cmd "silent! cclose"

  -- open telescope quickfix picker
  builtin.quickfix {
    prompt_title = "Bookmarks",
    path_display = { "tail" }, -- only filename
  }
end
