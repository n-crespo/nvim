-- media control buttons (don't send keypresses)
vim.keymap.set({ "i", "n" }, "", "<Nop>") -- volume up
vim.keymap.set({ "i", "n" }, "", "<Nop>") -- volume down
vim.keymap.set({ "i", "n" }, "", "<Nop>") -- mute
vim.keymap.set({ "i", "n" }, "", "<Nop>") -- mute
vim.keymap.set({ "i", "n" }, "", "<Nop>") -- prev
vim.keymap.set({ "i", "n" }, "", "<Nop>") -- skip

-- --------------------------------------- BETTER MOTIONS ---------------------------------------

vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, desc = "Half Page Down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, desc = "Half Page Up" })
vim.keymap.set("n", "n", "nzzzv", { noremap = true, desc = "Next Search Result" })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true, desc = "Prev Search Result" })
--
-- don't let cursor fly around when using J
vim.keymap.set("n", "J", "mzJ`z<cmd>delm z<CR>", { silent = true })
vim.keymap.set("n", "\\j", "j", { remap = false })
vim.keymap.set("n", "\\k", "k", { remap = false })

vim.keymap.set({ "n", "v" }, "go", "%", { desc = "Go to other pair" })

-- go to visual end of line unless wrap is disabled!!
vim.keymap.set({ "n", "v", "o" }, "E", function()
  if vim.opt.wrap:get() then
    vim.cmd("normal! g$")
  else
    vim.cmd("normal! $")
  end
end, { desc = "End of line", silent = true })

vim.keymap.set({ "n", "v", "o" }, "B", function()
  if vim.opt.wrap:get() then
    vim.cmd("normal! g^")
  else
    vim.cmd("normal! ^")
  end
end, { desc = "Start of line", silent = true })

-- better scrolling with mouse
vim.keymap.set("n", "<ScrollWheelUp>", "<C-y>")
vim.keymap.set("n", "<ScrollWheelDown>", "<C-e>")
vim.keymap.set("n", "<M-ScrollWheelUp>", "zh") -- left scroll
vim.keymap.set("n", "<M-ScrollWheelDown>", "zl") -- right scroll

-- <C-S-J> as  <C-j>
vim.keymap.set({ "n", "t" }, "<C-S-H>", "<cmd>wincmd h<cr>")
vim.keymap.set({ "n", "t" }, "<S-NL>", "<cmd>wincmd j<cr>")
vim.keymap.set({ "n", "t" }, "<C-S-K>", "<cmd>wincmd k<cr>")
vim.keymap.set({ "n", "t" }, "<C-S-L>", "<cmd>wincmd l<cr>")

vim.keymap.set("t", "<C-v>", "<c-\\><c-n><cmd>norm p<Cr>a", { remap = true })

-- don't scroll on <S-CR>
vim.keymap.set("n", "<S-CR>", "<NOP>")

-- search within selection by default when using / in visual mode
vim.keymap.set("x", "/", "<Esc>/\\%V")

