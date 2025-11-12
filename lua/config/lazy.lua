-- set the environment variable NVIM_FULL_CONFIG to "true" to enable all
-- features. set to "false" or leave unset to use default lite version

---@type boolean
vim.g.full_config = vim.env.NVIM_FULL_CONFIG == "true" or false
local full_config = vim.g.full_config

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
    -- import default LazyVim plugins (some disabled in disabled.lua)
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- these will only be enabled if you set the environment variable
    -- NVIM_FULL_CONFIG to true. Extras in lazyvim.json are always enabled
    { import = "lazyvim.plugins.extras.util.dot", cond = full_config },
    {
      import = "lazyvim.plugins.extras.lang.json",
      cond = function()
        return full_config or LazyVim.is_win()
      end,
    },
    { import = "lazyvim.plugins.extras.lang.toml", cond = full_config },
    { import = "lazyvim.plugins.extras.lang.yaml", cond = full_config },
    { import = "lazyvim.plugins.extras.lang.python", cond = full_config },
    { import = "lazyvim.plugins.extras.lang.tailwind", cond = full_config },
    { import = "lazyvim.plugins.extras.lang.typescript", cond = full_config },
    { import = "lazyvim.plugins.extras.lang.typst", cond = full_config },
    -- { import = "lazyvim.plugins.extras.dap.core", cond = full_config },
    -- { import = "lazyvim.plugins.extras.ai.copilot-chat", cond = full_config },
    -- { import = "lazyvim.plugins.extras.ui.smear-cursor", cond = full_config },
    -- { import = "lazyvim.plugins.extras.ai.copilot", cond = full_config },
    -- { import = "lazyvim.plugins.extras.lang.java", cond = full_config },

    -- this enables user define plugins, from ../plugins/
    { import = "plugins" },
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
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tutor",
        "zipPlugin",
        "netrw",
        "netrwSettings",
        "netrwFileHandlers",
        "zip",
        "tar",
        "getscript",
        "getscriptPlugin",
        "vimball",
        "vimballPlugin",
        "2html_plugin",
        "logipat",
        "rrhelper",
        "spellfile_plugin",
        "tohtml",
        "rplugin",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      },
    },
  },
})
