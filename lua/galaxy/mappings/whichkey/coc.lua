local wk = require "which-key"
local key = "<leader>c"

wk.map = {
  key,
  cond = nvim.opt.provider.lsp == "coc" and nvim.plugins.coc.enabled,
  icon = wk.icon { "󰆧", "green" },
  group = "COC",

  -- INFO
  {
    key .. "h",
    mode = "n",
    "<CMD>lua _G.show_docs()<CR>",
    desc = "Hover Docs",
  },
  {
    key .. "s",
    mode = "n",
    ":call CocActionAsync('showSignatureHelp')<CR>",
    desc = "Signature Help",
  },

  -- NAVIGATION
  {
    key .. "d",
    mode = "n",
    "<Plug>(coc-definition)",
    desc = "Goto Definition",
  },
  {
    key .. "D",
    mode = "n",
    "<Plug>(coc-declaration)",
    desc = "Goto Declaration",
  },
  {
    key .. "r",
    mode = "n",
    "<Plug>(coc-references)",
    desc = "Goto References",
  },
  {
    key .. "y",
    mode = "n",
    "<Plug>(coc-type-definition)",
    desc = "Goto Type Definition",
  },
  {
    key .. "i",
    mode = "n",
    "<Plug>(coc-implementation)",
    desc = "Goto Implementation",
  },

  -- FORMAT
  {
    key .. "f",
    mode = { "n", "x" },
    "<Plug>(coc-format-selected)",
    desc = "Format Selection/File",
  },

  -- SYMBOLS
  {
    key .. "o",
    mode = "n",
    ":CocList outline<CR>",
    desc = "Document Symbols",
  },

  -- ACTIONS group
  {
    key .. "a",
    group = "Actions",
  },

  {
    key .. "al",
    mode = "n",
    "<Plug>(coc-codelens-action)",
    desc = "Run CodeLens",
  },
  {
    key .. "aa",
    mode = { "n", "x" },
    "<Plug>(coc-codeaction-selected)",
    desc = "Code Action (Selected)",
  },
  {
    key .. "ac",
    mode = "n",
    "<Plug>(coc-codeaction-cursor)",
    desc = "Code Action (Cursor)",
  },
  {
    key .. "an",
    mode = "n",
    "<Plug>(coc-rename)",
    desc = "Rename Symbol",
  },
  {
    key .. "as",
    mode = "n",
    "<Plug>(coc-codeaction-source)",
    desc = "Source Actions",
  },

  -- WORKSPACE group
  {
    key .. "w",
    group = "Workspace",
  },

  {
    key .. "wa",
    mode = "n",
    ":CocCommand workspace.addFolder<CR>",
    desc = "Add Workspace Folder",
  },
  {
    key .. "wr",
    mode = "n",
    ":CocCommand workspace.removeFolder<CR>",
    desc = "Remove Workspace Folder",
  },
  {
    key .. "wd",
    mode = "n",
    ":CocCommand workspace.reload<CR>",
    desc = "Reload Workspace",
  },
  {
    key .. "wl",
    mode = "n",
    ":CocList workspace<CR>",
    desc = "List Workspace Folders",
  },
  {
    key .. "ws",
    mode = "n",
    ":<C-u>CocList -I symbols<cr>",
    desc = "Workspace Symbols",
  },

  -- REFACTOR group
  {
    key .. "R",
    group = "Refactor",
  },

  {
    key .. "Rr",
    mode = "n",
    "<Plug>(coc-codeaction-refactor)",
    desc = "Refactor",
  },
  {
    key .. "RR",
    mode = { "n", "x" },
    "<Plug>(coc-codeaction-refactor-selected)",
    desc = "Refactor Selection",
  },

  -- DIAGNOSTICS group
  {
    key .. "e",
    group = "Diagnostics",
  },

  {
    key .. "ek",
    mode = "n",
    "<Plug>(coc-diagnostic-prev)",
    desc = "Prev Diagnostic",
  },
  {
    key .. "ej",
    mode = "n",
    "<Plug>(coc-diagnostic-next)",
    desc = "Next Diagnostic",
  },
  {
    key .. "eq",
    mode = "n",
    "<Plug>(coc-fix-current)",
    desc = "QuickFix List",
  },

  -- LIST group
  {
    key .. "l",
    group = "Lists",
  },

  {
    key .. "ll",
    mode = "n",
    ":CocList<CR>",
    desc = "Open Coc List",
  },
  {
    key .. "ld",
    mode = "n",
    ":<C-u>CocList diagnostics<cr>",
    desc = "Diagnostics List",
  },
  {
    key .. "le",
    mode = "n",
    ":<C-u>CocList extensions<cr>",
    desc = "Extensions List",
  },
  {
    key .. "lc",
    mode = "n",
    ":<C-u>CocList commands<cr>",
    desc = "Commands List",
  },
  {
    key .. "lo",
    mode = "n",
    ":<C-u>CocList outline<cr>",
    desc = "Outline",
  },
  {
    key .. "ls",
    mode = "n",
    ":<C-u>CocList -I symbols<cr>",
    desc = "Workspace Symbols",
  },
  {
    key .. "lj",
    mode = "n",
    ":<C-u>CocNext<cr>",
    desc = "Next List Item",
  },
  {
    key .. "lk",
    mode = "n",
    ":<C-u>CocPrev<cr>",
    desc = "Prev List Item",
  },
  {
    key .. "lp",
    mode = "n",
    ":<C-u>CocListResume<cr>",
    desc = "Resume List",
  },
  {
    key .. "lw",
    mode = "n",
    ":CocList workspace<CR>",
    desc = "List Workspace Folders",
  },
}
