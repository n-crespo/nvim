-- see after/ftplugin/markdown.lua
local M = {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "mdslw", -- this cuts off lines for better diffing
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["markdown"] = { "mdslw", "cbfmt" },
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
        border = false,
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
        -- opts.app = { "/mnt/c/Program Files/BraveSoftware/Brave-Browser/Application/brave.exe", "--new-window" }
        opts.app = { "/mnt/c/Program Files/Zen Browser/zen.exe", "--new-window" }
      else
        opts.app = { "zen", "--new-window" }
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

-- send warning when cbfmt is not working
if
  vim.g.full_config
  and vim.fn.executable("cbfmt") == 1
  and vim.fn.filereadable(vim.fn.expand("~/.cbfmt.toml")) == 0
  and not vim.g.cbfmt_warn
then
  vim.api.nvim_echo({
    {
      "cbfmt for markdown codeblock formatting requires a config file at ~/.cbfmt.toml",
      "WarningMsg",
    },
  }, true, {})
  vim.g.cbfmt_warn = true
end
return M
