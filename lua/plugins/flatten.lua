-- until this issue: https://github.com/jesseduffield/lazygit/issues/3467 is
-- resolved, this is needed on windows edit files from within lazygit in the
-- current neovim process since the nvim-remote preset doesn't fully work
return {
  "willothy/flatten.nvim",
  enabled = vim.g.full_config or vim.g.is_win,
  lazy = false,
  config = true,
  opts = {
    window = { open = "tab" },
    hooks = {
      pre_open = function()
        -- if file was opened from a terminal, close that terminal
        if vim.bo.buftype == "terminal" then
          vim.api.nvim_win_close(0, false)
        end
      end,
    },
  },
}
