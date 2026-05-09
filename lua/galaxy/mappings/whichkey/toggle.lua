local wk = require "which-key"

local key = "<leader><space>"

--─────────────────────────▶ wk(Toggles) ◀───────────────────────────────

wk.map = {
  key,
  group = "Toggle",
  icon = "",

  {
    key .. "a",
    nvim.toggle.autosave,
    icon = wk.icon { "󰳻", "yellow" },
    desc = "Autosave",
  },

  {
    mode = { "n", "x" },
    key .. "b",
    nvim.toggle.background,
    desc = "Background",
    icon = wk.icon { "󰔎", "blue" },
  },

  {
    mode = { "n", "x" },
    key .. "c",
    nvim.toggle.smartcase,
    desc = "Smartcase",
    icon = wk.icon { "󰉿", "blue" },
  },

  {
    mode = { "n", "x" },
    key .. "C",
    vim.cmd.ColorizerToggle,
    cond = nvim.plugins.colorizer.enabled,
    desc = "Colorizer",
    icon = wk.icon { "󱥚", "blue" },
  },

  {
    key .. "L",
    vim.cmd.LiveServerToggle,
    cond = nvim.plugins.liveserver.enabled,
    icon = wk.icon { "", "cyan" },
    desc = "LiveServer",
  },

  {
    key .. "w",
    icon = "󰖶",
    nvim.toggle.wrap,
    desc = "Wrap",
  },

  {
    key .. "s",
    icon = wk.icon { "󰌌", "blue" },
    "<cmd>ShowkeysToggle<cr>",
    cond = nvim.plugins.showkeys.enabled,
    desc = "Screencast",
  },

  {
    key .. "t",
    icon = wk.icon { "󰐅", "green" },
    group = "Treesitter",
    cond = nvim.plugins.treesitter.enabled,
    {
      key .. "th",
      nvim.toggle.ts_buf_highlight,
      desc = "Highlight Buffer",
    },
    {
      key .. "ti",
      nvim.toggle.ts_buf_indent,
      desc = "Indent Buffer",
    },
    {
      key .. "tc",
      nvim.toggle.ts_context,
      desc = "Context Global",
    },
    {
      key .. "tH",
      nvim.toggle.ts_highlight,
      desc = "Highlight Global",
    },

    {
      key .. "tI",
      nvim.toggle.ts_indent,
      desc = "Indent Global",
    },
  },

  {
    key .. "l",
    group = "LSP",
    icon = wk.icon { "󰆧", "purple" },
    cond = nvim.plugins.lspconfig.enabled,

    {
      key .. "lh",
      nvim.toggle.lsp.inlay,
      desc = "Inlay Hints",
    },
    {
      key .. "ld",
      nvim.toggle.lsp.diagnostics,
      desc = "Diagnostics",
    },
    {
      key .. "lv",
      nvim.toggle.lsp.virtual_text,
      desc = "Virtual Text",
    },
    {
      key .. "ls",
      nvim.toggle.lsp.semantic_tokens,
      desc = "Semantic Highlight",
    },
    {
      key .. "lc",
      nvim.toggle.lsp.codelens,
      desc = "CodeLens",
    },
    {
      key .. "lf",
      nvim.toggle.lsp.format_on_save,
      desc = "Format on Save",
    },
  },

  {
    key .. "o",
    group = "Options",
    icon = "",
    {
      key .. "oa",
      function()
        nvim.toggle.opt("autochdir", "Autochdir")
      end,
      desc = "Autochdir",
    },
    {
      key .. "on",
      function()
        nvim.toggle.opt("number", "Line Numbers")
      end,
      desc = "Line numbers",
    },
    {
      key .. "or",
      function()
        nvim.toggle.opt("relativenumber", "Relative Numbers")
      end,
      desc = "Relative numbers",
    },
    {
      key .. "os",
      {
        key .. "osc",
        nvim.toggle.statuscolumn,
        desc = "Statuscolumn",
      },
      {
        key .. "osl",
        nvim.toggle.statusline,
        desc = "Statusline",
      },
      {
        key .. "osS",
        nvim.toggle.signcolumn,
        desc = "Signcolumn",
      },
      {
        key .. "ost",
        nvim.toggle.tabline,
        desc = "Tabline",
      },
      {
        key .. "osp",
        function()
          nvim.toggle.opt("spell", "Spell")
        end,
        desc = "Spell check",
      },
    },
    {
      key .. "ol",
      function()
        nvim.toggle.opt("list", "List chars")
      end,
      desc = "List chars",
    },
    {
      key .. "oc",
      function()
        nvim.toggle.opt("cursorline", "Cursor line")
      end,
      desc = "Cursor line",
    },
    {
      key .. "oh",
      function()
        nvim.toggle.opt("hlsearch", "Highlight search")
      end,
      desc = "Search highlight",
    },
    {
      key .. "oi",
      function()
        nvim.toggle.opt("ignorecase", "Ignore case")
      end,
      desc = "Ignore case",
    },
    {
      key .. "op",
      function()
        nvim.toggle.opt("paste", "Paste mode")
      end,
      desc = "Paste mode",
    },
  },
}
