-- default LazyVim plugin
-- this config just adds borders to lsp hover (K)

return {
  "folke/noice.nvim",
  lazy = false, -- required to avoid weird terminal resizing
  opts = {
    presets = { lsp_doc_border = true },
    cmdline = { view = "cmdline" },
    notify = { enabled = false },
    views = {
      mini = { win_options = { winblend = 0 } }, -- transparent lsp progress window
    },
    lsp = {
      progress = {
        format = {
          "({data.progress.percentage}%) ",
          { "{spinner} ", hl_group = "NoiceLspProgressSpinner" },
          { "{data.progress.title} ", hl_group = "NoiceLspProgressTitle" },
          { "{data.progress.client} ", hl_group = "NoiceLspProgressClient" },
        },
        format_done = {
          { "✔  ", hl_group = "NoiceLspProgressSpinner" },
          { "{data.progress.title} ", hl_group = "NoiceLspProgressTitle" },
          { "{data.progress.client} ", hl_group = "NoiceLspProgressClient" },
        },
      },
      hover = { enabled = true, silent = true },
      signature = { enabled = false },
      documentation = {
        opts = {
          win_options = { wrap = true },
          position = { row = 2 },
        },
      },
    },
  },
  config = function(_, opts)
    local noice = require("noice")
    noice.setup(opts)

    -- HACK: prevents Noice from sending "cleanup" signals on exit that resize
    -- terminal (related to windows terminal bug)
    local original_disable = noice.disable
    ---@diagnostic disable-next-line: duplicate-set-field
    noice.disable = function()
      if vim.v.exiting ~= vim.NIL then
        return
      end
      original_disable()
    end
  end,
  keys = {
    { "<leader>snt", nil },
    { "<leader>sna", nil },
    { "<leader>snh", nil },
    { "<leader>snl", nil },
    { "<leader>sn", nil },
    { "<leader>snd", nil },
    {
      "<leader>n",
      function()
        require("noice").cmd("all")
      end,
      desc = "Noice/Messages",
    },
  },
}
