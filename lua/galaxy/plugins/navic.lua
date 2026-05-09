local M = {}

local icons = nvim.icons.styled.kind.codicons

local function isempty(s)
  return s == nil or s == ""
end

local get_filename = function()
  local filename = vim.fn.expand "%:t"
  local extension = vim.fn.expand "%:e"

  if not isempty(filename) then
    local file_icon, hl_group
    local devicons_ok, devicons = pcall(nvim.require, "nvim-web-devicons")
    if nvim.opt.icons.enabled and devicons_ok then
      file_icon, hl_group = devicons.get_icon(filename, extension, { default = true })

      if isempty(file_icon) then
        file_icon = nvim.icons.kind.File
      end
    else
      file_icon = ""
      hl_group = "Normal"
    end

    local buf_ft = vim.bo.filetype

    if buf_ft == "dapui_breakpoints" then
      file_icon = nvim.icons.ui.Bug
    end

    if buf_ft == "dapui_stacks" then
      file_icon = nvim.icons.ui.Stacks
    end

    if buf_ft == "dapui_scopes" then
      file_icon = nvim.icons.ui.Scopes
    end

    if buf_ft == "dapui_watches" then
      file_icon = nvim.icons.ui.Watches
    end

    if buf_ft == "dapui_console" then
      file_icon = nvim.icons.ui.DebugConsole
    end

    local navic_text_hl = vim.api.nvim_get_hl(0, { name = "Normal" })
    vim.api.nvim_set_hl(0, "Winbar", { fg = navic_text_hl.fg })

    return "%#" .. hl_group .. "#" .. file_icon .. "%*" .. " " .. "%#Winbar#" .. filename .. "%*"
  end
end

local get_gps = function()
  local status_gps_ok, gps = pcall(nvim.require, "nvim-navic")
  if not status_gps_ok then
    return ""
  end

  local status_ok, gps_location = pcall(gps.get_location, {})
  if not status_ok then
    return ""
  end

  if not gps.is_available() or gps_location == "error" then
    return ""
  end

  if not isempty(gps_location) then
    return get_filename() .. " " .. "%#NavicSeparator#" .. nvim.icons.ui.ChevronRight .. "%* " .. gps_location
  else
    return ""
  end
end

local show_winbar = function()
  local value = get_filename()

  if not isempty(value) then
    local gps_value = get_gps()
    value = gps_value
  end

  local num_tabs = #vim.api.nvim_list_tabpages()

  if num_tabs > 1 and not isempty(value) then
    local tabpage_number = tostring(vim.api.nvim_tabpage_get_number(0))
    value = value .. "%=" .. tabpage_number .. "/" .. tostring(num_tabs)
  end

  local status = pcall(vim.api.nvim_set_option_value, "winbar", value, { scope = "local" })
  if not status then
    return
  end
end

M.config = function()
  return {
    "SmiteshP/nvim-navic",
    event = "LspAttach",
    main = "nvim-navic",
    opts = {
      lsp = {
        auto_attach = false,
        preference = nil,
      },
      icons = {
        Array = icons.Array .. " ",
        Boolean = icons.Boolean .. " ",
        Class = icons.Class .. " ",
        Color = icons.Color .. " ",
        Constant = icons.Constant .. " ",
        Constructor = icons.Constructor .. " ",
        Enum = icons.Enum .. " ",
        EnumMember = icons.EnumMember .. " ",
        Event = icons.Event .. " ",
        Field = icons.Field .. " ",
        File = icons.File .. " ",
        Folder = icons.Folder .. " ",
        Function = icons.Function .. " ",
        Interface = icons.Interface .. " ",
        Key = icons.Key .. " ",
        Keyword = icons.Keyword .. " ",
        Method = icons.Method .. " ",
        Module = icons.Module .. " ",
        Namespace = icons.Namespace .. " ",
        Null = icons.Null .. " ",
        Number = icons.Number .. " ",
        Object = icons.Object .. " ",
        Operator = icons.Operator .. " ",
        Package = icons.Package .. " ",
        Property = icons.Property .. " ",
        Reference = icons.Reference .. " ",
        Snippet = icons.Snippet .. " ",
        String = icons.String .. " ",
        Struct = icons.Struct .. " ",
        Text = icons.Text .. " ",
        TypeParameter = icons.TypeParameter .. " ",
        Unit = icons.Unit .. " ",
        Value = icons.Value .. " ",
        Variable = icons.Variable .. " ",
      },
      highlight = true,
      separator = " " .. nvim.icons.ui.ChevronRight .. " ",
      depth_limit = 0,
      depth_limit_indicator = "..",
    },
    config = function(_, opts)
      nvim.require("nvim-navic").setup(opts)

      nvim.create_autocmd({
        "CursorMoved",
        "CursorMovedI",
        "CursorHoldI",
        "CursorHold",
        "BufWinEnter",
        "BufFilePost",
        "InsertEnter",
        "BufWritePost",
        "TabClosed",
        "TabEnter",
      }, {
        group = "navic_winbar",
        clear = true,
        callback = function()
          vim.schedule(function()
            show_winbar()
          end)
        end,
      })
    end,
  }
end

return M
