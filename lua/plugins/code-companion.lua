vim.cmd([[cab cc CodeCompanion]]) -- works in visual mode too!

-- -- Custom Lualine component function
-- local function codecompanion_modifiable_status()
--   local current_bufnr = vim.api.nvim_get_current_buf()
--   if not vim.api.nvim_get_option_value("modifiable", { buf = current_bufnr }) then
--     return "✨ Working on an answer..."
--   else
--     return "📝 Ask me anything!" -- Or perhaps '✏️' to indicate editable
--   end
-- end

return {
  {
    "olimorris/codecompanion.nvim",
    enabled = true,
    dependencies = { "saghen/blink.cmp" },
    cmd = "CodeCompanion", -- allow the abbreviation :cc to load the plugin
    config = true,
    opts = {
      -- this defaults to 4o
      strategies = {
        chat = {
          adapter = "githubmodels",
          slash_commands = {
            ["buffer"] = {
              keymaps = {
                modes = {
                  i = "<C-b>",
                  n = { "<C-b>", "gb" },
                },
              },
            },
          },
        },
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
