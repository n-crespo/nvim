return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["html"] = { "superhtml" },
        ["c"] = { "clang-format" },
        ["zsh"] = { "beautysh" },
      },
      formatters = {
        beautysh = {
          append_args = { "--indent-size", "2" },
        },
      },
    },
  },
  {
    "mason-org/mason.nvim",
    event = "LspAttach",
    opts = {
      ensure_installed = { "superhtml" },
    },
  },
}
