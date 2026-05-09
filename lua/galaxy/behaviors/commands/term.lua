local recent_term = nil
local buf

local toggleterm = function()
  local Terminal = nvim.require("toggleterm.terminal").Terminal

  if recent_term then
    return recent_term
  end

  local term = Terminal:new {
    display_name = nil,
    direction = "horizontal",
    shell = vim.o.shell,
    close_on_exit = true,
    start_in_insert = true,
    auto_scroll = true,
  }

  recent_term = term

  return term
end

local close_term = function(term, bufnr)
  if term and vim.api.nvim_win_is_valid(term.window) then
    vim.api.nvim_win_close(term.window, true)
    vim.api.nvim_set_current_buf(bufnr)
  end
end

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(args)
    local bufnr = args.buf -- get buffer number
    local bufname = vim.api.nvim_buf_get_name(bufnr) -- get name of buffer
    local buftype = vim.bo[bufnr].buftype -- get buffer type

    -- only track normal file buffers
    if buftype == "" and bufname ~= "" then
      if buf and buf ~= bufnr then
        close_term(recent_term, bufnr)
      end

      buf = bufnr
    end
  end,
})

vim.api.nvim_create_user_command("Run", function(opts)
  if not buf or not vim.api.nvim_buf_is_valid(buf) then
    vim.notify "No file buffer to run"
    return
  end

  --  local file = vim.fn.expand("%")
  --  local ftype = vim.bo.filetype

  local file = vim.api.nvim_buf_get_name(buf) -- get filename by last buffer number
  local ftype = vim.bo[buf].filetype
  local fbase = vim.fn.fnamemodify(file, ":r") -- get file basename without extension
  local fdir = vim.fn.fnamemodify(file, ":h") -- get file absolute path

  local cmd_map = {
    -- Interpreted languages
    python = "python " .. file,
    lua = "lua " .. file,
    ruby = "ruby " .. file,
    php = "php " .. file,
    r = "Rscript " .. file,
    perl = "perl " .. file,
    sh = "bash " .. file,
    zsh = "zsh " .. file,
    fish = "fish " .. file,
    julia = "julia " .. file,
    elixir = "elixir " .. file,
    clojure = "clojure " .. file,
    haskell = "runhaskell " .. file,
    scala = "scala " .. file,
    dart = "dart run " .. file,
    crystal = "crystal run " .. file,
    nim = "nim compile --run " .. file,
    zig = "zig run " .. file,

    -- JavaScript / TypeScript
    javascript = "node " .. file,
    typescript = "node " .. file,

    -- React / JS frameworks
    javascriptreact = "npm run dev",
    typescriptreact = "npm run dev",

    -- Other JS frameworks
    nextjs = "npm run dev",
    nuxt = "npm run dev",
    vue = "npm run serve",
    angular = "ng serve",
    svelte = "npm run dev",

    -- Node.js scripts
    express = "node " .. file,
    nestjs = "npm run start",
    deno = "deno run " .. file,
    electron = "npm run start",

    -- Compiled languages
    c = "gcc " .. file .. " -o " .. fbase .. " && " .. fbase,
    cpp = "g++ " .. file .. " -o " .. fbase .. " && " .. fbase,
    java = "javac " .. file .. " && java " .. fbase,
    kotlin = "kotlinc " .. file .. " -include-runtime -d " .. fbase .. ".jar && java -jar " .. fbase .. ".jar",
    csharp = "dotnet run",
    vb = "vbc " .. file .. " && " .. fbase .. ".exe",
    rust = "cargo run",
    go = "go run " .. file,
  }

  local cmd = cmd_map[ftype]
  if not cmd then
    vim.notify("No runner found for filetype:" .. ftype)
    return
  end

  local args

  local cmd_args = function()
    if opts.fargs and #opts.fargs > 0 then
      args = table.concat(opts.fargs, " ")
      return cmd .. " " .. args
    else
      return cmd
    end
  end

  vim.cmd "silent! write"

  local term = toggleterm()
  if not term:is_open() then
    term:open(10) -- size=10
  end

  --  print(term.dir, term.id, term.window)

  if term.dir ~= fdir then
    term:change_dir(fdir)
  end

  term:send(cmd_args())
end, { nargs = "*" })

vim.api.nvim_create_user_command("Term", function(opts)
  local term = toggleterm()

  term:toggle(10)
  if #opts.args > 0 then
    term:send(opts.args)
  end
  vim.cmd "startinsert"
end, { nargs = "*" })
