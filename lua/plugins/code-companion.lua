vim.cmd([[cab cc CodeCompanion]]) -- works in visual mode too!
-- vim.cmd([[cab cmd CodeCompanionCmd]])

-- https://github.com/olimorris/codecompanion.nvim/discussions/813#discussioncomment-13081665
local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
local group = vim.api.nvim_create_augroup("CodeCompanionFidgetHooks", { clear = true })
vim.api.nvim_create_autocmd({ "User" }, {
  pattern = "CodeCompanion*",
  group = group,
  callback = function(request)
    if
      request.match == "CodeCompanionChatSubmitted"
      or request.match == "CodeCompanionContextChanged"
      or request.match == "CodeCompanionChatCreated"
      or request.match == "CodeCompanionChatOpened"
      or request.match == "CodeCompanionChatModel"
      or request.match == "CodeCompanionChatAdapter"
      or request.match == "CodeCompanionChatClosed"
      or request.match == "CodeCompanionChatHidden"
    then
      return
    end
    local msg
    msg = "[CodeCompanion] " .. request.match:gsub("CodeCompanion", "")
    vim.notify(msg, "info", {
      timeout = 1000,
      keep = function()
        return not vim
          .iter({ "Finished", "Opened", "Hidden", "Closed", "Cleared", "Created" })
          :fold(false, function(acc, cond)
            return acc or vim.endswith(request.match, cond)
          end)
      end,
      id = "code_companion_status",
      title = "Code Companion Status",
      opts = function(notif)
        notif.icon = ""
        if vim.endswith(request.match, "Started") then
          ---@diagnostic disable-next-line: undefined-field
          notif.icon = spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
        elseif vim.endswith(request.match, "Finished") then
          notif.icon = " "
        end
      end,
    })
  end,
})

return {
  "olimorris/codecompanion.nvim",
  -- enabled = false,
  dependencies = { "saghen/blink.cmp" },
  cmd = "CodeCompanion", -- allow the abbreviation :cc to load the plugin
  config = true,
  init = function()
    vim.api.nvim_create_autocmd({ "User" }, {
      pattern = "CodeCompanionInlineFinished",
      group = group,
      callback = function(request)
        vim.lsp.buf.format({ bufnr = request.buf })
      end,
    })
  end,
  opts = {
    display = {
      chat = {
        intro_message = "  What can I help with? (Press ? for options)",
        show_references = true,
        show_header_separator = false,
        show_settings = true,
        window = {
          width = 0.4,
          opts = {
            relativenumber = false,
            number = false,
            statuscolumn = "  ",
          },
        },
      },
    },

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
  },
  keys = {
    {
      "<leader>k",
      "<cmd>CodeCompanion<cr>",
      desc = "Prompt AI",
      mode = { "n", "x" },
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
      desc = "Add to New AI Chat",
      mode = "v",
    },
    {
      "<C-l>",
      function()
        ---@diagnostic disable-next-line: missing-parameter
        require("codecompanion").add()
      end,
      mode = "v",
      desc = "Add to Existing AI Chat",
    },
  },
}
