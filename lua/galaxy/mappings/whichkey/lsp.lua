local wk = require "which-key"

-- trouble.nvim
-- which_key["x"] = {
--   name = "Trouble",

--   a = {
--     "<cmd>Trouble diagnostics toggle<cr>",
--     "All Diagnostics",
--   },

--   x = {
--     "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
--     "Buffer Diagnostics",
--   },

--   l = {
--     "<cmd>Trouble loclist toggle<cr>",
--     "Location List",
--   },

--   q = {
--     "<cmd>Trouble qflist toggle<cr>",
--     "Quickfix List",
--   },

--   s = {
--     "<cmd>Trouble symbols toggle focus=false<cr>",
--     "Symbols",
--   },
-- }

local key = "<leader>l"

wk.map = {

  key,
  cond = nvim.opt.provider.lsp == "nvim" and nvim.plugins.lspconfig.enabled,
  icon = wk.icon { "󰆧", "purple" },
  group = "LSP",
  -- code actions
  {
    key .. "a",
    mode = "n",
    "<cmd>lua vim.lsp.buf.code_action()<cr>",
    desc = "Code Action",
  },

  -- rename
  {
    key .. "r",
    mode = "n",
    "<cmd>lua vim.lsp.buf.rename()<cr>",
    desc = "Rename",
  },

  -- hover docs
  {
    key .. "k",
    mode = "n",
    "<cmd>lua vim.lsp.buf.hover()<cr>",
    desc = "Hover",
  },

  -- signature help
  {
    key .. "s",
    mode = "n",
    "<cmd>lua vim.lsp.buf.signature_help()<cr>",
    desc = "Signature Help",
  },

  -- goto definition
  {
    key .. "d",
    mode = "n",
    "<cmd>lua vim.lsp.buf.definition()<cr>",
    desc = "Goto Definition",
  },

  -- goto declaration
  {
    key .. "D",
    mode = "n",
    "<cmd>lua vim.lsp.buf.declaration()<cr>",
    desc = "Goto Declaration",
  },

  -- goto implementation
  {
    key .. "i",
    mode = "n",
    "<cmd>lua vim.lsp.buf.implementation()<cr>",
    desc = "Goto Implementation",
  },

  -- goto type definition
  {
    key .. "t",
    mode = "n",
    "<cmd>lua vim.lsp.buf.type_definition()<cr>",
    desc = "Goto Type Definition",
  },

  -- references
  {
    key .. "R",
    mode = "n",
    "<cmd>lua vim.lsp.buf.references()<cr>",
    desc = "References",
  },

  -- format
  {
    key .. "f",
    mode = "n",
    "<cmd>lua vim.lsp.buf.format({ async = true })<cr>",
    desc = "Format",
  },

  -- diagnostics float
  {
    key .. "e",
    mode = "n",
    "<cmd>lua vim.diagnostic.open_float()<cr>",
    desc = "Line Diagnostics",
  },

  -- document symbols
  {
    key .. "o",
    mode = "n",
    "<cmd>lua vim.lsp.buf.document_symbol()<cr>",
    desc = "Document Symbol",
  },

  -- workspace
  {
    key .. "w",
    proxy = "gaw",
    group = "Workspace",
  },

  -- diagnostic prev/next
  {
    key .. "[",
    mode = "n",
    "<cmd>lua vim.diagnostic.goto_prev()<cr>",
    desc = "Prev Diagnostic",
  },
  {
    key .. "]",
    mode = "n",
    "<cmd>lua vim.diagnostic.goto_next()<cr>",
    desc = "Next Diagnostic",
  },
}

wk.map = {
  icon = wk.icon { "󰆧", "purple" },
  { "ga", desc = "Actions" },
  { "gaw", desc = "Workspace" },
  { "gh", desc = "Hover Docs" },
  { "gs", desc = "Signature Help" },
  { "gd", desc = "Goto Definition" },
  { "gD", desc = "Goto Declaration" },
  { "gR", desc = "Goto References" },
  { "gy", desc = "Goto Type Definition" },
  { "gI", desc = "Goto Implementation" },
  { "gr", desc = "Rename Symbol" },
  { "gF", desc = "Format File" },
  { "gO", desc = "Document Symbols" },
  { "gaa", desc = "Code Action" },
  { "gal", desc = "Codelens" },
  { "gar", desc = "Refactor" },
  { "gaR", desc = "Refactor Selection" },
  { "gawa", desc = "Add Workspace Folder" },
  { "gawr", desc = "Remove Workspace Folder" },
  { "gawd", desc = "Reload Workspace" },
  { "gawl", desc = "List Workspace Folders" },
  { "gaws", desc = "Workspace Symbols" },
  { "gl", desc = "Diagnostic" },
  { "gk", desc = "Prev Diagnostic" },
  { "gj", desc = "Next Diagnostic" },
  { "gq", desc = "QuickFix List" },
}
