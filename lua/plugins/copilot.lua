return {
  "zbirenbaum/copilot.lua",
  enabled = false,
  optional = true,
  opts = {
    suggestion = { enabled = false, autotrigger = false },
    server_opts_overrides = {
      setrings = {
        telemetry = {
          telemetryLevel = "off",
        },
      },
    },
  },
  keys = {
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
