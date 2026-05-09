return {
  function()
    local indicator = {
      " ",
      " ",
    }
    local rec = vim.fn.reg_recording()
    if rec == "" then
      return "" -- no recording
    end

    return indicator[os.date "%S" % #indicator + 1] .. "rec @" .. rec
  end,
  color = function()
    return {
      fg = nvim.hl.get("DiagnosticError").fg,
      gui = "bold",
    }
  end,
}
