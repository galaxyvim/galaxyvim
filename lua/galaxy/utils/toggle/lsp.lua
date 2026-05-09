local M = {}

function M.notify(text, cond)
  vim.notify(string.format("%s: %s", text, cond and "ON" or "OFF"))
end

---------------------------[ LSP ]-------------------------------

--------------------------------------------------
-- Formatter Toggle
--------------------------------------------------

function M.format_on_save()
  vim.g.format_on_save = not vim.g.format_on_save
  vim.notify("Format on save: " .. (vim.g.format_on_save and "ON" or "OFF"))
end

--------------------------------------------------
-- Inlay Hints Toggle
--------------------------------------------------
function M.inlay()
  local enabled = vim.lsp.inlay_hint.is_enabled()
  vim.lsp.inlay_hint.enable(not enabled)
  M.notify("Inlay Hints", not enabled)
end

--------------------------------------------------
-- Diagnostics Toggle
--------------------------------------------------
local diagnostics_active = true
function M.diagnostics()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.enable()
  else
    vim.diagnostic.disable()
  end
  M.notify("Diagnostics", diagnostics_active)
end

--------------------------------------------------
-- Virtual Text Toggle
--------------------------------------------------
local virtual_text = true
function M.virtual_text()
  virtual_text = not virtual_text
  vim.diagnostic.config {
    virtual_text = virtual_text,
  }
  M.notify("Virtual Text", virtual_text)
end

--------------------------------------------------
-- Semantic Tokens Toggle
--------------------------------------------------
local semantic = true
function M.semantic_tokens()
  semantic = not semantic

  for _, client in ipairs(vim.lsp.get_active_clients()) do
    if client.server_capabilities.semanticTokensProvider then
      client.server_capabilities.semanticTokensProvider = semantic and client.server_capabilities.semanticTokensProvider
        or nil
    end
  end

  vim.cmd "edit" -- refresh highlight
  M.notify("Semantic Tokens", semantic)
end

--------------------------------------------------
-- Codelens Toggle
--------------------------------------------------
local codelens = true
function M.codelens()
  codelens = not codelens
  if codelens then
    vim.lsp.codelens.refresh()
  else
    vim.lsp.codelens.clear()
  end
  M.notify("CodeLens", codelens)
end



return M
