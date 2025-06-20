return {
  "sphamba/smear-cursor.nvim",
  commit = "d11ce9d", -- i don't like the new animating thing
  opts = {
    anticipation = 0,
    damping = 1.1,
    cursor_color = "#C5C9C9",
    transparent_bg_fallback_color = "#1D1D1D",
    smear_between_neighbor_lines = true,
    smear_insert_mode = true,
    legacy_computing_symbols_support = true,
    legacy_computing_symbols_support_vertical_bars = false,
    gamma = 1,

    stiffness = 0.8, -- 0.5      [0, 1]
    trailing_stiffness = 0.5, -- 0.4      [0, 1]
    time_interval = 7, -- milliseconds
    stiffness_insert_mode = 0.8, -- 0.6      [0, 1]
    trailing_stiffness_insert_mode = 0.6, -- 0.6      [0, 1]
    distance_stop_animating = 0.5, -- 0.1      > 0

    never_draw_over_target = true,
    hide_target_hack = false,
  },
}
