return {

  -- NOTE: search for a plugin's config with <leader>fP (or just browse this file)
  --
  -- Use `zMzr` to fold this file into more manageable chunks (this works well
  -- with the nvim-origami plugin installed). My config is in one file because
  -- file reads are SO SLOW on windows that having a scattered config slowed
  -- down my startup.
  --

  -- UI --
  { -- set my custom colorscheme (../../colors/macro.lua)
    "LazyVim/LazyVim",
    opts = { colorscheme = "macro" },
  },
  { -- lualine.nvim (statusbar)
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-mini/mini.icons" },
    init = function()
      vim.g.trouble_lualine = false
      vim.g.lualine_laststatus = 3
    end,
    opts = function()
      local icons = LazyVim.config.icons
      local opts = {
        options = {
          padding = 0,
          theme = "minimal", -- use my theme in ../lualine/themes/minimal.lua
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
                return "󰖳"
              end,
              cond = function()
                return vim.g.is_win
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
        desc = "Print current file name",
      },
    },
  },
  { -- bufferline.nvim (tab bar)
    "akinsho/bufferline.nvim",
    event = function()
      return "LazyFile"
    end,
    opts = function()
      local ignored_bt = { prompt = true, nofile = true, terminal = true, quickfix = true }
      vim.api.nvim_create_user_command("BufferLineRename", function(opts)
        local key = "BufferLineCustomName" .. vim.api.nvim_get_current_tabpage()
        vim.g[key] = opts.args ~= "" and opts.args or nil
        vim.api.nvim_exec_autocmds("User", { pattern = "BufferLineRenamed" })
      end, { nargs = "?", desc = "Rename the current tab" })

      vim.api.nvim_create_autocmd("TabClosed", {
        desc = "Clear custom tabnames on tab close",
        callback = function(args)
          vim.g["BufferLineCustomName" .. args.file] = nil
        end,
      })
      return {
        options = {
          style_preset = require("bufferline").style_preset.no_italic,
          mode = "tabs",
          tab_size = 22,
          enforce_regular_tabs = false,
          truncate_names = false,
          always_show_bufferline = true,
          show_duplicate_prefix = false,
          show_close_icon = false,
          name_formatter = function(buf)
            local name = vim.g["BufferLineCustomName" .. buf.tabnr]
            return (name and name ~= "" and name) or (buf.name == "" and ":checkhealth") or buf.name
          end,
          custom_filter = function(buf_number)
            local ft = vim.api.nvim_get_option_value("filetype", { buf = buf_number })
            local bt = vim.api.nvim_get_option_value("buftype", { buf = buf_number })
            local bh = vim.api.nvim_get_option_value("bufhidden", { buf = buf_number })
            return ft == "checkhealth" or (not ignored_bt[bt] and bh == "")
          end,
        },
      }
    end,
    keys = {
      { "<leader>bl", nil },
      { "<leader>br", nil },
      { "<leader>bp", nil },
      { "<leader>bP", nil },
      { "<C-CR>", "<cmd>tabedit<cr>", { desc = "New Tab" } },
      { "<C-Space>", "<cmd>tabedit<cr>", { desc = "New Tab" } },
      { "<C-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<C-S-tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      {
        "<leader>r",
        function()
          vim.ui.input({ prompt = "Rename tab to: " }, function(input)
            if input then
              vim.cmd("BufferLineRename " .. input)
            end
          end)
        end,
        desc = "Rename Tab",
      },

      {
        "<A-,>",
        function()
          vim.cmd(vim.fn.tabpagenr() == 1 and "tabmove" or "-tabmove")
        end,
        desc = "Move Tab Left",
      },
      {
        "<A-;>",
        function()
          vim.cmd(vim.fn.tabpagenr() == vim.fn.tabpagenr("$") and "0tabmove" or "+tabmove")
        end,
        desc = "Move Tab Right",
      },
    },
  },
  { -- noice.nvim (cmdline, other UI)
    "folke/noice.nvim",
    lazy = false,
    opts = {
      presets = { lsp_doc_border = true },
      cmdline = { view = "cmdline" },
      notify = { enabled = false },
      views = {
        mini = { win_options = { winblend = 0 } }, -- transparent lsp progress window
      },
      lsp = {
        progress = {
          format = {
            "({data.progress.percentage}%) ",
            { "{spinner} ", hl_group = "NoiceLspProgressSpinner" },
            { "{data.progress.title} ", hl_group = "NoiceLspProgressTitle" },
            { "{data.progress.client} ", hl_group = "NoiceLspProgressClient" },
          },
          format_done = {
            { "✔  ", hl_group = "NoiceLspProgressSpinner" },
            { "{data.progress.title} ", hl_group = "NoiceLspProgressTitle" },
            { "{data.progress.client} ", hl_group = "NoiceLspProgressClient" },
          },
        },
        hover = { enabled = true, silent = true },
        signature = { enabled = false },
        documentation = {
          opts = {
            win_options = { wrap = true },
            position = { row = 2 },
          },
        },
      },
    },
    config = function(_, opts)
      local noice = require("noice")
      noice.setup(opts)

      -- HACK: prevents Noice from sending "cleanup" signals on exit that resize
      -- terminal (related to windows terminal bug)
      local original_disable = noice.disable
      ---@diagnostic disable-next-line: duplicate-set-field
      noice.disable = function()
        if vim.v.exiting ~= vim.NIL then
          return
        end
        original_disable()
      end
    end,
    keys = {
      { "<leader>snt", nil },
      { "<leader>sna", nil },
      { "<leader>snh", nil },
      { "<leader>snl", nil },
      { "<leader>sn", nil },
      { "<leader>snd", nil },
      {
        "<leader>n",
        function()
          require("noice").cmd("all")
        end,
        desc = "Noice/Messages",
      },
    },
  },
  { -- which-key.nvim (keymap help)
    "folke/which-key.nvim",
    opts = {
      filter = function(mapping) -- exclude mappings without a description
        return mapping.desc ~= "" and mapping.desc
      end,
      show_help = false,
      plugins = {
        marks = true,
        spelling = false,
        presets = { motions = true, operators = true },
      },
      win = {
        no_overlap = false,
        border = "rounded",
      },
      spec = {
        {
          mode = { "n", "v" },
          { "<R>", group = "run", icon = "" },
          { "<leader>q", group = "Close Window" },
          { "<leader>a", group = "+ai" },
        },
      },
    },
    keys = {
      { "<leader>K", nil },
      { "<leader><Tab><Tab>", nil },
      { "<leader><Tab>]", nil },
      { "<leader><Tab>[", nil },
      { "<leader><Tab>f", nil },
      { "<leader><Tab>d", nil },
      { "<leader><Tab>l", nil },
      { "<leader><Tab>l", nil },
      { "<leader>-", nil },
      { "<leader>w-", nil },
      { "<leader>w|", nil },
      { "<leader>|", nil },
      { "<leader>bb", nil },
      { "<leader>bD", nil },
      { "<leader>qq", nil },
    },
  },
  { -- gitsigns (git in statuscolumn)
    "gitsigns.nvim",
    opts = {
      preview_config = {
        border = "rounded",
      },
    },
  },
  { -- mini.files (file explorer)
    "nvim-mini/mini.files",
    keys = {
      -- open mini.files in current buffer's directory, if error is thrown fallback to cwd
      {
        "<leader>e",
        function()
          require("mini.files").open(require("custom.utils").get_dir_with_fallback(vim.fn.expand("%:t")))
        end,
        desc = "Explore",
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("BufEnter", {
        desc = "Start Mini-Files with directory",
        once = true,
        callback = function()
          if package.loaded["mini.files"] then
            return
          else
            local stats = vim.uv.fs_stat(tostring(vim.fn.argv(0)))
            if stats and stats.type == "directory" then
              require("mini.files").open()
            end
          end
        end,
      })
    end,
    config = function(_, opts)
      local mini_files = require("mini.files")
      local show_dotfiles = true
      ---@diagnostic disable-next-line: unused-local
      local filter_show = function(fs_entry)
        return true
      end
      local filter_hide = function(fs_entry)
        return not vim.startswith(fs_entry.name, ".")
          and not vim.endswith(fs_entry.name, ".jprf")
          and not vim.endswith(fs_entry.name, ".prf")
          and not vim.endswith(fs_entry.name, ".prf~")
          and not vim.endswith(fs_entry.name, ".jprf")
      end

      local files_set_cwd = function()
        local cur_entry_path = MiniFiles.get_fs_entry().path
        local cur_directory = vim.fs.dirname(cur_entry_path)
        if cur_directory ~= nil then
          vim.fn.chdir(cur_directory)
        end
        vim.notify(vim.fn.fnamemodify(vim.fn.getcwd(), ":~"), vim.log.levels.INFO, {})
      end

      local toggle_dotfiles = function()
        show_dotfiles = not show_dotfiles
        local new_filter = show_dotfiles and filter_show or filter_hide
        mini_files.refresh({ content = { filter = new_filter } })
      end

      -- open file in new tab
      local map_tab = function(buf_id, lhs)
        local rhs = function()
          local cur_entry_path = MiniFiles.get_fs_entry().path

          -- ignore if directory
          local stat = vim.loop.fs_stat(cur_entry_path)
          if stat and stat.type == "directory" then
            return
          end

          if cur_entry_path ~= nil then
            mini_files.close()
            -- create new tab and capture its window id
            vim.cmd("tabedit " .. cur_entry_path)
          end
        end

        local desc = "Open in new tab"
        vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
      end

      -- for setting up mappings to open file in split
      local map_split = function(buf_id, lhs, direction, close_on_file)
        local rhs = function()
          local new_target_window
          local cur_target_window = mini_files.get_explorer_state().target_window
          if cur_target_window ~= nil then
            vim.api.nvim_win_call(cur_target_window, function()
              vim.cmd("belowright " .. direction .. " split")
              new_target_window = vim.api.nvim_get_current_win()
            end)

            mini_files.set_target_window(new_target_window)
            mini_files.go_in({ close_on_file = close_on_file })
          end
        end

        local desc = "Open in " .. direction .. " split"
        if close_on_file then
          desc = desc .. " and close"
        end
        vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesActionRename",
        callback = function(event)
          Snacks.rename.on_rename_file(event.data.from, event.data.to)
        end,
      })

      mini_files.setup({
        options = {
          permanent_delete = false,
          use_as_default_explorer = true,
        },
        windows = {
          max_number = math.huge,
          preview = true,
          width_focus = 30,
          width_preview = 30,
        },
        mappings = {
          go_in_plus = "<CR>",
          go_out_plus = "",
          go_in_horizontal_plus = "_",
          go_in_vertical_plus = "|",
          go_home = "gh",
          go_here = "gH",
          go_config = "gc",
        },
      })

      -- setting up keymaps
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        group = vim.api.nvim_create_augroup("mini-file-buffer", { clear = true }),
        callback = function(args)
          local b = args.data.buf_id

          local map = function(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = b, desc = desc, remap = false })
          end

          map(opts.mappings and opts.mappings.toggle_hidden or "g.", toggle_dotfiles, "Toggle hidden files")
          map(opts.mappings and opts.mappings.go_here or "gH", files_set_cwd, "Go here (cwd)")
          map(opts.mappings and opts.mappings.go_config or "gd", function()
            mini_files.open(vim.api.nvim_get_runtime_file("", true)[1])
          end, "Go to config directory")
          map(opts.mappings and opts.mappings.go_home or "gh", function()
            MiniFiles.open(vim.fn.expand("~"))
          end, "Go to home directory")

          -- don't center motions
          vim.keymap.set("n", "<C-d>", "<C-d>", { remap = false, buffer = b })
          vim.keymap.set("n", "<C-u>", "<C-u>", { remap = false, buffer = b })

          -- split keymaps
          map_split(b, "_", "horizontal", false)
          map_split(b, "|", "vertical", false)
          map_tab(b, "<S-CR>")
          map_tab(b, "<C-CR>")
        end,
      })
    end,
  },
  { -- colorizer (preview color codes)
    "catgoose/nvim-colorizer.lua",
    ft = { "css", "html", "javascript", "typescriptreact", "typescript", "noice", "ghostty" },
    opts = {
      lazy_load = false,
      filetypes = {
        "*",
        noice = { always_update = true },
        blink_menu = { always_update = true },
        blink_docs = { always_update = true },
        cmp_menu = { always_update = true },
        cmp_docs = { always_update = true },
        snacks_picker_preview = { always_update = true },
      },
      -- exclude prompt and popup buftypes from highlight
      buftypes = { "!prompt", "!popup" },
      user_default_options = {
        RGB = false, -- #RGB hex codes
        RGBA = false,
        css_fn = true, -- CSS rgb(), rgba() hsl(), and hsla() functions
        names = false, -- `blue`, `red`
        tailwind = true,
        tailwind_opts = { update_names = false },
      },
    },
    keys = {
      {
        "<leader>uH",
        function()
          local attached = require("colorizer").is_buffer_attached()
          if not attached then
            require("colorizer").attach_to_buffer(0)
            vim.notify("Enabled **Colorizer Highlights**", vim.log.levels.INFO, { title = "Tabs" })
          else
            require("colorizer").detach_from_buffer(0)
            vim.notify("Disabled **Colorizer Highlights**", vim.log.levels.WARN, { title = "Tabs" })
          end
        end,
        desc = "Toggle Colorizer",
      },
    },
  },
  { -- match paren (highlight matching paren)
    "monkoose/matchparen.nvim",
    event = "LazyFile",
    opts = {},
  },
  { -- scrollEOF (don't scroll to bottom)
    "Aasim-A/scrollEOF.nvim",
    event = "VeryLazy",
    opts = {
      pattern = "*",
      disabled_filetypes = {
        "minifiles",
        "minifiles-help",
        "snacks_terminal",
        "crunner",
      },
    },
  },
  { -- todo comments (highlight todo comments)
    "folke/todo-comments.nvim",
    vscode = true,
    opts = {
      highlight = {
        comments_only = false,
        multiline = true,
      },
      keywords = {
        TODO = {
          color = "#8A9A7B",
        },
      },
    },
    keys = {
      {
        "<leader>st",
        function()
          ---@diagnostic disable-next-line: undefined-field
          Snacks.picker.todo_comments({
            cwd = LazyVim.root.get({ normalize = true }),
          })
        end,
        desc = "Todo",
      },
      {
        "<leader>sT",
        function()
          Snacks.picker.todo_comments({
            keywords = { "TODO", "FIX", "FIXME" },
            cwd = LazyVim.root.get({ normalize = true }),
          })
        end,
        desc = "Todo/Fix/Fixme",
      },
    },
  },

  -- SNACKS UI -
  { -- snacks (general)
    "folke/snacks.nvim", -- general
    opts = {
      words = { enabled = false },
      scroll = { enabled = false },
      animate = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      input = { enabled = true },
      rename = { enabled = true },
      git = { enabled = true },
      scope = { enabled = true },
      notifier = { enabled = true },
      gitbrowse = { enabled = true },
      scratch = { ft = "markdown" },
      styles = {
        scratch = { wo = { number = false, cursorline = false, statuscolumn = " ", wrap = true } },
        terminal = { wo = { winbar = "" } },
        notification = { wo = { winblend = 0 } },
        border = "rounded",
      },
      lazygit = {
        enabled = true,
        configure = not vim.g.is_win,
      },
    },
    keys = {
      { "<leader>dpp", nil },
      { "<leader>dph", nil },
      { "<leader>dps", nil },
      { "<leader>S", nil },
      { "<leader>n", nil },
      {
        "<leader>un",
        function()
          Snacks.notifier.hide()
        end,
        desc = "Dismiss All Notifications",
      },
    },
  },
  { -- snacks (dashboard)
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        width = 50,
        preset = {
          header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
          keys = {
            { icon = " ", key = "e", desc = "Explore", action = "<leader>e" },
            { icon = " ", key = "o", desc = "Open a File", action = ":lua LazyVim.pick('oldfiles')()" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua LazyVim.pick.config_files()()",
            },
            { icon = "󰑓 ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          { section = "header", padding = 1 },
          { section = "keys", gap = 1, padding = 2 },
          -- { pane = 2, section = "projects", height = 5 },
          { section = "startup" },
        },
      },
    },
  },
  { -- snacks (input UI)
    "folke/snacks.nvim",
    opts = {
      ---@type table<string, snacks.win.Config>
      styles = {
        above_cursor = {
          backdrop = false,
          position = "float",
          title_pos = "left",
          height = 1,
          noautocmd = true,
          width = 40,
          relative = "cursor",
          row = -3,
          col = 0,
          wo = {
            cursorline = false,
          },
          bo = {
            filetype = "snacksinput",
            buftype = "prompt",
          },
          --- buffer local variables
          b = {
            completion = false, -- disable blink completions in input
          },
        },
      },
      input = {
        enabled = true,
        win = {
          style = "above_cursor",
        },
      },
    },
  },
  { -- snacks (zen mode)
    "folke/snacks.nvim",
    opts = {
      styles = {
        quiet = {
          enter = true,
          fixbuf = false,
          minimal = false,
          width = 120,
          height = 0,
          backdrop = { transparent = true, blend = 0 },
          keys = { q = false },
          zindex = 40,
          wo = {
            winhighlight = "NormalFloat:Normal",
            statuscolumn = " ",
            number = false,
            cul = false,
          },
          w = {
            snacks_main = true,
          },
        },
      },
      zen = {
        enabled = true,
        backdrop = { transparent = true, blend = 0 },
        toggles = { dim = false },
        zoom = { win = { style = "zen" } },
        win = { style = "quiet" },
        on_close = function()
          vim.cmd([[set stal=1]])
        end,
        on_open = function()
          vim.cmd([[set stal=0]]) -- hide tabline/bufferline
        end,
      },
    },
    keys = {
      {
        "<leader>Z",
        function()
          Snacks.zen()
        end,
        desc = "Toggle Zen Mode",
      },
      {
        "<leader>z",
        function()
          Snacks.zen.zoom()
        end,
        desc = "Toggle Zoom",
      },
    },
  },
  { -- snacks (images)
    -- this doesn't work in windows terminal but sixel does (used in yazi)
    "folke/snacks.nvim", -- image
    ---@type snacks.Config
    opts = {
      image = {
        enabled = vim.fn.has("wsl") == 0,
        math = {
          enabled = true,
          latex = {
            font_size = "large",
          },
        },
      },
    },
  },
  { -- snacks (indent guides)
    "folke/snacks.nvim",
    opts = {
      indent = {
        enabled = true,
        indent = { enabled = true },
        scope = { enabled = true },
        animate = { enabled = false },
      },
    },
  },

  -- ICONS --
  { -- mini.icons (some overrides)
    "nvim-mini/mini.icons",
    lazy = true,
    opts = {
      default = {
        file = { glyph = "󰈤" },
      },
      extension = {
        h = { glyph = "", hl = "MiniIconsPurple" },
        pvs = { glyph = "", hl = "PVSBlue" },
        prf = { glyph = "󱇚", hl = "MiniIconsGrey" },
        prl = { glyph = "󱇚", hl = "MiniIconsGrey" },
      },
      filetype = {
        cf = { glyph = "", hl = "MiniIconsBlue" },
        mermaid = { glyph = " ", hl = "MiniIconsBlue" },
        Rmd = { glyph = "", hl = "MiniIconsBlue" },
        rmd = { glyph = "", hl = "MiniIconsBlue" },
        autohotkey = { glyph = "", hl = "MiniIconsGreen" },
        minifiles = { glyph = "", hl = "MiniIconsYellow" },
        objdump = { glyph = "󰘨" },
        matlab = { glyph = "", hl = "MiniIconsRed" },
        c = { glyph = "", hl = "MiniIconsBlue" },
      },
    },
  },
  { -- (more icon overrides)
    "LazyVim/LazyVim",
    opts = {
      icons = {
        kinds = {
          Text = "󰉿 ",
          Variable = " ",
        },
      },
    },
  },

  -- CORE FUNCTIONS --
  { -- flatten.nvim (merge instances)
    "willothy/flatten.nvim",
    cond = vim.g.is_win,
    lazy = false,
    config = true,
    opts = {
      window = { open = "tab" },
      hooks = {
        pre_open = function()
          -- if file was opened from a terminal, close that terminal
          if vim.bo.buftype == "terminal" then
            vim.api.nvim_win_close(0, false)
          end
        end,
      },
    },
  },
  { -- persistence.nvim (sessions)
    "folke/persistence.nvim",
    event = "VeryLazy",
    opts = function()
      local group = vim.api.nvim_create_augroup("titlestring", { clear = false })
      -- properly set titlestring when persistence is loaded
      vim.api.nvim_create_autocmd("User", {
        group = group,
        pattern = "PersistenceLoadPost",
        callback = function()
          require("custom.utils").set_titlestring()
        end,
      })
      return {}
    end,
    keys = {
      {
        "<leader>S",
        function()
          require("persistence").load({ last = true })
        end,
        desc = "Restore Last Session",
      },
      { "<leader>qs", nil },
      { "<leader>ql", nil },
      { "<leader>qd", nil },
      { "<leader>qS", nil },
    },
  },
  { -- nvim-origami (folds)
    "chrisgrieser/nvim-origami",
    event = "LazyFile",
    opts = {
      foldtext = {
        lineCount = {
          template = " %d",
        },
      },
    },
  },
  { -- flash.nvim (navigation)
    "folke/flash.nvim",
    dependencies = {
      {
        "folke/which-key.nvim",
        opts = {
          spec = {
            { "<BS>", desc = "Decrement Selection", mode = "x" },
            { "<CR>", desc = "Increment Selection", mode = { "x", "n" } },
          },
        },
      },
    },
    event = function()
      return {}
    end,
    opts = {
      search = {
        mode = "fuzzy",
        multi_window = false,
      },
      label = { uppercase = false },
      jump = {
        nohlsearch = true, -- clear highlight after jump
        autojump = false, -- automatically jump when there is only one match
      },
      highlight = {
        backdrop = false, -- do not dim the background
      },
      modes = {
        -- `f`, `F`, `t`, `T`, `;` and `,` motions
        char = { enabled = false },
        search = { enabled = false },
      },
      prompt = {
        win_config = {
          border = "none",
        },
      },
    },
    keys = {
      -- Simulate nvim-treesitter incremental selection
      {
        "v<cr>",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter({
            actions = {
              ["<CR>"] = "next",
              ["<BS>"] = "prev",
            },
          })
        end,
        desc = "Treesitter Incremental Selection",
      },
      {
        "<C-space>",
        mode = { "n", "o", "x" },
        false,
      },
    },
  },
  { -- nvim-spider (navigation)
    "chrisgrieser/nvim-spider",
    vscode = true,
    keys = {
      {
        "e",
        function()
          require("spider").motion("e")
        end,
        mode = { "n", "o", "x" },
      },
      {
        "w",
        function()
          require("spider").motion("w")
        end,
        mode = { "n", "o", "x" },
      },
      {
        "e",
        function()
          require("spider").motion("e")
        end,
        mode = { "n", "o", "x" },
      },
      {
        "b",
        function()
          require("spider").motion("b")
        end,
        mode = { "n", "o", "x" },
      },
      {
        "ge",
        function()
          require("spider").motion("ge")
        end,
        mode = { "n", "o", "x" },
      },
    },
  },
  { -- snacks (terminal)
    "folke/snacks.nvim", -- terminal
    opts = {
      terminal = {
        enabled = true,
        win = { keys = { nav_l = "<C-l>", nav_j = "<C-j>", nav_k = "<C-k>" } },
      },
    },
    keys = {
      -- note: this assumes your terminal can recognize the <C-/> and <C-S-/> keys
      { "<C-S-_>", nil },
      { "<C-_>", nil },
      { "<leader>ft", nil },
      { "<leader>fT", nil },
      {
        "<C-q>",
        function()
          require("snacks.terminal").toggle(nil, {
            win = { position = "bottom" },
            env = { SNACKS_TERM_ID = "bottom_terminal" },
          })
        end,
        desc = "Toggle bottom terminal",
        mode = { "n", "t" },
      },
      {
        "<C-s-/>",
        function()
          require("snacks.terminal").toggle(nil, {
            win = { position = "float", border = "rounded" },
            env = { SNACKS_TERM_ID = "floating_terminal" },
          })
        end,
        desc = "Toggle floating terminal",
        mode = { "n", "t" },
      },
      {
        "<C-?>",
        function()
          require("snacks.terminal").toggle(nil, {
            win = { position = "float", border = "rounded" },
            env = { SNACKS_TERM_ID = "floating_terminal" },
          })
        end,
        desc = "Toggle floating terminal",
        mode = { "n", "t" },
      },
    },
  },
  { -- snacks (picker)
    "folke/snacks.nvim",
    opts = {
      picker = {
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
              row = 2,
              width = 64,
              min_width = 64,
              height = 0.45,
              border = "none",
              box = "vertical",
              { win = "input", height = 1, border = "rounded", title = "{title} {live} {flags}", title_pos = "center" },
              { win = "list", border = "rounded" },
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
    { "<leader>g/", function() Snacks.picker.grep_word({ layout = "vertical", cwd = LazyVim.root.get({ normalize = true }) }) end, desc = "Grep (current word)", },
    { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
    { "<leader>gs", function() Snacks.picker.git_status({cwd = LazyVim.root.get({ normalize = true })}) end, desc = "Git Status" },
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
          -- Snacks.picker.smart()
          Snacks.picker.files({ cwd = LazyVim.root.get({ normalize = true }), title = "Picker" })
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
    },
  },
  { -- trouble.nvim (fancy qflist)
    "folke/trouble.nvim",
    keys = {
      { "<leader>xL", nil },
      { "<leader>xl", nil },
      { "<leader>xt", nil },
      { "<leader>xT", nil },
      { "<leader>xq", nil },
      { "<leader>xQ", nil },
      { "<leader>cS", nil },
      {
        "<S-CR>",
        "o",
        desc = "Select and Close",
        remap = true,
        ft = "trouble",
        buffer = true,
      },
    },
  },

  -- LANGUAGE SUPPORT --
  { -- nvim-treesitter (syntax highlighting)
    "nvim-treesitter/nvim-treesitter",
    opts = {
      indent = { enable = true },
      ensure_installed = {
        "comment",
        "css",
        "csv",
        "editorconfig",
        "git_config",
        "ssh_config",
        "todotxt",
        "markdown",
        "zsh",
        "make",
        "cmake",
        -- "objdump",
        -- "latex",
        -- "erlang",
        -- "fish",
      },
    },
  },
  { -- treesitter-context (sticky scroll)
    "nvim-treesitter/nvim-treesitter-context",
    optional = true, -- only enable if enabled by :LazyExtras
    opts = {
      -- multiwindow = true, -- Enable multiwindow support.
      highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "snacks_terminal" }, -- list of language that will be disabled
      },
    },
  },
  { -- (lazy load clangd extensions)
    "p00f/clangd_extensions.nvim",
    optional = true, -- enabled with :LazyExtras
    ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  },

  -- LSP/LINT/FORMATTING --
  { -- lspconfig (general)
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        float = {
          border = "rounded", -- rounded border around <leader>cd
        },
      },
      servers = { -- disabling lsp keymaps
        ["*"] = {
          keys = {
            -- disable <C-k> insert mode keymap for focusing signature help window
            { "<C-K>", false, mode = "i" },
            { "<leader>cA", false, mode = "n" },
            { "<leader>cc", false, mode = "n" },
            { "<leader>cC", false, mode = "n" },
            { "<M-n>", false, mode = "n" },
            { "<M-p>", false, mode = "n" },
            -- { "<leader>cR", false, mode = "n" }, -- file rename
            -- { "]]", false, mode = "n" },
            -- { "[[", false, mode = "n" },
          },
        },
        -- some python things
        ruff = { enabled = false },
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = "standard",
              },
            },
          },
        },
      },
    },
  },
  { -- lspconfig (virtual text)
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- space around dot in virt text diagnostic
      opts.diagnostics.virtual_text.prefix = " " .. opts.diagnostics.virtual_text.prefix .. " "
      return opts
    end,
  },
  { -- mason.nvim (package manager)
    "mason-org/mason.nvim",
    event = "LspAttach",
    opts = {
      ui = {
        border = "rounded",
        width = 0.8,
        height = 0.8,
      },
      ensure_installed = {},
    },
  },
  { -- conform.nvim (formatters)
    "stevearc/conform.nvim",
    opts = {
      -- formatters_by_ft = {
      -- ["c"] = { "clang-format" },
      -- ["html"] = { "superhtml" },
      -- ["zsh"] = { "beautysh" },
      -- },
      formatters = {
        beautysh = {
          append_args = { "--indent-size", "2" },
        },
      },
    },
  },
  { -- nvim-lint (linters)
    "mfussenegger/nvim-lint",
    event = "LazyFile",
    opts = {
      linters = {
        typos = {
          condition = function()
            return vim.fn.executable("typos") == 1
          end,
        },
      },
      linters_by_ft = {
        fish = { "fish" },
        ["*"] = { "typos" },
        -- Use the "*" filetype to run linters on all filetypes.
        -- ['*'] = { 'global linter' },
        -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
        -- ['_'] = { 'fallback linter' },
      },
    },
  },

  -- TEXT EDITING --
  { -- blink.cmp (completion menu)
    "saghen/blink.cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    -- build = "cargo build --release",
    opts = {
      cmdline = {
        enabled = true,
        keymap = {
          ["<C-j>"] = {
            "select_next",
            function()
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Down>", true, true, true), "n", true)
            end,
          },
          ["<C-k>"] = {
            "select_prev",
            function()
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Up>", true, true, true), "n", true)
            end,
          },
          ["<C-n>"] = {
            function()
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Down>", true, true, true), "n", true)
            end,
          },
          ["<C-p>"] = {

            function()
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Up>", true, true, true), "n", true)
            end,
          },
          ["<C-space>"] = { "show", "hide" }, -- used by neocodeium
          ["<Tab>"] = {
            "select_and_accept",
            "fallback",
          },
        },
        completion = { menu = { auto_show = true } },
        sources = function()
          local type = vim.fn.getcmdtype()
          if type == "/" or type == "?" then
            return { "buffer" }
          end
          if type == ":" or type == "@" then
            return { "cmdline" }
          end
          return {}
        end,
      },
      fuzzy = { sorts = { "exact", "score", "sort_text" } }, -- prioritize exact matches
      sources = {
        providers = {
          snippets = {
            should_show_items = function(ctx)
              return ctx.trigger.initial_kind ~= "trigger_character"
            end,
          },
          markdown = {
            name = "RenderMarkdown",
            module = "render-markdown.integ.blink",
            fallbacks = { "lsp" },
          },
          buffer = {
            opts = {
              -- get words from all active buffers for cmp list
              get_bufnrs = function()
                return vim.tbl_filter(function(bufnr)
                  return vim.bo[bufnr].buftype == ""
                end, vim.api.nvim_list_bufs())
              end,
            },
          },
          path = {
            opts = {
              show_hidden_files_by_default = true,
            },
          },
        },
      },
      completion = {
        list = {
          selection = {
            preselect = true,
            auto_insert = true,
          },
        },
        documentation = {
          window = {
            border = "rounded",
            winhighlight = "FloatBorder:FloatBorder",
          },
        },
      },
      signature = {
        enabled = true,
        trigger = {
          show_on_insert = false,
          show_on_insert_on_trigger_character = true,
        },
        window = {
          show_documentation = true,
          border = "rounded",
          winhighlight = "FloatBorder:FloatBorder",
        },
      },
      keymap = {
        ["<C-n>"] = {},
        ["<C-p>"] = {},
        ["<S-CR>"] = {},
        ["<CR>"] = {},
        ["<C-space>"] = { "show", "hide" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-CR>"] = { "select_and_accept", "fallback" }, -- for accepting from blink
        ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          "snippet_forward",
          "fallback",
        },
      },
    },
  },
  { -- mini.pairs (auto quote/bracket/paren)
    "nvim-mini/mini.pairs",
    event = function()
      return { "InsertEnter", "CmdlineEnter" }
    end,
  },
  { -- mini.move (move text)
    "nvim-mini/mini.move",
    vscode = true,
    opts = {
      mappings = {
        left = "<M-[>",
        right = "<M-]>",
        down = "<C-N>",
        up = "<C-P>",
        line_left = "<M-[>",
        line_right = "<M-]>",
        line_down = "<C-N>",
        line_up = "<C-P>",
      },
      options = {
        reindent_linewise = false,
      },
    },
    keys = {
      {
        "<C-P>",
        mode = { "n", "i", "v" },
        desc = "Move line up",
      },
      {
        "<C-N>",
        mode = { "n", "i", "v" },
        desc = "Move line down",
      },
      {
        "<M-]>",
        function()
          require("mini.move").move_line("right")
        end,
        mode = { "n", "i", "v" },
        desc = "Indent line",
      },
      {
        "<M-[>",
        function()
          require("mini.move").move_line("left")
        end,
        mode = { "n", "i", "v" },
        desc = "Un-indent line",
      },
    },
  },
  { -- comment.nvim (commenting)
    "numToStr/Comment.nvim",
    vscode = true,
    opts = {},
    keys = function()
      vim.keymap.set("", "<M-/>", "<C-/>", { remap = true })
      local function insert_mode_comment()
        local line = vim.api.nvim_get_current_line()
        if line:match("^%s*$") then
          -- do special things when on a blank line
          require("Comment.api").insert.linewise.eol()
          vim.api.nvim_feedkeys(" ", "n", false) -- delete the stray "a"
          vim.api.nvim_feedkeys("", "n", false) -- de-indent once cus the eol function does strange things
          return
        else
          local U = require("Comment.utils")
          local ft = require("Comment.ft")
          local api = vim.api
          local cs = ft.get(vim.bo.filetype, U.ctype.linewise)

          -- allow fallback to some other buffer-local <C-/> keymap if comment string
          -- is not defined (snacks.picker uses this for help keymap for example)
          if not cs then
            api.nvim_feedkeys(api.nvim_replace_termcodes("<C-/>", true, false, true), "n", false)
            return
          end

          -- i just want one thing please
          cs = (type(cs) == "table") and cs[1] or cs

          -- split & trim around '%s'
          local prefix, postfix = tostring(cs):match("^(.-)%%s(.-)$")
          prefix = prefix:match("^%s*(.-)%s*$") or ""
          postfix = postfix:match("^%s*(.-)%s*$") or ""

          -- store initial cursor + line state
          local row, old_col = unpack(api.nvim_win_get_cursor(0)) -- store initial state of the cursor
          line = api.nvim_get_current_line():match("^%s*(.-)%s*$") or ""

          local is_comment_first
          if postfix == "" then
            -- single-sided (line) comment
            is_comment_first = line:sub(1, #prefix) == prefix
          else
            -- two-sided (block) comment
            is_comment_first = line:sub(1, #prefix) == prefix and line:sub(-#postfix) == postfix
          end

          -- shift the cursor left if we are about to uncomment
          if is_comment_first then
            api.nvim_win_set_cursor(0, { row, math.max(0, old_col - (#prefix + 1)) })
          end

          require("Comment.api").toggle.linewise.current()

          -- either need to shift the cursor forwards if we just commented!
          if not is_comment_first then
            api.nvim_win_set_cursor(0, { row, math.max(0, old_col + (#prefix + 1)) })
          end
        end
      end
      return {
        {
          "<C-/>",
          function()
            require("Comment.api").toggle.linewise.current()
          end,
          mode = "n",
        },
        {
          "<C-/>",
          "<Plug>(comment_toggle_linewise_visual)gv",
          mode = "v",
        },
        {
          "<C-/>",
          -- super hacky way to insert mode commenting while retaining cursor
          -- position
          insert_mode_comment,
          mode = "i",
        },
        {
          "<C-_>",
          -- super hacky way to insert mode commenting while retaining cursor
          -- position
          insert_mode_comment,
          mode = "i",
        },
        -- some terminals read <C-/> as <C-_>, so define those as well
        {
          "<C-_>",
          function()
            require("Comment.api").toggle.linewise.current()
          end,
          mode = "n",
        },
        {
          "<C-_>",
          "<Plug>(comment_toggle_linewise_visual)gv",
          mode = "v",
        },
      }
    end,
  },
  { -- ts-autotag (auto close html tags)
    "windwp/nvim-ts-autotag",
    event = function()
      return {}
    end,
    optional = true,
    ft = {
      "astro",
      "typescriptreact",
      "dot",
      "glimmer",
      "handlebars",
      "html",
      "javascript",
      "jsx",
      "liquid",
      "vento",
      "markdown",
      "php",
      "rescript",
      "svelte",
      "tsx",
      "twig",
      "typescript",
      "vue",
      "xml",
    },
  },
  { -- mini.ai (text objects)
    "nvim-mini/mini.ai",
    event = "LazyFile",
    opts = {
      custom_textobjects = {
        s = {
          {
            -- __-1, __-U, __-l, __-1_, __-U_, __-l_
            "[^_%-]()[_%-]+()%w()()[%s%p]",
            "^()[_%-]+()%w()()[%s%p]",
            -- __-123SNAKE
            "[^_%-]()[_%-]+()%d+%u[%u%d]+()()",
            "^()[_%-]+()%d+%u[%u%d]+()()",
            -- __-123snake
            "[^_%-]()[_%-]+()%d+%l[%l%d]+()()",
            "^()[_%-]+()%d+%l[%l%d]+()()",
            -- __-SNAKE, __-SNAKE123
            "[^_%-]()[_%-]+()%u[%u%d]+()()",
            "^()[_%-]+()%u[%u%d]+()()",
            -- __-snake, __-Snake, __-snake123, __-Snake123
            "[^_%-]()[_%-]+()%a[%l%d]+()()",
            "^()[_%-]+()%a[%l%d]+()()",
            -- UPPER, UPPER123, UPPER-__, UPPER123-__
            -- No support: 123UPPER
            "[^_%-%u]()()%u[%u%d]+()[_%-]*()",
            "^()()%u[%u%d]+()[_%-]*()",
            -- UPlower, UPlower123, UPlower-__, UPlower123-__
            "%u%u()()[%l%d]+()[_%-]*()",
            -- lower, lower123, lower-__, lower123-__
            "[^_%-%w]()()[%l%d]+()[_%-]*()",
            "^()()[%l%d]+()[_%-]*()",
            -- Camel, Camel123, Camel-__, Camel123-__
            "[^_%-%u]()()%u[%l%d]+()[_%-]*()",
            "^()()%u[%l%d]+()[_%-]*()",
          },
        },
      },
    },
  },
  { -- ts-node-action (fancy treesitter things)
    "ckolkey/ts-node-action",
    vscode = true,
    keys = {
      {
        "m",
        function()
          local save_cursor = vim.fn.getpos(".")
          pcall(function()
            require("ts-node-action").node_action()
          end)
          vim.fn.setpos(".", save_cursor)
        end,
        { desc = "Node Action" },
      },
    },
  },

  -- MARKDOWN SUPPORT --
  { -- markdown-plus.nvim (better editing)
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
  { -- render-markdown.nvim (editor preview)
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
  { -- peek.nvim (external preview)
    "fmorroni/peek.nvim",
    branch = "my-main",
    cond = vim.g.full_config,
    cmd = { "PeekOpen", "PeekClose" },
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
        theme = "light",
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

  -- AI --
  { -- codecompanion.nvim (kinda meh)
    "olimorris/codecompanion.nvim",
    dependencies = { "saghen/blink.cmp" },
    cmd = "CodeCompanion", -- allow the abbreviation :cc to load the plugin
    cond = vim.g.full_config,
    opts = {
      display = {
        chat = {
          intro_message = "  What can I help with? (Press ? for options)",
          show_references = true,
          show_header_separator = false,
          show_settings = true,
          window = {
            width = 0.4,
            opts = {
              relativenumber = false,
              number = false,
              statuscolumn = "  ",
            },
          },
        },
      },

      strategies = {
        chat = {
          adapter = "copilot",
          tools = {
            opts = {
              auto_submit_errors = true,
              auto_submit_success = true,
            },
          },
          slash_commands = {
            ["buffer"] = {
              keymaps = {
                modes = {
                  i = "<C-b>",
                  n = { "<C-b>" },
                },
              },
            },
            ["file"] = {
              keymaps = {
                modes = {
                  i = "<C-f>",
                  n = { "<C-f>" },
                },
              },
            },
          },
        },
        inline = { adapter = "copilot" },
        cmd = { adapter = "copilot" },
      },
    },
    config = function(_, opts)
      require("codecompanion").setup(opts)

      -- vim.cmd([[cab cc CodeCompanion]]) -- works in visual mode too!
      -- vim.cmd([[cab cmd CodeCompanionCmd]])

      -- https://github.com/olimorris/codecompanion.nvim/discussions/813#discussioncomment-13081665
      local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
      local group = vim.api.nvim_create_augroup("CodeCompanionFidgetHooks", { clear = true })
      vim.api.nvim_create_autocmd({ "User" }, {
        pattern = "CodeCompanion*",
        group = group,
        callback = function(request)
          if
            request.match == "CodeCompanionChatSubmitted"
            or request.match == "CodeCompanionContextChanged"
            or request.match == "CodeCompanionChatCreated"
            or request.match == "CodeCompanionChatOpened"
            or request.match == "CodeCompanionChatModel"
            or request.match == "CodeCompanionChatAdapter"
            or request.match == "CodeCompanionChatClosed"
            or request.match == "CodeCompanionChatHidden"
          then
            return
          end
          local msg
          msg = "[CodeCompanion] " .. request.match:gsub("CodeCompanion", "")
          vim.notify(msg, "info", {
            timeout = 1000,
            keep = function()
              return not vim
                .iter({ "Finished", "Opened", "Hidden", "Closed", "Cleared", "Created" })
                :fold(false, function(acc, cond)
                  return acc or vim.endswith(request.match, cond)
                end)
            end,
            id = "code_companion_status",
            title = "Code Companion Status",
            opts = function(notif)
              notif.icon = ""
              if vim.endswith(request.match, "Started") then
                ---@diagnostic disable-next-line: undefined-field
                notif.icon = spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
              elseif vim.endswith(request.match, "Finished") then
                notif.icon = " "
              end
            end,
          })
        end,
      })
      vim.api.nvim_create_autocmd({ "User" }, {
        pattern = "CodeCompanionInlineFinished",
        group = group,
        callback = function(request)
          vim.lsp.buf.format({ bufnr = request.buf })
        end,
      })
    end,
    keys = {
      {
        "<leader>k",
        ":CodeCompanion<cr>",
        desc = "Prompt AI",
        mode = { "n", "x" },
      },
      {
        "<leader>a",
        function()
          require("codecompanion").chat()
        end,
        desc = "AI Chat",
        mode = "n",
      },
      {
        "<leader>a",
        function()
          require("codecompanion").chat()
          vim.cmd([[normal! o]])
          vim.cmd([[normal! o]])
        end,
        desc = "Add to New AI Chat",
        mode = "v",
      },
      {
        "<C-l>",
        function()
          ---@diagnostic disable-next-line: missing-parameter
          require("codecompanion").add()
        end,
        mode = "v",
        desc = "Add to Existing AI Chat",
      },
    },
  },

  --  DISABLED PLUGINS --
  { -- search and replace i don't use
    "MagicDuck/grug-far.nvim",
    cond = false,
  },
  { -- tree style file explorer (ew)
    "nvim-neo-tree/neo-tree.nvim", -- mini files better
    cond = false,
  },
  { -- unused colorscheme
    "folke/tokyonight.nvim",
    cond = false,
  },
  { -- unused colorscheme
    "catppuccin",
    cond = false,
  },
}
