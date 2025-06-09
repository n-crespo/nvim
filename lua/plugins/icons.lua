return {
  {
    "LazyVim/LazyVim",
    opts = {
      icons = {
        kinds = {
          Text = "󰉿 ",
          Variable = "󰫧 ",
        },
      },
    },
  },
  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {
      -- Override default glyph for "file" category (reuse highlight group)
      default = { file = { glyph = "󰈤" } },
      extension = {
        h = { glyph = "", hl = "MiniIconsPurple" },
      },
      filetype = {
        cf = { glyph = "", hl = "MiniIconsBlue" },
        Rmd = { glyph = "", hl = "MiniIconsBlue" },
        rmd = { glyph = "", hl = "MiniIconsBlue" },
        autohotkey = { glyph = "", hl = "MiniIconsGreen" },
        minifiles = { glyph = "", hl = "MiniIconsYellow" },
        objdump = { glyph = "󰈤" },
        c = { glyph = "", hl = "MiniIconsBlue" },
      },
    },
  },
}
