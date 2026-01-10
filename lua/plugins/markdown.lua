-- see after/ftplugin/markdown.lua
return {
  {
    "yousefhadder/markdown-plus.nvim",
    ft = { "markdown", "text" },
    opts = {
      features = { table = false },
      keymaps = { enabled = false },
    }, -- don't initialize default keymaps
    keys = {
      { "o", "<Plug>(MarkdownPlusNewListItemBelow)", buffer = true, ft = "markdown", mode = "n" },
      { "O", "<Plug>(MarkdownPlusNewListItemAbove)", buffer = true, ft = "markdown", mode = "n" },
      { "<CR>", "<Plug>(MarkdownPlusListEnter)", buffer = true, ft = "markdown", mode = "i" },
      { "<BS>", "<Plug>(MarkdownPlusListBackspace)", buffer = true, ft = "markdown", mode = "i" },
      { "<C-c>", "<Plug>(MarkdownPlusToggleCheckbox)", buffer = true, ft = "markdown" },
      { "<C-i>", "<Plug>(MarkdownPlusItalic)", buffer = true, ft = "markdown", mode = { "v" } },
      { "<C-b>", "<Plug>(MarkdownPlusBold)", buffer = true, ft = "markdown", mode = { "n", "v" } },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" }, -- if you use standalone mini plugins
    ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
    opts = {
      render_modes = { "n", "c", "i", "\x16", "t", "no", "V", "nov", "noV", "vs", "v" },
      on = {
        -- stylua: ignore start
        render = function() vim.wo.conceallevel = 3 end,
        clear = function() vim.wo.conceallevel = 0 end,
        -- stylua: ignore end
      },
      file_types = { "markdown", "norg", "rmd", "org", "codecompanion" },
      latex = { enabled = true },
      code = {
        width = "block",
        position = "right",
        border = "thick",
        sign = false,
        right_pad = 1,
        left_pad = 1,
        conceal_delimiters = false,
      },
      heading = {
        setext = false,
        sign = false,
        width = "block",
        left_pad = 1,
        right_pad = 1,
        icons = {},
      },
      checkbox = {
        checked = { icon = "󰄲" },
        unchecked = { icon = "󰄱" },
        custom = {
          todo = { raw = "[-]", rendered = "󰥔", highlight = "RenderMarkdownTodo", scope_highlight = nil },
        },
      },
      pipe_table = {
        border_virtual = true,
      },
      completions = {
        lsp = { enabled = true },
        blink = { enabled = true },
      },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)
      Snacks.toggle({
        name = "Render Markdown",
        get = require("render-markdown").get,
        set = require("render-markdown").set,
        ft = "markdown",
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
        opts.app = { "/mnt/c/Users/nicol/AppData/Local/imput/Helium/Application/chrome.exe", "--new-window" }
      else
        opts.app = { "chrome", "--new-window" }
      end
      return opts
    end,
    keys = {
      {
        "<leader>cp",
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
