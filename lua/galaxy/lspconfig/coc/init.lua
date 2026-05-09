local M = nvim.lazytable()
local coc = {}
local icons = nvim.icons.diagnostics

coc.autostart = nvim.opt.lsp.autostart
coc.autoinstall = nvim.opt.lsp.autoinstall
coc.border = nvim.opt.lsp.border

coc.servers = {
  lua = {
    command = "lua-language-server",
    filetypes = { "lua" },
    rootPatterns = { ".git", ".luarc.json" },
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {},
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
}

coc.install = {
  tsserver = true,
  json = true,
  html = true,
  css = true,
  pyright = true,
  lua = true,
  emmet = true,
}

local function install()
  local stats = vim.fn.CocAction "extensionStats"

  -- build installed list
  local installed = {}
  for _, ext in ipairs(stats) do
    installed[ext.id] = true
  end

  -- install missing extensions
  for ext, cond in pairs(coc.install) do
    local extension = "coc-" .. ext
    if not installed[extension] and cond then
      vim.cmd("CocInstall " .. extension)
    end
  end
end

-- https://raw.githubusercontent.com/neoclide/coc.nvim/master/doc/coc-example-config.lua

-- Some servers have issues with backup files, see #649
vim.opt.backup = false
vim.opt.writebackup = false

local map = vim.keymap.set
local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }

