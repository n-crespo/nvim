return {
  "folke/snacks.nvim",
  opts = {
    styles = {
      quiet = {
        enter = true,
        fixbuf = false,
        minimal = false,
        width = 120,
        height = 0,
        backdrop = { transparent = true, blend = 40 },
        keys = { q = false },
        zindex = 40,
        wo = {
          winhighlight = "NormalFloat:Normal",
          statuscolumn = "",
          number = false,
          cul = false,
        },
        w = {
          snacks_main = true,
        },
      },
    },
    zen = {
      enabled = true,
      backdrop = { transparent = true, blend = 0 },
      toggles = {
        dim = false,
      },
      zoom = { win = { style = "zen" } },
      win = { style = "quiet" },
    },
  },
  keys = {
    {
      "<leader>Z",
      function()
        Snacks.zen()
      end,
      desc = "Toggle Zen Mode",
    },
    {
      "<leader>z",
      function()
        Snacks.zen.zoom()
      end,
      desc = "Toggle Zoom",
    },
  },
}
