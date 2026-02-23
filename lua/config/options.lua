vim.g.mapleader = " "
vim.g.editorconfig = true
vim.g.maplocalleader = "\\"
vim.g.lazyvim_python_lsp = "basedpyright"
vim.g.root_spec = { ".root", "lsp", { ".git", "lua" }, "cwd" }
vim.g.loaded_ruby_provider = 0 -- never use this
vim.g.loaded_perl_provider = 0 -- never use this
vim.g.loaded_node_provider = 0 -- never use this
vim.g.loaded_python3_provider = 0 -- never use this

local opt = vim.opt
opt.title = true
opt.titlestring = "nvim"
opt.scrolloff = 8 -- don't scroll all the way down
opt.laststatus = 3
opt.sidescroll = 0 -- see help pages
opt.textwidth = 80 -- formatted text width
opt.numberwidth = 1 -- left side width
opt.softtabstop = 2 -- 2 space tabs
opt.swapfile = false -- don't make backup swap files
opt.modeline = false
opt.smartcase = true -- casing in search
opt.ignorecase = true -- casing in search
opt.sidescrolloff = 5 -- see :h sidescrolloff
opt.startofline = true
opt.breakindent = true -- indent smartly
opt.isfname:append("@-@")
opt.relativenumber = false
opt.cursorlineopt = "number,screenline" -- cursorline respects wrapped lines
opt.spelloptions = "noplainbuffer,camel"
opt.spellfile = vim.fn.stdpath("data") .. "/spell" .. "/en.utf-8.add"
opt.completeopt = "menu,menuone,noselect,noinsert,popup"
-- opt.winborder = "rounded" -- this adds some visual artifacts occasionally
-- opt.autochdir = true -- this breaks things

if LazyVim.is_win() then
  vim.g.is_win = true
  LazyVim.terminal.setup("pwsh")
else
  opt.fileformat = "unix"
  opt.fileformats = { "unix", "dos" }
end

-- opts set by default lazyvim: ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/config/options.lua
