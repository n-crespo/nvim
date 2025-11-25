return {
  "sphamba/smear-cursor.nvim",
  cond = false,
  lazy = false,
  opts = {
    anticipation = 0,
    damping = 0.999, -- setting this to 1 is a bit buggy
    cursor_color = "#e2e2e2",
    transparent_bg_fallback_color = "#0D0D0D",
    smear_between_neighbor_lines = true,
    gamma = 1,

    time_interval = 7, -- milliseconds, default 17

    stiffness = 0.8, -- 0.5      [0, 1]
    trailing_stiffness = 0.65, -- 0.4      [0, 1]

    smear_insert_mode = true,
    stiffness_insert_mode = 0.8, -- 0.6      [0, 1]
    trailing_stiffness_insert_mode = 0.8, -- 0.6      [0, 1]
    damping_insert_mode = 0.999, -- setting this to 1 is a bit buggy

    -- time_interval = 6, -- milliseconds
    distance_stop_animating = 0.5, -- 0.1      > 0
    never_draw_over_target = false,
    hide_target_hack = false,
    smear_to_cmd = false,
    smear_between_buffers = true,
  },
}
