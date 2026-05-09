_G.nvim = {
  opt = {},
  stats = {},
  packages = {},
}

nvim.v = vim.version()
nvim.v.require = 11

vim.opt.more = false -- disable pagination for long outputs (more)

function nvim.print(...)
  return vim.g.debug and vim.print(...)
end

----------------------[ NEOVIM VERSION ]-------------------------------

-- Check Neovim version requirement
if nvim.v.major >= 0 and nvim.v.minor < nvim.v.require then
  vim.api.nvim_echo({
    {
      string.format(
        "Unsupported Neovim version: %d.%d detected.\nThis configuration requires Neovim >= %d.%d.",
        nvim.v.major,
        nvim.v.minor,
        nvim.v.major,
        nvim.v.require
      ),
      "Tag",
    },
  }, true, {})
  vim.fn.input "Press Enter to exit..."
  vim.cmd "quit"
end

-- Store deprecation logs
nvim.deprecations = {}

-- Override vim.deprecate() to capture deprecation warnings into a table and get output using :Deprecated
vim.deprecate = function(name, alternative, version, plugin, backtrace)
  table.insert(nvim.deprecations, {
    name = name,
    alternative = alternative,
    version = version,
    plugin = plugin,
    backtrace = backtrace,
    time = os.date "%Y-%m-%d %H:%M:%S",
  })
end

---------------------[ Prerequisites  ]-------------------------------

local binaries = { "git", "rg", "node", "npm" }

local missing = {}
for _, bin in ipairs(binaries) do
  local which = vim.fn.executable
  if bin == "fd" then
    if which(bin) ~= 1 then
      if which "fdfind" ~= 1 then
        table.insert(missing, bin)
      end
    end
  else
    if which(bin) ~= 1 then
      table.insert(missing, bin)
    end
  end
end

if next(missing) then
  vim.api.nvim_echo({ { string.format(" %-6s | %-10s", "Binary", "Status"), "String" } }, true, {})
  print(string.rep("-", 20))
  for _, bin in ipairs(missing) do
    vim.api.nvim_echo({ { string.format(" %-6s | ✖ Missing ", bin), "Special" } }, true, {})
  end
  vim.api.nvim_echo({ { "Missing required binaries! Please install them before continuing.", "ErrorMsg" } }, true, {})
  vim.fn.input "Press Enter to exit…"
  vim.cmd "quit"
end

-----------------------------------------------------------------------

nvim.stdpath = {
  config = vim.fn.stdpath "config",
  data = vim.fn.stdpath "data",
  cache = vim.fn.stdpath "cache",
  state = vim.fn.stdpath "state",
  log = vim.fn.stdpath "log",
  run = vim.fn.stdpath "run",
}

function nvim.filepath(lvl, opt)
  return debug.getinfo(lvl or 1, opt or "S").source:sub(2)
end

local fnamemodify = vim.fn.fnamemodify

local path_modifiers = {
  -- Single modifiers
  abs = ":p", -- Absolute/full path
  head = ":h", -- Directory of the file/folder (head)
  tail = ":t", -- File or folder name only (tail)
  root = ":r", -- Name without extension (root)
  ext = ":e", -- File extension only (empty for folders)
  home = ":~", -- Replace home directory with ~
  rel = ":.", -- Make path relative to current directory

  -- Two-modifier combinations
  abs_head = ":p:h", -- Absolute path -> directory
  abs_tail = ":p:t", -- Absolute path -> file/folder name
  head_tail = ":h:t", -- Directory -> last component
  tail_root = ":t:r", -- Last component -> remove extension
  root_ext = ":r:e", -- Root -> extension
  abs_home = ":p:~", -- Absolute path -> replace home with ~
  head_root = ":h:r", -- Directory -> remove extension from last component
}

nvim.path = function(path)
  path = path or nvim.filepath()
  return setmetatable({}, {
    __index = function(_, key)
      return fnamemodify(path, path_modifiers[key])
    end,
  })
end

nvim.main = nvim.path().head_tail

function nvim.mkdir(path)
  if vim.fn.isdirectory(path) == 0 then
    vim.fn.mkdir(path, "p")
  end
  return path
