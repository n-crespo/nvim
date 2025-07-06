-- use haskell highlighting in .kyx files and "keymaerax" codeblocks
vim.filetype.add({
  extension = { kyx = "keymaerax" },
})
vim.treesitter.language.register("haskell", "keymaerax")
