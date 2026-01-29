return {
  "folke/todo-comments.nvim",
  event = function()
    return {}
  end,
  vscode = true,
  opts = {
    highlight = {
      comments_only = false,
      multiline = true,
    },
    keywords = {
      TODO = {
        color = "#8A9A7B",
      },
    },
  },
  keys = {
    {
      "<leader>st",
      function()
        ---@diagnostic disable-next-line: undefined-field
        Snacks.picker.todo_comments({
          cwd = require("custom.utils").get_dir_with_fallback(),
        })
      end,
      desc = "Todo",
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
