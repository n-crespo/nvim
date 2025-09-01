-- establish custom filetype associations
vim.filetype.add({
  extension = {
    pvs = "pvs",
    prl = "pvs",
    prf = "pvs",
    jprf = "json",
    kyx = "keymaeraX",
  },
  filename = { ["pvs-strategies"] = "lisp" },
})
vim.treesitter.language.register("erlang", "pvs")
vim.treesitter.language.register("haskell", "keymaeraX")
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

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
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "v<cr>",
          node_incremental = "<cr>",
          node_decremental = "<bs>",
        },
      },
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
      },
    },
  },
}

-- some filetypes that are sometimes useful:
-- vim.filetype.add({
--   extension = { od = "objdump", objdump = "objdump" },
--   pattern = {
--     [".*%.service"] = "systemd",
--     ["%.objdump$"] = "objdump",
--   },
-- })
