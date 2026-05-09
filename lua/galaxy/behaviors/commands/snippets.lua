local builtin_filetypes = vim.fn.getcompletion("", "filetype")
nvim.table.remove(builtin_filetypes, "all")
table.insert(builtin_filetypes, 1, "all")

vim.schedule(function()
  -- Get current filetype
  local current = vim.bo.filetype

  nvim.table.remove(builtin_filetypes, current)
  table.insert(builtin_filetypes, 1, current)

  -- Get all filetypes
  -- local filetypes = vim.fn.getcompletion("", "filetype")

  -- Function to read a file into a string
  local function read_file(path)
    local file = io.open(path, "r")
    if not file then
      return
    end
    local content = file:read "*a" -- read entire file
    file:close()
    return content
  end

  -- Example usage
  local path = nvim.stdpath.config .. "/snippets/"
  local content = read_file(path .. "vscode/" .. "package.json")

  if not content then
    return
  end

  -- Decode JSON
  local data = vim.fn.json_decode(content)
  local snippets = data.contributes.snippets
  local filetypes = {}

  for _, val in ipairs(snippets) do
    local lang = val.language
    local path = val.path:gsub("^%./", "")

    if type(lang) == "table" then
      for _, l in ipairs(lang) do
        if l ~= current then
          filetypes[l] = path
        end
      end
    else
      if val ~= current then
        local file = nvim.path(path).tail_root
        file = file == lang and lang or lang .. "/" .. file
        filetypes[file] = path
      end
    end
  end

  local vscode_filetypes = vim.tbl_keys(filetypes)
  nvim.table.remove(vscode_filetypes, "global")
  table.insert(vscode_filetypes, 1, "global")

  if filetypes[current] then
    nvim.table.remove(vscode_filetypes, current)
    table.insert(vscode_filetypes, 1, current)
  end

  -- vim.print(vim.tbl_keys(filetypes))

  local options = {
    "luasnip",
    "snipmate",
    "vscode",
  }

  local names = {
    luasnip = builtin_filetypes,
    snipmate = builtin_filetypes,
    vscode = vscode_filetypes,
  }

  local sources = {
    [1] = options, -- $1
    [2] = names, -- $2
  }

  vim.api.nvim_create_user_command("Snippets", function(opts)
    local args = {}

    for arg in opts.args:gmatch "%S+" do
      table.insert(args, arg)
    end

    local name = args[2]
    local sniptype = args[1]
    local target
    if sniptype == "vscode" then
      target = filetypes[name]
    elseif sniptype == "luasnip" then
      target = name .. ".lua"
    elseif sniptype == "snipmate" then
      target = name .. ".snippets"
    end
    vim.print(target)

    if target then
      local file = path .. sniptype .. "/" .. target
      if sniptype == "vscode" then
        nvim.mkdir(nvim.path(file).head)
      end

      local snippet_content = {
        luasnip = {},
        snipmate = {},
        vscode = {
          "{",
          '  "Print to Console": {',
          '    "prefix": "log",',
          '    "body": [',
          "      \"console.log('$1');\",",
          '      "$2"',
          "    ],",
          '    "description": "Log output to console"',
          "  }",
          "}",
        },
      }

      vim.cmd.edit(file)

      if not nvim.file.exists(file) then
        -- Replace the entire buffer with the snippet content
        vim.api.nvim_buf_set_lines(0, 0, -1, false, snippet_content[sniptype])
      end
    else
      vim.notify(string.format("Snippets not available for: %s", opts.args))
    end
  end, {
    nargs = 1,
    complete = function(ArgLead, CmdLine, CursorPos)
      -- take only the part of the line after the command
      local after_cmd = CmdLine:sub(#":Snippets" + 2, CursorPos)
      -- split by spaces, ignoring empty parts
      local args = {}
      for word in after_cmd:gmatch "%S+" do
        table.insert(args, word)
      end

      local option = vim.split(CmdLine, " ")[2]

      local index = #args + 1 -- current argument being typed
      local completion = sources[index] or {}
      completion = completion[option] or completion

      local matches = {}
      for _, name in ipairs(completion) do
        if name:lower():match("^" .. ArgLead:lower()) then
          table.insert(matches, name)
        end
      end
      return matches
    end,
  })
end)
