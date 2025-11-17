return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["html"] = { "superhtml" },
        ["c"] = { "clang-format" },
        ["zsh"] = { "beautysh" },
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
