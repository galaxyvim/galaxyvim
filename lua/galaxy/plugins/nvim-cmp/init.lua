local M = {}

local function preload()
  local cmp = nvim.require "cmp"
  local ok, luasnip = pcall(nvim.require, "luasnip")
  local config = nvim.autoload "plugins/nvim-cmp"

  local snippet = ok and {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  } or {}

  return {
    snippet = snippet,

    view = {
      entries = {
        name = "custom",
        selection_order = "top_down",
        vertical_positioning = "below",
        follow_cursor = false,
      },
      docs = {
        auto_open = true,
      },
    },

    window = {
      completion = cmp.config.window.bordered { border = "rounded" },
      documentation = cmp.config.window.bordered { border = "rounded" },
    },
    sources = cmp.config.sources(config.sources),

    formatting = config.formatting,

    completion = {
      autocomplete = { -- trigger cmp window when: -
        cmp.TriggerEvent.TextChanged,
        -- cmp.TriggerEvent.InsertEnter,
      },
      -- completeopt = 'menu,menuone,noselect', -- default to noselect item
      completeopt = "menu,menuone", -- keep selecting first item
    },

    sorting = {
      priority_weight = 2,
      comparators = { -- completion sorting priority
        config.sorting,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        cmp.config.compare.locality,
        cmp.config.compare.offset,
        cmp.config.compare.order,
      },
    },

    mapping = cmp.mapping.preset.insert(config.mapping.insert),

    cmdline = {
      [":"] = {
        window = {
          completion = {
            max_height = 10,
            col_offset = -3,
          },
        },
        completion = {
          completeopt = "menu,menuone,noselect", -- default to noselect item
        },
        mapping = cmp.mapping.preset.cmdline(config.mapping.cmdline[":"]),
        sources = cmp.config.sources {
          { name = "path" },
          { name = "cmdline", option = { ignore_cmds = { "Man", "!" } } },
          { name = "calc" },
        },
      },

      ["/"] = {
        mapping = cmp.mapping.preset.cmdline(config.mapping.cmdline["/"]),
        sources = cmp.config.sources {
          { name = "buffer" },
        },
      },
    },
  }
end

M.config = function()
  return {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = nvim.load "plugins.nvim-cmp.dependencies",
    opts = {
      experimental = { ghost_text = false },
      window = {
        completion = {
          col_offset = -3,
        },
        documentation = {
          -- max_width = 0,
        },
      },
    },
    enabled = nvim.opt.provider.lsp == "nvim" and nvim.opt.provider.cmp == "nvim-cmp",
    config = true,
    preload = preload, -- preload automatically merge returned values with opts
    afterload = function(_, opts) -- run after plugin setup
      local cmp = nvim.require "cmp"

      cmp.setup.cmdline(":", opts.cmdline[":"])
      cmp.setup.cmdline("/", opts.cmdline["/"])
    end,
  }
end

return M
