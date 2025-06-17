return {
  "folke/flash.nvim",
  enabled = true,
  event = "VeryLazy",
  opts = {
    search = {
      mode = "fuzzy",
      multi_window = false,
    },
    label = { uppercase = false },
    jump = {
      nohlsearch = true, -- clear highlight after jump
      autojump = false, -- automatically jump when there is only one match
    },
    highlight = {
      backdrop = false, -- do not dim the background
    },
    modes = {
      -- `f`, `F`, `t`, `T`, `;` and `,` motions
      char = { enabled = false },
      search = { enabled = false },
    },
    prompt = {
      win_config = {
        border = "none",
      },
    },
  },
}