vim.keymap.set({ "n", "x" }, "<C-p>", "<M-k>", { remap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<C-n>", "<M-j>", { remap = true, silent = true })

-- --------------------------------------- PASTING + REGISTERS -------------------------------------

-- allow changing and deleting without overriding current paste registers
-- in other words automatically delete or change to the void register
vim.keymap.set({ "n", "v" }, "D", '"_D', { noremap = true, silent = true, desc = "Delete till end of line" })
vim.keymap.set({ "n", "v" }, "d", '"_d', { noremap = true, silent = true, desc = "Delete" })
vim.keymap.set({ "n", "v" }, "C", '"_C', { noremap = true, silent = true, desc = "Change till end of line" })
vim.keymap.set({ "n", "v" }, "c", '"_c', { noremap = true, silent = true, desc = "Change" })
vim.keymap.set({ "n", "v" }, "x", '"_x', { noremap = true, silent = true, desc = "Delete under cursor" })
vim.keymap.set("v", "p", '"_dp', { noremap = true, silent = true, desc = "Paste" })
vim.keymap.set("n", "X", "0D", { remap = true, desc = "Clear Line", silent = true })

-- delete to register
vim.keymap.set("v", "<leader>D", '"+d', { desc = "Delete and Cut", silent = true, remap = false })
vim.keymap.set("n", "<leader>D", '"+dd', { desc = "Delete and Cut", silent = true })

-- paste from system clipboard
vim.keymap.set("i", "<C-v>", "<C-r>+", { noremap = true, silent = true, desc = "Paste from clipboard" })
vim.keymap.set("c", "<C-v>", "<C-r>+")

-- select last changed/yanked text
vim.keymap.set(
  "n",
  "gV",
  '"`[" . strpart(getregtype(), 0, 1) . "`]"',
  { expr = true, replace_keycodes = false, desc = "Visually select changed text" }
)

vim.keymap.set("n", "yc", "yygccp", { remap = true, desc = "copy and comment current line" })
vim.keymap.set("v", "Y", "ygvgc']p", { remap = true, desc = "copy and comment current line" })

-- --------------------------------------- WINDOWS BUFFERS AND TABS --------------------------------
-- rotate windows
vim.keymap.set("n", "<leader>wr", "<C-w>r", { desc = "Rotate Window" })

-- tab navigation
vim.keymap.set("n", "<S-h>", "<cmd>tabprev<cr>", { desc = "Previous Tab" })
vim.keymap.set("n", "<S-l>", "<cmd>tabnext<cr>", { desc = "Next Tab" })

-- create a new tab
vim.keymap.set("n", "<C-space>", function()
  if vim.fn.tabpagenr("$") >= 5 then
    vim.notify("Thats a lotta tabs...", vim.log.levels.WARN, { title = "Tabs" })
  else
    vim.cmd("tabe")
  end
end)

vim.keymap.set("n", "<leader><Tab>q", "<cmd>tabclose<cr>", { desc = "Close Tab" })

vim.keymap.set("n", "<leader>q", "<C-W>c", { desc = "Close Window", silent = true })

-- splits
vim.keymap.set("n", "|", "<cmd>vsplit<cr>", { remap = true, silent = true, desc = "Vertical Split" })
vim.keymap.set("n", "_", "<cmd>split<cr>", { remap = true, silent = true, desc = "Vertical Split" })

vim.keymap.set("n", "<leader>o", function()
  if vim.fn.executable("wsl-open") == 1 then
    vim.cmd([[silent! !wsl-open %]])
  else
    vim.cmd([[silent! !open %]])
  end
end, { desc = "Open File in System Viewer" })

vim.keymap.set("n", "<leader>1", "<cmd>silent! tabn 1<cr>", { silent = true, desc = "Tab 1" })
vim.keymap.set("n", "<leader>2", "<cmd>silent! tabn 2<cr>", { silent = true, desc = "Tab 2" })
vim.keymap.set("n", "<leader>3", "<cmd>silent! tabn 3<cr>", { silent = true, desc = "Tab 3" })
vim.keymap.set("n", "<leader>4", "<cmd>silent! tabn 4<cr>", { silent = true, desc = "Tab 4" })
vim.keymap.set("n", "<leader>5", "<cmd>silent! tabn 5<cr>", { silent = true, desc = "Tab 5" })

-- --------------------------------- INSERT MODE + COMPLETION -------------------------------------

-- completion cycling in command mode
vim.keymap.set("c", "<C-j>", "<C-n>", { remap = true, desc = "Next completion items" })
vim.keymap.set("c", "<C-k>", "<C-p>", { remap = true, desc = "Prev completion items" })
vim.keymap.set("c", "<C-a>", "<Home>", { remap = true, desc = "Next completion items" })
vim.keymap.set("c", "<C-e>", "<End>", { remap = true, desc = "Prev completion items" })

-- in insert mode auto-correct the last misspelled word
vim.keymap.set("i", "<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u", { desc = "Auto Correct", silent = true })

vim.keymap.set("i", "<C-Del>", "<C-o>de") -- traditional functionality of <C-delete>
vim.keymap.set("i", "<M-BS>", "<C-u>", { desc = "Clear Line" })
-- backspace to clear snippets
vim.keymap.set("s", "<BS>", "<C-O>c", { remap = true })

-- indents
vim.keymap.set("n", "<C-]>", ">>", { desc = "Increase Indent" })
vim.keymap.set("n", "<C-[>", "<<", { desc = "Decrease Indent" })
vim.keymap.set("i", "<C-]>", "<C-t>", { desc = "Increase Indent" })
vim.keymap.set("i", "<C-[>", "<C-d>", { desc = "Decrease Indent" })
vim.keymap.set("v", "<C-]>", ">", { remap = true, desc = "Increase Indent" })
vim.keymap.set("v", "<C-S-Find>", "<", { remap = true, desc = "Decrease Indent" })

-- ------------------------------------- PERMISSIONS -----------------------------------------------

-- Force save as sudo (for readonly files)
vim.keymap.set(
  "n",
  "<leader>W",
  "<cmd>silent! w !sudo tee %<cr>",
  { desc = "Force Save File", noremap = true, silent = true }
)

-- ------------------------------------- ABBREVIATIONS --------------------------------------------

-- note: these will work in every filetype
local abbrevations = {
  { "dont", "don't" },
  { "shouldnt", "shouldn't" },
  { "cant", "can't" },
  { "wont", "won't" },
  { "wouldnt", "wouldn't" },
  { "seperate", "separate" },
  { "teh", "the" },
  { "thats", "that's" },
  { "itll", "it'll" },
}
for _, v in ipairs(abbrevations) do
  vim.cmd(string.format("iabbrev %s %s", v[1], v[2]))
end

vim.cmd("cnoreabbrev Set  set")
vim.api.nvim_create_user_command("W", "w", { nargs = 0 })
vim.api.nvim_create_user_command("E", "e", { nargs = 0 })
vim.api.nvim_create_user_command("Q", "qa", { nargs = 0 })
vim.api.nvim_create_user_command("Wq", "wq", { nargs = 0 })
vim.api.nvim_create_user_command("WQ", "wq", { nargs = 0 })
vim.api.nvim_create_user_command("X", "LazyExtras", { nargs = 0 })
vim.cmd("cnoreabbrev F !prettier -w --parser=markdown") -- use for formatting lines with markdown

-- ------------------------------------- MISC KEYMAPS ----------------------------------------------

-- apply last created macro over selected region
vim.keymap.set("x", "Q", ":norm @@<cr>", { desc = "Play Q Macro", silent = true })

-- replace all instances of word (without LSP)
vim.keymap.set(
  "n",
  "<leader>ci",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace instances" }
)

vim.keymap.set(
  "n",
  "<leader>cI",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gIc<Left><Left><Left><Left>]],
  { desc = "Replace instances with confirmation" }
)

