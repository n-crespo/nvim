vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
  callback = function()
    if vim.bo.filetype == "dap-float" then
      vim.keymap.set("n", "q", "<cmd>q<cr>", { buffer = true })
    end
  end,
})

return {}
