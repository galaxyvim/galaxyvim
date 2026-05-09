local M = {}

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
    abs_head = ":p:h", -- Absolute path → directory
    abs_tail = ":p:t", -- Absolute path → file/folder name
    head_tail = ":h:t", -- Directory → last component
    tail_root = ":t:r", -- Last component → remove extension
    root_ext = ":r:e", -- Root → extension
    abs_home = ":p:~", -- Absolute path → replace home with ~
    head_root = ":h:r", -- Directory → remove extension from last component
  }

  M = function(path)
    return setmetatable({}, {
      __index = function(tbl, key)
        return fnamemodify(path, path_modifiers[key])
      end,
    })
  end

return M
