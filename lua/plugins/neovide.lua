if vim.g.neovide then
  local font_size_factor = 1.1
  local change_font_size = function(factor)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * factor
  end

  -- These are optional, here’s the full reference.
  vim.g.neovide_scroll_animation_length = 0.1
  vim.g.neovide_hide_mouse_when_typing = true

  -- macOS-specific, see if you like it compared to neovide_fullscreen.
  vim.g.neovide_fullscreen = false

  -- Replace it with any font you like. `h12` is the font size.
  vim.o.guifont = "JetBrainsMono NF:h10.2:w-1"
  vim.opt.linespace = 5

  -- zoom keymaps
  vim.keymap.set("n", "<c-=>", function()
    change_font_size(font_size_factor)
  end)
  vim.keymap.set("n", "<c-->", function()
    change_font_size(1 / font_size_factor)
  end)
  vim.keymap.set("n", "<c-0>", function()
    vim.g.neovide_scale_factor = 1
  end)

  -- padding
  vim.g.neovide_padding_top = 7
  vim.g.neovide_padding_bottom = 1
  vim.g.neovide_padding_right = 3
  vim.g.neovide_padding_left = 3

  -- Helper function for transparency formatting
  -- g:neovide_opacity should be 0 if you want to unify transparency of content and title bar.
  vim.g.neovide_opacity = 1
  vim.g.transparency = 0
  vim.g.neovide_background_color = require("snacks").util.color("Normal", "bg")
  vim.g.neovide_title_background_color = require("snacks").util.color("Normal", "bg")
  vim.g.neovide_floating_corner_radius = 0.2
  vim.g.neovide_show_border = true
  vim.g.experimental_layer_grouping = true
  vim.g.neovide_refresh_rate = 120
  vim.g.neovide_refresh_rate_idle = 5
  vim.g.neovide_cursor_animation_length = 0.1
  vim.g.neovide_scroll_animation_length = 0.2
  vim.g.neovide_cursor_trail_size = 1.0
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_cursor_smooth_blink = true
end
return {}
