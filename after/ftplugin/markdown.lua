-- i no longer use prettier for markdown, cbfmt instead
-- vim.cmd([[inoreabbrev <buffer> ps <!-- prettier-ignore-start -->]])
-- vim.cmd([[inoreabbrev <buffer> pe <!-- prettier-ignore-end -->]])

-- NOTE; these save to the `r` register arbitrarily as to not clog up system
-- clipboard bold/italicize in visual mode
vim.keymap.set("i", "<C-b>", "****<left><left>", { buffer = true, silent = true })
vim.keymap.set("i", "<tab>", "<C-t>", { buffer = true, silent = true })
vim.keymap.set("i", "<S-tab>", "<C-d>", { buffer = true, silent = true })
vim.opt_local.foldmethod = "expr" -- folds headers and lists nicely

-----------------------------------------------
------------- TABLE FORMATTING ----------------
-----------------------------------------------

-- this is a rudimentary table formatting
local pattern = "^%s*|.*|%s*$"

local function findTableBorders(line_num)
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local top, bottom = line_num, line_num

  while top > 0 and lines[top]:find(pattern) do
    top = top - 1
  end
  while bottom < #lines and lines[bottom + 1]:find(pattern) do
    bottom = bottom + 1
  end

  return top + 1, bottom
end

local function getSeparatorPositions(line)
  local positions = {}
  for pos in line:gmatch("()|") do
    table.insert(positions, pos)
  end
  return positions
end

local function formatTable(top, bottom)
  local lines = vim.api.nvim_buf_get_lines(0, top - 1, bottom, false)
  local max_columns = {}

  -- Calculate max width for each column
  for _, line in ipairs(lines) do
    local seps = getSeparatorPositions(line)
    for i = 1, #seps - 1 do
      local content = line:sub(seps[i] + 1, seps[i + 1] - 1):gsub("^%s*(.-)%s*$", "%1")
      max_columns[i] = math.max(max_columns[i] or 0, #content)
    end
  end

  -- Format each line
  for i, line in ipairs(lines) do
    local seps = getSeparatorPositions(line)
    local new_line = "|"
    for j = 1, #seps - 1 do
      local content = line:sub(seps[j] + 1, seps[j + 1] - 1):gsub("^%s*(.-)%s*$", "%1")
      new_line = new_line .. " " .. content .. string.rep(" ", max_columns[j] - #content) .. " |"
    end
    lines[i] = new_line
  end

  vim.api.nvim_buf_set_lines(0, top - 1, bottom, false, lines)
end

local function tableFormat()
  local line_num = vim.api.nvim_win_get_cursor(0)[1]
  local line = vim.api.nvim_get_current_line()
  if not line:find(pattern) then
    return
  end

  local top, bottom = findTableBorders(line_num)
  formatTable(top, bottom)
end

vim.api.nvim_buf_create_user_command(0, "TableFormat", function()
  tableFormat()
end, {})

-- vim.api.nvim_create_autocmd("BufWrite", {
--   callback = function()
--     pcall(tableFormat)
--   end,
-- })
