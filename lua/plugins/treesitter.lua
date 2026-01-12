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
    opts = {
      indent = { enable = true },
      ensure_installed = {
        "comment",
        "css",
        "csv",
        "editorconfig",
        "git_config",
        "ssh_config",
        "todotxt",
        "markdown",
        "zsh",
        "make",
        "cmake",
        -- "objdump",
        -- "latex",
        -- "erlang",
        -- "fish",
      },
    },
  },
}
