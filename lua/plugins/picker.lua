return {
  "folke/snacks.nvim",
  dependencies = { "echasnovski/mini.icons" },
  opts = {
    picker = {
      sources = {
        files = { hidden = true, ignored = true },
      },
      layout = {
        cycle = true,
        preset = function()
          if vim.o.lines <= 23 and vim.o.columns <= 22 then
            return "small"
          elseif vim.o.columns <= 116 then
            return "vertical"
          else
            return "default"
          end
        end,
      },
      layouts = {
        vscode = {
          layout = {
            preview = false,
            backdrop = false,
            row = 1,
            width = 0.4,
            min_width = 80,
            height = 0.4,
            border = "none",
            box = "vertical",
            { win = "input", height = 1, border = "rounded", title = "{title} {live} {flags}", title_pos = "center" },
            { win = "list", border = "single" },
            { win = "preview", title = "{preview}", border = "rounded" },
          },
        },
        -- this is just vertical but without a preview
        small = {
          layout = {
            box = "horizontal",
            width = 0.8,
            min_width = 60,
            height = 0.8,
            {
              box = "vertical",
              border = "rounded",
              title = "{title} {live} {flags}",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
            },
          },
        },
        vertical = {
          layout = {
            box = "vertical",
            width = 0.8,
            min_width = 40,
            height = 0.8,
            min_height = 20,
            {
              box = "vertical",
              border = "rounded",
              title = "{title} {live} {flags}",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
            },
            { win = "preview", title = "{preview}", height = 0.45, border = "rounded" },
          },
        },
        default = {
          layout = {
            box = "horizontal",
            width = 0.85,
            min_width = 80,
            height = 0.8,
            {
              box = "vertical",
              border = "rounded",
              title = "{title} {live} {flags}",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
            },
            { win = "preview", title = "{preview}", border = "rounded", width = 0.5 },
          },
        },
      },
      formatters = {
        file = {
          filename_first = true, -- display filename before the file path
          truncate = 60, -- truncate to rougthly this length
        },
      },
      ---@class snacks.picker.previewers.Config
      previewers = {
        -- use external tool (git) for diffs
        git = { builtin = false },
        diff = { builtin = false },
      },
      matcher = {
        frecency = true,
        cwd_bonus = true,
        history_bonus = true,
      },
      win = {
        -- input window
        input = {
          keys = {
            -- custom
            ["<C-a>"] = { nil, mode = { "i", "n" } },
            ["<Tab>"] = { "cycle_win", mode = { "i", "n" } },
            ["<S-CR>"] = { "tab", mode = { "i", "n" } },
            ["<C-CR>"] = { "tab", mode = { "i", "n" } },

            ["<C-p>"] = { "history_back", mode = { "i", "n" } },
            ["<C-n>"] = { "history_forward", mode = { "i", "n" } },

            -- <C-/> conflicts with commenting keymap
            ["<c-s-/>"] = { "toggle_help", mode = { "i", "n" } },
            ["<c-/>"] = { "toggle_help", mode = { "i", "n" } },

            -- exit when exiting insert mode
            ["<Esc>"] = { "cancel", mode = { "n", "i" } },

            -- misc
            ["<S-Tab>"] = { "cycle_win", mode = { "i", "n" } },
            ["<C-Space>"] = { "toggle_live", mode = { "i", "n" } },
            ["<c-s>"] = { "edit_split", mode = { "i", "n" } },
            ["<c-t>"] = { "trouble_open", mode = { "i", "n" } },

            -- scrolling
            ["<c-f>"] = { "preview_scroll_down", mode = { "i", "n" } },
            ["<c-b>"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
            ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },

            -- what does this do??
            ["<c-g>"] = { "toggle_live", mode = { "i", "n" } },
            ["<a-y>"] = { "toggle_follow", mode = { "i", "n" } },

            -- alt mappings
            ["<a-o>"] = { "toggle_maximize", mode = { "i", "n" } },
            ["<a-i>"] = { "toggle_ignored", mode = { "i", "n" } },
            ["<a-.>"] = { "toggle_hidden", mode = { "i", "n" } },
            ["<a-p>"] = { "toggle_preview", mode = { "i", "n" } },
          },
          b = {
            minipairs_disable = true,
          },
        },
        list = {
          keys = {
            ["<Tab>"] = { "focus_input", mode = { "i", "n" } },
            ["<S-Tab>"] = { "", mode = { "i", "n" } },
          },
        },
        -- preview window
        preview = {
          keys = {
            ["<a-o>"] = { "toggle_maximize", mode = { "i", "n" } },
            ["<S-Tab>"] = { "focus_input" },
            ["<Tab>"] = { "focus_input" },
            ["<Esc>"] = "close",
            ["i"] = "focus_input",
          },
          wo = { number = false, statuscolumn = "" },
        },
      },
    },
  },
  keys = {
    -- stylua: ignore start
    ----------- PICKER KEYMAPS -------------
    { "<leader>gc", nil },
    { "<leader>sg", nil },
    { "<leader>fb", nil },
    { "<leader>fB", nil },
    { "<leader>fr", nil },
    { "<leader>ff", nil },
    { "<leader>sc", nil },
    { "<leader>sq", nil }, -- quickfix list
    { "<leader>sC", nil },
    { "<leader>sG", nil },
    { "<leader>sl", nil },
    { '<leader>s"', nil },
    { "<leader>sd", nil }, -- search diagnostics
    { "<leader>sD", nil }, -- buffer diagnostics
    { "<leader>s/", nil }, -- search history
    { "<leader>qp", nil },
    { "<leader>sB", nil },
    { "<leader>fF", nil },
    { "<leader>fg", nil },
    { "<leader>fR", nil },
    { "<leader>sw", nil },
    { "<leader>sW", nil },
    { "<leader>sM", nil },
    { "<leader>sm", nil },
    { "<leader>sb", nil },
    { "<leader>sj", nil },
    { "<leader>sR", nil },
    { "<leader>fO", function() Snacks.picker.recent() end, desc = "Old Files (dumb)", },
    { "<leader>fo", function() Snacks.picker.smart() end, desc = "Old Files (smart)", },
    { "<leader>fp", function() Snacks.picker.files({ cwd = require("lazy.core.config").options.root, title = "Plugin Files" }) end, desc = "Plugin Files", },
    { "<leader>fP", function() Snacks.picker.lazy({ title = "Search for Plugin Spec" }) end, desc = "Search for Plugin Spec", },
    { "<leader>sp", function() Snacks.picker.pickers() end, desc = "Pickers", },
    { "<leader>fH", function() Snacks.picker.highlights() end, desc = "Highlights", },
    { "<leader>cl", function() Snacks.picker.lsp_config() end, desc = "Lsp Info", },
    { "<leader>sr", function() Snacks.picker.resume() end, desc = "Resume", },
    { "<leader>;", function() Snacks.picker.commands({ layout = "vscode", title = "Builtin Commands" }) end, desc = "Commands", },
    { "<leader>g/", function() Snacks.picker.grep_word({ layout = "vertical" }) end, desc = "Grep (current word)", },
    { "<leader>/", function() Snacks.picker.grep({ layout = "vertical", cwd = require("custom.utils").get_dir_with_fallback() }) end, desc = "Grep", },
    { "<S-Tab>", "<C-w><C-p>", }, -- this fixes <tab> in preview window
    -- stylua: ignore end
    {
      "<leader>F",
      function()
        if vim.fn.executable("zoxide") ~= 1 then
          return vim.notify("Zoxide is not installed", vim.log.levels.WARN)
        end
        Snacks.picker.zoxide({
          title = "Projects",
          -- load session at directory
          confirm = function(picker, item)
            picker:close()
            vim.fn.chdir(item._path)
            local session = Snacks.dashboard.sections.session()
            if session then
              vim.cmd(session.action:sub(2))
              vim.notify("Loading Session at: " .. vim.fn.fnamemodify(item._path, ":~"), "info")
            end
          end,
        })
      end,
      desc = "Projects",
    },
    {
      "<leader>j",
      function()
        if vim.fn.executable("zoxide") ~= 1 then
          return vim.notify("Zoxide is not installed", vim.log.levels.WARN)
        end
        Snacks.picker.zoxide({
          title = "Jump picker to...",
          confirm = function(picker, item)
            Snacks.picker.files({
              cwd = item._path,
              title = vim.fn.fnamemodify(item._path, ":~"),
              hidden = true,
            })
            picker:close()
          end,
        })
      end,
      desc = "Jump with Zoxide",
    },
    {
      "<leader>sH",
      function()
        Snacks.picker.grep({
          title = "Help Grep",
          glob = { "**/doc/*.txt" },
          rtp = true,
          previewers = { file = { ft = "help" } },
        })
      end,
      desc = "Help Grep",
    },
    {
      "<leader>fw",
      function()
        ---@diagnostic disable-next-line: missing-fields
        local dir = require("custom.utils").get_dir_with_fallback()
        Snacks.picker.grep({ cwd = dir, title = "Files in " .. vim.fn.fnamemodify(dir, ":~") })
      end,
      desc = "Grep (buffer dir)",
    },
    {
      "<leader>fh",
      function()
        local dir = require("custom.utils").get_dir_with_fallback()
        ---@diagnostic disable-next-line: missing-fields
        Snacks.picker.files({ cwd = dir, title = "Files in " .. vim.fn.fnamemodify(dir, ":~") })
      end,
      desc = "Here (buffer dir)",
    },
    {
      "<leader>st",
      function()
        ---@diagnostic disable-next-line: undefined-field
        Snacks.picker.todo_comments({
          cwd = require("custom.utils").get_dir_with_fallback(),
        })
      end,
      desc = "Todo",
    },
    {
      "<leader>sT",
      function()
        local dir = require("custom.utils").get_dir_with_fallback()
        ---@diagnostic disable-next-line: undefined-field
        Snacks.picker.todo_comments({
          title = "Todo Comments in " .. vim.fn.fnamemodify(dir, ":~"),
          keywords = { "TODO", "FIX", "FIXME" },
          cwd = dir,
        })
      end,
      desc = "Todo/Fix/Fixme",
    },
  },
}
