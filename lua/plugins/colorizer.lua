vim.api.nvim_create_user_command("Colorizer", function()
  if package.loaded["colorizer"] then
    require("colorizer").reload_all_buffers()
  end
  require("colorizer").attach_to_buffer(0)
end, { nargs = 0 })

return {
  "catgoose/nvim-colorizer.lua",
  cmd = "Colorizer",
  ft = { "css", "html", "javascript", "typescript", "noice", "ghostty" },
  opts = {
    lazy_load = false,
    filetypes = {
      "*",
      noice = { always_update = true },
      blink_menu = { always_update = true },
      blink_docs = { always_update = true },
      cmp_menu = { always_update = true },
      cmp_docs = { always_update = true },
      snacks_picker_preview = { always_update = true },
    },
    -- exclude prompt and popup buftypes from highlight
    buftypes = { "!prompt", "!popup" },
    user_default_options = {
      RGB = false, -- #RGB hex codes
      RGBA = false,
      css_fn = true, -- CSS rgb(), rgba() hsl(), and hsla() functions
      names = false, -- `blue`, `red`
      tailwind = true,
      tailwind_opts = { update_names = false },
    },
  },
  keys = {
    {
      "<leader>uH",
      function()
        local attached = require("colorizer").is_buffer_attached()
        if not attached then
          require("colorizer").attach_to_buffer(0)
          vim.notify("Enabled **Colorizer Highlights**", vim.log.levels.INFO, { title = "Tabs" })
        else
          require("colorizer").detach_from_buffer(0)
          vim.notify("Disabled **Colorizer Highlights**", vim.log.levels.WARN, { title = "Tabs" })
        end
      end,
      desc = "Toggle Colorizer",
    },
  },
}
