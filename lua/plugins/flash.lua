return {
  "folke/flash.nvim",
  enabled = true,
  event = function()
    return "LazyFile"
  end,
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
  keys = {
    -- Simulate nvim-treesitter incremental selection
    {
      "v<cr>",
      mode = { "n", "o", "x" },
      function()
        require("flash").treesitter({
          actions = {
            ["<CR>"] = "next",
            ["<BS>"] = "prev",
          },
        })
      end,
      desc = "Treesitter Incremental Selection",
    },
    {
      "<C-space>",
      mode = { "n", "o", "x" },
      false,
    },
  },
}
