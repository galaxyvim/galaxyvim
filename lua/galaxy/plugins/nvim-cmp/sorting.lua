local cmp = nvim.require "cmp"

return function(entry1, entry2)
  local k1 = entry1:get_kind()
  local k2 = entry2:get_kind()

  local s1 = entry1.source.name
  local s2 = entry2.source.name

  -- nvim_lsp priority over buffer
  if s1 == "buffer" and s2 == "nvim_lsp" then
    return false
  end
  if s2 == "buffer" and s1 == "nvim_lsp" then
    return true
  end

  -- nvim_lsp priority over dictionary
  if s1 == "dictionary" and s2 == "nvim_lsp" then
    return false
  end
  if s2 == "dictionary" and s1 == "nvim_lsp" then
    return true
  end

  -- luasnip priority over dictionary
  if s1 == "dictionary" and s2 == "luasnip" then
    return false
  end
  if s2 == "dictionary" and s1 == "luasnip" then
    return true
  end

  -- rg priority over dictionary
  if s1 == "dictionary" and s2 == "rg" then
    return false
  end
  if s2 == "dictionary" and s1 == "rg" then
    return true
  end

  -- nvim_lsp priority over text
  if s1 == "nvim_lsp" and k1 == cmp.lsp.CompletionItemKind.Text then
    return false
  end
  if s2 == "nvim_lsp" and k2 == cmp.lsp.CompletionItemKind.Text then
    return true
  end

end
