local M = {}
  function M.module(name)
    -- remove common prefixes
    name = name:gsub("^[nN]e[oO]vim[_%-%.]*", "") -- remove leading neovim
    name = name:gsub("^[nN]vim[_%-%.]*", "") -- remove leading nvim
    name = name:gsub("^[vV]im[_%-%.]*", "") -- remove leading vim

    -- remove common suffixes
    name = name:gsub("[_%-%.]*[nN]e[oO]vim$", "") -- remove trailing neovim
    name = name:gsub("[_%-%.]*[nN]vim$", "") -- remove trailing nvim
    name = name:gsub("[_%-%.]*[vV]im$", "") -- remove trailing vim

    -- remove any leftover leading/trailing separators
    name = name:gsub("^[_%-%.]+", "")
    name = name:gsub("[_%-%.]+$", "")

    return name
  end

return M
