local diagnostics_provider
if nvim.opt.provider.lsp == "nvim" then
  diagnostics_provider = "nvim_diagnostic"
elseif nvim.opt.provider.lsp == "coc" then
  diagnostics_provider = "coc"
end

return {
  "diagnostics",
  sources = { diagnostics_provider },
  symbols = {
    error = nvim.icons.diagnostics.Error .. " ",
    warn = nvim.icons.diagnostics.Warn .. " ",
    info = nvim.icons.diagnostics.Info .. " ",
    hint = nvim.icons.diagnostics.Hint .. " ",
  },
  on_click = function()
    nvim.open.picker("diagnostics")
  end,
}
