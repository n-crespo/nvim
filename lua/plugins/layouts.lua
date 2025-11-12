return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      layout = {
        cycle = true,
        preset = function()
          if vim.o.lines <= 23 and vim.o.columns <= 22 then
            return "small"
          elseif vim.o.columns <= 116 then
            return "vertical"
          else
            return "default"
          end
        end,
      },
      layouts = {
        vscode = {
          layout = {
            preview = false,
            backdrop = false,
            row = 2,
            width = 64,
            min_width = 64,
            height = 0.45,
            border = "none",
            box = "vertical",
            { win = "input", height = 1, border = "rounded", title = "{title} {live} {flags}", title_pos = "center" },
            { win = "list", border = "rounded" },
            { win = "preview", title = "{preview}", border = "rounded" },
          },
        },
        -- this is just vertical but without a preview
        small = {
          layout = {
            box = "horizontal",
            width = 0.8,
            min_width = 60,
            height = 0.8,
            {
              box = "vertical",
              border = "rounded",
              title = "{title} {live} {flags}",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
            },
          },
        },
        vertical = {
          layout = {
            box = "vertical",
            width = 0.8,
            min_width = 40,
            height = 0.8,
            min_height = 20,
            {
              box = "vertical",
              border = "rounded",
              title = "{title} {live} {flags}",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
            },
            { win = "preview", title = "{preview}", height = 0.45, border = "rounded" },
          },
        },
        default = {
          layout = {
            box = "horizontal",
            width = 0.85,
            min_width = 80,
            height = 0.8,
            {
              box = "vertical",
              border = "rounded",
              title = "{title} {live} {flags}",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
            },
            { win = "preview", title = "{preview}", border = "rounded", width = 0.5 },
          },
        },
      },
    },
  },
}
