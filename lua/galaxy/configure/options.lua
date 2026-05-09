-------------------------- [ core ] --------------------------------
vim.opt.backup = false -- disable backup files
vim.opt.swapfile = false -- disable swap files
vim.opt.writebackup = false -- no backup during write
vim.opt.hidden = true -- allow switching buffers without saving
vim.opt.more = false -- disable pagination for long outputs (more)
vim.opt.clipboard = "unnamedplus" -- use system clipboard
vim.opt.mouse = "a" -- enable mouse/touch support

------------------------- [ files ] -------------------------------
vim.opt.encoding = "utf-8" -- default encoding
vim.opt.fileencodings = "utf-8,ucs-bom,latin1" -- encoding priority
vim.opt.autoread = false -- reload changed files
vim.opt.confirm = true -- confirm before closing
vim.opt.endofline = true -- newline (\n) at EOF
vim.opt.fixendofline = true -- enforce newline
vim.opt.modeline = true -- allow modeline
vim.opt.modelines = 5 -- scan lines for modeline

-------------------------- [ ui ] ----------------------------------
vim.opt.cmdheight = 0 -- command line height
vim.opt.laststatus = 3 -- global statusline
vim.opt.showmode = false -- hide -- INSERT --
vim.opt.shortmess:append "I" -- disable the default vim intro message
vim.opt.showcmd = false -- hide command preview
vim.opt.ruler = false -- hide ruler
vim.opt.cursorline = true -- highlight current line
vim.opt.number = true -- show line numbers
vim.opt.numberwidth = 4 -- width of number column
vim.opt.signcolumn = "yes" -- always show sign column
vim.opt.wrap = false -- disable line wrapping
vim.opt.scrolloff = 10 -- keep context above/below cursor
vim.opt.sidescrolloff = 10 -- keep context left/right
vim.opt.smoothscroll = true -- smooth scrolling
vim.opt.showbreak = "󰘍 " -- wrapped line prefix
vim.o.statuscolumn = "%!v:lua.statuscol()" -- statuscolumn

-------------------------[ window/popup ]-------------------------------
vim.opt.winborder = "none" -- global float window border style
vim.opt.pumheight = 12 -- popup menu height
vim.opt.winblend = nvim.opt.transparency.float
vim.opt.pumblend = nvim.opt.transparency.popup -- popup menu transparency

-------------------------- [ search ] -------------------------------
vim.opt.ignorecase = true -- case-insensitive search
vim.opt.smartcase = true -- smart case search
vim.opt.hlsearch = true -- highlight search matches
vim.opt.incsearch = true -- highlight matches while typing

-------------------------- [ splits ] -------------------------------
vim.opt.splitbelow = true -- horizontal split below
vim.opt.splitright = true -- vertical split right

----------------------- [ tabs / indent ] ------------------------
vim.opt.expandtab = true -- tabs → spaces
vim.opt.shiftwidth = 2 -- indent width
vim.opt.tabstop = 2 -- tab width
vim.opt.autoindent = true
vim.opt.smartindent = false
vim.opt.cindent = false

------------------------- [ completion ] ---------------------------
vim.opt.completeopt = { "menu", "menuone" } -- completion behavior: { "menu", "menuone", "noselect" }
vim.opt.shortmess:append "c" -- Don't show redundant messages from the insert completion menu

---------------------- [ timeout / mappings ] -------------------
vim.opt.timeout = true -- enable mapping timeout
vim.opt.timeoutlen = 300 -- mapping wait time (ms)
vim.opt.updatetime = 200 -- cursor idle delay (ms)

------------------------- [ undo / shada ] -------------------------
vim.opt.undofile = true -- persistent undo
vim.opt.undodir = nvim.fs.undo -- undo directory
vim.opt.shadafile = nvim.fs.shada -- shada path

--------------------------- [ folding ] ------------------------------
vim.opt.foldtext = "" -- no custom fold text
vim.opt.foldopen = "block,insert,jump,mark,percent,quickfix,search,tag,undo"
vim.opt.foldlevel = 99 -- open all folds
vim.opt.foldlevelstart = -1 -- respect foldlevel
vim.opt.fillchars = { fold = " ", foldopen = "", foldclose = "" } -- fold characters

------------------------- [ formatting ] ---------------------------
vim.opt.formatoptions = "jcroqlnt" -- format behavior
vim.opt.formatexpr = "v:lua.vim.lsp.formatexpr({ timeout_ms = 3000 })" -- format provider

--------------------------- [ spell ] --------------------------------
vim.opt.spelllang:append "cjk" -- ignore asian chars for spell

------------------------- [ navigation ] ---------------------------
vim.opt.whichwrap:append "<,>,[,],h,l" -- allow wrap with arrows/h/l

------------------------- [ filetypes ] ----------------------------
vim.filetype.add {
  extension = { tex = "tex", zir = "zir", cr = "crystal" },
  -- json with comments
  pattern = { ["[jt]sconfig.*.json"] = "jsonc" },
}

-- Automatic shebang-based filetype detection
vim.filetype.add {
  pattern = {
    [".*"] = {
      function(_, bufnr)
        -- Read only the first line
        local line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1]
        if not line or not line:match "^#!" then
          return
        end

        -- Clean shebang
        local sb = line:gsub("^#!%s*", "")

        -- Map interpreters to filetypes
        local interpreters = {
          bash = { "bash", "/usr/bin/bash", "/bin/bash" },
          sh = { "sh", "/bin/sh" },
          zsh = { "zsh" },
          fish = { "fish" },
          tcsh = { "tcsh", "csh" },
          ksh = { "ksh" },
          python = { "python", "python2", "python3", "/usr/bin/python", "/usr/bin/python3" },
          ruby = { "ruby", "jruby" },
          lua = { "lua", "/bin/lua" },
          php = { "php" },
          perl = { "perl" },
          javascript = { "node", "bun", "/bin/node" },
          typescript = { "deno" },
          r = { "Rscript" },
          awk = { "awk" },
        }

        -- Check interpreter matches
        for ft, names in pairs(interpreters) do
          for _, name in ipairs(names) do
            -- Use pattern match for env-based or direct path
            if sb:match(name) then
              return ft
            end
          end
        end
      end,
    },
  },
}

-----------------------[ statuscolumn ]-------------------------------

function _G.statuscol()
  local winid = vim.api.nvim_get_current_win()
  local bufnr = vim.api.nvim_win_get_buf(winid)
  if vim.bo[bufnr].buftype ~= "" then
    -- hides the statuscolumn for local window only for non file buffer
    vim.wo.statuscolumn = ""
  end

  function _G.togglefold()
    local pos = vim.fn.getmousepos()
    vim.api.nvim_win_set_cursor(pos.winid, { pos.line, 1 })
    vim.api.nvim_win_call(pos.winid, function()
      if vim.fn.foldlevel(pos.line) > 0 then
        vim.cmd "normal! za"
      end
    end)
  end

  local lnum = vim.v.lnum

  local fchar = vim.opt.fillchars:get()
  local opened = vim.fn.foldclosed(lnum) == -1

  local arrow = opened and fchar.foldopen or fchar.foldclose
  local available = vim.fn.foldlevel(lnum) > vim.fn.foldlevel(lnum - 1)

  local cursor = (lnum == vim.fn.line ".")
  local hl = opened and (cursor and "CursorFold" or "FoldColumn") or "FoldedColumn"
  local fold = (available and nvim.hl.format(hl, arrow) or " ") .. " "

  -- clickable fold column
  return "%@v:lua.togglefold@" .. fold .. "%s" .. "%X" .. "%l" .. " "
end
