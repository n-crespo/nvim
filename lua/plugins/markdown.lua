-- see after/ftplugin/markdown.lua
local M = {
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
    -- preview markdown (only on full config)
    "fmorroni/peek.nvim",
    branch = "my-main",
    cond = vim.g.full_config,
    dependencies = {
      {
        "mason-org/mason.nvim",
        ensure_installed = {
          "deno",
        },
      },
    },
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
  {
    "mason-org/mason.nvim",
    ensure_installed = {
      "mdslw", -- this cuts off lines for better diffing
    },
  },
}

-- only enable cbfmt in full config if config file exists (in dotfiles repo)
if
  vim.g.full_config
  and (
    vim.fn.filereadable(vim.fn.expand("~/.cbfmt.toml")) == 0
    or vim.fn.getftype(vim.fn.expand("~/.cbfmt.toml")) == "link"
  )
then
  if vim.fn.executable("cbfmt") then
    -- cbfmt requires a config file
    vim.api.nvim_echo({
      {
        "Please create a ~/.cbfmt.toml file for markdown codeblock formatting.",
        "WarningMsg",
      },
    }, true, {})
  end
  table.insert(M, {
    {
      "stevearc/conform.nvim",
      opts = {
        formatters_by_ft = {
          ["markdown"] = { "mdslw", "cbfmt" },
        },
      },
    },
  })
end
return M
