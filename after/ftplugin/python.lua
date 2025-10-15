-- if package.loaded["lspconfig"] and vim.g.full_config then
-- require("lspconfig").pylsp.setup({
--   settings = {
--     pylsp = {
--       plugins = {
--         pycodestyle = {
--           enabled = false,
--           -- this disables errors about lines being too long,
--           -- line breaks between binary operators
--           ignore = { "E501", "W503", "W391", "E226", "E302" },
--         },
--       },
--     },
--   },
-- })
-- end

require("lspconfig").basedpyright.setup({
  settings = {
    basedpyright = {
      typeCheckingMode = "off",
    },
  },
})
