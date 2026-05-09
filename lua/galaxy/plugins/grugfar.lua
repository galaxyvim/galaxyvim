local M = {}

M.config = function()
  return {
    "MagicDuck/grug-far.nvim",
    main = "grug-far",
    lazy = true,
    opts = {
      transient = true,
      showEngineInfo = false,
      showCompactInputs = false,
      resultsSeparatorLineChar = "─",

      spinnerStates = nvim.icons.spinner.Arc,

      icons = {
        -- whether to show icons
        enabled = true,

        -- provider to use for file icons
        -- acceptable values: 'first_available', 'nvim-web-devicons', 'mini.icons', false (to disable)
        fileIconsProvider = "first_available",

        actionEntryBullet = " ",

        searchInput = " ",
        replaceInput = " ",
        filesFilterInput = " ",
        flagsInput = "󰮚 ",
        pathsInput = " ",

        resultsStatusReady = "󱩾 ",
        resultsStatusError = " ",
        resultsStatusSuccess = "󰗡 ",
        resultsActionMessage = "  ",
        resultsEngineLeft = "⟪",
        resultsEngineRight = "⟫",
        resultsChangeIndicator = "┃",
        resultsAddedIndicator = "▒",
        resultsRemovedIndicator = "▒",
        resultsDiffSeparatorIndicator = "┊",
        historyTitle = "   ",
        helpTitle = " 󰘥  ",
        lineNumbersEllipsis = " ",

        newline = " ",
      },

      keymaps = {
        replace = { n = "<localleader>r" },
        qflist = { n = "<localleader>q" },
        syncLocations = { n = "<localleader>s" },
        syncLine = { n = "<localleader>l" },
        close = { n = "<localleader>c" },
        historyOpen = { n = "<localleader>t" },
        historyAdd = { n = "<localleader>a" },
        refresh = { n = "<localleader>f" },
        openLocation = { n = "<localleader>o" },
        openNextLocation = { n = "<down>" },
        openPrevLocation = { n = "<up>" },
        gotoLocation = { n = "<enter>" },
        pickHistoryEntry = { n = "<enter>" },
        abort = { n = "<localleader>b" },
        help = { n = "?" },
        toggleShowCommand = { n = "<localleader>w" },
        swapEngine = { n = "<localleader>e" },
        previewLocation = { n = "<localleader>i" },
        swapReplacementInterpreter = { n = "<localleader>x" },
        applyNext = { n = "<localleader>j" },
        applyPrev = { n = "<localleader>k" },
        syncNext = { n = "<localleader>n" },
        syncPrev = { n = "<localleader>p" },
        syncFile = { n = "<localleader>v" },
        nextInput = { n = "<tab>" },
        prevInput = { n = "<s-tab>" },
      },
    },
    config = true,
  }
end

return M
