return {
  "sphamba/smear-cursor.nvim",
  opts = {
    smear_between_neighbor_lines = false,
    smear_insert_mode = true,
    legacy_computing_symbols_support = false,

    -- ORANGE
    -- cursor_color = "#ff8800",
    -- stiffness = 0.3,
    -- trailing_stiffness = 0.1,
    -- trailing_exponent = 5,
    -- gamma = 1,

    -- NO TRAIL
    -- stiffness = 0.5,
    -- trailing_stiffness = 0.49,
    -- transparent_bg_fallback_color = "#111111",

    stiffness = 0.8, -- 0.6      [0, 1]
    trailing_stiffness = 0.5, -- 0.4      [0, 1]
    time_interval = 7, -- milliseconds
    stiffness_insert_mode = 0.6, -- 0.4      [0, 1]
    trailing_stiffness_insert_mode = 0.6, -- 0.4      [0, 1]
    distance_stop_animating = 0.5, -- 0.1      > 0

    never_draw_over_target = true,
    hide_target_hack = true,
  },
}
