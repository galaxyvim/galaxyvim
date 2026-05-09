return {
  "branch",
  icon = nvim.icons.git.Branch,
  color = function()
    return {
      fg = nvim.hex.darken(nvim.hl.lualine_a_normal.bg, 0.80),
      bg = nvim.hex.lighten(nvim.hl.lualine_a_normal.bg, 0.5),
      gui = "bold",
    }
  end,
  separator = {
    right = "", -- the arrow glyph
  },

  on_click = function()
    if nvim.plugins.neogit.enabled then
      vim.cmd.Neogit()
    elseif nvim.plugins.fugitive.enabled then
      vim.cmd.Git()
    end
  end,
}
