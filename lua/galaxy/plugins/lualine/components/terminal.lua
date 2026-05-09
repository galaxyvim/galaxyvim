return {
  cond = function()
    return vim.bo.buftype == ""
  end,
  function()
    return ""
  end,
  color = function()
    -- local hl = nvim.lazyload("lualine.highlight").get_lualine_hl

    return {
      fg = nvim.hl.lualine_a_command.bg,
      gui = "bold",
    }
 end,
  on_click = function()
    if nvim.plugins.toggleterm.enabled then
      vim.cmd.Term()
    end
  end,
}
