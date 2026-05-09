local M = {}

M.dependencies = {
  notify = "notify",
}

M.load_extensions = function(load)
  for extension, cond in pairs(M.dependencies) do
    if cond then
      load(extension)
    end
  end
end

return M
