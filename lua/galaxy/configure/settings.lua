---------------------------▶ General ◀-------------------------------

vim.g.mapleader = " "
vim.g.maplocalleader = ";"
vim.g.debug = false

nvim.opt.auto = {
  save = false,
  format = false,
  shebang = false,
  tabhelp = true,
}

----------------------------▶ UI ◀-------------------------------

nvim.colorscheme = "pastel" -- list all colorscheme using <leader>uc

nvim.opt.transparency = {
  ui = 0,     -- background
  float = 0,  -- float window
  popup = 10, -- popup menu
}

nvim.opt.cursor = {
  animate = true,
}

nvim.opt.scroll = {
  smooth = true,
}

--------------------------▶ Styling ◀-------------------------------

nvim.opt.icons = {
    enabled = true,
    colors = true,
    kind = "material",      -- material | codicons | fontawesome
    diagnostics = "filled", -- filled | outline
    debug = "material",     -- material | codicons
    git = "filled",         -- filled | outline
  }

nvim.opt.style = {
  alpha = "dashboard",      -- dashboard | startify | theta
  whichkey = "classic",     -- classic | modern | helix
  colorizer = "background", -- background | foreground | underline | virtualtext

  lualine = {
    style = "modern",   -- default | modern
    theme = "auto",     -- auto | or any colorscheme
    component = {
      mode = "default", -- default | alpha | beta | helix | icons
      lsp = "count",    -- count | name
    },
  },
}

-------------------------▶ Providers ◀-------------------------------

nvim.opt.provider = {
  picker = "telescope",      -- telescope | snacks
  cmp = "nvim-cmp",          -- nvim-cmp | blink-cmp
  lsp = "nvim",              -- nvim | coc
}

----------------------------▶ LSP ◀-------------------------------

nvim.opt.lsp = {
  autostart = true,
  autoinstall = false,
  onhover = {
    diagnostic = true,
    docs = false,
  },
  border = "rounded",
  inlayhint = false,
  progress = {
    disabled = {
      "pyright",
    },
  },
}

-------------------------▶ Treesitter ◀-------------------------------

nvim.opt.treesitter = {
  textobjects = true,
  highlights = true,
  autotag = true,
  context = true,
  indent = true,
  folds = true,
  language = {
    javascriptreact = "tsx",
    typescriptreact = "tsx",
    sh = "bash"
  },
}
