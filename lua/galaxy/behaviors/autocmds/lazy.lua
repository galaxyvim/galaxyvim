vim.api.nvim_create_autocmd("User", {
  pattern = "LazyDone",
  once = true,
  callback = function()
    vim.schedule(function()
      local lazy = false
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)

        if vim.api.nvim_buf_is_valid(buf) then
          local ft = vim.bo[buf].filetype

          if ft == "lazy" then
            lazy = true
            vim.api.nvim_set_current_win(win) -- focus lazy window
            vim.cmd "close"
            break
          end
        end
      end

      local file = vim.api.nvim_buf_get_name(0)
      local ft = vim.bo.ft

      if lazy and ft ~= "alpha" and file == "" and package.loaded.alpha then
        vim.cmd.Alpha()
      end
    end)
  end,
})
