vim.opt.commentstring = "% %s"
if not vim.g.vscode then
  local ft = require("Comment.ft")
  ft.pvs = "% %s"
  -- vim.opt_local.foldmethod = "indent"
  vim.cmd([[setlocal fdm=indent]])
end
