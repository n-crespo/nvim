local spinner
vim.cmd([[cab cc CodeCompanion]]) -- works in visual mode too!
vim.cmd([[cab cmd CodeCompanionCmd]]) -- works in visual mode too!

return {
  {
    "olimorris/codecompanion.nvim",
    enabled = true,
    dependencies = { "saghen/blink.cmp" },
    cmd = "CodeCompanion", -- allow the abbreviation :cc to load the plugin
    config = true,
    opts = {
      strategies = {
        chat = {
          adapter = "copilot",
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
          keymaps = {
            send = {
              callback = function(chat)
                if not spinner then
                  spinner = require("custom.spinner")
                end
                spinner:init()

                vim.cmd("stopinsert")
                chat:submit()
                chat:add_buf_message({ role = "llm", content = "" })
              end,
              index = 1,
              description = "Send",
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
        "<leader>ae",
        "<cmd>CodeCompanion<CR>",
        mode = "v",
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
  },
}
