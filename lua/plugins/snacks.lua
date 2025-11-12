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
      ft = "md", -- so markdown formatter doesn't kick in and error out
    },
    styles = {
      scratch = { wo = { number = false, cursorline = false, statuscolumn = " ", wrap = true } },
      terminal = { wo = { winbar = "" } },
      notification = { wo = { winblend = 0 } },
      border = "rounded",
    },
    lazygit = {
      enabled = true,
      configure = not vim.g.is_win,
    },
  },
  keys = {
    { "<leader>dpp", nil },
    { "<leader>dph", nil },
    { "<leader>dps", nil },
    { "<leader>S", nil },
    { "<leader>n", nil },
    {
      "<leader>un",
      function()
        Snacks.notifier.hide()
      end,
      desc = "Dismiss All Notifications",
    },
  },
}
