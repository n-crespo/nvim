-- media control buttons (don't send keypresses)
vim.keymap.set({ "i", "n" }, "", "<Nop>") -- volume up
vim.keymap.set({ "i", "n" }, "", "<Nop>") -- volume down
vim.keymap.set({ "i", "n" }, "", "<Nop>") -- mute
vim.keymap.set({ "i", "n" }, "", "<Nop>") -- mute
vim.keymap.set({ "i", "n" }, "", "<Nop>") -- prev
vim.keymap.set({ "i", "n" }, "", "<Nop>") -- skip

-- --------------------------------------- BETTER MOTIONS ---------------------------------------

vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })
vim.keymap.set("n", "n", "nzzzv", { noremap = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true })
--
-- don't let cursor fly around when using J
vim.keymap.set("n", "J", "mzJ`z<cmd>delm z<CR>", { silent = true })
vim.keymap.set("n", "\\j", "j", { remap = false })
vim.keymap.set("n", "\\k", "k", { remap = false })

vim.keymap.set({ "n", "v" }, "go", "%", { desc = "Go to other pair" })

-- go to visual end of line (unless wrap is disabled)
vim.keymap.set({ "n", "v", "o" }, "E", function()
  if vim.opt.wrap:get() then
    vim.cmd("normal! g$")
  else
    vim.cmd("normal! $")
  end
end, { silent = true })
vim.keymap.set({ "n", "v", "o" }, "B", function()
  if vim.opt.wrap:get() then
    vim.cmd("normal! g^")
  else
    vim.cmd("normal! ^")
  end
end, { silent = true })

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

-- paste easier in terminal
vim.keymap.set("t", "<C-v>", "<c-\\><c-n><cmd>norm p<Cr>a", { remap = true })
vim.keymap.set("t", "<C-v>", "<c-\\><c-n><cmd>norm p<Cr>a", { remap = true })

-- insert blank lines in normal mode
vim.keymap.set("n", "<S-CR>", "] j", { remap = true, desc = "Insert line after line" })

-- search within selection by default when using / in visual mode
vim.keymap.set("x", "/", "<Esc>/\\%V")

