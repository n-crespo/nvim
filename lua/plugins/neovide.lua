if vim.g.neovide then
  -- font and spacing
  -- h10.2 is the font size , w-1 tightens width
  vim.o.guifont = "JetBrainsMono NF:h10.2:w-1"
  vim.opt.linespace = 5

  -- zoom/scaling logic
  local font_size_factor = 1.1
  local change_font_size = function(factor)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * factor
  end
  vim.keymap.set("n", "<c-=>", function()
    change_font_size(font_size_factor)
  end)
  vim.keymap.set("n", "<c-->", function()
    change_font_size(1 / font_size_factor)
  end)
  vim.keymap.set("n", "<c-0>", function()
    vim.g.neovide_scale_factor = 1
  end)

  -- refresh rate
  vim.g.neovide_refresh_rate = 120
  vim.g.neovide_refresh_rate_idle = 5
  vim.g.neovide_no_idle = false
  vim.g.neovide_confirm_quit = true

  -- animation timings (shorter = snappier)
  -- at 120Hz, 0.06 - 0.08s feels instant but smooth
  vim.g.neovide_cursor_animation_length = 0.07
  vim.g.neovide_cursor_trail_size = 0.2 -- smaller trail reduces visual clutter/lag feel
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_cursor_smooth_blink = true
  vim.g.neovide_no_multigrid = true

  -- padding
  vim.g.neovide_padding_top = 7
  vim.g.neovide_padding_bottom = 1
  vim.g.neovide_padding_right = 3
  vim.g.neovide_padding_left = 3

  -- other visuals
  vim.g.neovide_background_color = "#0F0F0F"
  vim.g.neovide_title_background_color = "#0F0F0F"
  vim.g.neovide_floating_corner_radius = 0.2
  vim.g.neovide_show_border = true
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_throttled = true
end
return {}
