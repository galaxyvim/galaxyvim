local M = {}

M.config = function()
  return {
    "ankushbhagats/liveserver.nvim",
    -- dir = "~/liveserver.nvim/",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "LiveServerStart", "LiveServerStop", "LiveServerSelect", "LiveServerToggle" },
    build = "npm i",
    module = false,
    opts = {
      -- filetypes = "*",
      colortype = "hex", -- hex | hl
      args = {
        port = 8080,
        ["no-browser"] = true,
      },
    },
  }
end

return M
