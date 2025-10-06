return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- space around dot in virt text diagnostic
      opts.diagnostics.virtual_text.prefix = " " .. opts.diagnostics.virtual_text.prefix .. " "

      -- disable <C-k> insert mode keymap for focusing signature help window and more
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "<C-K>", false, mode = "i" }
      keys[#keys + 1] = { "<leader>cA", false, mode = "n" }
      keys[#keys + 1] = { "<leader>cc", false, mode = "n" }
      keys[#keys + 1] = { "<leader>cC", false, mode = "n" }
      keys[#keys + 1] = { "<leader>cR", false, mode = "n" }
      keys[#keys + 1] = { "<M-n>", false, mode = "n" }
      keys[#keys + 1] = { "<M-p>", false, mode = "n" }
      keys[#keys + 1] = { "]]", false, mode = "n" }
      keys[#keys + 1] = { "[[", false, mode = "n" }
      return opts
    end,
  },
  -- rounded border around <leader>cd
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        float = {
          border = "rounded",
        },
      },
    },
  },
}
