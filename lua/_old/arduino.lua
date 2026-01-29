do
  return {}
end
return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["arduino"] = { "clang-format" }, -- use c++ formatter
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "arduino",
      },
    },
  },
}
