local M = {}

M.config = function()
  return {
    "Shatur/neovim-session-manager",
    main = "session_manager",
    dependencies = { "plenary.nvim" },
    event = "User UIReady",
    opts = {
      autosave_last_session = true,
      autosave_ignore_not_normal = true,
      autosave_ignore_filetypes = { "gitcommit", "gitrebase", "svn", "hgcommit" },
    },
    preload = function()
      local config = nvim.require "session_manager.config"

      return {
        sessions_dir = nvim.mkdir(nvim.stdpath.data .. "/sessions"),
        autoload_mode = config.AutoloadMode.Disabled,
      }
    end,

    config = true,
  }

  
end

return M
