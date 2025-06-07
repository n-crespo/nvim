return {
  "zbirenbaum/copilot.lua",
  opts = {
    server_opts_overrides = {
      settings = {
        telemetry = {
          telemetryLevel = "off",
        },
      },
    },
  },
  keys = {
    {
      "<C-n>",
      function()
        if package.loaded["copilot.suggestion"] then
          require("blink.cmp").cancel()
          require("copilot.suggestion").next()
        end
      end,
      mode = "i",
    },
    {
      "<C-p>",
      function()
        if package.loaded["copilot.suggestion"] then
          require("blink.cmp").cancel()
          require("copilot.suggestion").prev()
        end
      end,
      mode = "i",
    },
    {
      "<leader>aa",
      function()
        local clients = package.loaded["copilot"] and LazyVim.lsp.get_clients({ name = "copilot", bufnr = 0 }) or {}
        if #clients > 0 then
          vim.notify("Disabling Copilot", vim.log.levels.WARN)
          require("copilot.command").disable()
        else
          vim.notify("Enabling Copilot", vim.log.levels.INFO)
          require("copilot.command").enable()
        end
      end,
      expr = true,
      silent = true,
      desc = "Toggle AI Completion",
    },
  },
}
