local util = nvim.load "utils"
local merge = nvim.load "utils.merge"

local M = {
  setup = {},
}

nvim.stats.plugins = {}

-- Custom setup function for lazy.nvim plugin config
function M.plugin(name, plugin, cond)
  if type(plugin.enabled) == "boolean" then
    plugin.enabled = plugin.enabled and cond
  else
    plugin.enabled = cond
  end

  if plugin.config == true then -- rewrite of lazy config callback function with steroids.
    plugin.config = function(self, opts)
      -- print(self.name, self[1])

      self.preload = self.preload or {}
      self.afterload = self.afterload or {}

      -- run this before plugin call
      local config = util.callback(self, opts, "preload")
      -- merge preload returned config into opts
      opts = merge(unpack(config), opts)

      self.modtrim = self.modtrim ~= false
      self.main = self.main or self.modtrim == false and self.name or util.trim.module(self.name)
      local method = self.method or "setup"
      local start = vim.loop.hrtime()
      local okPlug, plug = pcall(require, self.main)
      nvim.stats.plugins[name] = (vim.loop.hrtime() - start) / 1e6 -- ms

      if okPlug then
        if not plug or type(plug) == "boolean" then
          return
        end
        local handler = plug[method]
        nvim.print(plugin) -- debug

        if handler then
          local okHandler, err = pcall(handler, opts or {})
          if not okHandler then
            vim.notify(err, vim.log.levels.ERROR)
            return
          end

          -- run this after plugin call
          util.callback(self, opts, "afterload")
        end
      else
        vim.notify(plug, vim.log.levels.ERROR)
      end
    end
  end

  plugin.name = plugin.name or name
  -- nvim.merge(plugin or {}, nvim.plugin[name])
  return plugin
end

function M.lsp()
  local provider = nvim.opt.provider.lsp

  if provider == "nvim" then
    if nvim.lsp then
      nvim.lsp.setup()
    end
  elseif provider == "coc" then
    if nvim.coc then
      nvim.coc.setup()
    end
  end
end

function M.theme(name)
  name = nvim.colorscheme

  local colors = vim.api.nvim_get_runtime_file(("colors/%s.*"):format(name), false)
  if #colors == 0 then
    vim.notify(string.format("Could not find '%s' colorscheme", name))
    name = nvim.v.major >= 0 and nvim.v.minor < nvim.v.require and "habamax" or "catppuccin"
  end

  vim.opt.termguicolors = true
  vim.g.colors_name = name
  vim.cmd.colorscheme(name)
end

return M
