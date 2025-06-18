return {
  "ckolkey/ts-node-action",
  event = "LazyFile",
  keys = {
    {
      "m",
      function()
        local save_cursor = vim.fn.getpos(".")
        pcall(function()
          require("ts-node-action").node_action()
        end)
        vim.fn.setpos(".", save_cursor)
      end,
      { desc = "Node Action" },
    },
  },
}
