local map = vim.keymap.set
local opts = function(...)
  local default = { noremap = true, silent = true }
  local extra = (...) or {}
  return nvim.merge(default, extra)
end

local textobjects = {
  select = function(group, parser_group)
    return function()
      nvim.require("nvim-treesitter-textobjects.select").select_textobject(group, parser_group or "textobjects")
    end
  end,
  move = function(name, group, parser_group)
    return function()
      nvim.require("nvim-treesitter-textobjects.move")[name](group, parser_group or "textobjects")
    end
  end,
}

if nvim.plugins.ts_textobjects.enabled then
  ----------------------[ textobjects select ]-------------------------------
  map({ "o", "x" }, "ak", textobjects.select "@block.outer", { desc = "around block" })
  map({ "o", "x" }, "ik", textobjects.select "@block.inner", { desc = "inside block" })
  map({ "o", "x" }, "ac", textobjects.select "@class.outer", { desc = "around class" })
  map({ "o", "x" }, "ic", textobjects.select "@class.inner", { desc = "inside class" })
  map({ "o", "x" }, "a?", textobjects.select "@conditional.outer", { desc = "around conditional" })
  map({ "o", "x" }, "i?", textobjects.select "@conditional.inner", { desc = "inside conditional" })
  map({ "o", "x" }, "af", textobjects.select "@function.outer", { desc = "around function " })
  map({ "o", "x" }, "if", textobjects.select "@function.inner", { desc = "inside function " })
  map({ "o", "x" }, "ao", textobjects.select "@loop.outer", { desc = "around loop" })
  map({ "o", "x" }, "io", textobjects.select "@loop.inner", { desc = "inside ltextobjects.select" })
  map({ "o", "x" }, "aa", textobjects.select "@parameter.outer", { desc = "around argument" })
  map({ "o", "x" }, "ia", textobjects.select "@parameter.inner", { desc = "inside argument" })

  ----------------------[ textobjects move ]-------------------------------
  -- goto_next_start
  -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queries.
  map({ "n", "x", "o" }, "]o", textobjects.move("goto_next_start", "@loop.*"))
  map({ "n", "x", "o" }, "]d", textobjects.move("goto_next_start", "@conditional.outer"))
  map({ "n", "x", "o" }, "]c", textobjects.move("goto_next_start", "@class.outer"), { desc = "Next class start" })
  map({ "n", "x", "o" }, "]k", textobjects.move("goto_next_start", "@block.outer"), { desc = "Next block start" })
  map({ "n", "x", "o" }, "]f", textobjects.move("goto_next_start", "@function.outer"), { desc = "Next function start" })
  map( { "n", "x", "o" }, "]a", textobjects.move("goto_next_start", "@parameter.inner"), { desc = "Next argument start" })
  map({ "n", "x", "o" }, "]s", textobjects.move("goto_next_start", "@local.scope", "locals"), { desc = "Next scope" })
  map({ "n", "x", "o" }, "]z", textobjects.move("goto_next_start", "@fold", "folds"), { desc = "Next fold" })
  -- goto_next_end
  map({ "n", "x", "o" }, "]O", textobjects.move("goto_next_end", "@loop.*"))
  map({ "n", "x", "o" }, "]D", textobjects.move("goto_next_end", "@conditional.outer"))
  map({ "n", "x", "o" }, "]D", textobjects.move("goto_next_end", "@conditional.outer"))
  map({ "n", "x", "o" }, "]C", textobjects.move("goto_next_end", "@class.outer"), { desc = "Next class end" })
  map({ "n", "x", "o" }, "]K", textobjects.move("goto_next_end", "@block.outer"), { desc = "Next block end" })
  map({ "n", "x", "o" }, "]F", textobjects.move("goto_next_end", "@function.outer"), { desc = "Next function end" })
  map({ "n", "x", "o" }, "]A", textobjects.move("goto_next_end", "@parameter.inner"), { desc = "Next argument end" })
  -- goto_previous_start
  map({ "n", "x", "o" }, "[o", textobjects.move("goto_previous_start", "@loop.*"))
  map({ "n", "x", "o" }, "[d", textobjects.move("goto_previous_start", "@conditional.outer"))
  map({ "n", "x", "o" }, "[c", textobjects.move("goto_previous_start", "@class.outer"), { desc = "Previous class start" })
  map({ "n", "x", "o" }, "[k", textobjects.move("goto_previous_start", "@block.outer"), { desc = "Previous block start" })
  map({ "n", "x", "o" }, "[f", textobjects.move("goto_previous_start", "@function.outer"), { desc = "Previous function start" })
  map({ "n", "x", "o" }, "[a", textobjects.move("goto_previous_start", "@parameter.inner"), { desc = "Previous argument start" })

  -- goto_previous_end
  map({ "n", "x", "o" }, "[O", textobjects.move("goto_previous_end", "@loop.*"))
  map({ "n", "x", "o" }, "[D", textobjects.move("goto_previous_end", "@conditional.outer"))
  map({ "n", "x", "o" }, "[c", textobjects.move("goto_previous_end", "@class.outer"), { desc = "Previous class start" })
  map({ "n", "x", "o" }, "[K", textobjects.move("goto_previous_end", "@block.outer"), { desc = "Previous block end" })
  map({ "n", "x", "o" }, "[F", textobjects.move("goto_previous_end", "@function.outer"), { desc = "Previous function end" })
  map({ "n", "x", "o" }, "[A", textobjects.move("goto_previous_end", "@parameter.inner"), { desc = "Previous argument end" })

  ----------------------[ textobjects swap ]-------------------------------
  -- swap_next
  map("n", ">K", "@block.outer", { desc = "Swap next block" })
  map("n", ">F", "@function.outer", { desc = "Swap next function" })
  map("n", ">A", "@parameter.inner", { desc = "Swap next argument" })

  -- swap_previous
  map("n", "<K", "@block.outer", { desc = "Swap previous block" })
  map("n", "<F", "@function.outer", { desc = "Swap previous function" })
  map("n", "<A", "@parameter.inner", { desc = "Swap previous argument" })
