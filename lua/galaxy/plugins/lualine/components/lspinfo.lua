-- File: lua/coc_count.lua

local function nvim_lsp()
  local clients = vim.lsp.get_clients { bufnr = 0 }
  if #clients == 0 then
    return ""
  end

  local names = {}
  for _, client in ipairs(clients) do
    table.insert(names, client.name)
  end

  local count = #names
  local list = table.concat(names, "|")

  return count, list
end

local function coc_lsp()
  -- Check if coc is ready
  if vim.fn["coc#rpc#ready"]() ~= 1 then
    return ""
  end

  -- Get services
  local services = vim.fn.CocAction "services"

  local names = {}
  for _, service in ipairs(services) do
    if service.state == "running" then
      table.insert(names, service.name)
    end
  end

  local count = #names
  local list = table.concat(names, "|")

  return #count, list
end

return {
  function()
    local case = nvim.opt.style.lualine.component.lsp
    local count, names, show
    if nvim.opt.provider.lsp == "nvim" then
      count, names = nvim_lsp()
    elseif nvim.opt.provider.lsp == "coc" then
      count, names = coc_lsp()
    end

    if case == "count" then
      show = count
    elseif case == "name" then
      show = names
    end

    return count > 0 and "󰆧 " .. nvim.hl.format("lualine_c_normal", show) or ""
  end,

  color = function()
    return {
      fg = nvim.hl.lualine_a_visual.bg,
      gui = "bold",
    }
  end,

  on_click = function()
    if nvim.opt.provider.lsp == "nvim" then
      vim.cmd.checkhealth "vim.lsp"
    end
  end,
}
