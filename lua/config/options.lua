-- opts set by default lazyvim: ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/config/options.lua

local opt = vim.opt
opt.cursorlineopt = "number,screenline" -- cursorline respects wrapped lines
opt.laststatus = 3
opt.relativenumber = false
opt.swapfile = false -- don't make backup swap files
opt.scrolloff = 8 -- don't scroll all the way down
opt.sidescrolloff = 7 -- see :h sidescrolloff
opt.sidescroll = 0 -- see help pages
opt.numberwidth = 1 -- left side width
opt.isfname:append("@-@")
opt.textwidth = 80 -- formatted text width
opt.softtabstop = 2 -- 2 space tabs
opt.startofline = true
opt.breakindent = true -- indent smartly
opt.smartcase = true -- casing in search
opt.ignorecase = true -- casing in search
opt.spelloptions = "noplainbuffer,camel"
opt.completeopt = "menu,menuone,noselect,noinsert,popup"
opt.winborder = "rounded" -- this does weird things with flash.nvim
-- opt.autochdir = true -- this breaks things
vim.g.loaded_ruby_provider = 0 -- never use this
vim.g.loaded_perl_provider = 0 -- never use this
vim.g.loaded_python3_provider = 0
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.lazyvim_python_lsp = "pylsp"
vim.g.root_spec = { ".root", "lsp", { ".git", "lua" }, "cwd" }
vim.g.editorconfig = true
opt.completeopt = { "menuone", "popup", "noinsert" }

if LazyVim.is_win() then
  LazyVim.terminal.setup("pwsh -nologo")
end

-- not needed anymore
-- if vim.fn.has("wsl") == 1 then
--   ---@diagnostic disable-next-line: undefined-field
--   opt.clipboard:append("unnamedplus") -- use system clipboard as default register
--   vim.g.clipboard = {
--     name = "xclip-wsl",
--     copy = {
--       ["+"] = { "xclip", "-quiet", "-i", "-selection", "clipboard" },
--       ["*"] = { "xclip", "-quiet", "-i", "-selection", "primary" },
--     },
--     paste = {
--       ["+"] = { "xclip", "-o", "-selection", "clipboard" },
--       ["*"] = { "xclip", "-o", "-selection", "primary" },
--     },
--     cache_enabled = 1, -- cache MUST be enabled, or else it hangs on dd/y/x and all other copy operations
--   }
-- elseif vim.fn.has("mac") == 1 or vim.fn.has("win32") == 1 then
--   opt.clipboard = "unnamedplus"
-- end
