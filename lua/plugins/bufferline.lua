-- called bufferline but i use it for tabs

local ignored_bt = { prompt = true, nofile = true, terminal = true, quickfix = true }

vim.api.nvim_create_user_command("BufferLineRename", function(opts)
  local current_tab = vim.api.nvim_get_current_tabpage()
  if opts.args == "" then
    vim.g["BufferLineCustomName" .. current_tab] = nil
  else
    vim.g["BufferLineCustomName" .. current_tab] = opts.args
  end
  vim.api.nvim_exec_autocmds("User", { pattern = "BufferLineRenamed" })
end, {
  nargs = "?",
  desc = "Rename the current tab",
})

return {
  "n-crespo/bufferline.nvim",
  event = "LazyFile",
  dev = { false },
  opts = {
    options = {
      mode = "tabs",
      tab_size = 5,
      enforce_regular_tabs = false,
      truncate_names = false,
      indicator = { style = "none" },

      -- hide things
      show_duplicate_prefix = true,
      default_duplicate_prefix = "",
      show_tab_indicators = false,
      always_show_bufferline = false,
      show_close_icon = false,
      show_buffer_close_icons = false,
      show_buffer_icons = true,
      diagnostics = false,
      themable = false,
      modified_icon = "",
      separator_style = { "", "" },

      name_formatter = function(buf)
        local tabnr = buf.tabnr
        local custom_name = vim.g["BufferLineCustomName" .. tabnr]
        local name
        if custom_name and custom_name ~= "" then
          name = custom_name
        else
          name = buf.name
        end
        if name == "" then
          name = ":checkhealth" -- i think this only happens in health buffers
        end
        return name
      end,

      -- don'd update tabline with random floating windows
      custom_filter = function(buf_number)
        if vim.api.nvim_get_option_value("filetype", { buf = buf_number }) == "checkhealth" then
          return true -- allow :checkhealth buffers
        elseif
          ignored_bt[vim.api.nvim_get_option_value("buftype", { buf = buf_number })]
          or vim.api.nvim_get_option_value("bufhidden", { buf = buf_number }) ~= ""
        then
          return false
        else
          return true
        end
      end,
    },
    -- show selected tab with TabLineSel bg highlights
    highlights = function()
      local hl_names = {
        "tab_selected",
        "tab_separator_selected",
        "close_button_selected",
        "buffer_selected",
        "numbers_selected",
        "modified_selected",
        "duplicate_selected",
        "separator_selected",
        "indicator_selected",
        "pick_selected",
      }
      local hls = {}
      for _, name in ipairs(hl_names) do
        hls[name] = {
          bg = { attribute = "bg", highlight = "CursorLine" },
          italic = false,
          bold = false,
        }
      end
      hls["duplicate"] = { italic = false } -- no italic duplicate prefix
      return hls
    end,
  },
  keys = function()
    return {
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "<C-tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<C-S-tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      {
        "<leader>p",
        function()
          require("bufferline").pick()
        end,
      },
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
