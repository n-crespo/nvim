vim.g.trouble_lualine = false

return {
  "nvim-lualine/lualine.nvim",
  event = "LazyFile",
  dependencies = { "echasnovski/mini.icons" },
  opts = function()
    local icons = LazyVim.config.icons
    local opts = {
      options = {
        -- always_show_tabline = false, -- causes flicker in dashboard, use autocmd workaround
        theme = "gray",
        disabled_filetypes = { statusline = { "snacks_dashboard" } },
        always_divide_middle = true,
        padding = 0,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        -- refresh = { statusline = 100 },
      },
      sections = {
        ------- LEFT SIDE of statusline -----
        lualine_a = {
          -- stylua: ignore start
          { function() return " " end, },

          ---@diagnostic disable-next-line: assign-type-mismatch
          LazyVim.lualine.root_dir({ cwd = true }),

          { function() return " " end, },
          -- stylua: ignore stop
        },
        lualine_b = {
          {
            "branch",
            padding = 1,
            draw_empty = false,
            icon = { "" },
          },
        },
        lualine_c = {
          {
            "filetype",
            icon_only = true,
            padding = { left = 1, right = 0 },
          },
          -- stylua: ignore
          { function() return " " end, cond = function () return vim.bo.filetype == '' end }, -- artificial padding
          {
            LazyVim.lualine.pretty_path(),
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = function() return { fg = Snacks.util.color("Debug") } end,
          },
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
            padding = { left = 1 },
          },
          -- {
          --   require("lualine_require").require("lazy.status").updates,
          --   cond = require("lualine_require").require("lazy.status").has_updates,
          --   color = "Special",
          --   padding = { left = 1 },
          -- },
          -- stylua: ignore
          {
            -- this is for showing when a macro is recording
            function() return require("lualine_require").require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("lualine_require").require("noice").api.status.mode.has() end,
            color = "WarningMsg",
            padding = { left = 1 },
          },
        },
        ------- RIGHT SIDE of statusline -----
        lualine_x = {
          -- stylua: ignore
          {
            function () return "" end,
            cond = function() return LazyVim.is_win() end,
            color = "Comment",
          },
          {
            "hostname",
            padding = { left = 1, right = 0 },
            color = "Comment",
          },
        },
        lualine_y = {
          {
            "location",
            cond = function()
              return not string.find(vim.fn.mode():lower(), "[v]")
            end,
            padding = 1,
          },
          {
            "selectioncount",
            padding = 1,
            fmt = function(str)
              if str == "" then
                return
              end
              local total_width = 6
              local str_len = #str
              if str_len < total_width and str_len ~= "" then
                local padding = total_width - str_len
                local right_pad = math.floor(padding / 2)
                local left_pad = padding - right_pad
                return string.rep(" ", left_pad) .. str .. string.rep(" ", right_pad)
              else
                return str
              end
            end,
          },
          { "progress", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          {
            function()
              return vim.g.full_config and "" or ""
            end,
            padding = 1,
            color = {
              fg = vim.g.full_config and Snacks.util.color("DiffAdded") or Snacks.util.color("DiagnosticWarn"), -- grab yellow fg part of
            },
          },
        },
      },
    }
    return opts
  end,
}
