vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = vim.api.nvim_create_augroup("TrimWhitespace", { clear = true }),
  desc = "Remove all trailing whitespace on save",
  pattern = { "*" },
  callback = function()
    if vim.b.autoformat == false then
      return
    end
    local save_cursor = vim.fn.getpos(".")
    pcall(function()
      vim.cmd([[%s/\s\+$//e]])
    end)
    vim.fn.setpos(".", save_cursor)
  end,
})

-- only show cursorline in active window normal mode
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter", "TabEnter", "TermLeave" }, {
  group = vim.api.nvim_create_augroup("SmartCursorline", { clear = true }),
  desc = "Enable cursorline only in active window",
  callback = function()
    vim.wo.cursorline = vim.bo.buftype == ""
  end,
})

vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave", "TabLeave" }, {
  group = "SmartCursorline",
  desc = "Enable cursorline only in active window",
  callback = function()
    vim.wo.cursorline = false
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "FileType" }, {
  group = vim.api.nvim_create_augroup("UnConceal", { clear = true }),
  desc = "Disable conceal for Mentorship-Hour-Log.md",
  pattern = "Mentorship-Hour-Log.md",
  command = "setlocal conceallevel=0",
})

vim.api.nvim_create_autocmd({ "OptionSet", "WinEnter", "VimEnter" }, {
  group = vim.api.nvim_create_augroup("SmartTextWidth", { clear = true }),
  desc = "Enable text width only when wrap is disabled",
  pattern = "wrap",
  callback = function()
    if vim.opt.wrap:get() then
      vim.cmd("setlocal tw=0")
    else
      vim.cmd("setlocal tw=80")
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Cycle quickfix list while inside qf window",
  group = vim.api.nvim_create_augroup("CycleQuickFix", { clear = true }),
  pattern = "qf",
  callback = function(event)
    local opts = { buffer = event.buf, silent = true }
    vim.keymap.set("n", "<C-n>", "<cmd>cn<CR>zz<cmd>wincmd p<CR>", opts)
    vim.keymap.set("n", "<C-p>", "<cmd>cN<CR>zz<cmd>wincmd p<CR>", opts)
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("SSHClipboard", { clear = true }),
  desc = "Sync pasting with local clipboard while ssh-ed",
  callback = function()
    if os.getenv("SSH_CONNECTION") ~= nil then
      -- vim.highlight.on_yank()
      local copy_to_unnamedplus = require("vim.ui.clipboard.osc52").copy("+")
      copy_to_unnamedplus(vim.v.event.regcontents)
      local copy_to_unnamed = require("vim.ui.clipboard.osc52").copy("*")
      copy_to_unnamed(vim.v.event.regcontents)
    end
  end,
})

-- pluginless autosave
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
  group = vim.api.nvim_create_augroup("AutoSave", { clear = true }),
  desc = "Auto save buffers when focus is lost (skips formatting).",
  callback = function()
    local file_path = vim.fn.expand("%") or ""
    if vim.bo.modifiable and vim.bo.buftype == "" and vim.bo.buflisted and vim.fn.filereadable(file_path) == 1 then
      vim.cmd([[silent noa up]]) -- save but without triggering autocmds (no format)
    end
  end,
})

-- properly set `titlestring` option
vim.api.nvim_create_autocmd({ "BufEnter", "TabNewEntered", "WinEnter", "WinLeave" }, {
  group = vim.api.nvim_create_augroup("titlestring", { clear = true }),
  callback = function()
    require("custom.utils").set_titlestring()
  end,
})

local function remove_from_qflist()
  local idx = vim.fn.line(".")
  local qflist = vim.fn.getqflist()
  table.remove(qflist, idx)
  vim.fn.setqflist(qflist, "r")
  vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "n", true)
end

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  group = vim.api.nvim_create_augroup("qf", { clear = true }),
  callback = function()
    if vim.bo.buftype == "quickfix" then
      vim.keymap.set({ "n", "v" }, "D", remove_from_qflist, { buffer = true }) -- for VD
      vim.keymap.set("n", "dd", remove_from_qflist, { buffer = true })
      vim.keymap.set("v", "d", remove_from_qflist, { buffer = true })
    end
  end,
})
