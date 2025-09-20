-- fast file system viewer, less intrusive oil.nvim
return {
  "nvim-mini/mini.files",
  event = "LazyFile",
  keys = {
    -- open mini.files in current buffer's directory, if error is thrown fallback to cwd
    {
      "<leader>e",
      function()
        require("mini.files").open(require("custom.utils").get_dir_with_fallback(vim.fn.expand("%:t")))
      end,
      desc = "Explore",
    },
    {
      "<leader>E",
      function()
        require("mini.files").open()
      end,
      desc = "Explore (cwd)",
    },
  },
  opts = {
    windows = {
      preview = true,
      width_focus = 30,
      width_preview = 30,
    },
    mappings = {
      go_in_plus = "<CR>",
      go_in_horizontal_plus = "_",
      go_in_vertical_plus = "|",
      go_home = "gh",
      go_here = "gH",
      go_config = "gc",
    },
    options = {
      permanent_delete = false, -- files are sent to ~/.local/share/nvim/mini.files/trash when true
      use_as_default_explorer = true, -- for nvim .
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
    -- don't center motions in mini.files
    vim.api.nvim_create_autocmd({ "FileType" }, {
      pattern = { "minifiles" },
      callback = function()
        vim.keymap.set("n", "<C-d>", "<C-d>", { remap = false, buffer = true })
        vim.keymap.set("n", "<C-u>", "<C-u>", { remap = false, buffer = true })
      end,
    })

    require("mini.files").setup(opts)

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
      require("mini.files").refresh({ content = { filter = new_filter } })
    end

    local map_split = function(buf_id, lhs, direction, close_on_file)
      local rhs = function()
        local new_target_window
        local cur_target_window = require("mini.files").get_explorer_state().target_window
        if cur_target_window ~= nil then
          vim.api.nvim_win_call(cur_target_window, function()
            vim.cmd("belowright " .. direction .. " split")
            new_target_window = vim.api.nvim_get_current_win()
          end)

          require("mini.files").set_target_window(new_target_window)
          require("mini.files").go_in({ close_on_file = close_on_file })
        end
      end

      local desc = "Open in " .. direction .. " split"
      if close_on_file then
        desc = desc .. " and close"
      end
      vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        local buf_id = args.data.buf_id

        -- g. to toggle hidden files
        vim.keymap.set(
          "n",
          opts.mappings and opts.mappings.toggle_hidden or "g.",
          toggle_dotfiles,
          { buffer = buf_id, desc = "Toggle hidden files" }
        )

        -- 'gh' to change cwd to Here
        vim.keymap.set("n", opts.mappings and opts.mappings.go_here or "gH", function()
          files_set_cwd()
        end, { buffer = buf_id, desc = "Change cwd to here" })

        -- 'gd' to navigate to config directory
        vim.keymap.set("n", opts.mappings and opts.mappings.go_config or "gd", function()
          require("mini.files").open(vim.api.nvim_get_runtime_file("", true)[1])
        end, { buffer = buf_id, desc = "Go to config directory" })

        -- 'gh' to navigate to home directory
        vim.keymap.set("n", opts.mappings and opts.mappings.go_home or "gh", function()
          require("mini.files").open(vim.fn.expand("~"))
        end, { buffer = buf_id, desc = "Go to home directory" })

        map_split(buf_id, opts.mappings and opts.mappings.go_in_horizontal or "<C-w>s", "horizontal", false)
        map_split(buf_id, opts.mappings and opts.mappings.go_in_vertical or "<C-w>v", "vertical", false)
        map_split(buf_id, opts.mappings and opts.mappings.go_in_horizontal_plus or "<C-w>S", "horizontal", true)
        map_split(buf_id, opts.mappings and opts.mappings.go_in_vertical_plus or "<C-w>V", "vertical", true)
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesActionRename",
      callback = function(event)
        Snacks.rename.on_rename_file(event.data.from, event.data.to)
      end,
    })
  end,
}
