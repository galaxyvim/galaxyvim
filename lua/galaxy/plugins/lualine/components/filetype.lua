local function pick(...)
  for _, v in ipairs { ... } do
    if v and v ~= "" then
      return v
    end
  end
end

local filetype = function(name)
  local fl = vim.fn.expand "%:t:r"
  local ext = vim.fn.expand "%:e"
  local ft = vim.bo.filetype
  local bt = vim.bo.buftype
  name = pick(ft, ext, fl, bt)
  return name
end

local function geticon()
  local ft = vim.bo.filetype
  local no_hl = "DevIconConf"

  local ok, devicons = pcall(nvim.require, "nvim-web-devicons")
  if not ok then
    return
  end
  local icon, hl = devicons.get_icon_by_filetype(ft)
  if not icon then
    icon = ""
    hl = no_hl
  end

  return icon, hl
end

local rename = {
  terminal = "",
  toggleterm = "",
  better_term = "",
  ["grug-far"] = "grugfar",
  spectre_panel = "spectre",
  javascriptreact = "react",
  typescriptreact = "tsreact",
  TelescopePrompt = "Telescope",
  snacks_picker_list = "explorer",
}

setmetatable(rename, {
  __index = function(_, key)
    return key
  end,
})

local icons = {
  explorer = "󰙅",
  Telescope = "",
  grugfar = "",
  spectre = "",
  gemini = "",
  opencode = "",
}

local gui = {
  [""] = "bold",
}

local function component()
  return {
    function()
      local name = rename[filetype()]
      local icon = icons[name] or geticon()

      -- icon = nvim.hl.format(icon_hl, icon)
      local text = nvim.hl.format("lualine_c_normal", name)

      return #name > 0 and icon .. " " .. text or ""
    end,

    color = function()
      local icon, hl = geticon()

      return {
        fg = nvim.hl.get(hl).fg,
        bg = nvim.hl.get("lualine_c_normal").bg,
        gui = gui[icon],
      }
    end,

    on_click = function()
      if nvim.plugins.toggleterm.enabled then
        vim.cmd.Run()
      end
    end,

    -- padding = 0
  }
end

return component()
