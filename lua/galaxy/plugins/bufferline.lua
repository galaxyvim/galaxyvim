local M = {}

function _G.bufferline_nvim_quit()
  vim.cmd "qall"
end

local diagnostics_provider = nvim.opt.provider.lsp == "nvim" and "nvim_lsp" or "coc"

local function is_ft(b, ft)
  return vim.bo[b].filetype == ft
end

local function diagnostics_indicator(num, level, diagnostics, _)
  local result = {}
  local symbols = {
    error = nvim.icons.diagnostics.Error,
    warning = nvim.icons.diagnostics.Warn,
    hint = nvim.icons.diagnostics.Hint,
    info = nvim.icons.diagnostics.Info,
  }
  if not nvim.opt.icons.enabled then
    return "[" .. num .. "]"
  end

  for name, count in pairs(diagnostics) do
    if symbols[name] and count > 0 then
      table.insert(result, symbols[name] .. " " .. count)
    end
  end

  result = table.concat(result, " ")
  return #result > 0 and result or ""
end

local function filter(buf, buf_nums)
  local logs = vim.tbl_filter(function(b)
    return is_ft(b, "log")
  end, buf_nums or {})
  if vim.tbl_isempty(logs) then
    return true
  end
  local tab_num = vim.fn.tabpagenr()
  local last_tab = vim.fn.tabpagenr "$"
  local is_log = is_ft(buf, "log")
  if last_tab == 1 then
    return true
  end
  -- only show log buffers in secondary tabs
  return (tab_num == last_tab and is_log) or (tab_num ~= last_tab and not is_log)
end

local function name_formatter(buf) -- buf contains a "name", "path" and "bufnr"
  local name = buf.name
  local ft = vim.bo.ft
  -- remove extension from markdown files for example
  if name:match "%.md" then
    return vim.fn.fnamemodify(buf.name, ":t:r")
  end
end

M.config = function()
  return {
    "akinsho/bufferline.nvim",
    branch = "main",
    event = { "User DirReady", "User BufReady", "User BufWindow" },
    dependencies = { "devicons" },
    opts = {
      highlights = {
         -- background = {
         --   italic = false,
         -- },
         -- buffer_selected = {
         --   bold = true,
         -- },
       },

      options = {
        themable = true, -- whether or not bufferline highlights can be overridden externally
        -- style_preset = preset,
        get_element_icon = nil,
        show_duplicate_prefix = true,
        duplicates_across_groups = true,
        auto_toggle_bufferline = true,
        move_wraps_at_ends = false,
        groups = { items = {}, options = { toggle_hidden_on_enter = true } },
        mode = "buffers", -- set to "tabs" to only show tabpages instead
        numbers = "none", -- can be "none" | "ordinal" | "buffer_id" | "both" | function
        close_command = nvim.buffer.close, -- can be a string | function, see "Mouse actions"
        right_mouse_command = "vert sbuffer %d", -- can be a string | function, see "Mouse actions"
        left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
        middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
        -- NOTE: this will be called a lot so don't do any heavy processing here
        custom_filter = filter,
        offsets = {
          {
            filetype = "undotree",
            text = "Undotree",
            highlight = "PanelHeading",
            padding = 1,
          },
          {
            filetype = "NvimTree",
            text = "Explorer",
            highlight = "PanelHeading",
            padding = 1,
          },
          {
            filetype = "neo-tree",
            text = "Explorer",
            highlight = "PanelHeading",
            padding = 1,
          },
          {
            filetype = "oil",
            text = "Explorer",
            highlight = "PanelHeading",
            padding = 1,
          },
          {
            filetype = "DiffviewFiles",
            text = "Diff View",
            highlight = "PanelHeading",
            padding = 1,
          },
          {
            filetype = "snacks_layout_box",
            highlight = "PanelHeading",
          },
        },

        color_icons = nvim.opt.icons.colors, -- whether or not to add the filetype icon highlights
        show_buffer_icons = nvim.opt.icons.enabled, -- disable filetype icons for buffers
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        -- can also be a table containing 2 custom separators
        -- [focused and unfocused]. eg: { '|', '|' }
        separator_style = "thin",
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        hover = {
          enabled = true, -- requires nvim 0.8+
          delay = 200,
          reveal = { "close" },
        },

        indicator = {
          icon = nvim.icons.strokes.Vertical[3] .. " ", -- this should be omitted if indicator style is not 'icon'
          style = "icon", -- can also be 'underline'|'none',
        },
        buffer_close_icon = nvim.icons.ui.Close,
        modified_icon = nvim.icons.ui.Circle,
        close_icon = nvim.icons.ui.Close,
        left_trunc_marker = nvim.icons.ui.ArrowCircleLeft,
        right_trunc_marker = nvim.icons.ui.ArrowCircleRight,

        --- name_formatter can be used to change the buffer's label in the bufferline.
        --- Please note some names can/will break the
        --- bufferline so use this at your discretion knowing that it has
        --- some limitations that will *NOT* be fixed.
        name_formatter = name_formatter,
        sort_by = "id",
        max_name_length = 18,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        truncate_names = true, -- whether or not tab names should be truncated
        tab_size = 18,

        diagnostics = diagnostics_provider, -- "nvim_lsp" | "coc"
        diagnostics_update_in_insert = false,
        diagnostics_indicator = diagnostics_indicator,

        debug = { logging = false },

        custom_areas = {
          right = function()
            return {
              {
                text = "%@v:lua.bufferline_nvim_quit@%#TabLine# 󰅜 %X",
              },
            }
          end,
        },
      },
    },
    preload = function(self, opts)
      local bufferline = nvim.lazyload "bufferline"
      opts.options.style_preset = bufferline.style_preset.no_italic
    end,
    config = true,
  }
end

return M
