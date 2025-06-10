-- use the $SHELL env variable or fish
vim.g.shell = vim.fn.has("wsl") ~= 0 and "/usr/bin/fish" or vim.o.shell

return {
  "folke/snacks.nvim",
  opts = {
    terminal = {
      enabled = true,
      win = { keys = { nav_l = "<C-l>", nav_j = "<C-j>", nav_k = "<C-k>" } },
      shell = vim.g.shell,
    },
  },
  keys = {
    -- note: this assumes your terminal can recognize the <C-/> and <C-S-/> keys
    { "<C-S-_>", nil },
    { "<C-_>", nil },
    {
      "<C-q>",
      function()
        require("snacks.terminal").toggle(nil, {
          win = { position = "bottom" },
          env = { SNACKS_TERM_ID = "bottom_terminal" },
        })
      end,
      desc = "Toggle bottom terminal",
      mode = { "n", "t" },
    },
    {
      "<C-s-/>",
      function()
        require("snacks.terminal").toggle(nil, {
          win = { position = "float", border = "rounded" },
          env = { SNACKS_TERM_ID = "floating_terminal" },
        })
      end,
      desc = "Toggle floating terminal",
      mode = { "n", "t" },
    },
  },
}
