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
  "nvim-treesitter/nvim-treesitter",
  event = "LazyFile",
  opts = {
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "v<cr>",
        scope_incremental = "<tab>",
        node_incremental = "<cr>",
        node_decremental = "<S-CR>",
      },
    },
    ensure_installed = {
      "diff",
      "bash",
      "csv",
      "yaml",
      "xml",
      "vimdoc",
      "css",
      "objdump",
      "erlang",
      "comment",
      "ssh_config",
      "editorconfig",
      "json",
      "jsonc",
      "json5",
      "matlab",
      "markdown_inline",
      "regex",
      "vim",
      "query",
      "html",
      "vimdoc",
      "todotxt",
    },
  },
}
