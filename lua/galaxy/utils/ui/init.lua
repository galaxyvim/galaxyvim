local M = nvim.autoload "utils/ui"

function M.notify(text, cond)
  vim.notify(string.format("%s: %s", text, cond and "ON" or "OFF"))
end

function M.vpaste()
  local reg = vim.fn.getreg '"' -- save current default register
  local regtype = vim.fn.getregtype '"' -- save register type
  vim.cmd 'silent normal! "_dP' -- delete selection + paste from default register
  -- restore default register
  vim.fn.setreg('"', reg, regtype)
end

function M.format()
  local ok, conform = pcall(require, "conform")
  if ok then
    conform.format {
      async = true,
      lsp_fallback = true,
    }
  else
    vim.lsp.buf.format()
  end
end

function M.stop_all_lsp()
  for _, client in ipairs(vim.lsp.get_active_clients()) do
    client.stop()
  end
end

local notify = function(msg)
  vim.notify(msg, vim.log.levels.INFO, { title = "UI" })
end

-- Background
function M.background()
  local bg = vim.opt.background:get()
  notify("Background: " .. bg)
end

-- Reload highlights
function M.reload_highlights()
  vim.cmd "hi clear"
  vim.cmd "syntax reset"
  vim.cmd.colorscheme(nvim.colorscheme)
  notify "Highlights reloaded"
end

-- Reset highlights
function M.clear_highlights()
  vim.cmd "hi clear"
  vim.cmd "syntax reset"
  notify "Highlights cleared"
end

-- Window UI
function M.window()
  notify("winblend: " .. vim.o.winblend)
end

-- Popup menu
function M.popup()
  notify("pumblend: " .. vim.o.pumblend)
end

-- Statusline
function M.statusline()
  notify(vim.o.laststatus == 0 and "Statusline hidden" or "Statusline visible")
end

return M
