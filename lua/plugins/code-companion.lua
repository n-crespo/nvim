local spinner
vim.cmd([[cab cc CodeCompanion]]) -- works in visual mode too!
vim.cmd([[cab cmd CodeCompanionCmd]])

return {
  "olimorris/codecompanion.nvim",
  -- enabled = false,
  dependencies = { "saghen/blink.cmp" },
  cmd = "CodeCompanion", -- allow the abbreviation :cc to load the plugin
  config = true,
  opts = {
    strategies = {
      chat = {
        adapter = "copilot",
        tools = {
          opts = {
            auto_submit_errors = true,
            auto_submit_success = true,
          },
        },
        slash_commands = {
          ["buffer"] = {
            keymaps = {
              modes = {
                i = "<C-b>",
                n = { "<C-b>" },
              },
            },
          },
          ["file"] = {
            keymaps = {
              modes = {
                i = "<C-f>",
                n = { "<C-f>" },
              },
            },
          },
        },
      },
      inline = { adapter = "copilot" },
      cmd = { adapter = "copilot" },
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
      "<leader>k",
      "<cmd>CodeCompanion<cr>",
      desc = "Prompt Code Companion",
      mode = { "n", "x" },
    },
    {
      "<leader>ac",
      function()
        require("codecompanion").chat()
      end,
      desc = "CodeCompanion Chat",
      mode = "n",
    },
    {
      "<leader>ac",
      function()
        require("codecompanion").chat()
        vim.cmd([[normal! o]])
        vim.cmd([[normal! o]])
      end,
      desc = "Add to CodeCompanion Chat",
      mode = "v",
    },
    {
      "<C-l>",
      function()
        ---@diagnostic disable-next-line: missing-parameter
        require("codecompanion").add()
      end,
      mode = "v",
      desc = "Add to CodeCompanion Chat",
    },
  },
}
