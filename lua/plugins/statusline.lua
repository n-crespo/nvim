-- basically lualine but native
local function get_macro()
  local recording_register = vim.fn.reg_recording()
  if recording_register == "" then
    return ""
  end
  return "%#WarningMsg# recording @" .. recording_register .. " "
end

function _G.minimal_statusline()
  local parts = {}
  -- lualine_c: file type and path string
  local ft = vim.bo.filetype ~= "" and vim.bo.filetype or ""
  local path = vim.fn.expand("%:f")
  if path == "" then path = "[No Name]" end
  local modify_flag = vim.bo.modified and " [+] " or " "

  -- file path
  table.insert(parts, string.format("%%#Delimiter# %s%s", path, modify_flag))
  -- native macro recording status
  table.insert(parts, get_macro())
  -- split point (separates left and right layout sides)
  table.insert(parts, "%=")
  -- lualine_y: location (hidden in visual mode)
  if not string.find(vim.fn.mode():lower(), "[v]") then
    table.insert(parts, "%#Delimiter# %l:%c ")
  end
  -- filetype
  if ft ~= "" then
    table.insert(parts, string.format("%%#Delimiter#%s ", ft))
  end
  -- progress tracker
  table.insert(parts, "%#Delimiter# %p%% ")
  -- windows icon condition check
  if vim.g.is_win then
    table.insert(parts, " 󰖳 ")
  end

  -- hostname parsing
  local hostname = vim.fn.hostname()
  table.insert(parts, hostname .. " ")

  -- neovim icon
  table.insert(parts, "%#String#%  ")
  return table.concat(parts, "")
end
vim.opt.laststatus = 3
vim.opt.statusline = "%!v:lua.minimal_statusline()"