end

nvim.file = {
  exists = (vim.uv or vim.loop).fs_stat,
}

function nvim.augroup(name, opts)
  return vim.api.nvim_create_augroup(name, opts or {})
end

function nvim.namespace(name)
  return vim.api.nvim_create_namespace(name)
end

nvim.create_autocmd = function(event, opts)
  opts = opts or {}

  -- handle group creation
  if type(opts.group) == "string" then
    local group_name = opts.group
    local clear = opts.clear or false

    opts.group = nvim.augroup(group_name, { clear = clear })
    opts.clear = nil
  end
  vim.api.nvim_create_autocmd(event, opts)
end
nvim.map = vim.keymap.set

-------------------------[ PATHS ]-------------------------------

nvim.fs = {
  undo = nvim.stdpath.state .. "/undo",
  package = nvim.stdpath.data .. "/site/pack",
  shada = nvim.stdpath.state .. "/nvim.shada",
  snippet = nvim.stdpath.config .. "/snippets",
  configs = nvim.stdpath.config .. "/configs.lua",
  presets = nvim.stdpath.config .. "/presets.lua",
  treesitter = nvim.stdpath.data .. "/site/treesitter",
}

nvim.fs.plugins = nvim.fs.package .. "/lazy"
nvim.fs.lazy = nvim.fs.plugins .. "/lazy.nvim"

nvim.fs.user = {
  specs = "plugins",
}

nvim.fs.snippets = {
  luasnip = {
    nvim.fs.snippet .. "/luasnip",
  },
  vscode = {
    nvim.fs.snippet .. "/vscode",
    nvim.fs.plugins .. "/friendly-snippets",
  },
  snipmate = {
    nvim.fs.snippet .. "/snipmate",
  },
}

nvim.fs.dictionary = {
  nvim.stdpath.config .. "/dictionary/words",
}

nvim.fs.runtime = {
  nvim.fs.lazy,
  nvim.fs.treesitter,
}

nvim.fs.main = nvim.path().head
nvim.fs.root = vim.fs.normalize(nvim.fs.main .. "/../..")

-----------------------------------------------------------------------

function nvim.dofile(path)
  if not nvim.file.exists(path) then
    return
  end
  local ok, mod = pcall(dofile, path)
  if not ok then
    vim.notify("Cannot load file: " .. mod, vim.log.levels.WARN)
  end
  return mod
end

function nvim.load(name, main, dest)
  if main == nil then
    main = true
  end

  if type(name) == "table" then
    local modules = dest or {}
    if next(modules) then
      for _, val in ipairs(name) do
        for key, mod in pairs(val) do
          modules[key] = nvim.load(mod, main)
        end
      end
    else
      for _, mod in ipairs(name) do
        modules[mod] = nvim.load(mod, main)
      end
    end
    return modules
  else
    if main then
      name = string.format("%s.%s", nvim.main, name)
    end

    local start = vim.loop.hrtime()

    local ok, mod = pcall(require, name)
    if not ok then
      vim.notify("Cannot load module '" .. name .. "': " .. mod, vim.log.levels.WARN)
    end
    nvim.stats[name] = (vim.loop.hrtime() - start) / 1e6 -- ms
    return mod
  end
end

function nvim.autoload(path, dest, init)
  local modules = dest or {}
  local files = vim.fn.readdir(string.format("%s/%s", nvim.fs.main, path))
  for _, file in ipairs(files) do
    local name = file:gsub(".lua", "")
    if name ~= "init" or init == true then
      module = path:gsub("/", ".") .. "." .. nvim.path(file).tail_root
      modules[name] = nvim.load(module)
    end
  end

  return modules
end

nvim.require = function(name)
  return nvim.load(name, false)
end

-----------------------[ LOAD UTILS ]-------------------------------

nvim.autoload("utils", nvim)
local utils = nvim.load "utils"
_G.nvim = nvim.merge(utils, nvim)

----------------------[ LOAD MODULES ]-------------------------------
nvim.load {
  "configure",
  "behaviors",
  "lspconfig",
  "bootstrap",
  "mappings",
}
