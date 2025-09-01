vim.api.nvim_create_autocmd("FileType", {
  pattern = "scratch",
  callback = function()
    vim.bo.filetype = "markdown"
    vim.b.autoformat = false
  end,
})

return {
  "folke/snacks.nvim",
  opts = {
    words = { enabled = false },
    scroll = { enabled = false },
    animate = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    input = { enabled = true },
    rename = { enabled = true },
    git = { enabled = true },
    scope = { enabled = true },
    notifier = { enabled = true },
    gitbrowse = { enabled = true },
    scratch = {
      ft = "scratch",
      win = { zindex = 50 },
      bo = { autoformat = false },
    },
    styles = {
      scratch = { wo = { number = false, cursorline = false, statuscolumn = " " } },
      terminal = { wo = { winbar = "" } },
      notification = { wo = { winblend = 0 } },
      border = "rounded",
    },
  },
  keys = {
    { "<leader>dpp", nil },
    { "<leader>dph", nil },
    { "<leader>dps", nil },
    { "<leader>S", nil },
    {
      "<leader>n",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "Notification History",
    },
  },
}
