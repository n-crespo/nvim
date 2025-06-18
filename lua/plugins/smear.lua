return {
  "sphamba/smear-cursor.nvim",
  opts = {
    cursor_color = "#C5C9C9",
    smear_between_neighbor_lines = true,
    smear_insert_mode = true,
    legacy_computing_symbols_support = false,

    stiffness = 0.8, -- 0.5      [0, 1]
    trailing_stiffness = 0.5, -- 0.4      [0, 1]
    time_interval = 7, -- milliseconds
    stiffness_insert_mode = 0.8, -- 0.6      [0, 1]
    trailing_stiffness_insert_mode = 0.6, -- 0.6      [0, 1]
    distance_stop_animating = 0.1, -- 0.1      > 0

    never_draw_over_target = true,
    hide_target_hack = false,
  },
}
