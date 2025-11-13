-- establish custom filetype associations
vim.filetype.add({
  extension = {
    pvs = "pvs",
    prl = "pvs",
    prf = "pvs",
    jprf = "json",
    kyx = "keymaeraX",
    od = "objdump",
    objdump = "objdump",
  },
  pattern = {
    [".*%.service"] = "systemd",
    ["%.objdump$"] = "objdump",
  },
  filename = { ["pvs-strategies"] = "lisp" },
})
vim.treesitter.language.register("erlang", "pvs")
vim.treesitter.language.register("haskell", "keymaeraX")

return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<BS>", desc = "Decrement Selection", mode = "x" },
        { "<CR>", desc = "Increment Selection", mode = { "x", "n" } },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "LazyFile",
    opts = {
      indent = { enable = true },
      ensure_installed = {
        "comment",
        "css",
        "csv",
        "editorconfig",
        "erlang",
        "fish",
        "git_config",
        "objdump",
        "ssh_config",
        "todotxt",
        "latex",
        "markdown",
        "zsh",
        "make",
        "cmake",
      },
    },
  },
}