-- : (easier to hit when using in combination with <C-k>)
vim.keymap.set({ "n", "v" }, "<C-;>", ":", { remap = true, silent = false, desc = "Commmand Mode" })

-- increment and decrement with plus and minus (since I override <C-a>)
vim.keymap.set({ "n", "v" }, "+", "<C-a>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "-", "<C-x>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select All" })

-- follow links better
vim.keymap.set("n", "gx", function()
  vim.ui.open(vim.fn.expand("<cfile>"))
end, { silent = true, desc = "Follow Link" })

-- Use ` to fold when in normal mode
-- To see help about folds use `:help fold`
vim.keymap.set({ "n", "v" }, "`", function()
  -- Get the current line number
  local line = vim.fn.line(".")
  -- Get the fold level of the current line
  local foldlevel = vim.fn.foldlevel(line)
  if foldlevel == 0 then
    vim.notify("No fold found", vim.log.levels.WARN, { title = "Fold" })
  else
    vim.cmd("normal! za")
  end
end, { desc = "Toggle fold" })

-- clean ^Ms (windows newlines)
vim.keymap.set("n", "<C-S-S>", function()
  vim.cmd([[silent! %s/\r//g]])
  vim.cmd([[w]])
  vim.notify("Cleaned all newline characters!", vim.log.levels.INFO, { title = "File Saved" })
end, { remap = false, desc = "Clean ^M", silent = true })

-- get word count of current file
vim.keymap.set("n", "<C-S-C>", function()
  vim.notify(
    "Word Count: " .. vim.fn.wordcount().words .. "\nChar Count: " .. vim.fn.wordcount().chars,
    vim.log.levels.INFO
  )
end)

-- z= with vim.ui.select() (selection UI)
-- (you can also type a number to pick the nth suggestion)
local spell_on_choice = vim.schedule_wrap(function(_, idx)
  if type(idx) == "number" then
    vim.cmd.normal({ idx .. "z=", bang = true })
  end
end)
local spell_select = function()
  if vim.v.count > 0 then
    spell_on_choice(nil, vim.v.count)
    return
  end
  local cword = vim.fn.expand("<cword>")
  vim.ui.select(vim.fn.spellsuggest(cword, vim.o.lines), { prompt = "Change " .. cword .. " to:" }, spell_on_choice)
end
vim.keymap.set("n", "z=", spell_select, { desc = "Show spelling suggestions" })

-- auto pick the first spelling suggestion and apply it
vim.keymap.set("n", "<leader>fs", "1z=", { remap = false, silent = true, desc = "Fix Spelling under cursor" })

vim.keymap.set("n", "<leader>R", function()
  local plugins = require("lazy").plugins()
  local plugin_names = {}
  for _, plugin in ipairs(plugins) do
    table.insert(plugin_names, plugin.name)
  end

  vim.ui.select(plugin_names, {
    title = "Reload plugin",
  }, function(selected)
    require("lazy").reload({ plugins = { selected } })
  end)
end, { desc = "Reload plugin" })

-- Diffview (https://github.com/LazyVim/LazyVim/discussions/5462)

-- util function
local function greplist(str, inputlist)
  for i, v in ipairs(inputlist) do
    if v:match(str) then
      return i, v
    end
  end
  return nil
end

local diffwins = {}
local function diffwins_clean()
  vim.cmd("diffoff!")
  diffwins = {}
end
vim.keymap.set("n", "<leader>da", function()
  vim.notify("Enabled Diffview (Buffer)", vim.log.levels.INFO, { title = "Diffview" })
  if #diffwins >= 2 then
    diffwins_clean()
    return
  end
  local winnr = tostring(vim.fn.winnr())
  local cached_winnr, _ = greplist(winnr, diffwins)
  if cached_winnr then
    vim.cmd("diffoff")
    table.remove(diffwins, cached_winnr)
  else
    vim.cmd("diffthis")
    table.insert(diffwins, winnr)
  end
end, { silent = true, desc = "Diff this buffer" })

vim.keymap.set("n", "<leader>do", function()
  vim.notify("Disabled Diffview (global)", vim.log.levels.WARN, { title = "Diffview" })
  return diffwins_clean()
end, { silent = true, desc = "Diff off all buffers" })

vim.keymap.set("n", "<leader>m", "<cmd>messages<cr>", { desc = "Show messages" })
