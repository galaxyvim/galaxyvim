local function is_unix()
  return vim.fn.has "win32" == 0 and vim.fn.has "win64" == 0
end

local function detect_shebang()
  if not is_unix() then
    return nil
  end

  local ft = vim.bo.filetype

  local map = {
    python = { "python3", "python" },
    lua = { "lua" },
    sh = { "sh" },
    bash = { "bash" },
    zsh = { "zsh" },
    javascript = { "node" },
    typescript = { "node" },
    ruby = { "ruby" },
    perl = { "perl" },
    php = { "php" },
    julia = { "julia" },
  }

  local list = map[ft]
  if not list then
    return nil
  end

  for _, exe in ipairs(list) do
    local path = vim.fn.exepath(exe)
    if path ~= "" then
      return "#!" .. path
    end
  end

  return nil
end

local function insert_shebang_if_missing()
  local shebang = detect_shebang()
  if not shebang then
    return
  end

  local first = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] or ""

  if first:match "^#!" then
    return
  end

  vim.api.nvim_buf_set_lines(0, 0, 0, false, { shebang, "" })
end

vim.api.nvim_create_user_command("Shebang", function()
  insert_shebang_if_missing()
end, {})

if nvim.opt.auto.shebang then
  vim.api.nvim_create_autocmd("BufNewFile", {
    callback = function()
      vim.schedule(function()
        insert_shebang_if_missing()
      end)
    end,
  })
end