-- move lines of code with <C-n> and <C-p> (since M-j/k are taken by window manager)
vim.keymap.set({ "n", "x" }, "<C-p>", "<M-k>", { remap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<C-n>", "<M-j>", { remap = true, silent = true })

-- --------------------------------------- PASTING + REGISTERS -------------------------------------

-- allow changing and deleting without overriding current paste registers
-- in other words automatically delete or change to the void register
vim.keymap.set({ "n", "v" }, "D", '"_D', { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "d", '"_d', { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "C", '"_C', { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "c", '"_c', { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "x", '"_x', { noremap = true, silent = true })
vim.keymap.set("v", "p", '"_dp', { noremap = true, silent = true })
-- this one is a bit weird
vim.keymap.set("n", "X", "0D", { remap = true, desc = "Clear Line", silent = true })

-- delete to register
vim.keymap.set("v", "<leader>D", '"+d', { desc = "Delete and Copy", silent = true, remap = false })
vim.keymap.set("n", "<leader>D", '"+dd', { desc = "Delete and Copy", silent = true })

-- paste from system clipboard
vim.keymap.set("i", "<C-v>", "<C-r>+", { noremap = true, silent = true })
vim.keymap.set("c", "<C-v>", "<C-r>+")

-- select last changed/yanked text
vim.keymap.set(
  "n",
  "gV",
  '"`[" . strpart(getregtype(), 0, 1) . "`]"',
  { expr = true, replace_keycodes = false, desc = "Select last changed/yanked text" }
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
  -- if vim.fn.tabpagenr("$") >= 5 then
  --   vim.notify("Thats a lotta tabs...", vim.log.levels.WARN, { title = "Tabs" })
  -- else
  vim.cmd("tabe")
  -- end
end)

vim.keymap.set("n", "<leader><Tab>q", "<cmd>tabclose<cr>", { desc = "Close Tab" })

vim.keymap.set("n", "<leader>q", function()
  -- stylua: ignore
  local close_window = function() vim.cmd("close") end
  local ok, _ = pcall(close_window)
  if not ok then
    vim.cmd("bdelete")
  end
end, { desc = "Close Window", silent = true })

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

-- exclude "desc" so they don't populate which-key
vim.keymap.set("n", "<leader>1", "<cmd>silent! tabn 1<cr>", { silent = true })
vim.keymap.set("n", "<leader>2", "<cmd>silent! tabn 2<cr>", { silent = true })
vim.keymap.set("n", "<leader>3", "<cmd>silent! tabn 3<cr>", { silent = true })
vim.keymap.set("n", "<leader>4", "<cmd>silent! tabn 4<cr>", { silent = true })
vim.keymap.set("n", "<leader>5", "<cmd>silent! tabn 5<cr>", { silent = true })
vim.keymap.set("n", "<leader>6", "<cmd>silent! tabn 6<cr>", { silent = true })
vim.keymap.set("n", "<leader>7", "<cmd>silent! tabn 7<cr>", { silent = true })
vim.keymap.set("n", "<leader>8", "<cmd>silent! tabn 8<cr>", { silent = true })

-- --------------------------------- INSERT MODE + COMPLETION -------------------------------------

-- completion cycling in command mode
vim.keymap.set("c", "<C-j>", "<C-n>", { remap = true })
vim.keymap.set("c", "<C-k>", "<C-p>", { remap = true })
vim.keymap.set("c", "<C-a>", "<Home>", { remap = true })
vim.keymap.set("c", "<C-e>", "<End>", { remap = true })

-- in insert mode auto-correct the last misspelled word
vim.keymap.set("i", "<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u", { desc = "Auto Correct", silent = true })

vim.keymap.set("i", "<C-Del>", "<C-o>de") -- traditional functionality of <C-delete>
vim.keymap.set("i", "<M-BS>", "<C-u>") -- clean line (windows keymap)
vim.keymap.set("s", "<BS>", "<C-O>c", { remap = true }) -- backspace to clear snippets

-- indenting easier
vim.keymap.set("n", "<C-]>", ">>")
vim.keymap.set("i", "<C-]>", "<C-t>")
vim.keymap.set("v", "<C-]>", ">gv")

vim.keymap.set("n", "<C-S-Find>", "<<")
vim.keymap.set("i", "<C-S-Find>", "<C-d>")
vim.keymap.set("v", "<C-S-Find>", "<gv")

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

-- force save as sudo, good for readonly files
vim.api.nvim_create_user_command("WF", "silent! w !sudo tee %", { nargs = 0, desc = "Force Save" })

-- use for formatting lines with markdown
vim.cmd("cnoreabbrev F !prettier -w --parser=markdown")

-- ------------------------------------- MISC KEYMAPS ----------------------------------------------

-- apply last created macro over selected region
vim.keymap.set("x", "Q", ":norm @@<cr>", { desc = "Play Q Macro", silent = true })

-- default mappings, just removing description so they're hidden from whichkey
vim.keymap.set("x", "Y", "y$")
vim.keymap.set("x", "&", ":&&<CR>")

-- : (easier to hit when using in combination with <C-k>)
vim.keymap.set({ "n", "v" }, "<C-;>", ":", { remap = true, silent = false, desc = "Commmand Mode" })

-- increment and decrement with plus and minus (since i override <c-a>)
vim.keymap.set({ "n", "v" }, "+", "<c-a>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "-", "<C-x>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-a>", "ggVG")

-- follow links better
vim.keymap.set({ "n", "x" }, "gx", function()
  vim.ui.open(vim.fn.expand("<cfile>"))
end, { silent = true })

-- Use ` to fold when in normal mode
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
end)

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
vim.keymap.set("n", "z=", spell_select)

-- auto pick the first spelling suggestion and apply it
vim.keymap.set("n", "<leader>fs", "1z=", { remap = false, silent = true, desc = "Fix Spelling" })

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
end, { desc = ":Lazy reload plugin" })
