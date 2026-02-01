return {
  -- this doesn't work in windows terminal but sixel does (used in yazi)
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    image = {
      enabled = vim.fn.has("wsl") == 0,
      math = {
        enabled = true,
        latex = {
          font_size = "large",
        },
      },
    },
  },
}
