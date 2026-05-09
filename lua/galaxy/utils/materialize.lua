local function materialize(tbl, seen)
if type(tbl) ~= "table" then
return tbl
end

seen = seen or {}
if seen[tbl] then
return seen[tbl]
end

local out = {}
seen[tbl] = out

-- copy normal keys
for k, v in pairs(tbl) do
out[materialize(k, seen)] = materialize(v, seen)
end

-- kill metatable completely
setmetatable(out, nil)

return out
end

return materialize
