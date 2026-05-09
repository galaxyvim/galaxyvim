return function(main, style)
  local header = {}
  local top_buttons = {
    opts = {},

    val = {
      { "n", "󰈔" .. "  New File", "<CMD>enew<CR>" },
    },
  }
  local bottom_buttons = {
    val = {
      { "q", "" .. "  Quit", "<CMD>quit<CR>" },
    },
  }
  main.setButtons(style, top_buttons)
  main.setButtons(style, bottom_buttons)
  return {
    header = header,
    top_buttons = top_buttons,
    bottom_buttons = bottom_buttons,
  }
end
