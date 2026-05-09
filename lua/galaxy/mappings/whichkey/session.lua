local wk = require "which-key"

local key = "<leader>S"

-- session-manager.nvim
wk.map = {
  key,
  icon = wk.icon { "", "blue" },
  group = "Session",
  cond = nvim.plugins.session_manager.enabled,
  {
    key .. "l",
    function()
      require("session_manager").load_session()
    end,
    desc = "Load Session",
  },

  {
    key .. "r",
    function()
      require("session_manager").load_last_session()
    end,
    desc = "Restore Session",
  },

  {
    key .. "s",
    function()
      require("session_manager").save_current_session()
    end,
    desc = "Save Current Session",
  },

  {
    key .. "d",
    function()
      require("session_manager").delete_session()
    end,
    desc = "Delete Session",
  },
}
