vim.filetype.add({
  extension = {
    pvs = "pvs",
  },
})
vim.treesitter.language.register("erlang", "pvs")
vim.opt.commentstring = "% %s"
