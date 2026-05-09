local M = {}

local scroll = {}
if nvim.opt.scroll.smooth then
  scroll = {
    animate = {
      duration = { step = 10, total = 200 },
      easing = "linear",
    },
    -- faster animation when repeating scroll after delay
    animate_repeat = {
      delay = 100, -- delay in ms before using the repeat animation
      duration = { step = 5, total = 50 },
      easing = "linear",
    },
    -- what buffers to animate
    filter = function(buf)
      return vim.g.snacks_scroll ~= false and vim.b[buf].snacks_scroll ~= false and vim.bo[buf].buftype ~= "terminal"
    end,
  }
end

M.config = function()
  return {
    "folke/snacks.nvim",
    lazy = false,
    desc = "Snacks",
    priority = 1000,
    opts = {
      explorer = {
        enabled = true,
        replace_netrw = true, -- hijack netrw
      },

      input = { enabled = true },

      scroll = scroll,

      picker = {
        prompt = " " .. nvim.icons.ui.Search .. " ",
        sources = {
          explorer = {
            layout = {
              preset = "sidebar",
              preview = false,
            },
          },
        },

        win = {
          -- input window
          input = {
            keys = {
              -- to close the picker on ESC instead of going to normal mode,
              -- add the following keymap to your config
              -- ["<Esc>"] = { "close", mode = { "n", "i" } },
              ["/"] = "toggle_focus",
              ["<C-Down>"] = { "history_forward", mode = { "i", "n" } },
              ["<C-Up>"] = { "history_back", mode = { "i", "n" } },
              ["<C-c>"] = { "cancel", mode = "i" },
              ["<C-w>"] = { "<c-s-w>", mode = { "i" }, expr = true, desc = "delete word" },
              ["<CR>"] = { "confirm", mode = { "n", "i" } },
              ["<Down>"] = { "list_down", mode = { "i", "n" } },
              ["<Esc>"] = "cancel",
              ["<S-CR>"] = { { "pick_win", "jump" }, mode = { "n", "i" } },
              ["<S-Tab>"] = { "select_and_prev", mode = { "i", "n" } },
              ["<Tab>"] = { "select_and_next", mode = { "i", "n" } },
              ["<Up>"] = { "list_up", mode = { "i", "n" } },
              ["<c-q>"] = { "close", mode = { "i", "n", "x" } },
              ["gq"] = { "qflist", mode = { "i", "n" } },
              ["?"] = "toggle_help_input",
              ["G"] = "list_bottom",
              ["gg"] = "list_top",
              ["j"] = "list_down",
              ["k"] = "list_up",
              ["q"] = "close",
            },
            b = {
              minipairs_disable = true,
            },
          },
          -- result list window
          list = {
            keys = {
              ["/"] = "toggle_focus",
              ["<2-LeftMouse>"] = "confirm",
              ["<CR>"] = "confirm",
              ["<Down>"] = "list_down",
              ["<Esc>"] = "cancel",
              ["<S-CR>"] = { { "pick_win", "jump" } },
              ["<S-Tab>"] = { "select_and_prev", mode = { "n", "x" } },
              ["<Tab>"] = { "select_and_next", mode = { "n", "x" } },
              ["<Up>"] = "list_up",
              ["<c-q>"] = { "close", mode = { "i", "n", "x" } },
              ["gq"] = "qflist",
              ["?"] = "toggle_help_list",
              ["G"] = "list_bottom",
              ["gg"] = "list_top",
              ["i"] = "focus_input",
              ["j"] = "list_down",
              ["k"] = "list_up",
              ["q"] = "close",
              ["zb"] = "list_scroll_bottom",
              ["zt"] = "list_scroll_top",
              ["zz"] = "list_scroll_center",
            },
            wo = {
              conceallevel = 2,
              concealcursor = "nvc",
            },
          },
          -- preview window
          preview = {
            keys = {
              ["<Esc>"] = "cancel",
              ["<C-q>"] = "close",
              ["q"] = "close",
              ["i"] = "focus_input",
              ["<a-w>"] = "cycle_win",
            },
          },
        },

        icons = {
          files = {
            enabled = true, -- show file icons
            dir = "󰉋 ",
            dir_open = "󰝰 ",
            file = "󰈔 ",
          },
          keymaps = {
            nowait = "󰓅 ",
          },
          tree = {
            vertical = "│ ",
            middle = "├╴",
            last = "└╴",
          },
          undo = {
            saved = " ",
          },
          ui = {
            live = "󰐰 ",
            hidden = "h",
            ignored = "i",
            follow = "f",
            selected = "● ",
            unselected = " ",
            -- selected = " ",
          },
          git = {
            enabled = true, -- show git icons
            commit = "󰜘 ", -- used by git log
            staged = "●", -- staged changes. always overrides the type icons
            added = "",
            deleted = "",
            ignored = " ",
            modified = "",
            renamed = "",
            unmerged = " ",
            untracked = "?",
          },
          diagnostics = {
            Error = nvim.icons.diagnostics.Error .. " ",
            Warn = nvim.icons.diagnostics.Warn .. " ",
            Hint = nvim.icons.diagnostics.Hint .. " ",
            Info = nvim.icons.diagnostics.Info .. " ",
          },
          lsp = {
            unavailable = "",
            enabled = " ",
            disabled = " ",
            attached = "󰖩 ",
          },
          kinds = nvim.icons.kind,
        },
      },
    },
    config = true,
  }
end

return M
