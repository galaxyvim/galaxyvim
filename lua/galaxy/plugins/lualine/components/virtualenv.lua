local function get_venv()
  local venv = os.getenv "VIRTUAL_ENV"
  if venv then
    return vim.fn.fnamemodify(venv, ":t"), "venv"
  end

  local conda = os.getenv "CONDA_DEFAULT_ENV"
  if conda then
    return conda, "conda"
  end

  local cwd = vim.loop.cwd()
  if vim.fn.isdirectory(cwd .. "/.venv") == 1 then
    return ".venv", "Local"
  end
end

local colors = {
  venv =  "#A6E3A1", -- green
  conda = "#F9E2AF", -- yellow
  Local = "#60AAFF", -- blue
}

local function component()
  local name, kind = get_venv()
  if not name then
    return ""
  end

  return {
    function()
      return " " .. name
    end,
    color = function()
      return { fg = colors[kind] or "#CDD6F4", gui = "bold" }
    end,
  }
end

return component()
