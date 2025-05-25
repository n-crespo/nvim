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
      filetype = {
        cf = { glyph = "", hl = "MiniIconsBlue" },
        Rmd = { glyph = "", hl = "MiniIconsBlue" },
        rmd = { glyph = "", hl = "MiniIconsBlue" },
        autohotkey = { glyph = "", hl = "MiniIconsGreen" },
        minifiles = { glyph = "", hl = "MiniIconsYellow" },
      },
      extension = {
        c = { glyph = "", hl = "MiniIconsBlue" },
        h = { glyph = "", hl = "MiniIconsPurple" },
        od = { glyph = "󰈤" },
      },
    },
    config = function(_, opts)
      require("mini.icons").setup(opts)

      -- generate custom highlights that are used in tabline (see lualine.lua)
      local highlights = {
        "MiniIconsAzure",
        "MiniIconsBlue",
        "MiniIconsCyan",
        "MiniIconsGreen",
        "MiniIconsGrey",
        "MiniIconsOrange",
        "MiniIconsPurple",
        "MiniIconsRed",
        "MiniIconsYellow",
      }

      local hl_get = function(name)
        return vim.api.nvim_get_hl(0, { name = name, link = false })
      end

      local tabs_active = hl_get("TabLineSel")
      local tabs_inactive = hl_get("TabLineFill")

      for _, hl in ipairs(highlights) do
        local icon = hl_get(hl)
        vim.api.nvim_set_hl(0, hl .. "_lualine_a_tabs_active", { fg = icon.fg, bg = tabs_active.bg })
        vim.api.nvim_set_hl(0, hl .. "_lualine_a_tabs_inactive", { fg = icon.fg, bg = tabs_inactive.bg })
      end
    end,
  },
}
