local mini_files = require("minifiles")
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

    map("g.", toggle_dotfiles, "Toggle hidden files")
    map("gH", files_set_cwd, "Go here (cwd)")
    map("gd", function()
      mini_files.open(vim.api.nvim_get_runtime_file("", true)[1])
    end, "Go to config directory")
    map("gh", function()
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

vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Start Mini-Files with directory",
  once = true,
  callback = function()
    if package.loaded["minifiles"] then
      return
    else
      local stats = vim.uv.fs_stat(tostring(vim.fn.argv(0)))
      if stats and stats.type == "directory" then
        require("minifiles").open()
      end
    end
  end,
})

vim.keymap.set("n", "<leader>e", function() require("minifiles").open(require("custom.utils").get_dir_with_fallback(vim.fn.expand("%:t"))) end)
