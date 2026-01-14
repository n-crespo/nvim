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

    local CONFIG = {
      width_focus = 30,
      width_nofocus = 30,
      width_nofocus_detailed = 30,
      width_preview = 30,
      sort_limit = 100, -- Max files before disabling details/sorting
      sort_warning_cd = 2000, -- Cooldown for warnings (ms)
      cache_limit = 1000, -- Max No. of dir to be cached
    }

    local STATE = {
      show_details = false,
      sort_mode = "date", -- "name" | "date" | "size"
      last_warn_time = 0,
    }

    local STAT_CACHE = {} -- Map: path -> fs_stat
    local CACHED_DIRS = {} -- Set: dir_path -> boolean
    local CACHE_DIR_COUNT = 0 -- Counter for cached directories
    local LARGE_DIRS = {} -- Set: dir_path -> boolean (Too large for details)

    -- Clear cache (used on close, overflow, or synchronize)
    local clear_cache = function()
      STAT_CACHE = {}
      CACHED_DIRS = {}
      LARGE_DIRS = {}
      CACHE_DIR_COUNT = 0
    end

    local ensure_stats = function(fs_entries)
      if #fs_entries == 0 then
        return
      end

      local dir_path = vim.fs.dirname(fs_entries[1].path)

      if not CACHED_DIRS[dir_path] then
        if CACHE_DIR_COUNT >= CONFIG.cache_limit then
          clear_cache()
        end
        CACHED_DIRS[dir_path] = true
        CACHE_DIR_COUNT = CACHE_DIR_COUNT + 1
      end

      for _, entry in ipairs(fs_entries) do
        if not STAT_CACHE[entry.path] then
          STAT_CACHE[entry.path] = vim.uv.fs_stat(entry.path)
        end
      end
    end

    -- formatter for size detail
    local format_size = function(size)
      if not size then
        return ""
      end
      if size < 1024 then
        return string.format("%3dB", size)
      elseif size < 1048576 then
        return string.format("%3.0fK", size / 1024)
      else
        return string.format("%3.0fM", size / 1048576)
      end
    end

    -- formatter for modified time detail
    local format_time = function(time)
      if not time then
        return ""
      end
      return os.date("%y-%m-%d %H:%M", time.sec)
    end

    -- prefix thing?
    local my_pre_prefix = function(fs_stat)
      if not fs_stat then
        return ""
      end
      local parts = {}
      local mtime = format_time(fs_stat.mtime)
      if mtime ~= "" then
        table.insert(parts, mtime)
      end

      if fs_stat.type == "file" then
        local size = format_size(fs_stat.size)
        if size ~= "" then
          table.insert(parts, size)
        end
      end

      if #parts == 0 then
        return ""
      end
      return table.concat(parts, " ")
    end
    local my_prefix = function(fs_entry)
      if not STATE.show_details then
        return mini_files.default_prefix(fs_entry)
      end

      local fs_stat = STAT_CACHE[fs_entry.path]
      -- Fallback: In case fs_stat is missing (due to cache clearance), fetch now
      local parent_dir = vim.fs.dirname(fs_entry.path)
      if not fs_stat and not LARGE_DIRS[parent_dir] then
        fs_stat = vim.uv.fs_stat(fs_entry.path)
        STAT_CACHE[fs_entry.path] = fs_stat
      end

      local prefix, hl = mini_files.default_prefix(fs_entry)

      local pre_prefix = "..."
      if not LARGE_DIRS[parent_dir] then
        pre_prefix = my_pre_prefix(fs_stat)
      end

      if pre_prefix == "" then
        return prefix, hl
      end
      return pre_prefix .. " " .. prefix, hl
    end

    -- sorts the things
    local sorter = function(fs_entries, fs_accessor)
      table.sort(fs_entries, function(a, b)
        -- 1. Directories always come first and sorted by name
        if a.fs_type ~= b.fs_type then
          return a.fs_type == "directory"
        end
        if a.fs_type == "directory" then
          return a.name:lower() < b.name:lower()
        end
        -- 2. Files are sorted using the fs_accessor
        local stat_a = STAT_CACHE[a.path]
        local stat_b = STAT_CACHE[b.path]

        local val_a = stat_a and fs_accessor(stat_a) or 0
        local val_b = stat_b and fs_accessor(stat_b) or 0
        return val_a > val_b
      end)
      return fs_entries
    end

    -- custom sort the things
    local custom_sort = function(fs_entries)
      if #fs_entries == 0 then
        return fs_entries
      end

      local dir_path = vim.fs.dirname(fs_entries[1].path)

      -- 1. Check if Active Directory
      local explorer = mini_files.get_explorer_state()
      local is_active = false
      if explorer then
        local focused_dir = explorer.branch[explorer.depth_focus]
        if dir_path == focused_dir then
          is_active = true
        end
      end

      -- 2. Check if the dir too big
      if #fs_entries > CONFIG.sort_limit then
        -- if file_count > CONFIG.sort_limit then
        LARGE_DIRS[dir_path] = true

        if is_active and STATE.sort_mode ~= "name" then
          local now = vim.uv.now()
          if (now - STATE.last_warn_time) > CONFIG.sort_warning_cd then
            vim.notify(
              "Directory too large (" .. #fs_entries .. " > " .. CONFIG.sort_limit .. "). Sorting aborted.",
              vim.log.levels.WARN
            )
            STATE.last_warn_time = now
          end
        end

        return mini_files.default_sort(fs_entries)
      else
        LARGE_DIRS[dir_path] = nil
      end

      local mode_to_use = is_active and STATE.sort_mode or "name"

      if STATE.show_details or mode_to_use ~= "name" then
        ensure_stats(fs_entries)
      end

      -- 3. perform sorting
      if mode_to_use == "size" then
        return sorter(fs_entries, function(s)
          return s.size
        end)
      elseif mode_to_use == "date" then
        return sorter(fs_entries, function(s)
          return s.mtime.sec
        end)
      else
        return mini_files.default_sort(fs_entries)
      end
    end

    local toggle_details = function()
      STATE.show_details = not STATE.show_details
      local new_width = STATE.show_details and CONFIG.width_nofocus_detailed or CONFIG.width_nofocus
      mini_files.refresh({
        windows = { width_nofocus = new_width },
        content = { prefix = my_prefix },
      })
    end

    local set_sort = function(mode)
      if STATE.sort_mode == mode then
        return
      end
      STATE.sort_mode = mode

      local msg = "Sort: Name (A-Z)"
      if mode == "size" then
        msg = "Sort: Size (Descending)"
      end
      if mode == "date" then
        msg = "Sort: Date (Newest)"
      end

      vim.notify(msg, vim.log.levels.INFO)
      mini_files.refresh({ content = { sort = custom_sort } })
    end

    local safe_synchronize = function()
      mini_files.synchronize()
      clear_cache()
      -- vim.notify("Synchronized & Cache Cleared", vim.log.levels.INFO)
    end

    mini_files.setup({
      options = {
        permanent_delete = false,
        use_as_default_explorer = true,
      },
      windows = {
        max_number = math.huge,
        preview = true,
        width_focus = CONFIG.width_focus,
        width_nofocus = CONFIG.width_nofocus_detailed,
        width_preview = CONFIG.width_preview,
        --   preview = true,
        --   width_focus = 30,
        --   width_preview = 30,
      },
      content = { prefix = my_prefix, sort = custom_sort },
      mappings = {
        go_in_plus = "<CR>",
        go_in_horizontal_plus = "_",
        go_in_vertical_plus = "|",
        go_home = "gh",
        go_here = "gH",
        go_config = "gc",
      },
    })

    -- Navigation Wrappers
    local go_in_reset = function()
      STATE.sort_mode = "name"
      mini_files.go_in()
    end
    local go_out_reset = function()
      STATE.sort_mode = "name"
      mini_files.go_out()
    end
    local go_in_plus_reset = function()
      STATE.sort_mode = "name"
      mini_files.go_in({ close_on_file = true })
    end

    -- cache clearing
    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesWindowClose",
      callback = function()
        clear_cache()
      end,
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

        map("l", go_in_reset, "Go in (Reset Sort)")
        map("h", go_out_reset, "Go out (Reset Sort)")
        map("<CR>", go_in_plus_reset, "Go in plus (Reset Sort)")

        map(opts.mappings and opts.mappings.toggle_hidden or "g.", toggle_dotfiles, "Toggle hidden files")
        map(opts.mappings and opts.mappings.go_here or "gH", files_set_cwd)
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
        map_split(b, opts.mappings and opts.mappings.go_in_horizontal or "_", "horizontal", false)
        map_split(b, opts.mappings and opts.mappings.go_in_vertical or "|", "vertical", false)
        map_split(b, opts.mappings and opts.mappings.go_in_horizontal_plus or "<C-w>S", "horizontal", true)
        map_split(b, opts.mappings and opts.mappings.go_in_vertical_plus or "<C-w>V", "vertical", true)

        map(",,", toggle_details, "Toggle file details")
        map(",s", function()
          set_sort("size")
        end, "Sort by Size")
        map(",m", function()
          set_sort("date")
        end, "Sort by Modified")
        map(",a", function()
          set_sort("name")
        end, "Sort by Name")

        map("=", safe_synchronize, "Synchronize & Clear Cache")
      end,
    })
  end,
}
