local map = vim.keymap.set

---------------------------
-----== NORMAL MODE ==-----
---------------------------

-- Replace the word cursor is on globally
map("n", "<leader>ci", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Change instances" })

map("n", "<C-d>", "<C-d>zz", { noremap = true })
map("n", "<C-u>", "<C-u>zz", { noremap = true })
map("n", "n", "nzzzv", { noremap = true })
map("n", "N", "Nzzzv", { noremap = true })

-- don't let cursor fly around when using J
map("n", "J", "mzJ`z<cmd>delm z<CR>", { silent = true })
map("n", "\\j", "j", { remap = false })
map("n", "\\k", "k", { remap = false })

-- follow links!
map("n", "<CR>", function()
  require("custom.utils").follow_link()
end, { noremap = true, silent = true, desc = "Follow link" })
map("n", "<S-CR>", function()
  require("custom.utils").follow_link(true)
end, { noremap = true, silent = true, desc = "Follow link in new tab" })

-- select entire file
map("n", "<C-a>", "ggVG")

-- select last changed/yanked text
map(
  "n",
  "gp",
  '"`[" . strpart(getregtype(), 0, 1) . "`]"',
  { expr = true, replace_keycodes = false, desc = "Select last changed/yanked text" }
)

-- apply last created macro over selected region
map("x", "Q", ":norm @@<cr>", { desc = "Play Q macro", silent = true })

-- duplicate lines
map("n", "yc", "yygccp", { remap = true, desc = "Copy and comment current line" })

-- create a new tab
map("n", "<C-space>", "<cmd>tabe<cr>", { desc = "New Tab" })
map("n", "<C-CR>", "<cmd>tabe<cr>", { desc = "New Tab" })

-- close tabs/all buffers
map("n", "<leader><Tab>q", "<cmd>tabclose<cr>", { desc = "Close tab" })

-- exclude "desc" so they don't populate which-key
map("n", "<leader>1", "<cmd>silent! tabn 1<cr>", { silent = true })
map("n", "<leader>2", "<cmd>silent! tabn 2<cr>", { silent = true })
map("n", "<leader>3", "<cmd>silent! tabn 3<cr>", { silent = true })
map("n", "<leader>4", "<cmd>silent! tabn 4<cr>", { silent = true })
map("n", "<leader>5", "<cmd>silent! tabn 5<cr>", { silent = true })
map("n", "<leader>6", "<cmd>silent! tabn 6<cr>", { silent = true })
map("n", "<leader>7", "<cmd>silent! tabn 7<cr>", { silent = true })
map("n", "<leader>8", "<cmd>silent! tabn 8<cr>", { silent = true })
map("n", "<leader>9", "<cmd>silent! tabn 9<cr>", { silent = true })

-- splits/windows
map("n", "<F25>", "<C-h>", { remap = true }) -- ugly remap for windows since it can't differentiate <C-h> and <BS>
map("n", "<leader>wr", "<C-w>r", { desc = "Rotate window" })
map("n", "|", "<cmd>vsplit<cr>", { remap = true, silent = true, desc = "Vertical split" })
map("n", "_", "<cmd>split<cr>", { remap = true, silent = true, desc = "Horizontal split" })
map("n", "<M-\\>", "<cmd>vsplit<cr>", { remap = true, silent = true, desc = "Vertical split" })
map("n", "<M-->", "<cmd>split<cr>", { remap = true, silent = true, desc = "Vertical split" })

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
map("n", "z=", spell_select)

-- auto pick the first spelling suggestion and apply it
map("n", "<leader>fs", "1z=", { remap = false, silent = true, desc = "Fix spelling" })

map("n", "<leader>R", function()
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
map("x", "/", "<Esc>/\\%V")
map("n", "g/", "*") -- `:h *`
map("x", "g/", "*<esc>", { remap = true }) -- `:h default-mappings`

-- go to visual end of line (unless wrap is disabled)
map({ "n", "v", "o" }, "E", function()
  if vim.opt.wrap:get() then
    vim.cmd("normal! g$")
  else
    vim.cmd("normal! $")
  end
end, { silent = true })
map({ "n", "v", "o" }, "B", function()
  if vim.opt.wrap:get() then
    vim.cmd("normal! g^")
  else
    vim.cmd("normal! ^")
  end
end, { silent = true })

map("x", "<bs>", "d", { remap = true })

---------------------------
-----== INSERT MODE ==-----
---------------------------

map("i", "<C-Del>", "<C-o>de") -- traditional functionality of <C-delete>
map("i", "<M-BS>", "<C-u>") -- clean line (windows keymap)
map({ "i", "c", "t" }, "<C-BS>", "<C-w>", { remap = true }) -- clean line (windows keymap)
map("i", "<D-BS>", "<C-u>") -- clean line (windows keymap)
map("s", "<BS>", "<C-O>c", { remap = true }) -- backspace to clear snippets

-- in insert mode auto-correct the last misspelled word
map("i", "<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u", { desc = "Auto correct", silent = true })

-- easier navgiation in cmdline
map("c", "<C-a>", "<Home>")
map("c", "<C-e>", "<End>")

-----------------------------
-----== TERMINAL MODE ==-----
-----------------------------

-- paste easier in terminal
map("t", "<C-v>", "<c-\\><c-n><cmd>norm p<Cr>a", { remap = true })
map("t", "<C-v>", "<c-\\><c-n><cmd>norm p<Cr>a", { remap = true })

--------------------------
-----== MANY MODES ==-----
--------------------------

-- for vscode on macos (see mini.move)
map("n", "<D-]>", "<M-]>", { remap = true })
map("i", "<D-]>", "<M-]>", { remap = true })
map("v", "<D-]>", "<M-]>", { remap = true })
map("n", "<D-[>", "<M-[>", { remap = true })
map("i", "<D-[>", "<M-[>", { remap = true })
map("v", "<D-[>", "<M-[>", { remap = true })

-- follow links better
map({ "n", "x" }, "gx", function()
  vim.ui.open(vim.fn.expand("<cfile>"))
end, { silent = true })

-- increment and decrement with plus and minus (since i override <c-a>)
map({ "n", "v" }, "+", "<c-a>", { noremap = true, silent = true })
map({ "n", "v" }, "-", "<C-x>", { noremap = true, silent = true })

-- : (easier to hit when using in combination with <C-k>)
map({ "n", "v" }, "<C-;>", ":", { remap = true, silent = false, desc = "Commmand mode" })

-- allow changing and deleting without overriding current paste registers
-- in other words automatically delete or change to the void register
map({ "n", "v" }, "D", '"_D', { noremap = true, silent = true })
map({ "n", "v" }, "d", '"_d', { noremap = true, silent = true })
map({ "n", "v" }, "C", '"_C', { noremap = true, silent = true })
map({ "n", "v" }, "c", '"_c', { noremap = true, silent = true })
map({ "n", "v" }, "x", '"_x', { noremap = true, silent = true })
map("v", "p", '"_dp', { noremap = true, silent = true })
map("n", "X", "0D", { remap = true, desc = "Clear line", silent = true })

-- paste from system clipboard
map("i", "<C-v>", "<C-r>+", { noremap = true, silent = true })
map("c", "<C-v>", "<C-r>+")

-- delete to register
map("v", "<leader>D", '"+d', { desc = "Delete and copy", silent = true, remap = false })
map("n", "<leader>D", '"+dd', { desc = "Delete and copy", silent = true })

map({ "n", "i" }, "<M-z>", function()
  vim.wo.wrap = not vim.wo.wrap
end, { desc = "Toggle Wrap" })

map({ "n", "v", "o" }, "go", "%", { desc = "Go to other pair" })

-----------------------
-----== SPECIAL ==-----
-----------------------

-- default mappings, just removing description so they're hidden from whichkey
map("x", "Y", "y$")
map("x", "&", ":&&<CR>")

-- Executes shell command from neovim making file executable
map("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make Executable" })

map("n", "<leader>o", function()
  if vim.fn.has("win32") == 1 then
    vim.cmd([[!open "%"]])
  elseif vim.fn.executable("wsl-open") == 1 then
    vim.cmd([[silent! !wsl-open %]])
  else
    vim.cmd([[Open %]])
  end
end, { desc = "Open with OS" })

-- requires mini.surround
map("x", '"', "gsaq", { remap = true, desc = "Surround Selection with Quotes" })
map("x", "'", "gsa'", { remap = true, desc = "Surround Selection with Quotes" })

-- better scrolling with mouse
map("n", "<ScrollWheelUp>", "<C-y>")
map("n", "<ScrollWheelDown>", "<C-e>")
map("n", "<ScrollWheelLeft><ScrollWheelLeft>", "zh") -- left scroll
map("n", "<ScrollWheelRight><ScrollWheelRight>", "zl") -- right scroll
-- k("n", "<M-ScrollWheelUp>", "zh") -- left scroll
-- k("n", "<M-ScrollWheelDown>", "zl") -- right scroll
map({ "n", "i" }, "<ScrollWheelLeft>", "")
map({ "n", "i" }, "<ScrollWheelRight>", "")
map("i", "<ScrollWheelUp>", "")
map("i", "<ScrollWheelDown>", "")

map("n", "<C-f>", "<C-e>", { remap = true })
map("n", "<C-b>", "<C-y>", { remap = true })

-- media control buttons (don't send keypresses)
map({ "i", "n" }, "", "<Nop>") -- volume up
map({ "i", "n" }, "", "<Nop>") -- volume down
map({ "i", "n" }, "", "<Nop>") -- mute
map({ "i", "n" }, "", "<Nop>") -- mute
map({ "i", "n" }, "", "<Nop>") -- prev
map({ "i", "n" }, "", "<Nop>") -- skip

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
map({ "n", "i" }, "<C-D-S>", "<cmd>noa up<CR>", { remap = false, desc = "Save (noa)", silent = true })
map({ "n", "i" }, "<D-s>", "<cmd>noa up<CR>", { remap = false, desc = "Save (noa)", silent = true })
map("n", "<M-C-S>", "<cmd>noa up<CR>", { remap = false, desc = "Save (noa)", silent = true })

-- get word count of current file
map("n", "<C-S-C>", function()
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

map("n", "R", "<cmd>make<cr>")

-----------------------
-----== VSCODE ==------
-----------------------

-- setup vscode overrides
if not vim.g.vscode then
  -- done with bufferline
  -- map("n", "<S-h>", "<cmd>tabprev<cr>", { desc = "Previous tab" })
  -- map("n", "<S-l>", "<cmd>tabnext<cr>", { desc = "Next tab" })

  map("n", "<leader>q", function()
    -- stylua: ignore
    local close_window = function() vim.cmd("close") end
    local ok, _ = pcall(close_window)
    if not ok then
      pcall(vim.cmd("bdelete"))
    end
  end, { desc = "Close window", silent = true })
else
  local vscode = require("vscode")

  vim.cmd([[
    function s:moveCursor(to)
        normal! m'
        call VSCodeExtensionNotify('move-cursor', a:to)
    endfunction
  ]])

  map("n", "*", function()
    vim.cmd(":silent! norm! *")
    local curline = vim.fn.line(".")
    vscode.call("revealLine", { args = { lineNumber = curline, at = "center" } })
  end, { noremap = true, silent = true })

  map("n", "n", function()
    vim.cmd(":silent! norm! n")
    local curline = vim.fn.line(".")
    vscode.call("revealLine", { args = { lineNumber = curline, at = "center" } })
  end, { noremap = true, silent = true })

  map("n", "N", function()
    vim.cmd(":silent! norm! N")
    local curline = vim.fn.line(".")
    vscode.call("revealLine", { args = { lineNumber = curline, at = "center" } })
  end, { noremap = true, silent = true })

  map("n", "g/", function()
    vim.cmd(":silent! norm! *")
    local curline = vim.fn.line(".")
    vscode.call("revealLine", { args = { lineNumber = curline, at = "center" } })
  end, { noremap = true, silent = true })

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

  vim.notify = vscode.notify

  vim.keymap.del("n", "<leader>qq")
  map("n", "<leader>q", "<cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>", { silent = true })
end

-- no idea why this doesnt work
-- clean ^Ms (windows newlines created when pasting into WSL from winddows)
-- map("n", "<C-S-S>", function()
--   vim.cmd([[silent! %s/\r//g]])
--   vim.notify("Cleaned all newline characters!", vim.log.levels.INFO, { title = "File Saved" })
-- end, { remap = false, desc = "Clean ^M", silent = true })
