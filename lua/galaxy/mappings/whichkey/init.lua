local ok, wk = pcall(require, "which-key")
if not ok then return end

wk.icon = function(...)
  local icon = (...)
  local i = icon[1] or icon.i
  local c = icon[2] or icon.c
  local hl = icon[3] or icon.hl

  if not c and not hl then
    c = "blue"
  end

  return {
    icon = i,
    color = c,
    hl = hl,
  }
end

wk.mappings = {
  -- alpha
  {
    "<leader>a",
    mode = { "n", "v" },
    desc = "Dashboard",
    function()
      if vim.bo.ft ~= "alpha" then
        vim.cmd.Alpha()
      end
    end,
    icon = wk.icon { "󰀫" },
    cond = nvim.plugins.alpha.enabled,
  },

  {
    "<leader>/",
    mode = { "n", "v" },
    icon = wk.icon { "󰉿" },
  },

  { "<leader>f1", hidden = true }, -- hide this keymap

  -- proxy to window mappings
  {
    "<leader>w",
    proxy = "<c-w>",
    group = "Window",
    icon = wk.icon { "" },
  },
}

wk.add(wk.mappings)

setmetatable(wk, {
  __newindex = function(_, key, val)
    if key == "map" then
      val.mode = val.mode or { "n", "v" }
      table.insert(wk.mappings, val)
    end
  end,
})

vim.schedule(function()
  nvim.autoload "mappings/whichkey"
end)
