return {
  {
    "LazyVim/LazyVim",
    opts = {
      icons = {
        kinds = {
          Text = "󰉿 ",
          Variable = " ",
        },
      },
    },
  },
  {
    "nvim-mini/mini.icons",
    lazy = true,
    opts = {
      extension = {
        h = { glyph = "", hl = "MiniIconsPurple" },
        pvs = { glyph = "", hl = "PVSBlue" },
        prf = { glyph = "󱇚", hl = "MiniIconsGrey" },
        prl = { glyph = "󱇚", hl = "MiniIconsGrey" },
      },
      filetype = {
        cf = { glyph = "", hl = "MiniIconsBlue" },
        Rmd = { glyph = "", hl = "MiniIconsBlue" },
        rmd = { glyph = "", hl = "MiniIconsBlue" },
        autohotkey = { glyph = "", hl = "MiniIconsGreen" },
        minifiles = { glyph = "", hl = "MiniIconsYellow" },
        objdump = { glyph = "󰘨" },
        c = { glyph = "", hl = "MiniIconsBlue" },
      },
    },
  },
}