function M.setup()
  nvim.merge(coc, M)

  if M.autoinstall then
    vim.api.nvim_create_autocmd("User", {
      pattern = "CocNvimInit",
      callback = install,
    })
  end

  local coc_config = {
    ["coc.enable"] = M.autostart,
    ---------------------------------------------------------------------------
    -- Diagnostics
    ---------------------------------------------------------------------------
    ["diagnostic.enable"] = true,
    ["diagnostic.virtualText"] = true,
    ["diagnostic.virtualTextCurrentLineOnly"] = false,
    ["diagnostic.checkCurrentLine"] = true,
    ["diagnostic.refreshOnInsertMode"] = false,
    ["diagnostic.level"] = "hint",

    ["diagnostic.errorSign"] = icons.ErrorBold,
    ["diagnostic.warningSign"] = icons.WarnBold,
    ["diagnostic.infoSign"] = icons.InfoBold,
    ["diagnostic.hintSign"] = icons.HintBold,

    ["diagnostic.messageTarget"] = "float",
    ["diagnostic.format"] = "[%source] %message",

    ["diagnostic.floatConfig"] = {
      border = coc.border,
      maxWidth = 80,
      focusable = false,
    },

    ---------------------------------------------------------------------------
    -- Hover
    ---------------------------------------------------------------------------
    ["hover.enable"] = true,
    ["hover.floatEnable"] = true,

    ["hover.floatConfig"] = {
      border = coc.border,
      maxWidth = 90,
    },

    ---------------------------------------------------------------------------
    -- Signature Help
    ---------------------------------------------------------------------------
    ["signature.enable"] = true,
    ["signature.target"] = "float",

    ["signature.floatConfig"] = {
      border = coc.border,
      maxWidth = 80,
    },

    ---------------------------------------------------------------------------
    -- Completion Engine
    ---------------------------------------------------------------------------
    ["suggest.enablePreview"] = true,
    ["suggest.noselect"] = false,
    ["suggest.timeout"] = 500,
    ["suggest.triggerAfterInsertEnter"] = true,

    ["suggest.maxCompleteItemCount"] = 15,
    ["suggest.minTriggerInputLength"] = 1,

    ["suggest.localityBonus"] = true,
    ["suggest.snippetIndicator"] = "",

    ["suggest.floatEnable"] = true,
    ["suggest.floatConfig"] = {
      border = coc.border,
      maxWidth = 80,
    },

    ---------------------------------------------------------------------------
    -- Documentation popup
    ---------------------------------------------------------------------------
    ["suggest.detailMaxLength"] = 80,
    ["suggest.labelMaxLength"] = 80,

    ---------------------------------------------------------------------------
    -- UI
    ---------------------------------------------------------------------------
    ["coc.preferences.formatOnSaveFiletypes"] = nvim.opt.auto.format and "*" or {},

    ["coc.preferences.useQuickfixForLocations"] = true,
    ["coc.preferences.jumpCommand"] = "edit",

    ---------------------------------------------------------------------------
    -- Performance
    ---------------------------------------------------------------------------
    ["coc.source.buffer.enable"] = true,
    ["coc.source.buffer.priority"] = 9,

    ["coc.source.path.enable"] = true,
    ["coc.source.path.priority"] = 8,

    ["coc.source.around.enable"] = true,
    ["coc.source.around.priority"] = 6,

    ["workspace.ignoredFolders"] = {
      "$HOME",
      "$HOME/.cargo/**",
      "$HOME/.rustup/**",
      "$HOME/.npm/**",
      "$HOME/.yarn/**",
      "$HOME/.cache/**",
      "$HOME/.local/**",
      "**/.git/**",
      "**/node_modules/**",
      "**/dist/**",
      "**/build/**",
    },

    ---------------------------------------------------------------------------
    -- Language Servers
    ---------------------------------------------------------------------------
    languageserver = coc.servers,
  }

  local path = nvim.stdpath.config .. "/coc-settings.json"

  local json = vim.fn.json_encode(coc_config)
  vim.fn.writefile({ json }, path)

  -----------------------[ Autopairs ]-------------------------------
  local ok, npairs = pcall(require, "nvim-autopairs")
  if ok then
    -- skip it, if you use another global object
    _G.MUtils = {}

    MUtils.completion_confirm = function()
      if vim.fn.pumvisible() ~= 0 then
        vim.fn["coc#_select_confirm"]()
      else
        return npairs.autopairs_cr()
      end
    end

    map("i", "<CR>", "v:lua.MUtils.completion_confirm()", opts)
  end

  --------------------------[ Keymaps ]-------------------------------

  function _G.check_back_space()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s" ~= nil
  end

  -- Use K to show documentation in preview window
  function _G.show_docs()
    local cw = vim.fn.expand "<cword>"
    if vim.fn.index({ "vim", "help" }, vim.bo.filetype) >= 0 then
      vim.api.nvim_command("h " .. cw)
    elseif vim.api.nvim_eval "coc#rpc#ready()" then
      vim.fn.CocActionAsync "doHover"
    else
      vim.api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
    end
  end

  -- Use Tab for trigger completion with characters ahead and navigate
  -- NOTE: There's always a completion item selected by default, you may want to enable
  -- no select by setting `"suggest.noselect": true` in your configuration file
  -- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
  -- other plugins before putting this into your config

  -- Cycle Complition
  map("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
  map("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

  -- Make <CR> to accept selected completion item or notify coc.nvim to format
  -- <C-g>u breaks current undo, please make your own choice
  map("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

  -- Use <c-j> to trigger snippets
  map("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
  -- Use <c-space> to trigger completion
  map("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })

  -- Highlight the symbol and its references on a CursorHold event(cursor is idle)
  nvim.create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold",
  })

  -- Setup formatexpr specified filetype(s)
  nvim.create_autocmd("FileType", {
    group = "CocGroup",
    pattern = "typescript,json",
    command = "setl formatexpr=CocAction('formatSelected')",
    desc = "Setup formatexpr specified filetype(s).",
  })

  local opts = { silent = true, nowait = true }

  local mappings = {

    -- INFO
    { "n", "gh", "<CMD>lua _G.show_docs()<CR>", { desc = "Hover Docs" } },
    { "n", "gs", ":call CocActionAsync('showSignatureHelp')<CR>", { desc = "Signature Help" } },

    -- NAVIGATION
    { "n", "gd", "<Plug>(coc-definition)", { desc = "Goto Definition" } },
    { "n", "gD", "<Plug>(coc-declaration)", { desc = "Goto Declaration" } },
    { "n", "gr", "<Plug>(coc-references)", { desc = "Goto References" } },
    { "n", "gy", "<Plug>(coc-type-definition)", { desc = "Goto Type Definition" } },
    { "n", "gI", "<Plug>(coc-implementation)", { desc = "Goto Implementation" } },

    -- FORMAT
    { { "n", "x" }, "gF", "<Plug>(coc-format-selected)", { desc = "Format Selection/File" } },

    -- SYMBOLS
    { "n", "gO", ":CocList outline<CR>", { desc = "Document Symbols" } },

    -- ACTIONS
    { "n", "gal", "<Plug>(coc-codelens-action)", { desc = "Run CodeLens" } },
    { { "n", "x" }, "gaa", "<Plug>(coc-codeaction-selected)", { desc = "Code Action (Selected)" } },
    { "n", "gac", "<Plug>(coc-codeaction-cursor)", { desc = "Code Action (Cursor)" } },
    { "n", "gan", "<Plug>(coc-rename)", { desc = "Rename Symbol" } },
    { "n", "gas", "<Plug>(coc-codeaction-source)", { desc = "Source Actions" } },

    -- WORKSPACE
    { "n", "gawa", ":CocCommand workspace.addFolder<CR>", { desc = "Add Workspace Folder" } },
    { "n", "gawr", ":CocCommand workspace.removeFolder<CR>", { desc = "Remove Workspace Folder" } },
    { "n", "gawd", ":CocCommand workspace.reload<CR>", { desc = "Reload Workspace" } },
    { "n", "gawl", ":CocList workspace<CR>", { desc = "List Workspace Folders" } },
    { "n", "gaws", ":<C-u>CocList -I symbols<cr>", { desc = "Workspace Symbols" } },

    -- REFACTOR
    { "n", "gar", "<Plug>(coc-codeaction-refactor)", { desc = "Refactor" } },
    { { "n", "x" }, "gaR", "<Plug>(coc-codeaction-refactor-selected)", { desc = "Refactor Selection" } },

    -- DIAGNOSTICS
    { "n", "gk", "<Plug>(coc-diagnostic-prev)", { desc = "Prev Diagnostic" } },
    { "n", "gj", "<Plug>(coc-diagnostic-next)", { desc = "Next Diagnostic" } },
    { "n", "gq", "<Plug>(coc-fix-current)", { desc = "QuickFix List" } },

    -- LIST
    { "n", "gll", ":CocList<CR>", { desc = "Open Coc List" } },
    { "n", "gld", ":<C-u>CocList diagnostics<cr>", { desc = "Diagnostics List" } },
    { "n", "gle", ":<C-u>CocList extensions<cr>", { desc = "Extensions List" } },
    { "n", "glc", ":<C-u>CocList commands<cr>", { desc = "Commands List" } },
    { "n", "glo", ":<C-u>CocList outline<cr>", { desc = "Outline" } },
    { "n", "gls", ":<C-u>CocList -I symbols<cr>", { desc = "Workspace Symbols" } },
    { "n", "glj", ":<C-u>CocNext<cr>", { desc = "Next List Item" } },
    { "n", "glk", ":<C-u>CocPrev<cr>", { desc = "Prev List Item" } },
    { "n", "glp", ":<C-u>CocListResume<cr>", { desc = "Resume List" } },
    { "n", "glw", ":CocList workspace<CR>", { desc = "List Workspace Folders" } },
  }

  for _, mapping in pairs(mappings) do
    map(unpack(mapping))
  end

  -- only define coc textobjects if TS parser NOT available
  if not nvim.plugins.ts_textobjects then
    -- Map function and class text objects
    -- NOTE: Requires 'textDocument.documentSymbol' support from the language server
    map("x", "if", "<Plug>(coc-funcobj-i)", opts)
    map("o", "if", "<Plug>(coc-funcobj-i)", opts)
    map("x", "af", "<Plug>(coc-funcobj-a)", opts)
    map("o", "af", "<Plug>(coc-funcobj-a)", opts)
    map("x", "ic", "<Plug>(coc-classobj-i)", opts)
    map("o", "ic", "<Plug>(coc-classobj-i)", opts)
    map("x", "ac", "<Plug>(coc-classobj-a)", opts)
    map("o", "ac", "<Plug>(coc-classobj-a)", opts)
  end

  -- Remap <C-f> and <C-b> to scroll float windows/popups
  local opts = { silent = true, nowait = true, expr = true }
  map({ "n", "v" }, "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
  map({ "n", "v" }, "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
  map("i", "<C-f>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
  map("i", "<C-b>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)

  -- Use CTRL-S for selections ranges
  -- Requires 'textDocument/selectionRange' support of language server
  map({ "n", "x" }, "<leader>s", "<Plug>(coc-range-select)", { silent = true })

  -- Add `:Format` command to format current buffer
  vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

  -- " Add `:Fold` command to fold current buffer
  vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = "?" })

  -- Add `:OR` command for organize imports of the current buffer
  vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

  -- Add (Neo)Vim's native statusline support
  -- NOTE: Please see `:h coc-status` for integrations with external plugins that
  -- provide custom statusline: lightline.vim, vim-airline
  vim.opt.statusline:prepend "%{coc#status()}%{get(b:,'coc_current_function','')}"
end

return M
