local alpha = {
  function()
    local mode = vim.fn.mode():upper()
    if mode == "\22" then
      mode = "V" .. "-" .. "B"
    elseif mode == "\19" then
      mode = "S" .. "-" .. "B"
    end
    return mode
  end,
}

local beta = {
  function()
    local symbol = nvim.icons.alphabet
    local mode = vim.fn.mode():upper()
    if mode == "\22" then
      mode = symbol.V .. "-" .. symbol.B
    elseif mode == "\19" then
      mode = symbol.S .. "-" .. symbol.B
    else
      mode = symbol[mode]
    end

    return mode
  end,
}

local icons = {
  function()
    local mode = vim.fn.mode()
    local modes = {
      n = " \u{f040} NORMAL", -- nf-fa-pencil
      i = " \u{f303} INSERT", -- nf-linux-vim
      v = " \u{f06e} VISUAL", -- nf-fa-eye
      V = " \u{f06e} V-LINE",
      ["\22"] = " \u{f06e} V-BLOCK", -- Ctrl-V
      c = " \u{f120} COMMAND", -- nf-fa-terminal
      s = " \u{f0c5} SELECT", -- nf-fa-files_o
      S = " \u{f0c5} S-LINE",
      ["\19"] = " \u{f0c5} S-BLOCK", -- Ctrl-S
      R = " \u{f044} REPLACE", -- nf-fa-edit
      r = " \u{f044} REPLACE",
      ["!"] = " \u{f489} SHELL", -- nf-oct-terminal
      t = " \u{f120} TERMINAL", -- nf-fa-terminal
    }
    return modes[mode] or " \u{f059} " .. mode:upper()
  end,
}

local helix = {
  function()
    local mode = vim.fn.mode()
    local modes = {
      n = "NOR",
      i = "INS",
      v = "VIS",
      V = "V-L",
      ["\22"] = "V-B",
      c = "CMD",
      s = "SEL",
      S = "S-L",
      ["\19"] = "S-B",
      R = "REP",
      r = "REP",
      ["!"] = "$SH",
      t = "TER",
    }
    return modes[mode]
  end,
}

local styles = {
  default = "mode",
  alpha = alpha,
  beta = beta,
  icons = icons,
  helix = helix,
}

return styles[nvim.opt.style.lualine.component.mode]
