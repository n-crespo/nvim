return {
  "folke/todo-comments.nvim",
  vscode = true,
  opts = {
    highlight = {
      comments_only = false,
      multiline = true,
    },
    keywords = {
      TODO = {
        color = "#76946a", -- c_autumnGreen
      },
    },
  },
  keys = {
    {
      "<leader>st",
      function()
        Snacks.picker.todo_comments({
          cwd = require("custom.utils").get_dir_with_fallback(),
        })
      end,
    },
    {
      "<leader>sT",
      function()
        Snacks.picker.todo_comments({
          keywords = { "TODO", "FIX", "FIXME" },
          cwd = require("custom.utils").get_dir_with_fallback(),
        })
      end,
      desc = "Todo/Fix/Fixme",
    },
  },
}
