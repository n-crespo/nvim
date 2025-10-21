-- called bufferline but i use it for tabs

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
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  opts = {
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
  },
  keys = {
    { "<leader>bl", false },
    { "<leader>br", false },
    { "<leader>bP", false },
    { "<C-tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "<C-S-tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    {
      "<leader>bp",
      require("bufferline").pick,
      desc = "Pick Buffer",
    },

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
}
