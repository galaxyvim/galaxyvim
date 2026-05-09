return {
  function()
    local search = vim.fn.searchcount { maxcount = 0 }
    if search.current > 0 and vim.v.hlsearch ~= 0 then
      return "󱈆 " .. search.current .. "/" .. search.total
    else
      return ""
    end
  end,

  color = function()
    -- local hl = nvim.lazyload("lualine.highlight").get_lualine_hl

    return {
      fg = nvim.hl.lualine_a_command.bg,
    }
  end,
}
