-- adds rainbow delimiters when treesitter not available
-- note: ONLY works when treesitter parser is NOT installed
return {
  "luochen1990/rainbow",
  ft = "erlang",
  event = { "BufReadPre", "BufNewFile" },
  init = function()
    vim.g.rainbow_active = 1
  end,
  config = function()
    vim.cmd("RainbowToggleOn")
  end,
}
