vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPre" }, {
  pattern = { "*.pvs", "pvs-strategies", "*.md" },
  group = vim.api.nvim_create_augroup("keymaerax_ftdetect", { clear = true }),
  once = true,
  callback = function()
    vim.filetype.add({
      extension = { pvs = "pvs" },
      filename = { ["pvs-strategies"] = "lisp" },
    })
    vim.treesitter.language.register("erlang", "pvs")
  end,
})
