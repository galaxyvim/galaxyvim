local ok_lspkind, lspkind = pcall(nvim.require, "lspkind")
local ok_tailwind, tailwind = pcall(nvim.require, "tailwindcss-colorizer-cmp")

local format = ok_lspkind
  and lspkind.cmp_format {
    maxwidth = {
      -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      -- can also be a function to dynamically calculate max width such as
      -- menu = function() return math.floor(0.45 * vim.o.columns) end,
      menu = function()
        return math.floor(vim.o.columns * 0.20)
      end, -- leading text (labelDetails)
      abbr = function()
        return math.floor(vim.o.columns * 0.30)
      end, -- actual suggestion item
    },

    ellipsis_char = "…", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
    show_labelDetails = true, -- show labelDetails in menu. Disabled by default

    before = function(entry, item)
      if ok_tailwind then
        tailwind.formatter(entry, item)
      end

      local custom_sources = {
        nvim_lsp = "[LSP]",
        emoji = "[Emoji]",
        path = "(Path)",
        calc = "[Calc]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
      }

      local kind = {
        Text = "Text",
        Method = "Mthd",
        Function = "Func",
        Constructor = "Cnstr",
        Dictionary = "Dict",
        Field = "Field",
        Variable = "Var",
        Class = "Cls",
        Interface = "Inrfc",
        Module = "Mod",
        Property = "Prop",
        Unit = "Unit",
        Value = "Val",
        Enum = "Enum",
        Keyword = "Key",
        Snippet = "Snip",
        Color = "Color",
        File = "File",
        Reference = "Ref",
        Folder = "Dir",
        EnumMember = "EnmM",
        Constant = "Const",
        Struct = "Strct",
        Event = "Evnt",
        Operator = "Oprtr",
        TypeParameter = "Type",
      }

      local hl = {
        rg = "CmpItemKind",
        emoji = "CmpItemKindSnippet",
        dictionary = "CmpItemKindKeyword",
      }

      local source = {
        rg = "Grep",
        calc = "Calc",
        dotenv = "ENV",
        emoji = "Emoji",
        nerdfont = "Glyph",
        dictionary = "Dict",
      }

      local icon = {
        calc = "󰃬 ",
        emoji = "󰱨",
        nerdfont = "",
        dictionary = "󰘝",
      }

      setmetatable(kind, {
        __index = function(_, key)
          return key
        end,
      })

      local src = entry.source.name

      if src then -- check condition if src is available
        nvim.print(item.kind, src)

        if source[src] then
          item.kind = source[src]
          item.icon = icon[src] or item.icon
          item.icon_hl_group = hl[src]
          item.kind_hl_group = hl[src]
        else
          if src == "nvim_lsp" then
            local kind_hl = item.kind_hl_group
            if kind_hl and kind_hl:find("documentColor", 1, true) then
              item.kind = "Color"
            end
          end
          item.kind = kind[item.kind]
        end
        item.menu = custom_sources[src]
      end

      item.dup = ({
        dictionary = 1,
        nvim_lsp = 0,
        nvim_lua = 0,
        luasnip = 1,
        buffer = 0,
        path = 0,
        rg = 1,
      })[entry.source.name] or 0

      return item -- return item that contains fields.
    end,
  }

return {
  fields = {
    "icon",
    "abbr", -- title (eg, printf, for, if)
    "kind", -- type (eg. function, classs, const)
    -- "menu", -- (eg. [LSP], [Snippet], [Emoji])
  },

  format = format,
}
