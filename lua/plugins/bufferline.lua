-- called bufferline but i use it for tabs

local ignored_bt = { prompt = true, nofile = true, terminal = true, quickfix = true }

-- returns true if picker is open (don't want tabline changing)
local function picker_open()
  local P = package.loaded["snacks.picker.core.picker"]
  return P and #P.get() > 0
end

-- setup :BufferLineRename
vim.api.nvim_create_user_command("BufferLineRename", function(opts)
  local current_tab = vim.api.nvim_get_current_tabpage()
  if opts.args == "" then
    vim.g["BufferLineCustomName" .. current_tab] = nil
  else
    vim.g["BufferLineCustomName" .. current_tab] = opts.args
  end
end, {
  nargs = "?",
  desc = "Rename the current tab",
})

return {
  "n-crespo/bufferline.nvim",
  event = "VeryLazy",
  dev = { false },
  opts = {
    options = {
      mode = "tabs",
      tab_size = 10,
      enforce_regular_tabs = false,
      indicator = { style = "none" },
      -- hide things
      show_duplicate_prefix = true,
      default_duplicate_prefix = "",
      show_tab_indicators = false,
      always_show_bufferline = true,
      show_close_icon = false,
      show_buffer_close_icons = false,
      show_buffer_icons = false,
      diagnostics = false,
      themable = false,
      modified_icon = "",
      separator_style = { "", "" },
      style_preset = require("bufferline").style_preset.no_italic,

      name_formatter = function(buf)
        local tabnr = buf.tabnr
        local custom_name = vim.g["BufferLineCustomName" .. tabnr]
        local name
        if custom_name and custom_name ~= "" then
          name = custom_name
        else
          name = buf.name
        end
        vim.opt.title = true
        if vim.api.nvim_win_get_tabpage(0) == tabnr then
          vim.opt.titlestring = name
        end
        return name
      end,

      numbers = function(opts)
        -- use the :h tabpagenr() instead of :h tabpageid
        local tabpagenr = vim.fn.index(vim.api.nvim_list_tabpages(), opts.id) + 1
        return string.format("%s", opts.raise(tabpagenr))
      end,

      -- don'd update tabline with random floating windows
      custom_filter = function(buf_number)
        if
          ignored_bt[vim.api.nvim_get_option_value("buftype", { buf = buf_number })]
          or vim.api.nvim_get_option_value("bufhidden", { buf = buf_number }) ~= ""
          or vim.api.nvim_buf_get_name(buf_number) == ""
          or vim.api.nvim_get_option_value("filetype", { buf = buf_number }) == "snacks_dashboard"
          or picker_open()
        then
          return false
        end
        return true
      end,
    },
    -- show selected tab with TabLineSel bg highlights
    highlights = {
      tab_selected = {
        underline = true,
        bg = {
          attribute = "bg",
          highlight = "TabLineSel",
        },
        fg = {
          attribute = "fg",
          highlight = "TabLineSel",
        },
      },
      numbers_selected = {
        bg = {
          attribute = "bg",
          highlight = "TabLineSel",
        },
        underline = true,
      },
      buffer_selected = {
        bg = {
          attribute = "bg",
          highlight = "TabLineSel",
        },
        italic = false,
        bold = false,
        underline = true,
      },
      pick_selected = {
        bg = {
          attribute = "bg",
          highlight = "TabLineSel",
        },
        underline = true,
      },
      tab_separator_selected = {
        bg = {
          attribute = "bg",
          highlight = "TabLineSel",
        },
        underline = true,
      },
      modified_selected = {
        bg = {
          attribute = "bg",
          highlight = "TabLineSel",
        },
        fg = {
          attribute = "fg",
          highlight = "TabLineSel",
        },
        underline = true,
      },
      duplicate_selected = {
        bg = {
          attribute = "bg",
          highlight = "TabLineSel",
        },
        fg = {
          attribute = "fg",
          highlight = "TabLineSel",
        },
        underline = true,
      },
      fill = {
        bg = {
          attribute = "bg",
          highlight = "TabLineFill",
        },
      },
    },
  },
  keys = function()
    return {
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "<leader>p", require("bufferline").pick },
      {
        "<leader>r",
        function()
          vim.ui.input({ prompt = "Rename tab to: " }, function(input)
            if input then
              vim.cmd("BufferLineRename " .. input) -- custom defined vim cmd (see top of file)
            end
          end)
        end,
        desc = "Rename Tab",
      },
      {
        "<A-,>",
        function()
          local current_tab = vim.fn.tabpagenr()
          if current_tab == 1 then
            vim.cmd("tabmove")
          else
            vim.cmd("-tabmove")
          end
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
        end,
        desc = "Move Tab Right",
      },
    }
  end,
}
