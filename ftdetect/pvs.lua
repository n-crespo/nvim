vim.filetype.add({
  extension = {
    pvs = "pvs",
  },
})
vim.treesitter.language.register("erlang", "pvs")
vim.opt.commentstring = "% %s"

local ft = require("Comment.ft")
ft.pvs = "% %s"
