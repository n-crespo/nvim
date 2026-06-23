-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(lazypath) then
   -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" }, -- default lazyvim plugins (some disabled in disabled.lua)

    -- Extras in lazyvim.json are always enabled
    { import = "lazyvim.plugins.extras.util.dot" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.toml" },
    { import = "lazyvim.plugins.extras.lang.yaml" },
    { import = "lazyvim.plugins.extras.lang.python" },
    { import = "lazyvim.plugins.extras.lang.tailwind" },
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.typescript.tsgo" },
    { import = "lazyvim.plugins.extras.lang.typst" },
    { import = "lazyvim.plugins.extras.formatting.black" },
    -- { import = "lazyvim.plugins.extras.linting.eslint" },
    -- { import = "lazyvim.plugins.extras.dap.core" },
    -- { import = "lazyvim.plugins.extras.ai.copilot-chat" },
    -- { import = "lazyvim.plugins.extras.ui.smear-cursor" },
    -- { import = "lazyvim.plugins.extras.ai.copilot" },
    -- { import = "lazyvim.plugins.extras.lang.java" },

    { import = "plugins.all" }, -- enable plugins from ../plugins
  },
  defaults = {
    lazy = true,
    version = false, -- always use the latest git commit
    -- version = "*",  try installing the latest stable version for plugins that support semver
  },
  ui = { border = "rounded" },
  change_detection = { notify = false }, -- don't show message on config change/reload
  checker = { enabled = false, notify = false }, --   automatically check for plugin updates
  profiling = { require = false }, -- this has performance overhead
  rocks = { enabled = false },
  -- dev = {
  --   path = "~/clones",
  --   fallback = false,
  -- },
  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "bugreport",
        "compiler",
        "ftplugin",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "matchit",
        "matchparen",
        "netrw",
        "netrwFileHandlers",
        "netrwPlugin",
        "netrwSettings",
        "optwin",
        "rplugin",
        "rrhelper",
        -- "spellfile_plugin",
        "synmenu",
        "tar",
        "tarPlugin",
        "tohtml",
        "tutor",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
      },
    },
  },
})
