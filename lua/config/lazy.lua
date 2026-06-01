require("config.keymaps")
require("config.autocmds")
require("config.options")

-- plugin setup
require("plugins.explore")
require("plugins.tabline")
require("plugins.statusline")
require("plugins.scroll")

-- disable some builtin plugins that i never use
local disabled = {
  "2html_plugin",
  "bugreport",
  "compiler",
  "ftplugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "matchit",
  -- "matchparen",
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
}

for _, plugin in ipairs(disabled) do
  vim.g["loaded_" .. plugin] = 1
end
