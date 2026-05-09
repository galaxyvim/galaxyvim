local config = {}

local root_markers = {
  ".emmyrc.json",
  ".luarc.json",
  ".luarc.jsonc",
  ".luacheckrc",
  ".stylua.toml",
  "stylua.toml",
  "selene.toml",
  "selene.yml",
  ".git",
}

config.lua_ls = {
  defaults = true,
  root_markers = vim.fn.has "nvim-0.11.3" == 1 and { root_markers } or root_markers,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim", "nvim" },
      },
      path = {
        "lua/?.lua",
        "lua/?/init.lua",
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
          "${3rd}/luv/library",
          "${3rd}/busted/library",
          "${3rd}/luassert/library",
        },
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

config.jsonls = {
  settings = {
    json = {
      validate = { enable = true },
      format = { enable = true },
      schemas = {
        {
          description = "package.json",
          fileMatch = { "package.json" },
          url = "https://json.schemastore.org/package.json",
        },
        {
          description = "tsconfig.json",
          fileMatch = { "tsconfig.json", "tsconfig.*.json" },
          url = "https://json.schemastore.org/tsconfig.json",
        },
        {
          description = "prettierrc",
          fileMatch = { ".prettierrc", ".prettierrc.json" },
          url = "https://json.schemastore.org/prettierrc.json",
        },
        {
          description = "eslint config",
          fileMatch = { ".eslintrc", ".eslintrc.json" },
          url = "https://json.schemastore.org/eslintrc.json",
        },
      },
    },
  },
}

config.yamlls = {
  settings = {
    yaml = {
      validate = true,
      format = { enable = true },
      hover = true,
      completion = true,
      schemaStore = {
        enable = true,
      },
    },
  },
}

return config
