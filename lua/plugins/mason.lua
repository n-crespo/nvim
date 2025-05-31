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
    },
  },
  -- mason and mason-lspconfig released version 2.0.
  -- with some breaking changes, multiple methods have been changed
  -- therefore (for now) a workaround is needed for Mason to still work in LazyVim
  -- THIS WILL PIN th Version number, remove later, when no longer needed
  { "mason-org/mason.nvim", version = "1.11.0" },
  { "mason-org/mason-lspconfig.nvim", version = "1.32.0" },
}
