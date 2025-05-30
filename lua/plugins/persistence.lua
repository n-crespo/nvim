return {
  {
    "folke/persistence.nvim",
    enabled = not LazyVim.is_win(),
    opts = {
      pre_save = function()
        vim.api.nvim_exec_autocmds("User", { pattern = "SessionSavePre" })
      end,
    },
    keys = {
      { "<leader>qs", false },
      { "<leader>ql", false },
      { "<leader>qd", false },
      { "<leader>qS", false },
    },
  },
  -- i just do this manually with an alias to
  --
  -- nvim -c "lua require('persistence').load()"
  --
  -- load the last saved session when neovim is opened with no args
  -- https://github.com/LazyVim/LazyVim/discussions/5462
  -- {
  --   "folke/persistence.nvim",
  --   lazy = false, -- make persistence start on startup
  --   opts = function()
  --     -- Auto restore session (in main config)
  --     if vim.g.full_config then
  --       vim.api.nvim_create_autocmd("VimEnter", {
  --         nested = true,
  --         callback = function()
  --           local persistence = require("persistence")
  --           if vim.fn.argc() == 0 and not require("custom.utils").is_man_pager() and not vim.g.started_with_stdin then
  --             persistence.load()
  --             -- else
  --             -- persistence.stop()
  --             -- you can use above to discard sessions when neovim is opened with args
  --           end
  --         end,
  --       })
  --     end
  --   end,
  -- },
}
