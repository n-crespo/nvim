return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            -- disable <C-k> insert mode keymap for focusing signature help window
            { "<C-K>", false, mode = "i" },
            { "<leader>cA", false, mode = "n" },
            { "<leader>cc", false, mode = "n" },
            { "<leader>cC", false, mode = "n" },
            -- { "<leader>cR", false, mode = "n" },
            { "<M-n>", false, mode = "n" },
            { "<M-p>", false, mode = "n" },
            -- { "]]", false, mode = "n" },
            -- { "[[", false, mode = "n" },
          },
        },
      },
    },
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
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruff = {
          enabled = false,
        },
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = "standard",
              },
            },
          },
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- space around dot in virt text diagnostic
      opts.diagnostics.virtual_text.prefix = " " .. opts.diagnostics.virtual_text.prefix .. " "
      return opts
    end,
  },
}
