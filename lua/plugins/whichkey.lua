-- default LazyVim plugin, adds floating window for remembering keymaps
return {
  "folke/which-key.nvim",
  opts = {
    icons = { mappings = true }, -- disable icons
    filter = function(mapping)
      -- exclude mappings without a description but enable vimtext keymaps
      if type(mapping.rhs) == "string" and mapping.rhs:find("vimtex") then
        mapping.rhs = mapping.rhs:gsub("vimtex%-", "")
        mapping.rhs = mapping.rhs:sub(1, -2)
        return true
      end
      return mapping.desc and mapping.desc ~= ""
    end,
    show_help = false,
    delay = function(ctx)
      return ctx.plugin and 0 or 350
    end,
    plugins = {
      marks = true,
      spelling = false,
      presets = { motions = false, operators = false },
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
