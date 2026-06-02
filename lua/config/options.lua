vim.g.mapleader = " "
vim.g.editorconfig = true
vim.g.maplocalleader = "\\"
vim.g.lazyvim_python_lsp = "pyright"
vim.g.lazyvim_ts_lsp = "tsgo"
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
opt.completeopt = "menu,menuone,noselect,noinsert"
opt.background = "dark"
opt.nrformats = "unsigned"
opt.clipboard = "unnamedplus"
opt.showtabline = 2
-- opt.winborder = "rounded" -- this adds some visual artifacts occasionally
-- opt.autochdir = true -- this breaks things

if vim.fn.has("win32") then
  vim.g.is_win = true
else
  opt.fileformat = "unix"
  opt.fileformats = { "unix", "dos" }
end

-- OPTIONS FOR MIN

vim.cmd.colorscheme("macro")
opt.number = true -- show line numbers

-- make find work better
opt.path:append("**")
opt.wildignore:append({ "*/node_modules/*", "*/.git/*", "*/build/*", "*/target/*" })
opt.wildoptions:append("pum")

opt.wildmode = "longest:full,full"
opt.conceallevel = 2
opt.confirm = true
opt.cursorline = true
opt.expandtab = true -- Use spaces instead of tabs
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
opt.foldlevel = 99
opt.foldmethod = "indent"
opt.foldtext = ""
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.jumpoptions = "view"
opt.laststatus = 3 -- global statusline
opt.linebreak = true -- Wrap lines at convenient points
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = "a" -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.ruler = false -- Disable the default ruler
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.shortmess:append({ W = true, c = true, C = true })
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { "en" }
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap
vim.g.markdown_recommended_style = 0 -- fix markdown indent settings

vim.cmd[[
  set complete-=i   " disable scanning included files
  set complete-=t   " disable searching tags
]]

opt.cmdheight = 0
