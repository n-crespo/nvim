vim.g.mapleader = " "
vim.g.editorconfig = true
vim.g.maplocalleader = "\\"
vim.g.loaded_ruby_provider = 0 -- never use this
vim.g.loaded_perl_provider = 0 -- never use this
vim.g.loaded_python3_provider = 0
vim.g.lazyvim_python_lsp = "pylsp"
vim.g.root_spec = { ".root", "lsp", { ".git", "lua" }, "cwd" }

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
opt.completeopt = "menu,menuone,noselect,noinsert,popup"
-- opt.winborder = "rounded" -- this adds some visual artifacts occasionally
-- opt.autochdir = true -- this breaks things

if LazyVim.is_win() then
  LazyVim.terminal.setup("pwsh")
end

-- opts set by default lazyvim: ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/config/options.lua
