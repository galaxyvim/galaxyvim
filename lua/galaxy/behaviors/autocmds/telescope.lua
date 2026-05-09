nvim.create_autocmd("User", {
  pattern = "TelescopePreviewerLoaded",
  callback = function(args)
    vim.wo.number = true
    vim.wo.wrap = false
  end,
})

