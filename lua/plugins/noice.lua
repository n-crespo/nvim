-- default LazyVim plugin
-- this config just adds borders to lsp hover (K)

return {
  "folke/noice.nvim",
  opts = {
    presets = { lsp_doc_border = true },
    notify = { enabled = false },
    views = {
      mini = { win_options = { winblend = 0 } }, -- transparent lsp progress window
    },
    lsp = {
      hover = { enabled = true, silent = true },
      signature = { enabled = false },
      documentation = {
        opts = {
          win_options = { wrap = true },
          position = { row = 2 },
        },
      },
    },
    routes = {
      {
        filter = {
          event = "lsp",
          kind = "progress",
          cond = function(message)
            local client = vim.tbl_get(message.opts, "progress", "client")
            return client == "ltex_plus"
          end,
        },
      },
    },
  },
  keys = {
    { "<leader>snt", false },
    {
      "<leader>m",
      function()
        require("noice").cmd("all")
      end,
      desc = "Messages",
    },
  },
}
