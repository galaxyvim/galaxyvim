local components = nvim.autoload "plugins/lualine/components"

local M = {}

local Styles = {}

Styles.default = {
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
}

Styles.modern = {
  sections = {
    lualine_a = {
      components.mode,
      components.visualLines,
    },

    lualine_b = {
      components.gitbranch,
      components.filediff,
      components.gitdiff,
    },

    lualine_c = {
      -- "filename",
      -- components.filesize,
    },

    lualine_x = {
      components.searchcount,
      components.macroRecorder,
      components.diagnostics,
      components.filetype,
      components.copilot,
      components.lspinfo,
      components.terminal,
      components.virtualenv,
      "liveserver",
      -- "encoding",
      -- "fileformat",
      -- "filetype",
    },

    lualine_y = {
      components.progress,
    },

    lualine_z = {
      "location",
    },
  },
}

M.config = function()
  return {
    "nvim-lualine/lualine.nvim",
    dependencies= { "devicons" },
    priority = 1000,
    event = "VimEnter",
    style = nvim.opt.style.lualine.style,
    opts = {
      options = {
        component_separators = "",
        section_separators = { left = "", right = "" },

        theme = nvim.opt.style.lualine.theme,
        disabled_filetypes = { statusline = { "alpha" } },
        globalstatus = true,
      },
      sections = nvim.lazytable(),
      inactive_sections = nvim.lazytable(),
      tabline = nil,
      extensions = nil,
    },
    config = function(self, opts)
      opts = nvim.merge(Styles[self.style], opts)
      nvim.require("lualine").setup(opts)
    end,
  }
end

return M
