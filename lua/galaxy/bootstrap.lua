----------------------[ Configuration ]-------------------------------

nvim.plugins = nvim.lazytable()
nvim.dofile(nvim.fs.presets)

-- setup plugin configs
for name, cond in pairs(nvim.load "configure.plugins") do
  local module = nvim.main .. ".plugins." .. name

  local ok, plugin = pcall(require, module)
  local plugname = name:gsub("-", "_")
  if ok then
    nvim.plugins[plugname] = nvim.setup.plugin(name, plugin.config(), cond)
  else
    vim.notify(("Failed to load plugin config: %s"):format(name), vim.log.levels.WARN)
  end
end

local config = nvim.dofile(nvim.fs.configs)
local plugins = vim.deepcopy(nvim.plugins)
local lazyconf = nvim.load "lazy"

-----------------------[ DEPENDENCIES ]-------------------------------

for _, plugin in pairs(plugins) do
  if type(plugin.dependencies) == "table" then
    plugin.dependencies = vim.tbl_values(plugin.dependencies)
  end
end

-----------------------[ SET RUNTIME ]-------------------------------

for _, path in ipairs(nvim.fs.runtime) do
  if not vim.tbl_contains(vim.opt.rtp:get(), path) then
    vim.opt.rtp:prepend(path)
  end
end

------------------------[ LAZY SETUP ]-------------------------------

nvim.lazy = nvim.require "lazy"
local specs = vim.tbl_values(nvim.materialize(plugins))
nvim.lazy.setup({ specs, { import = nvim.fs.user.specs } }, lazyconf)

-----------------------[ SETUP AFTER ]-------------------------------

nvim.setup.lsp()
nvim.setup.theme()
vim.schedule(config or function() end)
