local M = {}

local setButtons = function(theme, buttons)
  local out = {}

  for i, item in ipairs(buttons.val) do
    out[i] = theme.button(
      item.key or item[1],
      item.label or item[2], -- label (icon + text already)
      item.cmd or item[3]
    )
  end

  -- assign back to val table
  -- this mutates the original table reference
  buttons.val = {}

  for i, v in ipairs(out) do
    buttons.val[i] = v
  end
end

local main = {
  setButtons = setButtons,
}

local styles = nvim.autoload("plugins/alpha/styles")

M.config = function()
  return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "devicons" },
    mode = nvim.opt.style.alpha, -- specifies mode for alpha theme
    opts = {
      dashboard = {
        section = nvim.lazytable(),
        config = {},
        opts = { autostart = true },
      },

      startify = {
        section = nvim.lazytable(),
        config = {},
        opts = { autostart = true },
      },

      theta = {
        section = nvim.lazytable(),
        config = {},
        opts = { autostart = true },
      },
    },
    config = function(self, opts)
      local mode = self.mode
      local style = nvim.require("alpha.themes." .. mode)
      local style_opts = nvim.merge({
        section = styles[mode](main, style),
      }, opts[mode])

      nvim.merge(style, style_opts)
      nvim.print(style.custom) -- debug
      nvim.require("alpha").setup(style.config)
    end,
  }
end

return M
