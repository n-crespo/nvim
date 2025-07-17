-- use c highlighting for pvs filetype
-- vim.filetype.add({
--   extension = { od = "objdump", objdump = "objdump" },
--   pattern = {
--     [".*%.pvs"] = "pvs",
--     [".*%.service"] = "systemd",
--     ["%.objdump$"] = "objdump",
--   },
-- })

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
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "v<cr>",
          node_incremental = "<cr>",
          node_decremental = "<S-CR>",
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
