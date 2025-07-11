return {
  "sphamba/smear-cursor.nvim",
  opts = {
    anticipation = 0,
    damping = 0.99, -- setting this to 1 is a bit buggy
    cursor_color = "#c9c9c9",
    transparent_bg_fallback_color = "#0D0D0D",
    smear_between_neighbor_lines = true,
    legacy_computing_symbols_support = true,
    legacy_computing_symbols_support_vertical_bars = true,
    gamma = 1,

    stiffness = 0.8, -- 0.5      [0, 1]
    trailing_stiffness = 0.5, -- 0.4      [0, 1]

    smear_insert_mode = true,
    stiffness_insert_mode = 0.8, -- 0.6      [0, 1]
    trailing_stiffness_insert_mode = 0.8, -- 0.6      [0, 1]
    damping_insert_mode = 0.99, -- setting this to 1 is a bit buggy

    -- time_interval = 6, -- milliseconds
    distance_stop_animating = 0.5, -- 0.1      > 0
    never_draw_over_target = true,
    hide_target_hack = true,
    smear_to_cmd = false,
  },
}
