-- define more keymaps
return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
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
