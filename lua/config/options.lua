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
opt.sidescrolloff = 7 -- see :h sidescrolloff
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

-- properly set `titlestring` option
-- if place in autocmds.lua, this autocmd gets registered by neovim too late and
-- misses the first round of WinEnter events (thus why i moved it here).
local ignored_bt = { prompt = true, nofile = true, terminal = true, quickfix = true }
vim.api.nvim_create_autocmd({ "BufEnter", "TabNewEntered", "WinEnter", "WinLeave" }, {
  group = vim.api.nvim_create_augroup("group", { clear = true }),
  callback = function()
    local name = vim.api.nvim_buf_get_name(0)
    if vim.api.nvim_get_option_value("filetype", { buf = 0 }) == "checkhealth" then
      vim.opt.titlestring = ":checkhealth - nvim"
    elseif vim.api.nvim_get_option_value("filetype", { buf = 0 }) == "snacks_dashboard" then
      vim.opt.titlestring = "nvim"
    elseif
      ignored_bt[vim.api.nvim_get_option_value("buftype", { buf = 0 })]
      or vim.api.nvim_get_option_value("bufhidden", { buf = 0 }) ~= ""
      or name == ""
    then
      -- don't update title string
    else
      vim.opt.titlestring = vim.fn.expand("%:t") .. " - nvim"
    end
  end,
})

-- opts set by default lazyvim: ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/config/options.lua
