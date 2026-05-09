local M = {}

M.config = function()
  return {
    "mason-org/mason.nvim",
    enabled = nvim.opt.provider.lsp == "nvim",
    name = "mason",
    main = "mason",
    event = "User UIReady",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    dependencies = {
      { "neovim/nvim-lspconfig", name = "lspconfig" },
      { "mason-org/mason-lspconfig.nvim", name = "mason-lspconfig" },
    },
    build = function()
      pcall(function()
        nvim.require("mason-registry").refresh()
      end)
    end,
    opts = {
      ui = {
        -- Whether to automatically check for new versions when opening the :Mason window.
        check_outdated_packages_on_open = true,

        icons = {
          package_installed = "󰸞",
          package_pending = "󰁆",
          package_uninstalled = "",
        },

        border = "rounded", -- Float window border style, use cmd `:h 'winborder'` for more info.
        backdrop = 60, -- The backdrop opacity. 0 is fully opaque, 100 is fully transparent.
        width = 0.85, -- Width of float window, range 0-1 in decimal.
        height = 0.85, -- Width of float window, range 0-1 in decimal.

        keymaps = {
          toggle_package_expand = "<CR>",
          install_package = "i",
          update_package = "u",
          check_package_version = "c",
          update_all_packages = "U",
          check_outdated_packages = "C",
          uninstall_package = "X",
          cancel_installation = "<C-c>",
          apply_language_filter = "<C-f>",
        },
      },

      -- The directory in which to install packages.
      install_root_dir = vim.fn.stdpath "data" .. "/mason",
      PATH = "prepend", -- add to neovim runtime path as '"prepend"' | '"append"' | '"skip"'

      pip = {
        upgrade_pip = false,
        -- pip args:
        -- Example: { "--proxy", "https://proxyserver" }
        install_args = {},
      },

      log_level = vim.log.levels.INFO, -- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when

      max_concurrent_installers = 4,

      -- [Advanced setting]
      -- The registries to source packages from. Accepts multiple entries. Should a package with the same name exist in
      -- multiple registries, the registry listed first will be used.
      registries = {
        "lua:mason-registry.index",
        "github:mason-org/mason-registry",
      },

      -- The provider implementations to use for resolving supplementary package metadata (e.g., all available versions).
      -- Accepts multiple entries, where later entries will be used as fallback should prior providers fail.
      providers = {
        "mason.providers.registry-api",
        "mason.providers.client",
      },

      github = {
        -- The template URL to use when downloading assets from GitHub.
        -- The placeholders are the following (in order):
        -- 1. The repository (e.g. "rust-lang/rust-analyzer")
        -- 2. The release version (e.g. "v0.3.0")
        -- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
        download_url_template = "https://github.com/%s/releases/download/%s/%s",
      },
    },
    config = true,
  }
end

return M
