-- makes installing and managing language servers a lot easier
return {
  {
    "mason-org/mason.nvim",
    event = "LspAttach",
    opts = {
      ui = {
        border = "rounded",
        width = 0.8,
        height = 0.8,
      },
      ensure_installed = {
        "deno",
      },
    },
  },
}
