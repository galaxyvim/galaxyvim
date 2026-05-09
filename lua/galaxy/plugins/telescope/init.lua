local M = {}

local backtoSearch = function(prompt_win)
  vim.cmd(string.format("noautocmd lua vim.api.nvim_set_current_win(%s)", prompt_win))
  vim.cmd "startinsert"
end

local focus_preview = function(prompt_bufnr)
  local action_state = require "telescope.actions.state"
  local picker = action_state.get_current_picker(prompt_bufnr)
  local prompt_win = picker.prompt_win
  local previewer = picker.previewer
  local winid = previewer.state.winid
  local bufnr = previewer.state.bufnr
  vim.cmd(string.format("noautocmd lua vim.api.nvim_set_current_win(%s)", winid))

  vim.keymap.set("n", "<ESC>", function()
    backtoSearch(prompt_win)
  end, { buffer = bufnr })

  vim.keymap.set("n", "<C-q>", function()
    backtoSearch(prompt_win)
  end, { buffer = bufnr })
end

local sources = nvim.load "plugins.telescope.sources"

local preload = function()
  local telescope = nvim.require "telescope"
  local builtin = telescope.builtin
  local picker = nvim.require "telescope.pickers"
  local actions = nvim.require "telescope.actions"
  local sorters = nvim.require "telescope.sorters"
  local finders = nvim.require "telescope.finders"
  local previewers = nvim.require "telescope.previewers"
  local config = nvim.require("telescope.config").values
  local actionState = nvim.require "telescope.actions.state"
  sources.load_extensions(telescope.load_extension)

  local core = {
    builtin = builtin,
    pickers = picker,
    finders = finders,
    config = config,
    actions = actions,
    sorters = sorters,
    previewers = previewers,
    actionState = actionState,
  }

  return {
    pickers = { -- Default configuration for builtin pickers goes here:
      find_files = {
        hidden = true,
      },
      live_grep = {
        --@usage don't include the filename in the search results
        only_sort_text = true,
      },
      grep_string = {
        only_sort_text = true,
      },
      buffers = {
        initial_mode = "normal",
        mappings = {
          i = {
            ["<C-d>"] = actions.delete_buffer,
          },
          n = {
            ["dd"] = actions.delete_buffer,
          },
        },
      },
      planets = {
        show_pluto = true,
        show_moon = true,
      },
      git_files = {
        hidden = true,
        show_untracked = true,
      },
      colorscheme = {
        enable_preview = true,
      },
    },
    extensions = { -- extensions goes here, please take a look at the readme of the extension you want to configure
    },

    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new,
    file_sorter = sorters.get_fuzzy_file,
    generic_sorter = sorters.get_generic_fuzzy_sorter,

    -----------------------[ Mappings ]-------------------------------
    defaults = {
      attach_mappings = function(_, map)
        map({ "i", "n" }, "<LeftMouse>", function(prompt_bufnr)
          -- your custom preview-click behavior here
        end)
        return true
      end,
      mappings = {
        i = {
          ["<C-n>"] = actions.move_selection_next,
          ["<C-p>"] = actions.move_selection_previous,
          ["<C-j>"] = actions.cycle_history_next,
          ["<C-k>"] = actions.cycle_history_prev,
          ["<CR>"] = actions.select_default,
          ["<C-q>"] = actions.close,
        },
        n = {
          ["<C-q>"] = actions.close,
          ["<LeftMouse>"] = focus_preview,
          ["<C-n>"] = actions.move_selection_next,
          ["<C-p>"] = actions.move_selection_previous,
        },
      },
    },
  }
end

M.config = function()
  return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = sources.dependencies,
    opts = {
      defaults = { -- Default configuration for telescope goes here:
        entry_prefix = "  ",
        multi_icon = nvim.icons.strokes.Vertical[4] .. " ",
        prompt_prefix = " " .. nvim.icons.ui.Search .. " ",
        selection_caret = nvim.icons.caret.Right .. " ",
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        sorting_strategy = "ascending", -- keeps results from top to bottom
        history = {
          path = "~/.local/share/nvim/databases/telescope_history.sqlite3",
          limit = 100,
        },
        file_ignore_patterns = {},
        path_display = { "smart" },
        border = {},
        borderchars = nil,
        color_devicons = true,
        winblend = 0, -- transparency (0 = opaque)
        initial_mode = "insert",
        layout_strategy = "vertical",
        layout_config = {
          width = 0.90,
          height = 0.95,
          vertical = {
            preview_height = 0.50, -- 50% of window height for preview
            mirror = false, -- preview above results
          },
          preview_cutoff = 1,
          prompt_position = "bottom", -- search prompt position
        },

        -- Preview
        preview = {
          -- allow cursor movement
          hide_on_startup = false,
        },
        preview_title = true,
        dynamic_preview_title = true, -- shows filename in title

        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
          "--glob=!.git/",
        },
      },
    },
    preload = preload,
    config = true,
  }
end

return M
