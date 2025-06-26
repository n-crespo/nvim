local M = {
  {
    "bullets-vim/bullets.vim",
    ft = { "markdown", "text", "gitcommit", "scratch" },
    config = function()
      vim.g.bullets_set_mappings = 1
      vim.g.bullets_enabled_file_types = {
        "markdown",
        "text",
        "gitcommit",
        "scratch",
      }
    end,
    keys = {
      {
        "<C-CR>",
        function()
          require("custom.utils").toggle_checkbox()
        end,
        ft = "markdown",
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
    opts = {
      render_modes = { "n", "c", "i", "\x16", "t", "no", "V", "nov", "noV", "vs", "v" },
      on = {
        render = function()
          vim.wo.conceallevel = 3
        end,
        clear = function()
          vim.wo.conceallevel = 0
        end,
      },
      file_types = { "markdown", "norg", "rmd", "org", "codecompanion" },
      latex = { enabled = false },
      code = {
        sign = true,
        width = "block",
        position = "left",
        style = "full",
        language_icon = false,
        language_name = false,
        right_pad = 2,
        highlight_inline = "DiagnosticOk",
        border = "thick",
      },
      heading = {
        setext = false,
        sign = false,
        position = "inline",
        border = true,
        left_pad = 1,
        right_pad = 1,
        width = "block",
        border_virtual = true,
        icons = {},
      },
      checkbox = {
        checked = { icon = "󰄲" },
        unchecked = { icon = "󰄱" },
      },
      indent = { enabled = false },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)
      Snacks.toggle({
        name = "Render Markdown",
        get = function()
          return require("render-markdown.state").enabled
        end,
        set = function(enabled)
          local m = require("render-markdown")
          if enabled then
            m.enable()
          else
            m.disable()
          end
        end,
      }):map("<leader>um")
    end,
    keys = {
      {
        "<leader>um",
        function()
          require("render-markdown").toggle()
        end,
        desc = "Toggle Markdown Preview",
      },
    },
  },
  {
    -- preview markdown
    "fmorroni/peek.nvim",
    branch = "my-main",
    cond = vim.fn.executable("deno") == 1,
    ft = "markdown",
    build = "deno task --quiet build:fast",
    opts = function()
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})

      local opts = {
        app = "webview",
        theme = "dark",
        close_on_bdelete = false,
      }

      if vim.fn.has("wsl") == 1 then
        opts.app = { "/mnt/c/Program Files/BraveSoftware/Brave-Browser/Application/brave.exe", "--new-window" }
      end

      return opts
    end,
    keys = {
      {
        "<leader>o",
        function()
          require("peek").open()
        end,
        desc = "Preview Markdown",
        ft = "markdown",
        buffer = true,
      },
    },
  },
}

-- enable marksman lsp/markdown-toc formatter in full config
if
  vim.g.full_config
  and (
    vim.fn.filereadable(vim.fn.expand("~/.cbfmt.toml")) == 0
    or vim.fn.getftype(vim.fn.expand("~/.cbfmt.toml")) == "link"
  )
then
  -- cbfmt requires a config file
  --   vim.api.nvim_echo({
  --     {
  --       "Please create a ~/.cbfmt.toml file for markdown codeblock formatting.",
  --       "WarningMsg",
  --     },
  --   }, true, {})
  -- end
  table.insert(M, {
    {
      "neovim/nvim-lspconfig",
      opts = {
        servers = {
          marksman = {},
        },
      },
    },
    {
      "mason-org/mason.nvim",
      opts = { ensure_installed = { "markdownlint-cli2", "marksman" } },
    },
    {
      "stevearc/conform.nvim",
      opts = {
        formatters_by_ft = {
          ["markdown"] = { "markdownlint-cli2", "cbfmt" },
        },
        formatters = {
          ["markdownlint-cli2"] = {
            condition = function(_, ctx)
              local diag = vim.tbl_filter(function(d)
                return d.source == "markdownlint"
              end, vim.diagnostic.get(ctx.buf))
              return #diag > 0
            end,
          },
        },
      },
    },
    {
      "mfussenegger/nvim-lint",
      opts = {
        linters_by_ft = {
          markdown = { "markdownlint-cli2" },
        },
        linters = {
          ["markdownlint-cli2"] = {
            -- explicitly provide config file (in dotfiles repo)
            args = { "--config", vim.fn.expand("~/.markdownlint.yaml") },
          },
        },
      },
    },
  })
end
return M
