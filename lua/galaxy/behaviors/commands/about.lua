local function center_text(text, width)
  local padding = math.floor((width - #text) / 2)
  if padding < 0 then
    padding = 0
  end
  return string.rep(" ", padding) .. text
end

local function yesno(v)
  if v then
    return "yes"
  end
  return "no"
end

local function get_nvim_version()
  local v = vim.version()
  return string.format("v%d.%d.%d", v.major, v.minor, v.patch)
end

local function get_os()
  local uname = vim.loop.os_uname()
  return string.format("%s (%s)", uname.sysname, uname.machine)
end

local function get_nvim_build()
  local v = vim.version()
  if v.prerelease then
    return "nightly"
  end
  return "stable"
end

local function safe_system(cmd)
  local ok, output = pcall(vim.fn.system, cmd)
  if not ok or not output then
    return nil
  end
  output = vim.trim(output)
  if output == "" then
    return nil
  end
  return output
end

local function get_git_info()
  local config_dir = nvim.fs.root

  local branch = safe_system { "git", "-C", config_dir, "rev-parse", "--abbrev-ref", "HEAD" }
  local commit = safe_system { "git", "-C", config_dir, "rev-parse", "--short", "HEAD" }

  if not branch or not commit then
    return "N/A", "N/A"
  end

  return branch, commit
end

local function get_lazy_plugin()
  local ok, lazy = pcall(require, "lazy")
  if not ok then
    return "N/A"
  end

  local plugins = lazy.plugins()
  if type(plugins) ~= "table" then
    return "N/A"
  end

  local count = 0
  for _ in pairs(plugins) do
    count = count + 1
  end

  return tostring(count)
end

local function get_startup_time()
  local ok, lazy_stats = pcall(require, "lazy.stats")
  if not ok then
    return "N/A"
  end

  local stats = lazy_stats.stats()
  if not stats or not stats.startuptime then
    return "N/A"
  end

  return string.format("%.2f ms", stats.startuptime)
end

local open = function()
  local width = math.floor(vim.o.columns * 0.60)
  local height = math.floor(vim.o.lines * 0.55)

  local nvim_ver = get_nvim_version()
  local build_type = get_nvim_build()
  local os_info = get_os()

  local branch, commit = get_git_info()
  local plugin_count = get_lazy_plugin()
  local startup_time = get_startup_time()
  local lspinfo = vim.lsp.get_clients { bufnr = 0 } and "active" or "inactive"
  local treesitter = vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] ~= nil and "active" or "inactive"

  if width < 60 then
    width = 60
  end

  if height < 15 then
    height = 15
  end

  local buf = vim.api.nvim_create_buf(false, true)
  local lines = {
    center_text("About", width),
    string.rep("—", width),
    "",
    "Project",
    "  • Name     : galaxyvim",
    "  • Branch   : " .. branch,
    "  • Commit   : " .. commit,
    "",
    "System",
    "  • Neovim   : " .. nvim_ver .. " (" .. build_type .. ")",
    "  • OS       : " .. os_info,
    "",
    "Interface",
    " • Colorscheme : " .. vim.g.colors_name,
    " • Background  : " .. vim.o.background,
    " • Truecolor   : " .. yesno(vim.o.termguicolors),
    "",
    "Stats",
    "  • Plugins    : " .. plugin_count,
    "  • Startup    : " .. startup_time,
    "  • Treesitter : " .. treesitter,
    "  • LSP Server : " .. lspinfo,
    "",
    "Paths",
    "  • Plugin   : " .. nvim.fs.plugins,
    "  • Config   : " .. nvim.stdpath.config,
    "  • Cache    : " .. nvim.stdpath.cache,
    "  • Data     : " .. nvim.stdpath.data,
    "",
    "Links",
    "  • GitHub   : https://github.com/galaxyvim/galaxyvim",
    "  • Docs     : https://github.com/galaxyvim/galaxyvim/wiki",
    "",
    "Community",
    " • Github    : https://github.com/galaxyvim/galaxyvim/discussions",
    " • Reddit    : https://www.reddit.com/r/galaxyvim",
    " • Discord   : https://discord.gg/uvtdTS8tFE",
    " • Telegram  : https://t.me/galaxyvim",
    "",
    "Credits",
    "  • Neovim Community",
    "  • Plugin Authors",
    "",
    string.rep("—", width),
    "",
    center_text("Press q or <Esc> to close", width),
    "",
  }

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
  vim.api.nvim_set_option_value("filetype", "about", { buf = buf })

  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

  vim.api.nvim_set_option_value("winblend", 10, { win = win })
  vim.api.nvim_set_option_value("wrap", false, { win = win })

  vim.keymap.set("n", "q", function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end, { buffer = buf, silent = true })

  vim.keymap.set("n", "<Esc>", function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end, { buffer = buf, silent = true })
end

vim.api.nvim_create_user_command("About", function()
  open()
end, { desc = "About Neovim Distribution"})
