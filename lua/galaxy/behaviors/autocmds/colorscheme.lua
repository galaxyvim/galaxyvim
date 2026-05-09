nvim.create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    nvim.hl.set("Reset", { fg = "NONE", bg = "NONE" })
    nvim.hl.set("LspProgressIcon", { fg = nvim.hl.DiagnosticWarn.fg, bold = true })
    nvim.hl.set("LspProgressText", { fg = nvim.hl.Title.fg, bold = false })
    nvim.hl.set("LspProgressClient", { fg = nvim.hl.DiagnosticOk.fg, bold = false })

    vim.schedule(function()
      -- Bold DevIconJava
      nvim.hl.set("BufferLineDevIconJava", { fg = nvim.hl.get("DevIconJava").fg, bg = nvim.hl.get("BufferLineBuffer").bg, bold = true })
      nvim.hl.set("BufferLineDevIconJavaInactive", { fg = nvim.hl.get("DevIconJava").fg, bg = nvim.hl.get("BufferLineBufferVisible").bg, bold = true })
      nvim.hl.set("BufferLineDevIconJavaSelected", { fg = nvim.hl.get("DevIconJava").fg, bg = nvim.hl.get("BufferLineBufferSelected").bg, bold = true })
    end)

  end,
})
