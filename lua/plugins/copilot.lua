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
      "<leader>aa",
      function()
        print("hi")
        local clients = package.loaded["copilot"] and LazyVim.lsp.get_clients({ name = "copilot", bufnr = 0 }) or {}
        if #clients > 0 then
          vim.notify("Disabling Copilot", vim.log.levels.WARN)
        else
          vim.notify("Enabling Copilot", vim.log.levels.INFO)
        end
        return "<cmd>Copilot toggle<CR>"
      end,
      expr = true,
      silent = true,
      desc = "Toggle AI Completion",
    },
  },
}
