vim.api.nvim_create_autocmd("FileType", {
  pattern = "csv",
  desc = "Enable CSV View on .csv files",
  callback = function()
    vim.cmd([[silent! CsvViewEnable]])
  end,
})

return {
  "hat0uma/csvview.nvim",
  ft = "csv",
  cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
  ---@module "csvview"
  ---@type CsvView.Options
  opts = {
    parser = { comments = { "#", "//" } },
    view = { display_mode = "border" },
    keymaps = {
      -- Text objects for selecting fields
      textobject_field_inner = { "if", mode = { "o", "x" } },
      textobject_field_outer = { "af", mode = { "o", "x" } },
      -- excel like row/col navigation
      jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
      jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
      jump_next_row = { "<Enter>", mode = { "n", "v" } },
      jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
    },
  },
}
