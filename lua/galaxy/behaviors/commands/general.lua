local editconf_targets = {
  presets = nvim.fs.presets,
  configs = nvim.fs.configs,
  project = nvim.fs.main,
  mappings = nvim.fs.main .. "/mappings",
  bootstrap = nvim.fs.main .. "/bootstrap.lua",
  options = nvim.fs.main .. "/configure/options.lua",
  settings = nvim.fs.main .. "/configure/settings.lua",
  plugins = nvim.fs.main .. "/configure/plugins.lua",
}

vim.api.nvim_create_user_command("EditConf", function(opts)
  local key = opts.args
  local path = editconf_targets[key]

  if not path then
    vim.notify("Unknown EditConf target: " .. (key or ""), vim.log.levels.ERROR)
    return
  end

  vim.cmd("edit " .. path)
end, {
  nargs = 1,
  complete = function(arglead)
    local items = vim.tbl_keys(editconf_targets)
    table.sort(items)
    return vim.tbl_filter(function(item)
      return item:find("^" .. vim.pesc(arglead))
    end, items)
  end,
})

vim.api.nvim_create_user_command("GitConfig", function()
  vim.cmd.edit(vim.fn.expand "~/.gitconfig")
end, {})

vim.api.nvim_create_user_command("Pwd", function()
  vim.notify(vim.fn.getcwd(), vim.log.levels.INFO, { title = "PWD" })
end, { desc = "Show current working directory" })
