-- define more keymaps
return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    enabled = false,
    optional = true,
    opts = {
      mappings = {
        complete = {
          insert = "<Tab>",
        },
      },
    },
    keys = {
      { "<leader>aq", false },
      { "<leader>aa", false },
      {
        "<leader>ac",
        function()
          require("CopilotChat").toggle()
        end,
        desc = "Chat (Toggle)",
        mode = { "n", "v" },
      },
      {
        "<leader>k",
        function()
          vim.ui.input({ prompt = "Quick Chat: " }, function(input)
            if input and input ~= "" then
              require("CopilotChat").ask(input)
            end
          end)
        end,
        desc = "Ask AI",
        mode = { "n", "v" },
      },
      {
        "<TAB>",
        "<C-CR>",
        remap = false,
        mode = "i",
        ft = "copilot-chat",
      },
    },
  },
  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      sources = {
        providers = {
          path = {
            -- Path sources triggered by "/" interfere with CopilotChat commands
            enabled = function()
              return vim.bo.filetype ~= "copilot-chat"
            end,
          },
        },
      },
    },
  },
}
