return function(main, style)
  local header, buttons, footer

  header = {
    val = nil,
  }

  buttons = {
    opts = {
      hl_shortcut = "Include",
      spacing = 1,
    },
    val = {
      { "n", "󰈔" .. "  New File", "<CMD>enew<CR>" },
      { "f", "󰈞" .. "  Find File", "<CMD>Telescope find_files<CR>" },
      { "g", "" .. "  Find Text", "<CMD>lua nvim.open.picker('live_grep')<CR>" },
      { "r", "󰈢" .. "  Recent Files", "<CMD>lua nvim.open.picker('oldfiles') <CR>" },
      { "m", "󰃅" .. "  Bookmarks", nvim.load("plugins." .. nvim.opt.provider.picker .. ".pickers.bookmarks") },
      { "t", "" .. "  Terminal", "<CMD>Term<CR>" },
      { "s", "󰙰" .. "  Last Session", "<CMD>lua nvim.require('session_manager').load_last_session()<CR>" },
      { "c", "" .. "  Configuration", "<CMD>edit " .. nvim.stdpath.config .. "/configs.lua" .. " <CR>" },
      { "q", "" .. "  Quit", "<CMD>quit<CR>" },
    },
  }

  local stats = nvim.lazy.stats()
  local plugs = stats.loaded .. "/" .. stats.count
  local time = (stats.times.LazyDone - stats.times.LazyStart)

  footer = {
    val = {
      "Neovim loaded " .. plugs .. " 󰏗 in " .. string.format("%.2f", time) .. "ᵐˢ",
    },
  }

  main.setButtons(style, buttons)

  return {
    header = header,
    buttons = buttons,
    footer = footer,
  }
end
