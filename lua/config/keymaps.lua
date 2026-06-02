local map = vim.keymap.set

---------------------------
-----== NORMAL MODE ==-----
---------------------------

-- Replace the word cursor is on globally
map("n", "<leader>ci", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Change instances" })

map("n", "<C-d>", function()
  if vim.fn.line(".") == 1 then
    return "M"
  end
  return "<C-d>zz"
end, { expr = true })

map("n", "<C-u>", function()
  if vim.fn.line(".") == vim.fn.line("$") then
    return "M"
  end
  return "<C-u>zz"
end, { expr = true })
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
map("n", "<leader>fs", "1z=", { remap = true, silent = true, desc = "Fix spelling" })
map("n", "<leader>fl", "[s1z=", { remap = true, silent = true, desc = "Fix last spelling" })

---------------------------
-----== VISUAL MODE ==-----
---------------------------

-- search within selection by default when using / in visual mode
map("x", "/", "<Esc>/\\%V")
map("n", "g/", "*") -- `:h *`
map("n", "g?", "#")
map("v", "g/", "*", { remap = true }) -- `:h default-mappings`
map("v", "g?", "$", { remap = true })

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

map({ "i", "c" }, "<C-Del>", "<C-o>de") -- traditional functionality of <C-delete>
map({ "i", "c" }, "<M-BS>", "<C-u>") -- clean line (windows keymap)
map({ "i", "c", "t" }, "<C-BS>", "<C-w>", { remap = true }) -- clean line (windows keymap)
map("i", "<D-BS>", "<C-u>") -- clean line (windows keymap)
map("s", "<BS>", "<C-O>c", { remap = true }) -- backspace to clear snippets

-- in insert mode auto-correct the last misspelled word
map("i", "<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u", { desc = "Auto correct", silent = true })

-- easier navigation in cmdline
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

-- follow links better (not available in old neovim version)
-- map({ "n", "x" }, "gx", function()
--   vim.ui.open(vim.fn.expand("<cfile>"))
-- end, { silent = true })

-- increment and decrement with plus and minus (since i override <c-a>)
map({ "n", "v" }, "+", "<c-a>", { noremap = true, silent = true })
map({ "n", "v" }, "-", "<C-x>", { noremap = true, silent = true })

-- : (easier to hit when using in combination with <C-k>)
map({ "n", "v" }, "<C-;>", ":", { remap = true, silent = false, desc = "Command mode" })

--- Clean carriage returns from the specified register
local function clean_register(reg)
  local content = vim.fn.getreg(reg)
  if type(content) == "string" then
    vim.fn.setreg(reg, content:gsub("\r", ""))
  elseif type(content) == "table" then
    for i, line in ipairs(content) do
      content[i] = line:gsub("\r", "")
    end
    vim.fn.setreg(reg, content)
  end
end

-- normal mode paste
map("n", "p", function()
  clean_register(vim.v.register)
  vim.cmd("normal! p")
end, { silent = true })

-- visual mode paste to void register
map("x", "p", function()
  clean_register(vim.v.register)
  vim.cmd('normal! "_p')
end, { silent = true })

-- allow changing and deleting without overriding current paste registers
-- in other words automatically delete or change to the void register
map({ "n", "v" }, "D", '"_D', { noremap = true, silent = true })
map({ "n", "v" }, "d", '"_d', { noremap = true, silent = true })
map({ "n", "v" }, "C", '"_C', { noremap = true, silent = true })
map({ "n", "v" }, "c", '"_c', { noremap = true, silent = true })
map({ "n", "v" }, "x", '"_x', { noremap = true, silent = true })
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
    vim.cmd([[!start "%"]])
  elseif vim.fn.executable("wsl-open") == 1 then
    vim.cmd([[silent! !wsl-open %]])
  else
    vim.cmd([[Open %]])
  end
end, { desc = "Open with OS" })

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
local abbreviations = {
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
for _, v in ipairs(abbreviations) do
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

-- Define a command to get word and character count of the current file
vim.api.nvim_create_user_command("Wordcount", function()
  vim.notify(
    "Word Count: " .. vim.fn.wordcount().words .. "\nChar Count: " .. vim.fn.wordcount().chars,
    vim.log.levels.INFO
  )
end, { desc = "Display word/char count" })

-- get word count of current file
map("n", "<C-S-C>", "<cmd>Wordcount<cr>", { desc = "Display word/char count" })

-----------------------
-----== VSCODE ==------
-----------------------

-- setup vscode overrides
map("n", "<leader>q", function()
  local close_window = function() vim.cmd("close") end
  local ok, _ = pcall(close_window)
  if not ok then
    pcall(vim.cmd("bdelete"))
  end
end, { desc = "Close window", silent = true })

-- clean ^Ms (windows newlines created when pasting into WSL from winddows)
map("n", "<C-S-s>", function()
  vim.cmd([[silent! %s/\r//g]])
  vim.notify("Cleaned all newline characters!", vim.log.levels.INFO, { title = "File Saved" })
end, { desc = "clean ^M" })

-----------------------
-----== RUNNER ==------
-----------------------

local runners = {
  python = { cmd = "python3" },
  javascript = { cmd = "node" },
  lua = { cmd = "lua" },
  go = { cmd = "go run" },
  sh = { cmd = "bash" },
  cpp = { cmd = "g++ % -o %< && ./%<" },
  autohotkey = { cmd = "start", term = false },
  typst = { cmd = "typst compile", term = false },
  markdown = { cmd = "pandoc -V geometry:margin=0.5in % -o %<.pdf && open %<.pdf", term = false },
}

local function run_current_file()
  -- Executes the current buffer's file using the configured runner.
  local filetype = vim.bo.filetype
  local runner = runners[filetype]

  if not runner then
    vim.notify("no runner configured for filetype: " .. filetype)
    return
  end

  -- default to terminal mode
  if runner.term == nil then
    runner.term = true
  end

  -- use absolute paths and shell escape them for spaces
  local path = vim.fn.expand("%:p")
  local target = vim.fn.expand("%:p:r")
  local escaped_path = vim.fn.shellescape(path)
  local escaped_target = vim.fn.shellescape(target)

  local full_cmd = runner.cmd
  if full_cmd:find("%%") then
    -- replace placeholders if present (%% matches literal %)
    full_cmd = full_cmd:gsub("%%<", function()
      return escaped_target
    end)
    full_cmd = full_cmd:gsub("%%", function()
      return escaped_path
    end)
  else
    -- otherwise just append the file path
    full_cmd = full_cmd .. " " .. escaped_path
  end

  if runner.term then
    -- make the terminal window
    vim.cmd("split")
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
    vim.api.nvim_set_option_value("buflisted", false, { buf = buf })
    vim.api.nvim_win_set_buf(0, buf)

    -- run the command
    vim.fn.jobstart(full_cmd, { term = true })

    -- set buffer local keymaps to close/escape to normal mode
    local opts = { buffer = buf, silent = true }
    map("t", "<esc><esc>", [[<C-\><C-n>]], opts)
    map("n", "q", [[<cmd>close<cr>]], opts)
  else
    vim.notify("Job started: " .. full_cmd)

    -- run command in the background non-blockingly if term=false
    vim.fn.jobstart(full_cmd, {

      on_exit = function(_, exit_code)
        if exit_code == 0 then
          vim.notify("Done!")
        else
          vim.notify("Job failed with exit code: " .. exit_code)
        end
      end,
    })
  end
end

map("n", "R", run_current_file, { desc = "run current file" })

-- MIN SPECIFIC MAPPINGS --

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- q text object to be quotes
local function get_closest_quote()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2] + 1
  local closest_quote = nil
  local min_dist = math.huge

  for _, q in ipairs({ '"', "'", "`" }) do
    local s = 1
    while true do
      local start_idx, end_idx = line:find(q .. "[^" .. q .. "]*" .. q, s)
      if not start_idx then break end

      if col <= end_idx then
        local dist = start_idx - col
        if dist < 0 then dist = 0 end

        if dist < min_dist then
          min_dist = dist
          closest_quote = q
        end
        break
      end
      s = end_idx + 1
    end
  end
  return closest_quote
end
for _, text_obj in ipairs({ "i", "a" }) do
  vim.keymap.set({ "x", "o" }, text_obj .. "q", function()
    local q = get_closest_quote()
    if q then
      vim.api.nvim_feedkeys(text_obj .. q, "n", false)
    end
  end, { desc = "Target closest quote" })
end

-- lazyvim defaults --

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
map("n", "<M-n>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<M-p>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("v", "<M-n>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<M-p>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })
map("n", "<C-n>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<C-p>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("v", "<C-n>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<C-p>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

map("n", "<leader>bd", "<cmd>bd<cr>", { desc = "Delete buffer" })

map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / Clear hlsearch / Diff Update" }
)

map({ "i", "n", "s" }, "<esc>", function()
  vim.cmd("noh")
  return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- better indenting
map("x", "<", "<gv")
map("x", ">", ">gv")

-- quickfix list
map("n", "<leader>xq", function()
  local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = "Quickfix List" })
map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
map("n", "<leader><tab>q", "<cmd>tabclose<cr>", { desc = "Close Tab" })

-- my own --

map("n", "<leader>wo", "<cmd>only<cr>")

map("n", "<M-o>", ":find ", { desc = "Open file" })
map("n", "<C-CR>", "<cmd>tabe<cr>", { desc = "Open new tab" })

map("n", "H", "<cmd>tabp<cr>", { desc = "Previous Tab" })
map("n", "L", "<cmd>tabn<cr>", { desc = "Next Tab" })

-- indent/unindent lines
map("n", "<M-]>", ">>", { desc = "indent line" })
map("n", "<M-[>", "<<", { desc = "unindent line" })
map("v", "<M-]>", ">gv", { desc = "indent block" })
map("v", "<M-[>", "<gv", { desc = "unindent block" })

-- lualine keymap
map("n", "<C-g>", function()
  local path = vim.fn.expand("%:p:~")
  local relative = vim.fn.expand("%:.")
  if relative ~= "" then
    relative = "\n" .. relative
  end
  vim.notify("[" .. path .. "]" .. relative)
end, { desc = "Print current file name" })

-- traverse command history
map("c", "<C-k>", "<C-p>")
map("c", "<C-j>", "<C-n>")

map("n", "<leader>n", function()
  -- create a new split buffer and set it to a scratchpad/log filetype
  vim.cmd("new")
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "wipe"
  vim.bo.swapfile = false
  vim.bo.filetype = "messages"
  vim.wo.number = false

  -- redirect the output of the :messages command straight into our new buffer
  vim.cmd("redir => l_messages")
  vim.cmd("silent messages")
  vim.cmd("redir END")

  -- clean up trailing spaces or blank characters from the string stream
  local lines = vim.split(vim.g.l_messages or "", "\n")
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

  -- clear out the temporary global variable
  vim.g.l_messages = nil
end, { desc = "Open messages in a scratch buffer" })

-- better commenting
map("n", "<C-/>", "gcc", { remap = true })
map("v", "<C-/>", "gcgv", { remap = true })
map("i", "<C-/>", function()
  local api = vim.api
  local cursor = api.nvim_win_get_cursor(0)
  local row, col = cursor[1], cursor[2]
  local line = api.nvim_get_current_line()

  -- get commentstring components natively using nvim_get_option_value
  local cs = api.nvim_get_option_value("commentstring", { buf = 0 })
  if cs == "" or not cs:find("%%s") then
    return
  end

  local prefix, suffix = cs:match("^(.-)%%s(.-)$")
  local trim_pre = prefix:gsub("%s+$", "") -- prefix without trailing space
  local trim_suf = suffix:gsub("^%s+", "") -- suffix without leading space

  -- capture leading whitespace and everything else
  local indent, content = line:match("^(%s*)(.*)")

  -- handle line that is either empty OR only contains the comment markers
  -- we use vim.pesc to treat markers as literal strings in the regex
  local pattern = "^" .. vim.pesc(prefix) .. vim.pesc(suffix) .. "$"
  local pattern_trimmed = "^" .. vim.pesc(trim_pre) .. vim.pesc(trim_suf) .. "$"

  if content == "" or content:match(pattern) or content:match(pattern_trimmed) then
    if content == "" then
      -- case: empty line -> add comment, keep indent
      api.nvim_set_current_line(indent .. prefix .. suffix)
      api.nvim_win_set_cursor(0, { row, #indent + #prefix })
    else
      -- case: only comment markers exist -> remove markers, keep indent
      api.nvim_set_current_line(indent)
      api.nvim_win_set_cursor(0, { row, #indent })
    end
    return
  end

  -- standard toggle logic for lines with actual content
  local is_commented = content:sub(1, #trim_pre) == trim_pre
  local offset = 0
  if is_commented then
    local space_match = content:match("^" .. vim.pesc(trim_pre) .. "(%s?)") or ""
    offset = -(#trim_pre + #space_match)
  else
    local padding = prefix:find("%s$") and 1 or 0
    offset = #trim_pre + padding
  end

  -- drop temporarily to normal mode to parse the native gcc lookup mapping recursively
  api.nvim_feedkeys(api.nvim_replace_termcodes("<C-o>:normal gcc<CR>", true, false, true), "m", false)

  -- ensure cursor matches calculated tracking coordinates after processing
  vim.schedule(function()
    api.nvim_win_set_cursor(0, { row, math.max(0, col + offset) })
  end)
end, { remap = true })
