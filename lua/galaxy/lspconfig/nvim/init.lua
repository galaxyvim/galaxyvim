local M = nvim.lazytable()
local lsp = {}

local mergeFunc = function(target, dest)
  if type(target) == "table" then
    nvim.merge(dest, target)
  elseif type(target) == "function" then
    table.insert(dest, target)
  else
    error("Expected function or table, got: " .. type(target))
  end
end

local provider = nvim.load "lspconfig.nvim.provider"

lsp.servers = {
  jsonls = provider.jsonls,
  yamlls = provider.yamlls,
  lua_ls = provider.lua_ls,
}

local function array_to_keys(tbl, cond)
  local result = {}
  for k, v in pairs(tbl) do
    if type(k) == "number" then
      result[v] = true -- array element becomes key
    elseif type(v) == "table" then
      -- keep value if exists or set false
      result[k] = cond or v
    else
      result[k] = v
    end
  end
  return result
end

local function hover()
  vim.lsp.buf.hover {
    max_width = 80,
    max_height = 25,
    silent = true,
    border = nvim.opt.lsp.border,
  }
end

local function signature()
  vim.lsp.buf.signature_help {
    max_width = 80,
    max_height = 25,
    silent = true,
    border = nvim.opt.lsp.border,
  }
end

local diagnostic = {
  jump = function(count)
    return function()
      count = vim.v.count1 * count
      vim.diagnostic.jump {
        count = count,
        float = true,
      }
    end
  end,
}

