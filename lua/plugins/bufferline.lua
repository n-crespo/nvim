-- called bufferline but i use it for tabs

local ignored_bt = { prompt = true, nofile = true, terminal = true, quickfix = true }

-- returns true if picker is open (don't want tabline changing)
local function picker_open()
  local P = package.loaded["snacks.picker.core.picker"]
  return P and #P.get() > 0
end

return {
  "akinsho/bufferline.nvim",
  enabled = true,
  opts = {
    options = {
      mode = "tabs",
      tab_size = 10,
      enforce_regular_tabs = false,
      indicator = { style = "none" },

      -- hide things
      show_duplicate_prefix = true,
      show_tab_indicators = false,
      always_show_bufferline = false,
      show_close_icon = false,
      show_buffer_close_icons = false,
      show_buffer_icons = false,
      diagnostics = false,
      themable = false,
      modified_icon = "",
      separator_style = { "", "" },

      numbers = function(opts)
        -- use the :h tabpagenr() instead of :h tabpageid
        local tabpagenr = vim.fn.index(vim.api.nvim_list_tabpages(), opts.id) + 1
        return string.format("%s", opts.raise(tabpagenr))
      end,

      -- no italics
      style_preset = require("bufferline").style_preset.no_italic,

      -- don'd update tabline with random floating windows
      custom_filter = function(buf_number)
        if ignored_bt[vim.bo[buf_number].buftype] then
          return false
        end
        if vim.bo[buf_number].bufhidden ~= "" then
          return false
        end
        if vim.api.nvim_buf_get_name(buf_number) == "" then
          return false
        end
        if picker_open() then
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
