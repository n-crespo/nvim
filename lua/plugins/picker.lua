return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      db = {
        sqlite3_path = "/lib/x86_64-linux-gnu/libsqlite3.so.0.8.6",
      },
      sources = { files = { hidden = true, ignored = false } },
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
            ["<C-BS>"] = { "<c-s-w>", mode = { "i" }, expr = true, desc = "delete word" },

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
            ["<D-o>"] = { "toggle_maximize", mode = { "i", "n" } },
            ["<a-i>"] = { "toggle_ignored", mode = { "i", "n" } },
            ["<D-i>"] = { "toggle_ignored", mode = { "i", "n" } },
            ["<a-.>"] = { "toggle_hidden", mode = { "i", "n" } },
            ["<D-.>"] = { "toggle_hidden", mode = { "i", "n" } },
            ["<a-p>"] = { "toggle_preview", mode = { "i", "n" } },
            ["<D-p>"] = { "toggle_preview", mode = { "i", "n" } },
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
          -- wo = { number = false, statuscolumn = " " },
        },
      },
    },
  },
  keys = {
    -- stylua: ignore start
    { "<leader>sg", nil },
    { "<leader>fb", nil },
    { "<leader>fB", nil },
    { "<leader>fr", nil },
    { "<leader>ff", nil },
    { "<leader>sc", nil },
    { "<leader>sC", nil },
    { "<leader>sG", nil },
    { "<leader>sl", nil },
    { '<leader>s"', nil },
    { "<leader>sd", nil },
    { "<leader>sD", nil },
    { "<leader>s/", nil },
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
    { "<leader>:", nil },
    { "<leader>sR", nil },
    { "<leader>sq", nil }, -- quickfix list
    { "<leader>gp", nil }, -- github pull requests
    { "<leader>gP", nil },
    { "<leader>gi", nil }, -- github issues
    { "<leader>gI", nil },
    { "<leader>gG", nil }, -- lazygit cwd
    { "<leader>fo", function() Snacks.picker.recent() end, desc = "Old Files (dumb)", },
    { "<leader>fO", function() Snacks.picker.smart() end, desc = "Old Files (smart)", },
    { "<leader>fp", function() Snacks.picker.files({ cwd = require("lazy.core.config").options.root, title = "Plugin Files" }) end, desc = "Plugin Files", },
    { "<leader>fP", function() Snacks.picker.lazy({ title = "Plugin Configs" }) end, desc = "Plugin Configs", },
    { "<leader>sp", function() Snacks.picker.pickers() end, desc = "Pickers", },
    { "<leader>cl", function() Snacks.picker.lsp_config() end, desc = "Lsp Info", },
    { "<leader>sr", function() Snacks.picker.resume() end, desc = "Resume", },
    { "<leader>s;", function() Snacks.picker.commands({ layout = "vscode", title = "Commands" }) end, desc = "Commands", },
    { "<leader>g/", function() Snacks.picker.grep_word({ layout = "vertical", cwd = require("custom.utils").get_dir_with_fallback() }) end, desc = "Grep (current word)", },
    { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
    -- { "<leader><space>", function() Snacks.picker.smart() end, desc = "Find File" },
    -- { "<M-p>", function() Snacks.picker.files({ layout = "vscode", cwd = require("custom.utils").get_dir_with_fallback() }) end, desc = "Pick", },
    { "<S-Tab>", "<C-w><C-p>", }, -- this fixes <tab> in preview window
    -- stylua: ignore end
    {
      "<leader>ff",
      function()
        local dir = vim.fn.expand("%:p:h")
        ---@diagnostic disable-next-line: missing-fields
        Snacks.picker.files({ cwd = dir, title = "Files (buffer dir)" })
      end,
      desc = "Files (buffer dir)",
    },
    {
      "<leader><space>",
      function()
        if vim.g.full_config then
          Snacks.picker.smart()
        else
          local dir = vim.fn.expand("%:p:h")
          ---@diagnostic disable-next-line: missing-fields
          Snacks.picker.files({ cwd = dir, title = "Files (buffer dir)" })
        end
      end,
    },
    {
      "<leader>F",
      function()
        if vim.fn.executable("zoxide") ~= 1 then
          return vim.notify("Zoxide is not installed", vim.log.levels.WARN)
        end
        Snacks.picker.zoxide({
          title = "Projects",
          confirm = function(picker, item)
            if item then
              vim.fn.chdir(item._path)
              local session = Snacks.dashboard.sections.session()
              if session then
                vim.cmd(session.action:sub(2))
                vim.notify("Loading Session at: " .. vim.fn.fnamemodify(item._path, ":~"), "info")
              end
            end
            picker:close()
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
          title = "Jump picker to",
          confirm = function(picker, item)
            if item then
              Snacks.picker.files({
                cwd = item._path,
                title = vim.fn.fnamemodify(item._path, ":~"),
                hidden = true,
              })
            end
            picker:close()
          end,
        })
      end,
      desc = "Jump with Zoxide",
    },
    -- {
    --   "<leader>sH",
    --   function()
    --     Snacks.picker.grep({
    --       title = "Help Grep",
    --       glob = { "**/doc/*.txt" },
    --       rtp = true,
    --       previewers = { file = { ft = "help" } },
    --     })
    --   end,
    --   desc = "Help Grep",
    -- },
    -- {
    --   "<leader>st",
    --   function()
    --     ---@diagnostic disable-next-line: undefined-field
    --     Snacks.picker.todo_comments({
    --       cwd = require("custom.utils").get_dir_with_fallback(),
    --     })
    --   end,
    --   desc = "Todo",
    -- },
    -- {
    --   "<leader>sT",
    --   function()
    --     local dir = require("custom.utils").get_dir_with_fallback()
    --     ---@diagnostic disable-next-line: undefined-field
    --     Snacks.picker.todo_comments({
    --       title = "Todo Comments in " .. vim.fn.fnamemodify(dir, ":~"),
    --       keywords = { "TODO", "FIX", "FIXME" },
    --       cwd = dir,
    --     })
    --   end,
    --   desc = "Todo/Fix/Fixme",
    -- },
  },
}
