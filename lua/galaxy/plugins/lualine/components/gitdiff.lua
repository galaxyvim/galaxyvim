return {
  "diff",
  separator = {
    right = "", -- the arrow glyph
  },

  source = function()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
      return {
        added = gitsigns.added,
        modified = gitsigns.changed,
        removed = gitsigns.removed,
      }
    end
  end,

  symbols = {
    added = nvim.icons.git.Added .. " ",
    modified = nvim.icons.git.Modified .. " ",
    removed = nvim.icons.git.Removed .. " ",
  },

  on_click = function()
    if nvim.plugins.gitsigns.enabled then
      vim.cmd.Gitsigns "toggle_linehl"
      vim.cmd.Gitsigns "toggle_deleted"
    end
  end,
}
