local M = {}

M.config = function()
  return {
    "NeogitOrg/neogit",
    dependencies = {
      "plenary.nvim", -- required
      "diffview",
      "telescope",
      "snacks",
    },
    cmd = "Neogit",
    opts = {
      -- Change the default way of opening neogit
      kind = "tab", -- "tab" | "split" | "vsplit" | "floating" | "auto"
      -- Floating window style
      floating = {
        relative = "editor",
        width = 0.85,
        height = 0.85,
        style = "minimal",
        border = "rounded",
      },
      signs = {
        -- { CLOSED, OPENED }
        hunk = { "", "" },
        item = { "", "" },
        section = { "", "" },
      },
      commit_editor = {
        kind = "tab", -- opens commit window as horizontal split (bottom)
        staged_diff_split_kind = "split_above",
      },
      integrations = {
        diffview = true,
        telescope = nvim.opt.provider.picker == "telescope",
        snacks = nvim.opt.provider.picker == "snacks",
      },
    },
    config = true,
  }
end

return M
