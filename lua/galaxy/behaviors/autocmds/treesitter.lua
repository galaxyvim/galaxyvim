local highlight = function(bufnr, lang)
  -------------------[ treesitter highlights ]-------------------------------
  if nvim.opt.treesitter.highlights then
    if not vim.treesitter.language.add(lang) then
      return vim.notify(
        string.format("Treesitter cannot load parser for language: %s", lang),
        vim.log.levels.INFO,
        { title = "Treesitter" }
      )
    end
    vim.treesitter.start(bufnr)
  end
end

nvim.create_autocmd("FileType", {
  callback = function(args)
    local ft = vim.bo.filetype
    ft = nvim.opt.treesitter.language[ft] or ft
    local bt = vim.bo.buftype
    local buf = args.buf

    if bt ~= "" then return end

    local ok, treesitter = pcall(require, "nvim-treesitter")

    if not ok then return end

    --------------------[ treesitter folds ]-------------------------------

    if nvim.opt.treesitter.folds then
      if ft == "javascriptreact" or ft == "typescriptreact" then
        vim.opt_local.foldmethod = "indent"
      else
        vim.opt_local.foldmethod = "expr"
        vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      end

      vim.schedule(function()
        -- Do not fold in terminal mode
        if vim.fn.mode() ~= "t" then
          vim.cmd "silent! normal! zx"
        end
      end)
    end

    if nvim.opt.treesitter.indent then
      if not vim.tbl_contains({ "python", "html", "yaml", "markdown" }, ft) then
        vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
      end
    end

    --------------------[ treesitter parsers ]-------------------------------
    if vim.fn.executable "tree-sitter" ~= 1 then
      vim.api.nvim_echo({
        {
          "tree-sitter CLI not found. Parsers cannot be installed.",
          "ErrorMsg",
        },
      }, true, {})
      return false
    end

    if not vim.treesitter.language.get_lang(ft) then
      return
    end

    if vim.list_contains(treesitter.get_installed(), ft) then
      highlight(buf, ft)
    elseif vim.list_contains(treesitter.get_available(), ft) then
      treesitter.install(ft):await(function()
        highlight(buf, ft)
      end)
    end
  end,
})
