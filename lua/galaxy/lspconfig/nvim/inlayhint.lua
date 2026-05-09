local M = {}

-- enable inlay_hint globally
vim.lsp.inlay_hint.enable(nvim.opt.lsp.inlayhint)

---------------------------[ LUA ]-------------------------------

M.lua_ls = {
  settings = {
    Lua = {
      hint = {
        enable = true,
        paramType = true,
        paramName = "All",
        setType = true,
      },
    },
  },
}

---------------------------[ RUST ]-------------------------------
M.rust_analyzer = {
  settings = {
    ["rust-analyzer"] = {
      inlayHints = {
        typeHints = true,
        parameterHints = true,
        chainingHints = true,
      },
    },
  },
}

---------------------------[ JS/TS ]-------------------------------

local inlayHints = {
  includeInlayParameterNameHints = "all",
  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  includeInlayFunctionParameterTypeHints = true,
  includeInlayVariableTypeHints = true,
  includeInlayVariableTypeHintsWhenTypeMatchesName = false,
  includeInlayPropertyDeclarationTypeHints = true,
  includeInlayFunctionLikeReturnTypeHints = true,
  includeInlayEnumMemberValueHints = true,
}

M.ts_ls = {
  settings = {
    typescript = {
      inlayHints = inlayHints,
    },
    javascript = {
      inlayHints = inlayHints,
    },
  },
}

---------------------------[ GOLANG ]-------------------------------

M.gopls = {
  settings = {
    hints = {
      rangeVariableTypes = true,
      parameterNames = true,
      constantValues = true,
      assignVariableTypes = true,
      compositeLiteralFields = true,
      compositeLiteralTypes = true,
      functionTypeParameters = true,
    },
  },
}

---------------------------[ C/C++ ]-------------------------------

M.clangd = {
  settings = {
    clangd = {
      InlayHints = {
        Designators = true,
        Enabled = true,
        ParameterNames = true,
        DeducedTypes = true,
      },
      fallbackFlags = { "-std=c++20" },
    },
  },
}

---------------------------[ PYTHON ]-------------------------------

M.pyright = {
  settings = {
    python = {
      analysis = {
        inlayHints = {
          variableTypes = true,
          functionReturnTypes = true,
          callArgumentNames = true,
        },
      },
    },
  },
}

---------------------------[ HTML ]-------------------------------
M.html = {
  settings = {
    html = {
      hover = { documentation = true },
    },
  },
}

---------------------------[ CSS ]-------------------------------

M.cssls = {
  settings = {
    css = { validate = true },
    scss = { validate = true },
    less = { validate = true },
  },
}

---------------------------[ JSON ]-------------------------------

M.jsonls = {
  settings = {
    json = {
      validate = { enable = true },
    },
  },
}

---------------------------[ YAML ]-------------------------------

M.yamlls = {
  settings = {
    yaml = {
      keyOrdering = false,
    },
  },
}

---------------------------[ BASH ]-------------------------------

M.bashls = {
  settings = {
    bashIde = {
      globPattern = "*@(.sh|.bash|.zsh)",
    },
  },
}

---------------------------[ TOML ]-------------------------------

M.taplo = {
  settings = {
    taplo = {
      hints = {
        enabled = true,
      },
    },
  },
}

---------------------------[ DART ]-------------------------------

M.dartls = {
  settings = {
    dart = {
      showTodos = true,
      completeFunctionCalls = true,
    },
  },
}

---------------------------[ RUBY ]-------------------------------

M.solargraph = {
  settings = {
    solargraph = {
      diagnostics = true,
    },
  },
}

---------------------------[ LATEX ]-------------------------------

M.texlab = {
  settings = {
    texlab = {
      inlayHints = {
        labelDefinitions = true,
        labelReferences = true,
      },
    },
  },
}

---------------------------[ C# ]-------------------------------

M.omnisharp = {
  enable_import_completion = true,
  organize_imports_on_format = true,
}

---------------------------[ HASKELL ]-------------------------------

M.hls = {
  settings = {
    haskell = {
      formattingProvider = "ormolu",
    },
  },
}

---------------------------[ ZIG ]-------------------------------

M.zls = {
  settings = {
    zls = {
      enable_inlay_hints = true,
    },
  },
}

return M
