---@module 'snacks.input'

return {
  "folke/snacks.nvim",
  opts = {
    ---@type table<string, snacks.win.Config>
    styles = {
      above_cursor = {
        backdrop = false,
        position = "float",
        title_pos = "left",
        height = 1,
        noautocmd = true,
        width = 40,
        relative = "cursor",
        row = -3,
        col = 0,
        wo = {
          cursorline = false,
        },
        bo = {
          filetype = "snacksinput",
          buftype = "prompt",
        },
        --- buffer local variables
        b = {
          completion = false, -- disable blink completions in input
        },
      },
    },
    input = {
      enabled = true,
      win = {
        style = "above_cursor",
      },
    },
  },
}
