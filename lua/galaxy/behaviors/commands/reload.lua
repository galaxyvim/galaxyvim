local function reload(name)
  package.loaded[name] = nil
  -- try requiring again
  local ok, result = pcall(require, name)

  if not ok then
    return print("Error reloading: " .. name, result, vim.log.levels.ERROR)
  end

  vim.notify(name .. " Reloaded")
end

vim.api.nvim_create_user_command("Reload", function(opts)
  reload(opts.args)
end, { nargs = "?" })
