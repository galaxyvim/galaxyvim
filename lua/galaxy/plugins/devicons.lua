local M = {}

M.config = function()
  return {
    "nvim-tree/nvim-web-devicons",
    main = "nvim-web-devicons",
    lazy = true,
    opts = {
      -- your personal icons can go here (to override)
      -- you can specify color or cterm_color instead of specifying both of them
      -- DevIcon will be appended to `name`
      override = {
        py = {
          icon = "",
          color = "#5AA0E6",
          name = "Python",
        },
        js = {
          icon = "",
          color = "#f0ba00",
          name = "JavaScript",
        },
        css = {
          icon = "",
          color = "#BE90FA",
          name = "CSS",
        },
        jsx = {
          icon = "",
          color = "#11Bfff",
          name = "JSX",
        },
        jpg = {
          icon = "",
          color = "#FFB7A5",
          name = "Jpg",
        },
        png = {
          icon = "",
          color = "#7EC8FF",
          name = "Png",
        },
        gif = {
          icon = "",
          color = "#FFF07A",
          name = "Gif",
        },
        svg = {
          icon = "󰋩",
          color = "#D8A8FF",
          name = "Svg",
        },
        webp = {
          icon = "󰋩",
          color = "#8EE3C8",
          name = "Webp",
        },
        tiff = {
          icon = "󰋩",
          color = "#FFF07A",
          name = "Tiff",
        },
        bmp = {
          icon = "󰋩",
          color = "#C9CCD6",
          name = "Bmp",
        },
      },
    },
    config = true,
  }
end

return M
