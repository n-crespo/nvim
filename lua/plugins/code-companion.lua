vim.cmd([[cab cc CodeCompanion]]) -- works in visual mode too!
return {
  "olimorris/codecompanion.nvim",
  cmd = "CodeCompanion", -- allow the abbreviation :cc to load the plugin
  config = true,
  opts = {
    -- this defaults to 4o
    strategies = {
      chat = { adapter = "githubmodels" },
      inline = { adapter = "githubmodels" },
      cmd = { adapter = "githubmodels" },
    },
    display = {
      chat = {
        window = {
          opts = {
            number = false,
            statuscolumn = "  ",
          },
        },
      },
    },
  },
  keys = {
    {
      "<leader>a",
      desc = "+ai",
      mode = { "n", "v" },
    },
    {
      "<leader>ac",
      function()
        require("codecompanion").chat()
      end,
      desc = "AI Chat",
      mode = "n",
    },
    {
      "<leader>ac",
      function()
        require("codecompanion").chat()
        vim.cmd([[normal! o]])
        vim.cmd([[normal! o]])
      end,
      desc = "AI Chat (with selection)",
      mode = "v",
    },
    {
      "<leader>aa",
      function()
        ---@diagnostic disable-next-line: missing-parameter
        require("codecompanion").actions()
      end,
      desc = "AI Actions",
      mode = { "n", "v" },
    },
    {
      "ga",
      function()
        ---@diagnostic disable-next-line: missing-parameter
        require("codecompanion").add()
      end,
      mode = "v",
      desc = "Add to AI Chat",
    },
    {
      "<C-l>",
      function()
        ---@diagnostic disable-next-line: missing-parameter
        require("codecompanion").add()
      end,
      mode = "v",
      desc = "Add to AI Chat",
    },
  },
}
