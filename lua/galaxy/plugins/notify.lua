local M = {}

M.config = function()
  return {
    "rcarriga/nvim-notify",
    lazy = true,
    opts = {
      -- on_open = function(win, record)
      --   vim.api.nvim_win_set_config(win, { title = record.title[1], title_pos = "center" })
      -- end,

      timeout = 3,
      stages = "fade_in_slide_out", -- can also be "fade", "slide", "static"
      background_colour = "Normal",
      minimum_width = 50,
      max_height = math.floor(vim.o.lines / 2),
      -- top_down = false, -- false means bottom notifications stack upwards
      render = function(bufnr, notif, highlights)
        local base = nvim.require "notify.render.base"
        local namespace = base.namespace()
        local icon = notif.icon
        local title = notif.title[1]

        if type(title) == "string" and notif.duplicates then
          title = string.format("%s x%d", title, #notif.duplicates)
        end

        local prefix
        if type(title) == "string" and #title > 0 then
          prefix = string.format("%s %s:", icon, title)
        else
          prefix = icon
        end
        local message = {
          string.format(" %s %s", prefix, notif.message[1]),
          unpack(notif.message, 2),
        }

        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, message)

        vim.api.nvim_buf_set_extmark(bufnr, namespace, 0, 0, {
          virt_text = { { " " .. icon .. " ", highlights.icon } },
          virt_text_win_col = 0,
          priority = 50,
        })
        vim.api.nvim_buf_set_extmark(bufnr, namespace, 0, 0, {
          virt_text = { { title .. ": ", highlights.title } },
          virt_text_win_col = 3,
          priority = 50,
        })

        local prefix_length = string.len(prefix)
        vim.api.nvim_buf_set_extmark(bufnr, namespace, 0, prefix_length + 1, {
          hl_group = highlights.body,
          end_line = #message,
          priority = 50,
        })
      end,
    },
    config = true,
  }
end

return M
