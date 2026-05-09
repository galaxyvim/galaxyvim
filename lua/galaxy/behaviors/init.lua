if nvim.opt.auto.tabhelp then
  vim.cmd.cnoreabbrev({
  "<expr>",
  "help",
  [[getcmdtype() == ':' && getcmdline() ==# 'help' ? 'tab help' : 'help']]
})
  -- vim.cmd "cnoreabbrev help tab help"
end

nvim.autoload("behaviors/autocmds")
nvim.autoload("behaviors/commands")

