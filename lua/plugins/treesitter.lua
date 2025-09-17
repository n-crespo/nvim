return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<BS>", desc = "Decrement Selection", mode = "x" },
        { "<CR>", desc = "Increment Selection", mode = { "x", "n" } },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "LazyFile",
    init = function(plugin)
      -- below is from lazyvim config
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")

      -- establish custom filetype associations
      vim.filetype.add({
        extension = {
          pvs = "pvs",
          prl = "pvs",
          prf = "pvs",
          jprf = "json",
          kyx = "keymaeraX",
        },
        filename = { ["pvs-strategies"] = "lisp" },
      })
      vim.treesitter.language.register("erlang", "pvs")
      vim.treesitter.language.register("haskell", "keymaeraX")
      vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end,
    opts = {
      indent = { enable = true },
      ensure_installed = {
        "comment",
        "css",
        "csv",
        "editorconfig",
        "erlang",
        "fish",
        "git_config",
        "objdump",
        "ssh_config",
        "todotxt",
      },
    },
  },
}

-- some filetypes that are sometimes useful:
-- vim.filetype.add({
--   extension = { od = "objdump", objdump = "objdump" },
--   pattern = {
--     [".*%.service"] = "systemd",
--     ["%.objdump$"] = "objdump",
--   },
-- })
