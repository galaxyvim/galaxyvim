-- Auto Show Diagnostic on CursorHold
nvim.create_autocmd("CursorHold", {
  group = "lsp_diagnostic",
  callback = function()
    if not nvim.opt.lsp.onhover.diagnostic then
      return
    end
    vim.diagnostic.open_float(nil, {
      focus = false,
      scope = "cursor",
      border = "rounded",
      source = "always",
    })
  end,
})

-- Auto Show LSP Hover Docs on CursorHold
nvim.create_autocmd("CursorHold", {
  group = "lsp_docs",
  callback = function()
    if not nvim.opt.lsp.onhover.docs then
      return
    end
    if not vim.fn.mode == "n" then
      return
    end
    local timer = vim.loop.new_timer()
    timer:start(
      800,
      0,
      vim.schedule_wrap(function()
        vim.lsp.buf.hover({ focus = false })
      end)
    )
  end,
})

-- Auto format on Save
nvim.create_autocmd("BufWritePre", {
  group = "lsp_autoformat",
  callback = function(args)
    if not nvim.opt.auto.format then
      return
    end
    local ok, conform = pcall(require, "conform")
    if ok then
      conform.format {
        bufnr = args.buf,
        timeout_ms = 3000,
        lsp_fallback = true,
      }
    else
      vim.lsp.buf.format()
    end
  end,
})
