---------------------------
-----== NORMAL MODE ==-----
---------------------------

-- Replace the word cursor is on globally
vim.keymap.set("n", "<leader>ci", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Change instances" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })
vim.keymap.set("n", "n", "nzzzv", { noremap = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true })

-- don't let cursor fly around when using J
vim.keymap.set("n", "J", "mzJ`z<cmd>delm z<CR>", { silent = true })
vim.keymap.set("n", "\\j", "j", { remap = false })
vim.keymap.set("n", "\\k", "k", { remap = false })

-- follow links!
vim.keymap.set("n", "<CR>", function()
  require("custom.utils").follow_link()
end, { noremap = true, silent = true, desc = "Follow link" })
vim.keymap.set("n", "<S-CR>", function()
  require("custom.utils").follow_link(true)
end, { noremap = true, silent = true, desc = "Follow link in new tab" })

-- select entire file
vim.keymap.set("n", "<C-a>", "ggVG")

-- select last changed/yanked text
vim.keymap.set(
  "n",
  "gp",
  '"`[" . strpart(getregtype(), 0, 1) . "`]"',
  { expr = true, replace_keycodes = false, desc = "Select last changed/yanked text" }
)

-- apply last created macro over selected region
vim.keymap.set("x", "Q", ":norm @@<cr>", { desc = "Play Q macro", silent = true })

-- duplicate lines
vim.keymap.set("n", "yc", "yygccp", { remap = true, desc = "Copy and comment current line" })

-- create a new tab
vim.keymap.set("n", "<C-space>", "<cmd>tabe<cr>", { desc = "New Tab" })
vim.keymap.set("n", "<C-CR>", "<cmd>tabe<cr>", { desc = "New Tab" })

-- close tabs/all buffers
vim.keymap.set("n", "<leader>Q", "<cmd>bufdo bd<cr>", { desc = "Close all buffers", silent = true })
vim.keymap.set("n", "<leader><Tab>q", "<cmd>tabclose<cr>", { desc = "Close tab" })

-- exclude "desc" so they don't populate which-key
vim.keymap.set("n", "<leader>1", "<cmd>silent! tabn 1<cr>", { silent = true })
vim.keymap.set("n", "<leader>2", "<cmd>silent! tabn 2<cr>", { silent = true })
vim.keymap.set("n", "<leader>3", "<cmd>silent! tabn 3<cr>", { silent = true })
vim.keymap.set("n", "<leader>4", "<cmd>silent! tabn 4<cr>", { silent = true })
vim.keymap.set("n", "<leader>5", "<cmd>silent! tabn 5<cr>", { silent = true })
vim.keymap.set("n", "<leader>6", "<cmd>silent! tabn 6<cr>", { silent = true })
vim.keymap.set("n", "<leader>7", "<cmd>silent! tabn 7<cr>", { silent = true })
vim.keymap.set("n", "<leader>8", "<cmd>silent! tabn 8<cr>", { silent = true })
vim.keymap.set("n", "<leader>9", "<cmd>silent! tabn 9<cr>", { silent = true })

-- splits/windows
vim.keymap.set("n", "<leader>wr", "<C-w>r", { desc = "Rotate window" })
vim.keymap.set("n", "|", "<cmd>vsplit<cr>", { remap = true, silent = true, desc = "Vertical split" })
vim.keymap.set("n", "_", "<cmd>split<cr>", { remap = true, silent = true, desc = "Horizontal split" })

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
vim.keymap.set("n", "<leader>fs", "1z=", { remap = false, silent = true, desc = "Fix spelling" })

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

---------------------------
-----== VISUAL MODE ==-----
---------------------------

-- search within selection by default when using / in visual mode
vim.keymap.set("x", "/", "<Esc>/\\%V")
vim.keymap.set("n", "g/", "*") -- `:h *`

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

vim.keymap.set("x", "<bs>", "d", { remap = true })

---------------------------
-----== INSERT MODE ==-----
---------------------------

vim.keymap.set("i", "<C-Del>", "<C-o>de") -- traditional functionality of <C-delete>
vim.keymap.set("i", "<M-BS>", "<C-u>") -- clean line (windows keymap)
vim.keymap.set("i", "<C-BS>", "<C-w>") -- clean line (windows keymap)
vim.keymap.set("i", "<D-BS>", "<C-u>") -- clean line (windows keymap)
vim.keymap.set("s", "<BS>", "<C-O>c", { remap = true }) -- backspace to clear snippets

-- in insert mode auto-correct the last misspelled word
vim.keymap.set("i", "<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u", { desc = "Auto correct", silent = true })

-- easier navgiation in cmdline
vim.keymap.set("c", "<C-a>", "<Home>", { remap = true })
vim.keymap.set("c", "<C-e>", "<End>", { remap = true })

-----------------------------
-----== TERMINAL MODE ==-----
-----------------------------

-- paste easier in terminal
vim.keymap.set("t", "<C-v>", "<c-\\><c-n><cmd>norm p<Cr>a", { remap = true })
vim.keymap.set("t", "<C-v>", "<c-\\><c-n><cmd>norm p<Cr>a", { remap = true })

--------------------------
-----== MANY MODES ==-----
--------------------------

vim.keymap.set("i", "<C-.>", "<C-t>")
vim.keymap.set("i", "<C-,>", "<C-d>")
vim.keymap.set({ "n", "x" }, "<C-.>", ">>", { remap = true })
vim.keymap.set({ "n", "x" }, "<C-,>", "<<", { remap = true })

-- for macos (vscode native)
vim.keymap.set("n", "<D-]>", ">>")
vim.keymap.set("i", "<D-]>", "<C-t>")
vim.keymap.set("v", "<D-]>", ">gv")
vim.keymap.set("n", "<D-[>", "<<")
vim.keymap.set("i", "<D-[>", "<C-d>")
vim.keymap.set("v", "<D-[>", "<gv")

-- for windows
vim.keymap.set("n", "<M-]>", ">>")
vim.keymap.set("i", "<M-]>", "<C-t>")
vim.keymap.set("v", "<M-]>", ">gv")
vim.keymap.set("n", "<M-[>", "<<")
vim.keymap.set("i", "<M-[>", "<C-d>")
vim.keymap.set("v", "<M-[>", "<gv")

-- follow links better
vim.keymap.set({ "n", "x" }, "gx", function()
  vim.ui.open(vim.fn.expand("<cfile>"))
end, { silent = true })

-- increment and decrement with plus and minus (since i override <c-a>)
vim.keymap.set({ "n", "v" }, "+", "<c-a>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "-", "<C-x>", { noremap = true, silent = true })

-- : (easier to hit when using in combination with <C-k>)
vim.keymap.set({ "n", "v" }, "<C-;>", ":", { remap = true, silent = false, desc = "Commmand mode" })

-- allow changing and deleting without overriding current paste registers
-- in other words automatically delete or change to the void register
vim.keymap.set({ "n", "v" }, "D", '"_D', { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "d", '"_d', { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "C", '"_C', { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "c", '"_c', { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "x", '"_x', { noremap = true, silent = true })
vim.keymap.set("v", "p", '"_dp', { noremap = true, silent = true })
vim.keymap.set("n", "X", "0D", { remap = true, desc = "Clear line", silent = true })

-- paste from system clipboard
vim.keymap.set("i", "<C-v>", "<C-r>+", { noremap = true, silent = true })
vim.keymap.set("c", "<C-v>", "<C-r>+")

-- delete to register
vim.keymap.set("v", "<leader>D", '"+d', { desc = "Delete and copy", silent = true, remap = false })
vim.keymap.set("n", "<leader>D", '"+dd', { desc = "Delete and copy", silent = true })

-- move lines of code with <C-n> and <C-p> (since M-j/k are taken by window manager)
vim.keymap.set({ "n", "x" }, "<C-p>", "<M-k>", { remap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<C-n>", "<M-j>", { remap = true, silent = true })

vim.keymap.set({ "n", "i" }, "<M-z>", function()
  vim.wo.wrap = not vim.wo.wrap
end, { desc = "Toggle Wrap" })

vim.keymap.set({ "n", "v" }, "go", "%", { desc = "Go to other pair" })

-----------------------
-----== SPECIAL ==-----
-----------------------

-- default mappings, just removing description so they're hidden from whichkey
vim.keymap.set("x", "Y", "y$")
vim.keymap.set("x", "&", ":&&<CR>")

-- Executes shell command from neovim making file executable
vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make executable" })

vim.keymap.set("n", "<leader>o", function()
  if vim.fn.executable("wsl-open") == 1 then
    vim.cmd([[silent! !wsl-open %]])
  else
    vim.cmd([[silent! !open %]])
  end
end, { desc = "Open buffer in system viewer" })

-- requires mini.surround
vim.keymap.set("x", '"', "gsaq", { remap = true, desc = "Surround Selection with Quotes" })
vim.keymap.set("x", "'", "gsa'", { remap = true, desc = "Surround Selection with Quotes" })

-- better scrolling with mouse
vim.keymap.set("n", "<ScrollWheelUp>", "<C-y>")
vim.keymap.set("n", "<ScrollWheelDown>", "<C-e>")
vim.keymap.set("n", "<ScrollWheelLeft><ScrollWheelLeft>", "zh") -- left scroll
vim.keymap.set("n", "<ScrollWheelRight><ScrollWheelRight>", "zl") -- right scroll
-- vim.keymap.set("n", "<M-ScrollWheelUp>", "zh") -- left scroll
-- vim.keymap.set("n", "<M-ScrollWheelDown>", "zl") -- right scroll
vim.keymap.set("n", "<ScrollWheelLeft>", "")
vim.keymap.set("n", "<ScrollWheelRight>", "")

vim.keymap.set("n", "zk", "<C-y>", { desc = "Scroll viewport up", remap = true })
vim.keymap.set("n", "zj", "<C-e>", { desc = "Scroll viewport down", remap = true })

-- media control buttons (don't send keypresses)
vim.keymap.set({ "i", "n" }, "", "<Nop>") -- volume up
vim.keymap.set({ "i", "n" }, "", "<Nop>") -- volume down
vim.keymap.set({ "i", "n" }, "", "<Nop>") -- mute
vim.keymap.set({ "i", "n" }, "", "<Nop>") -- mute
vim.keymap.set({ "i", "n" }, "", "<Nop>") -- prev
vim.keymap.set({ "i", "n" }, "", "<Nop>") -- skip

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

vim.cmd("cnoreabbrev Set set")
vim.api.nvim_create_user_command("W", "w", { nargs = 0 })
vim.api.nvim_create_user_command("E", "e", { nargs = 0 })
vim.api.nvim_create_user_command("Q", "qa", { nargs = 0 })
vim.api.nvim_create_user_command("Wq", "wq", { nargs = 0 })
vim.api.nvim_create_user_command("WQ", "wq", { nargs = 0 })
vim.api.nvim_create_user_command("X", "LazyExtras", { nargs = 0 })

-- force save as sudo, good for readonly files
vim.api.nvim_create_user_command("WF", "silent! w !sudo tee %", { nargs = 0, desc = "Force save" })

-- use for formatting lines with markdown
vim.cmd("cnoreabbrev F !prettier -w --parser=markdown")

-- clean ^Ms (windows newlines created when pasting into WSL from windows)
vim.api.nvim_create_user_command("Clean", "silent! %s/\r//g", { nargs = 0, desc = "Clean newline characters" })

-- save without removing trailing whitespace
vim.keymap.set({ "n", "i" }, "<C-D-S>", "<cmd>noa up<CR>", { remap = false, desc = "Save (noa)", silent = true })
vim.keymap.set({ "n", "i" }, "<D-s>", "<cmd>noa up<CR>", { remap = false, desc = "Save (noa)", silent = true })
vim.keymap.set("n", "<M-C-S>", "<cmd>noa up<CR>", { remap = false, desc = "Save (noa)", silent = true })

-- get word count of current file
vim.keymap.set("n", "<C-S-C>", function()
  vim.notify(
    "Word Count: " .. vim.fn.wordcount().words .. "\nChar Count: " .. vim.fn.wordcount().chars,
    vim.log.levels.INFO
  )
end)

-- Define a command to get word and character count of the current file
vim.api.nvim_create_user_command("Wordcount", function()
  vim.notify(
    "Word Count: " .. vim.fn.wordcount().words .. "\nChar Count: " .. vim.fn.wordcount().chars,
    vim.log.levels.INFO
  )
end, { desc = "Display word and character count of the current file" })

-- setup vscode overrides
if not vim.g.vscode then
  vim.keymap.set("n", "<S-h>", "<cmd>tabprev<cr>", { desc = "Previous tab" })
  vim.keymap.set("n", "<S-l>", "<cmd>tabnext<cr>", { desc = "Next tab" })

  vim.keymap.set("n", "<leader>q", function()
    -- stylua: ignore
    local close_window = function() vim.cmd("close") end
    local ok, _ = pcall(close_window)
    if not ok then
      pcall(vim.cmd("bdelete"))
    end
  end, { desc = "Close window", silent = true })
else
  vim.cmd([[
    function! s:split(...) abort
      let direction = a:1
      let file = exists('a:2') ? a:2 : ''
      call VSCodeCall(direction ==# 'h' ? 'workbench.action.splitEditorDown' : 'workbench.action.splitEditorRight')
      if !empty(file)
        call VSCodeExtensionNotify('open-file', expand(file), 'all')
      endif
    endfunction

    nnoremap _ <Cmd>call <SID>split('h')<CR>
    nnoremap \| <Cmd>call <SID>split('v')<CR>
  ]])

  local vscode = require("vscode")
  vim.notify = vscode.notify

  vim.keymap.del("n", "<leader>qq")
  vim.keymap.set(
    "n",
    "<leader>q",
    "<cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>",
    { silent = true }
  )
end

-- vim.keymap.set({ "n", "t" }, "<C-S-H>", "<cmd>wincmd h<cr>")
-- vim.keymap.set({ "n", "t" }, "<S-NL>", "<cmd>wincmd j<cr>")
-- vim.keymap.set({ "n", "t" }, "<C-S-K>", "<cmd>wincmd k<cr>")
-- vim.keymap.set({ "n", "t" }, "<C-S-L>", "<cmd>wincmd l<cr>")

-- -- clean ^Ms (windows newlines created when pasting into WSL from winddows)
-- vim.keymap.set("n", "<C-S-S>", function()
--   vim.cmd([[silent! %s/\r//g]])
--   vim.notify("Cleaned all newline characters!", vim.log.levels.INFO, { title = "File Saved" })
-- end, { remap = false, desc = "Clean ^M", silent = true })
