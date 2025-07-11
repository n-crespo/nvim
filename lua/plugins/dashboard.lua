return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      width = 45,
      preset = {
        keys = {
          { icon = " ", key = "e", desc = "Explore", action = "<leader>e" },
          { icon = " ", key = "o", desc = "Old Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = " ", key = "F", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        header = vim.g.full_config and "[full]" or "[lite]",
      },
      sections = {
        { section = "header", padding = 3 },
        { section = "keys", gap = 0, padding = 0 },
        -- { pane = 2, section = "projects", height = 5 },
        -- { section = "startup" },
      },
    },
  },
}
