local wk = require "which-key"
local key = "<leader>g"

wk.map = {
  key,
  group = "Git",
  icon = wk.icon { nvim.icons.git.Logo, hl = "DevIconGitLogo" },

  {
    key .. "l",
    "<cmd>LazyGit<cr>",
    desc = "LazyGit",
    cond = nvim.plugins.toggleterm.enabled,
  },

  {
    key .. "n",
    desc = "NeoGit",
    cond = nvim.plugins.neogit.enabled,

    { key .. "ns", "<cmd>Neogit<cr>", desc = "Status" },
    { key .. "nc", "<cmd>Neogit commit<cr>", desc = "Commit" },
    { key .. "nd", "<cmd>Neogit kind=split<cr>", desc = "Diff" },
    { key .. "np", "<cmd>Neogit push<cr>", desc = "Push" },
    { key .. "nP", "<cmd>Neogit pull<cr>", desc = "Pull" },
    { key .. "nl", "<cmd>Neogit log<cr>", desc = "Logs" },
  },

  {
    key .. "d",
    group = "GitDiff",
    cond = nvim.plugins.diffview.enabled,
    { key .. "do", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
    { key .. "dc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
    { key .. "dr", "<cmd>DiffviewRefresh<cr>", desc = "Refresh Diffview" },
    { key .. "df", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
    { key .. "dF", "<cmd>DiffviewFocusFiles<cr>", desc = "Diffview Focus Files" },
    { key .. "dd", "<cmd>DiffviewToggleFiles<cr>", desc = "File Panel" },
    { key .. "dl", "<cmd>DiffviewLog<cr>", desc = "Diffview Log" },
  },

  {
    key .. "s",
    group = "GitSigns",
    cond = nvim.plugins.gitsigns.enabled,
    {
      key .. "sd",
      function()
        vim.cmd.Gitsigns "toggle_linehl"
        vim.cmd.Gitsigns "toggle_deleted"
      end,
      desc = "Git Diff Preview",
    },
    {
      key .. "sD",
      "<cmd>Gitsigns diffthis HEAD<cr>",
      desc = "Git Diff Buffer",
    },
    {
      key .. "sh",
      "<cmd>Gitsigns preview_hunk_inline<cr>",
      desc = "Preview Hunk",
    },
    {
      key .. "sj",
      "<cmd>lua require('gitsigns').nav_hunk('next', {navigation_message = false})<cr>",
      desc = "Next Hunk",
    },
    {
      key .. "sk",
      "<cmd>lua require('gitsigns').nav_hunk('prev', {navigation_message = false})<cr>",
      desc = "Prev Hunk",
    },
    {
      key .. "sl",
      "<cmd>Gitsigns blame_line<cr>",
      desc = "Blame",
    },
    {
      key .. "sL",
      "<cmd>lua require('gitsigns').blame_line({full=true})<cr>",
      desc = "Blame Line",
    },
    {
      key .. "sn",
      "<cmd>Gitsigns toggle_numhl<cr>",
      desc = "Highlight NumLine",
    },
    {
      key .. "sp",
      "<cmd>Gitsigns preview_hunk<cr>",
      desc = "Preview Hunk Float",
    },
    {
      key .. "sq",
      "<cmd>Gitsigns setqflist<cr>",
      desc = "QfList Buffer",
    },
    {
      key .. "sQ",
      "<cmd>lua require('gitsigns').setqflist('all')<cr>",
      desc = "QfList All",
    },
    {
      key .. "sr",
      "<cmd>Gitsigns reset_hunk<cr>",
      desc = "Reset Hunk",
    },
    {
      key .. "sR",
      "<cmd>Gitsigns reset_buffer<cr>",
      desc = "Reset Buffer",
    },
    {
      key .. "sS",
      "<cmd>Gitsigns stage_buffer<cr>",
      desc = "Stage Buffer",
    },
    {
      key .. "ss",
      "<cmd>Gitsigns stage_hunk<cr>",
      desc = "Stage Hunk",
    },
    {
      key .. "su",
      "<cmd>Gitsigns undo_stage_hunk<cr>",
      desc = "Undo Stage Hunk",
    },
  },
}
