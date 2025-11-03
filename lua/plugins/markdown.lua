-- see after/ftplugin/markdown.lua
local M = {
  {
    "yousefhadder/markdown-plus.nvim",
    ft = { "markdown", "text" }, -- Load on markdown files by default
    opts = {
      enabled = true,
      features = {
        list_management = true,
        text_formatting = true,
        headers_toc = true,
        links = true,
      },
      keymaps = {
        enabled = true,
      },
      -- filetypes = { "markdown" }, -- Filetypes to enable the plugin for
    },
  },
  {
    "OXY2DEV/markview.nvim",
    dependencies = { "saghen/blink.cmp" },
    ft = { "markdown", "yaml", "latex" },
    opts = {
      typst = {
        enable = false,
      },
      markdown = {
        code_blocks = { pad_amount = 0 },
        headings = {
          shift_width = 0,
          org_indent = false,
        },
        list_items = {
          shift_width = function(buffer, item)
            ---@type integer Parent list items indent. Must be at least 1.
            local parent_indent = math.max(1, item.indent - vim.bo[buffer].shiftwidth)
            return item.indent * (1 / (parent_indent * 2))
          end,
          marker_minus = {
            add_padding = function(_, item)
              return item.indent > 1
            end,
          },
        },
      },
    },
    keys = {
      {
        "<leader>um",
        "<CMD>Markview<CR>",
        desc = "Toggle Markview",
      },
    },
  },
  {
    -- preview markdown (full config only)
    "fmorroni/peek.nvim",
    branch = "my-main",
    cond = vim.g.full_config,
    ft = "markdown",
    build = "deno task --quiet build:fast",
    dependencies = {
      {
        "mason-org/mason.nvim",
        ensure_installed = {
          "deno",
        },
      },
    },
    opts = function()
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
      local opts = {
        app = "webview",
        theme = "dark",
        close_on_bdelete = false,
      }
      if vim.fn.has("wsl") == 1 then
        opts.app = { "/mnt/c/Users/nicol/AppData/Local/imput/Helium/Application/chrome.exe", "--new-window" }
      else
        opts.app = { "chrome", "--new-window" }
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

-- use cmfmt if config file exists
if
  vim.g.full_config
  and vim.fn.executable("cbfmt") == 1 -- cbfmt is installed
  and vim.fn.filereadable(vim.fn.expand("~/.cbfmt.toml")) == 1 -- config file exists
then
  table.insert(M, {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["markdown"] = { "cbfmt" },
      },
    },
  })
end
return M
