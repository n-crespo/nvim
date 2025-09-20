vim.g.trouble_lualine = false

return {
  "nvim-lualine/lualine.nvim",
  event = function()
    return { "LazyFile", "WinNew" }
  end,
  dependencies = { "nvim-mini/mini.icons" },
  opts = function()
    local icons = LazyVim.config.icons
    local opts = {
      options = {
        padding = 0,
        theme = "minimal",
        always_divide_middle = true,
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        disabled_filetypes = { statusline = { "snacks_dashboard" } },
      },
      sections = {
        lualine_a = {},
        lualine_b = {
          -- stylua: ignore start
          { function() return " " end, },
          ---@diagnostic disable-next-line: assign-type-mismatch
          LazyVim.lualine.root_dir({ cwd = true }),
          { function() return "  " end, },
          -- stylua: ignore stop
          {
            "branch",
            padding = { left = 0, right = 2 },
            draw_empty = false,
            icon = { "" },
            -- color = { "Comment" },
            color = { gui = 'bold'}
          },
        },
        lualine_c = {
          {
            "filetype",
            icon_only = true,
            padding = { left = 0, right = 0 },
            colored = true,
            draw_empty = true,
          },
          {
            LazyVim.lualine.pretty_path(),
            padding = { left = 0, right = 1 },
            draw_empty = false,
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
        lualine_x = {},
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
          { "progress", padding = 1 },
          {
            function()
              return ""
            end,
            cond = function()
              return LazyVim.is_win()
            end,
            padding = { left = 1, right = 0 },
            color = nil,
          },
          {
            "hostname",
            padding = 1,
            color = nil,
          },
        },
        lualine_z = {
          {
            function()
              return vim.g.full_config and "" or ""
            end,
            padding = 1,
            color = {
              fg = vim.g.full_config and Snacks.util.color("String") or Snacks.util.color("DiagnosticWarn"), -- grab yellow fg part of
            },
          },
        },
      },
    }
    return opts
  end,
  keys = {
    {
      "<C-g>", -- :h CTRL_G
      -- stylua: ignore
      function()
        local pretty_path = require("lazyvim.util.lualine").pretty_path({ directory_hl = "", filename_hl = "", modified_hl = "" })({})
        if pretty_path ~= "" then pretty_path = "\n" .. pretty_path .. "" end
        vim.notify("[" .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p:~") .. "]" .. pretty_path)
      end,
    },
  },
}
