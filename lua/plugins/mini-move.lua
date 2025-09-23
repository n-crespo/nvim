return {
  "nvim-mini/mini.move",
  event = function()
    return "LazyFile"
  end,
  vscode = true,
  opts = {
    mappings = {
      left = "<M-[>",
      right = "<M-]>",
      down = "<C-N>",
      up = "<C-P>",
      line_left = "<M-[>",
      line_right = "<M-]>",
      line_down = "<C-N>",
      line_up = "<C-P>",
    },
    options = {
      reindent_linewise = false,
    },
  },
  keys = {
    {
      "<M-]>",
      function()
        require("mini.move").move_line("right")
      end,
      mode = "i",
      desc = "Indent line",
    },
    {
      "<M-[>",
      function()
        require("mini.move").move_line("left")
      end,
      mode = "i",
      desc = "Un-indent line",
    },
  },
}
