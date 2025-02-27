vim.g.trouble_lualine = false
return {
  "nvim-lualine/lualine.nvim",
  -- event = "LazyFile",
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.o.statusline = " "
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    local opts = {
      options = {
        theme = require("custom.lualine_theme").theme,
        disabled_filetypes = { statusline = { "snacks_dashboard" } },
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = {},
        ---@diagnostic disable-next-line: assign-type-mismatch
        lualine_b = { LazyVim.lualine.root_dir({ cwd = true }) },
        lualine_c = {
          {
            function()
              if LazyVim.is_win() then
                return ""
              end
              return ""
            end,
            padding = { right = 1, left = 1 },
            color = function()
              return { fg = Snacks.util.color("Comment") }
            end,
            cond = function()
              return os.getenv("SSH_CONNECTION") ~= nil or LazyVim.is_win()
            end,
          },
          {
            "hostname",
            padding = { right = 0, left = 0 },
            color = function()
              return { fg = Snacks.util.color("Comment") }
            end,
            cond = function()
              return os.getenv("SSH_CONNECTION") ~= nil
            end,
            always_visible = true,
          },
          {
            "diagnostics",
            symbols = {
              error = LazyVim.config.icons.diagnostics.Error,
              warn = LazyVim.config.icons.diagnostics.Warn,
              info = LazyVim.config.icons.diagnostics.Info,
              hint = LazyVim.config.icons.diagnostics.Hint,
            },
            padding = { left = 1, right = 0 },
          },
          {
            require("lualine_require").require("lazy.status").updates,
            cond = require("lualine_require").require("lazy.status").has_updates,
            color = function()
              return { fg = Snacks.util.color("Special") }
            end,
          },
          -- stylua: ignore
          {
            -- this is for showing when a macro is recording
            function() return require("lualine_require").require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("lualine_require").require("noice").api.status.mode.has() end,
            color = function() return { fg = Snacks.util.color("Constant") } end,
          },
        },
        lualine_x = {
          {
            -- see custom/tabline.lua
            require("custom.tabline").tabline,
            padding = { left = 4, right = 1 },
          },
        },
        lualine_y = {
          {
            "progress",
          },
        },
        lualine_z = {},
      },
    }
    return opts
  end,
  keys = {
    {
      "<A-,>",
      function()
        local current_tab = vim.fn.tabpagenr()
        if current_tab == 1 then
          vim.cmd("tabmove")
        else
          vim.cmd("-tabmove")
        end
        require("lualine").refresh()
      end,
      desc = "Move Tab Left",
    },
    {
      "<A-;>",
      function()
        local current_tab = vim.fn.tabpagenr()
        if current_tab == vim.fn.tabpagenr("$") then
          vim.cmd("0tabmove")
        else
          vim.cmd("+tabmove")
        end
        require("lualine").refresh()
      end,
      desc = "Move Tab Right",
    },
  },
}
