local function float(msg)
  local text = {
    " ",
    "  " .. msg,
    " ",
    "  Please wait...",
    " ",
  }

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, text)

  local win = vim.api.nvim_open_win(buf, false, {
    width = vim.o.columns,
    height = vim.o.lines,
    style = "minimal",
    border = "rounded",
    relative = "editor",
    row = 0,
    col = 0,
  })

  vim.wo[win].winhl = "NormalFloat:Normal,FloatBorder:DiagnosticHint"
  vim.cmd "redraw"
  return win, buf
end

----------------------[ LAZY INSTALLER ]-------------------------------

local lockfile = nvim.stdpath.config .. "/lockfile.json"
if vim.fn.filereadable(lockfile) == 0 then
  vim.fn.writefile(vim.fn.readfile(nvim.fs.main .. "/lazy/lockfile.json"), lockfile)
end

if not nvim.file.exists(nvim.fs.lazy) then
  local win = float "Installing Plugin Manager..."
  local process = vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    nvim.fs.lazy,
  }

  if vim.fn.isdirectory(nvim.fs.lazy) == 1 then
    lockfile = assert(vim.fn.json_decode(vim.fn.readfile(nvim.stdpath.config .. "/lockfile.json")))
    vim.fn.system {
      "git",
      "-C",
      nvim.fs.lazy,
      "checkout",
      lockfile["lazy.nvim"].commit,
    }
  end

  if vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_win_close(win, true)
  end

  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { process, "WarningMsg" },
      { "\nPress any key to exit…" },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

------------------------[ LAZY CONFIG ]-------------------------------

local lazyconf = {
  lockfile = nvim.stdpath.config .. "/lockfile.json",
  checker = { enabled = false }, -- notify about plugin updates.
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = { -- runtime path
      paths = {
        vim.g.galaxypath,
      }, -- add any custom paths here to include in rtp
      disabled_plugins = {
        -- "gzip",
        -- "tarPlugin",
        -- "zipPlugin",
      },
    },
  },
  concurrency = vim.uv.available_parallelism() * 2 or 16, -- concurrent tasks
  spec = { -- stores plugin specs
    { "nvim-lua/plenary.nvim", cmd = { "PlenaryBustedFile", "PlenaryBustedDirectory" }, lazy = true },
  },
  root = nvim.fs.plugins, -- directory where plugins will be installed
  install = { colorscheme = { nvim.colorscheme, "catppuccin", "habamax" } },
  ui = {
    -- a number <1 is a percentage., >1 is a fixed size
    size = { width = 0.85, height = 0.85 },
    wrap = true, -- wrap the lines in the ui
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = "rounded",
    -- The backdrop opacity. 0 is fully opaque, 100 is fully transparent.
    backdrop = 80,
    title = nil, -- only works when border is not "none"
    title_pos = "center", -- "center" | "left" | "right"
    -- Show pills on top of the Lazy window
    pills = true,
    icons = {
      cmd = " ",
      config = "",
      debug = "● ",
      event = " ",
      favorite = " ",
      ft = "󰈔 ",
      init = " ",
      import = " ",
      keys = "󰌌 ",
      lazy = "",
      loaded = "󰸞",
      not_loaded = "",
      plugin = "󰏗 ",
      runtime = " ",
      require = "󱧕 ",
      source = "󰈮 ",
      start = " ",
      task = " ",
      list = {
        "●",
        "󰁕",
        "",
        "‒",
      },
    },
  },
}

return lazyconf
