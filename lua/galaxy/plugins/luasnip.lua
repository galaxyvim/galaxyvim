local M = {}

M.config = function()
  return {
    "L3MON4D3/LuaSnip",
    version = "v2.*", -- follow latest release, Replace <CurrentMajor> by the latest released major (first number of latest release)
    cmd = { "LuaSnipListAvailable" },
    event = { "InsertEnter" },
    -- build = "make install_jsregexp", -- install jsregexp (optional!).
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    extend = {
      javascript = { "html" },
      javascriptreact = { "html" },
      typescript = { "html" },
      typescriptreact = { "html" },
    },
    config = function(self)
      -- load plugin only for real files.

      local paths = nvim.fs.snippets

      local luasnip = nvim.require "luasnip"

      luasnip.config.setup {
        enable_autosnippets = true,
        updateevents = "TextChanged,TextChangedI",
      }

      for ft, extras in pairs(self.extend) do
        luasnip.filetype_extend(ft, extras)
      end

      -- load snippets from ~/.config/nvim/snippets/luasnip/init.lua
      nvim.dofile(nvim.fs.snippet .. "/luasnip/init.lua")

      -- load snippets from ~/.config/nvim/snippets/<folder>/*
      nvim.require("luasnip.loaders.from_lua").lazy_load {
        paths = paths.luasnip,
      }
      nvim.require("luasnip.loaders.from_vscode").lazy_load {
        paths = paths.vscode,
      }
      nvim.require("luasnip.loaders.from_snipmate").lazy_load {
        paths = paths.snipmate,
      }
    end,
  }
end

return M