---------------------[ on_attach functions ]---------------------------
local on_attach = {
  function(client, bufnr)
    local function map(mode, key, cmd, desc)
      vim.keymap.set(mode, key, cmd, { buffer = bufnr, silent = true, desc = desc })
    end

    lsp.mappings = {
      -- GROUPS
      { "n", "ga", "<NOR>" },

      -- INFO
      hover = { "n", "gh", hover, "Hover Docs" },
      signatureHelp = { "n", "gs", signature, "Signature Help" },

      -- NAVIGATION
      definition = { "n", "gd", vim.lsp.buf.definition, "Goto Definition" },
      declaration = { "n", "gD", vim.lsp.buf.declaration, "Goto Declaration" },
      references = { "n", "gR", vim.lsp.buf.references, "Goto References" },
      typeDefinition = { "n", "gy", vim.lsp.buf.type_definition, "Goto Type Definition" },
      implementation = { "n", "gI", vim.lsp.buf.implementation, "Goto Implementation" },

      -- FORMAT
      formatting = { "n", "gF", "<cmd>lua vim.lsp.buf.format { async = true }<cr>", "Format File" },

      -- SYMBOLS
      symbols = { "n", "gO", vim.lsp.buf.document_symbol, "Document Symbols" },

      -- RENAME
      rename = { "n", "gr", vim.lsp.buf.rename, "Rename Symbol" },

      -- ACTIONS
      codeAction = { "n", "gaa", vim.lsp.buf.code_action, "Code Action" },
      codeLens = { "n", "gal", vim.lsp.codelens.run, "Codelens" },

      -- WORKSPACE
      { "n", "gawa", vim.lsp.buf.add_workspace_folder, "Add Workspace Folder" },
      { "n", "gawr", vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder" },
      { "n", "gawd", "<cmd>LspRestart<cr>", "Reload Workspace" },
      {
        "n",
        "gawl",
        "<cmd> lua print(vim.print(vim.lsp.buf.list_workspace_folders()))<cr>",
        "List Workspace Folders",
      },
      { "n", "gaws", vim.lsp.buf.workspace_symbol, "Workspace Symbols" },

      -- DIAGNOSTICS
      { "n", "gj", diagnostic.jump(1), "Next Diagnostic" },
      { "n", "gk", diagnostic.jump(-1), "Prev Diagnostic" },
      { "n", "gl", vim.diagnostic.open_float, "Diagnostic" },
      { "n", "gq", vim.diagnostic.setloclist, "QuickFix List" },
    }

    for provider, mapping in pairs(lsp.mappings) do
      local support = client:supports_method("textDocument/" .. provider)
      if type(provider) == "number" or support then
        map(unpack(mapping))
      end
    end

    -- Fire LspPostAttach User event
    -- vim.api.nvim_exec_autocmds("User", {
    --   pattern = "LspPostAttach",
    --   data = { client = client or {}, bufnr = bufnr or nil, keys = nvim.keys.lsp or {} },
    -- })
  end,

  function(client, bufnr)
    local ok, navic = pcall(require, "nvim-navic")
    local symbols_supported = client:supports_method "textDocument/documentSymbol"
    if ok and symbols_supported then
      navic.attach(client, bufnr)
    end
  end,
}

-----------------------[ Diagnostics ]-------------------------------

lsp.diagnostic = {
  signs = {
    text = {},
    texthl = {},
    numhl = {},
    Error = nvim.icons.diagnostics.Error,
    Warn = nvim.icons.diagnostics.Warn,
    Hint = nvim.icons.diagnostics.Hint,
    Info = nvim.icons.diagnostics.Info,
  },
  virtual_text = {
    prefix = "●", -- | "󱓻" | "" | "■", ""
    spacing = 2,
    -- format = function(d)
    -- nvim.print(d.message)
    -- end,
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,

  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = "",
    header = "",
    prefix = "",
  },
}

--------------------
------ Diagnostic Signs
--------------------

local sevmap = {
  Error = vim.diagnostic.severity.ERROR,
  Warn = vim.diagnostic.severity.WARN,
  Info = vim.diagnostic.severity.INFO,
  Hint = vim.diagnostic.severity.HINT,
}

for name, sev in pairs(sevmap) do
  local signs = lsp.diagnostic.signs
  local hl = "DiagnosticSign" .. name
  signs.text[sev] = signs[name]
  signs.texthl[sev] = hl
  signs.numhl[sev] = hl
end

---------------------[ multiple on attach ]-------------------------------

-- preferred server per filetype
lsp.priority = nvim.opt.lsp.priority

local function attach_all(...)
  local funcs = { M.on_attach, on_attach, ... }

  for _, item in ipairs(funcs) do
    mergeFunc(item, on_attach)
  end

  return function(client, bufnr)
    local ft = vim.bo[bufnr].filetype
    local preferred = lsp.priority[ft]

    -- if preferred server *exists and if not matched → skip
    if preferred and client.name ~= preferred then
      return
    end

    for _, fn in ipairs(on_attach) do
      fn(client, bufnr)
    end
  end
end

------------------------[ Defaults ]-------------------------------

lsp.install = nvim.opt.lsp.autoinstall and array_to_keys(lsp.servers, true) or {}
lsp.autostart = nvim.opt.lsp.autostart
lsp.autoinstall = nvim.opt.lsp.autoinstall
lsp.defaults = {
  on_attach = attach_all(),
}

---------------------------[ Setup ]-------------------------------
M.setup = function()
  if not nvim.plugins.lspconfig.enabled then
    return
  end
  nvim.create_autocmd("User", {
    pattern = "BufReady",
    callback = function()
      nvim.merge(lsp, M)
      nvim.print(lsp.servers)

      -----------------------[ Progress UI  ]-------------------------------
      vim.lsp.handlers["$/progress"] = nvim.load "lspconfig.nvim.progress"

      --------------------------[ Diagnostic ]-------------------------------
      vim.diagnostic.config(lsp.diagnostic)

      ----------------------[ mason-lspconfig ]-------------------------------
      local ok_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
      if ok_mason_lspconfig then
        for key, value in pairs(lsp.install) do
          if not value then
            lsp.install[key] = nil
          end
        end
        mason_lspconfig.setup {
          ensure_installed = vim.tbl_keys(lsp.install),
          automatic_installation = lsp.autoinstall,
          automatic_enable = false,
        }
      end

      ------------------------[ lspconfig ]-------------------------------

      local ok_cmp_lsp, cmp_lsp = pcall(require, "cmp_nvim_lsp")

      if ok_cmp_lsp then
        lsp.defaults.capabilities = cmp_lsp.default_capabilities()
      end

      local installed_servers = {}
      if ok_mason_lspconfig then
        installed_servers = mason_lspconfig.get_installed_servers()
      end

      local servers = nvim.merge(array_to_keys(installed_servers), array_to_keys(lsp.servers))
      local inlayhint = nvim.load "lspconfig.nvim.inlayhint"
      nvim.print(servers) -- debug

      for name, value in pairs(servers) do
        local config = {}

        if value == true then
          -- Just use defaults
          config = nvim.merge(inlayhint[name], lsp.defaults)
        elseif type(value) == "table" then
          if value.defaults then
            config = nvim.merge(inlayhint[name], lsp.defaults, value)
            config.on_attach = attach_all(value.on_attach)
          else
            config = value
          end
        end

        nvim.print(name, config) -- debug

        if value ~= false then
          vim.lsp.config(name, config)
          if lsp.autostart then
            vim.lsp.enable(name)
          end
        end
      end
    end,
  })
end

return M