end

-------------------------[ Comment Toggle ]-------------------------------

vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Comments" })
vim.keymap.set("v", "<leader>/", "gc", { remap = true, desc = "Comments" })

vim.keymap.set("i", "<C-_>", "<C-o>gcc", { remap = true, desc = "Comments" })
vim.keymap.set("n", "<C-_>", "gcc", { remap = true, desc = "Comments" })
vim.keymap.set("v", "<C-_>", "gc", { remap = true, desc = "Comments" })

-------------------------[ Command Line ]-------------------------------

map("n", "<A-p>", ":", { desc = "Open cmdline" })
map("i", "<A-p>", "<C-o>:", { desc = "Open cmdline" })

---------------------[ Clear Search Highlights ]-------------------------------

-- Clear search highlights with ESC
map("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>", opts { desc = "Clear search highlights" })

------------------------[ GOTO LINE NUMBER ]-------------------------------

map({ "n", "x" }, ",", function()
  local line = tostring(vim.v.count)
  if line == "0" then
    local pos = vim.api.nvim_win_get_cursor(0)[1]
    if pos == 1 then
      line = "normal! G0"
    else
      line = "normal! gg0"
    end
  end
  vim.cmd(line)
end)

------------------------[ Window Management ]-------------------------------

-- Window Navigation
map("n", "<C-h>", "<C-w>h", opts { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", opts { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", opts { desc = "Move to top window" })
map("n", "<C-l>", "<C-w>l", opts { desc = "Move to right window" })

-- Splitting & Resizing
map("n", "<A-v>", ":vsplit<CR>", opts { desc = "Split window vertically" })
map("n", "<A-h>", ":split<CR>", opts { desc = "Split window horizontally" })

--------------------[ Smart Window Management ]-------------------------------

if nvim.plugins.smart_splits.enabled then
  -- resizing splits
  map("n", "<A-S-Up>", '<cmd>lua require("smart-splits").resize_up()<cr>', opts {})
  map("n", "<A-S-Down>", '<cmd>lua require("smart-splits").resize_down()<cr>', opts {})
  map("n", "<A-S-Left>", '<cmd>lua require("smart-splits").resize_left()<cr>', opts {})
  map("n", "<A-Right>", '<cmd>lua require("smart-splits").resize_right()<cr>', opts {})
  map("n", "<C-Left>", '<cmd>lua require("smart-splits").resize_left()<cr>', opts {})
  map("n", "<C-Right>", '<cmd>lua require("smart-splits").resize_right()<cr>', opts {})
  -- moving between splits
  map("n", "<C-h>", '<cmd>lua require("smart-splits").move_cursor_left()<cr>', opts {})
  map("n", "<C-j>", '<cmd>lua require("smart-splits").move_cursor_down()<cr>', opts {})
  map("n", "<C-k>", '<cmd>lua require("smart-splits").move_cursor_up()<cr>', opts {})
  map("n", "<C-l>", '<cmd>lua require("smart-splits").move_cursor_right()<cr>', opts {})
  map("n", "<C-\\>", '<cmd>lua require("smart-splits").move_cursor_previous()<cr>', opts {})
  -- swapping buffers between windows
  map("n", "<C-S-h>", '<cmd>lua require("smart-splits").swap_buf_left()<cr>', opts {})
  map("n", "<C-S-j>", '<cmd>lua require("smart-splits").swap_buf_down()<cr>', opts {})
  map("n", "<C-S-k>", '<cmd>lua require("smart-splits").swap_buf_up()<cr>', opts {})
  map("n", "<C-S-l>", '<cmd>lua require("smart-splits").swap_buf_right()<cr>', opts {})
end

---------------------[ Duplicate Lines ]-------------------------------

-- NORMAL mode: Duplicate line (without yank)
map("n", "<A-j>", '"zyy"zP', opts { desc = "Duplicate line down" })
map("n", "<A-k>", '"zyy"zp', opts { desc = "Duplicate line up" })

-- INSERT mode: Duplicate line (without yank)
map("i", "<A-j>", '<ESC>"zyy"zP', opts { desc = "Duplicate line down" })
map("i", "<A-k>", '<ESC>"zyy"zp', opts { desc = "Duplicate line up" })

-- VISUAL mode: Duplicate selection (without yank)
map("v", "<A-j>", '"zyo<Esc>"zP', opts { desc = "Duplicate line down" })
map("v", "<A-k>", '"zyO<Esc>"zp', opts { desc = "Duplicate line up" })

------------------------[ Move Lines ]-------------------------------

-- Visual mode: move selected lines / indent
map("v", "J", ":m '>+1<CR>gv=gv", opts { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", opts { desc = "Move selection up" })
map("v", "L", ">gv", opts { desc = "Indent selection right" })
map("v", "H", "<gv", opts { desc = "Indent selection left" })

map("v", "<A-Down>", ":m '>+1<CR>gv=gv", opts { desc = "Move selection down" })
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", opts { desc = "Move selection up" })
map("v", "<A-Right>", ">gv", opts { desc = "Indent selection right" })
map("v", "<A-Left>", "<gv", opts { desc = "Indent selection left" })

-- Normal mode: move / indent current line
map("n", "J", ":m .+1<CR>==", opts { desc = "Move line down" })
map("n", "K", ":m .-2<CR>==", opts { desc = "Move line up" })
map("n", "L", ">>", opts { desc = "Indent line right" })
map("n", "H", "<<", opts { desc = "Indent line left" })

map("n", "<A-Down>", ":m .+1<CR>==", opts { desc = "Move line down" })
map("n", "<A-Up>", ":m .-2<CR>==", opts { desc = "Move line up" })
map("n", "<A-Right>", ">>", opts { desc = "Indent line right" })
map("n", "<A-Left>", "<<", opts { desc = "Indent line left" })

-- Insert mode: move / indent current line
map("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", opts { desc = "Move line down" })
map("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", opts { desc = "Move line up" })
map("i", "<A-Left>", "<Esc><<gi", opts { desc = "Indent line left" })
map("i", "<A-Right>", "<Esc>>>gi", opts { desc = "Indent line right" })

----------------------[ Line Insertion ]-------------------------------

map("n", "<A-Enter>", "o", opts { desc = "Insert new line below" })
map("i", "<A-Enter>", "<C-o>o", opts { desc = "Insert new line below" })

---------------------[ Buffer Management ]-------------------------------

map({ "n", "i" }, "<C-b>.", "<cmd>enew<CR>", opts { desc = "New buffer" })
map({ "n", "i" }, "<C-b>f", "<cmd>bfirst<CR>", opts { desc = "Goto first buffer" })
map({ "n", "i" }, "<C-b>l", "<cmd>blast<CR>", opts { desc = "Goto last buffer" })
map({ "n", "i" }, "<C-b>o", ":%bd|e#|bd#<CR>", opts { desc = "Close other buffers" })
map({ "n", "i" }, "<C-b>s", nvim.buffer.switch, opts { desc = "Switch buffer" })
map({ "n", "i" }, "<C-b>q", nvim.buffer.close, opts { desc = "Close buffer" })
map({ "n", "i" }, "<C-b>r", nvim.buffer.restore, opts { desc = "Restore buffer" })
map({ "n", "i" }, "<C-b>n", nvim.buffer.next, opts { desc = "Next buffer" })
map({ "n", "i" }, "<C-b>b", nvim.buffer.previous, opts { desc = "Previous buffer" })
map({ "n", "i" }, "<C-b><Left>", nvim.buffer.close_left, opts { desc = "Close buffers to left" })
map({ "n", "i" }, "<C-b><Right>", nvim.buffer.close_right, opts { desc = "Close buffers to right" })

------------------------[ Save & Exit ]-------------------------------

-- Save the file with Ctrl+S
map("n", "<C-s>", "<cmd>w<CR>", opts { desc = "Save file" })
map("v", "<C-s>", "<Esc><cmd>w<CR>", opts { desc = "Save file" })
map("i", "<C-s>", "<Esc><cmd>w<CR>`^i", opts { desc = "Save file" })

-- Exit NVIM with Ctrl+Q
map("n", "<C-q>", "<cmd>q<CR>", opts { desc = "Exit Editor" })
map("i", "<C-q>", "<Esc><cmd>q<CR>", opts { desc = "Exit Editor" })

------------------[ Delete, Copy, Cut, Paste, Redo ]-------------------------------

-- Delete without Copy (yank)
map({ "n", "v" }, "d", '"_d', opts { desc = "Delete without yank" })

-- Delete character without Copy
map("n", "x", '"_x', opts { desc = "Delete character" })

-- Delete word without Copy
map("i", "<C-d>", '<C-o>"_dB', opts { desc = "Delete word before cursor" })
map("i", "<A-d>", '<C-o>"_dE', opts { desc = "Delete word after cursor" })
map("i", "<C-BS>", '<C-o>"_dB', opts { desc = "Delete word before cursor" })
map("i", "<C-S-BS>", '<C-o>"_dE', opts { desc = "Delete word after cursor" })

-- Copy (yank) to system clipboard with Ctrl+C
map("v", "<C-c>", '"+y', opts { desc = "Copy to system clipboard" })
map("n", "<C-c>", '"+yy', opts { desc = "Copy to system clipboard" })
map("i", "<C-c>", '<C-o>"+yy', opts { desc = "Copy to system clipboard" })
map("n", "<A-c>", "<cmd>%y+<cr>", opts { desc = "Copy all to clipboard" })

-- Cut with Ctrl-X
map("n", "<C-x>", "dd", opts { desc = "Cut the lines" })
map("i", "<C-x>", "<C-o>dd", opts { desc = "Cut the lines" })
map("v", "<C-x>", "d", opts { desc = "Cut the lines" })

-- Paste without Copy (yank)
map("x", "p", nvim.ui.vpaste, opts { desc = "Paste without yank" })

-- Paste with Ctrl+V
map("i", "<C-v>", '<C-r><C-o>+', opts { desc = "Paste from system clipboard" })

-- Undo with Alt+z
map("n", "<A-z>", "u", opts { desc = "Undo last operation" })
map("i", "<A-z>", "<C-o>u", opts { desc = "Undo last operation" })

-- Redo with Ctrl+U / Alt+Shift+z
map("n", "U", "<C-r>", opts { desc = "Redo last operation" })
map("n", "<A-S-z>", "<C-r>", opts { desc = "Redo last operation" })
map("i", "<A-S-z>", "<C-o><C-r>", opts { desc = "Redo last operation" })

------------------------[ Terminal ]-------------------------------

-- Ctrl+e to toggle terminal
map({ "n", "i", "t" }, "<A-e>", "<cmd>Term<cr>", opts { desc = "Toggle Terminal" })

-- Ctrl+r to run code in terminal
map({ "n", "i", "t" }, "<A-r>", "<cmd>Run<CR>", opts { desc = "Run code in Terminal" })

-- Explicitly out the focus of the temminal
map("t", "<Esc><Esc>", [[<C-\><C-n>]], opts { desc = "Escape terminal mode" })

------------------------[ Formatter ]-------------------------------

-- Format buffer
map({ "n", "v", "i" }, "<M-f>", nvim.ui.format, opts { desc = "Format buffer / selection" })

-- Toggle formatter on save
map("n", "<A-F>", nvim.toggle.lsp.format_on_save, opts { desc = "Toggle format on save" })

-----------------------------------------------------------------------
map("n", "<localleader><localleader>", function() end)
nvim.load("mappings.whichkey")
