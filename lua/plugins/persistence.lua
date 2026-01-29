return {
  "folke/persistence.nvim",
  event = "VeryLazy",
  opts = function()
    local group = vim.api.nvim_create_augroup("titlestring", { clear = false })
    -- properly set titlestring when persistence is loaded
    vim.api.nvim_create_autocmd("User", {
      group = group,
      pattern = "PersistenceLoadPost",
      callback = function()
        require("custom.utils").set_titlestring()
      end,
    })
    return {}
  end,
  keys = {
    { "<leader>qs", nil },
    { "<leader>ql", nil },
    { "<leader>qd", nil },
    { "<leader>qS", nil },
  },
}
