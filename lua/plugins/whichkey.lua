-- default LazyVim plugin, adds floating window for remembering keymaps
return {
  "folke/which-key.nvim",
  opts = {
    filter = function(mapping) -- exclude mappings without a description
      return mapping.desc ~= "" and mapping.desc
    end,
    show_help = false,
    plugins = {
      marks = true,
      spelling = false,
      presets = { motions = true, operators = true },
    },
    win = {
      no_overlap = false,
      border = "rounded",
    },
    spec = {
      {
        mode = { "n", "v" },
        { "<R>", group = "run", icon = "" },
        { "<leader>q", group = "Close Window" },
        { "<leader>a", group = "+ai" },
      },
    },
  },
  keys = {
    { "<leader>K", nil },
    { "<leader><Tab><Tab>", nil },
    { "<leader><Tab>]", nil },
    { "<leader><Tab>[", nil },
    { "<leader><Tab>f", nil },
    { "<leader><Tab>l", nil },
    { "<leader><Tab>l", nil },
    { "<leader>-", nil },
    { "<leader>w-", nil },
    { "<leader>w|", nil },
    { "<leader>|", nil },
    { "<leader>bb", nil },
    { "<leader>bD", nil },
    { "<leader>ft", nil },
    { "<leader>fT", nil },
    { "<leader>qq", nil },
  },
}
