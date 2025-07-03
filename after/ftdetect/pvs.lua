vim.filetype.add({
  extension = {
    pvs = "pvs",
  },
  filename = {
    ["pvs-strategies"] = "lisp",
  },
})
vim.treesitter.language.register("erlang", "pvs")
