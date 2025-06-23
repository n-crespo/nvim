local M = {}

---@diagnostic disable: undefined-field
local uv = vim.loop
local api = vim.api
local fn = vim.fn

--- Get the parent directory of a buffer. Returns nil if this cannot be found.
---
--- @param bufnr number Buffer number to inspect
--- @return string|nil path An absolute path to the buffer's directory, or nil
local function path_to_buf(bufnr)
  local name = api.nvim_buf_get_name(bufnr)
  if name ~= "" then
    -- make it absolute and strip to the parent directory
    return fn.fnamemodify(name, ":p:h")
  end
end

--- Determines a directory based on buffer context, with fallbacks.
---
--- @param filename string? Optional filename to append to the directory
--- @return string dir Absolute path to the chosen directory or file path
function M.get_dir_with_fallback(filename)
  filename = filename or ""

  -- we probably have a regular file
  if filename ~= "" then
    local buf_dir_guess = path_to_buf(0) .. "/" .. filename
    if buf_dir_guess and uv.fs_stat(buf_dir_guess) then
      return buf_dir_guess -- only if this is a valid directory
    end
  end

  -- try to use alternate buffer's directory
  local alt_bufnr = fn.bufnr("#")
  local alt_dir = api.nvim_buf_is_valid(alt_bufnr) and path_to_buf(alt_bufnr)

  if alt_dir then
    return alt_dir -- use alt buffer dir if valid
  end
  return uv.cwd() or "~" -- default to home directory
end

-- returns true if neovim has been started as a man pager
function M.is_man_pager()
  for _, arg in ipairs(vim.v.argv) do
    if arg == "+Man!" then
      return true
    end
  end
  return false
end

-- https://github.com/ixru/nvim-markdown
function M.find_word_under_cursor()
  local cursor = api.nvim_win_get_cursor(0)
  local mode = fn.mode(".")
  if mode:find("n") then
    -- normal mode is converted to 1 index while insert mode is
    -- left as 0 index, this is because of how spaces are counted
    cursor[2] = cursor[2] + 1
  end
  local line = fn.getline(cursor[1])
  local word_start, word_stop, word
  local start = 1
  repeat
    -- repeats until it finds a link the cursor is inside or ends as nil
    word_start, word_stop, word = line:find("([^%s]+)", start)
    if word_start then
      start = word_stop + 1
    end
  until not word_start or (word_start <= cursor[2] and word_stop >= cursor[2])
  if word_start then
    return {
      start = word_start,
      stop = word_stop,
      text = word,
    }
  else
    return nil
  end
end

-- https://github.com/ixru/nvim-markdown
function M.find_link_under_cursor()
  local cursor = api.nvim_win_get_cursor(0)
  local line = fn.getline(cursor[1])
  local column = cursor[2] + 1
  local link_start, link_stop, text, url
  local current_match_start = 1 -- To keep track of where to start the next search

  while true do
    link_start, link_stop, text, url = line:find("%[([^%[%]]-)%]%(([^%)]-)%)", current_match_start)
    if not link_start then
      -- No more links found on this line
      break
    end

    if column >= link_start and column <= link_stop then
      return {
        link = "[" .. text .. "](" .. url .. ")",
        start = link_start,
        stop = link_stop,
        text = text,
        url = url,
      }
    end
    current_match_start = link_stop + 1 -- start looking for next match at end of current
  end
  return nil
end

--- Follows a given path string (optionally in a new tab). Returns true if path
--- was navigated to.
---
--- @param path string defaults to relative path, provide full for absolute
--- @param tab boolean? open in new tab?
--- @return boolean success if path was navigated to
function M.follow_path(path, tab)
  local ecmd = tab and "tabe " or "e "
  path = path:gsub('^"(.-)[.,"]?$', "%1") -- remove quotes, trailing commas/peridos

  if path:match("^[~/]") then
    -- an absolute path (starts with ~ or /)
    if uv.fs_stat(fn.expand(path)) then
      vim.cmd(ecmd .. path)
      return true
    else
      return false -- this is an invalid link
    end
  else
    -- does it exist relative to current buffer?
    local relative_path = fn.expand("%:p:h") .. "/" .. path
    if uv.fs_stat(relative_path) then
      vim.cmd(ecmd .. relative_path)
      return true
    end
  end
  return false
end

--- Follow a link under the cursor. Optionally opens links in a new tab.
---
--- Combines the functionality of `gf`, `za` and `gx`, with markdown support and
--- other improvements. Inspired by http://github.com/ixru/nvim-markdown.
---
--- @param tab boolean? When true, links open in a new tab/checkboxes are toggled.
function M.follow_link(tab)
  -- don't break qflists
  if vim.bo.filetype == "qf" then
    api.nvim_feedkeys(api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)
    return
  end

  tab = tab or false
  local word = M.find_word_under_cursor()
  local link = M.find_link_under_cursor() -- matches []() links only

  -- first try to follow a markdown formatted link
  if word and link and link.url then
    if link.url:match("^https?://") then
      vim.ui.open(link.url)
      return
    else
      local anchor = link.url:match("#(.+)$") or ""
      if anchor then
        link.url = link.url:gsub("#.+$", "")
      end
      -- follow anchor link if there's no URL
      if link.url == "" then
        -- re-open this buffer in a new tab (optionally)
        if tab then
          vim.cmd([[tabe %]])
        end
        -- now follow the anchor link
        fn.search("^#* " .. anchor:gsub("-", "[%- ]"))
        return
      end
      -- try to follow a file path (assume relative since expected in markdown)
      if M.follow_path(link.url, tab) then
        -- First, check if it's a line number (e.g., L10 or 10)
        local line_number_match = anchor:match("^L?(%d+)$")
        if line_number_match then
          local line_number = tonumber(line_number_match)
          if line_number then
            api.nvim_win_set_cursor(0, { line_number, 0 })
            vim.cmd("normal! zz") -- center the cursor
            return
          end
        end
        -- Try going to anchor (file.md#my-header) (only if file is md)
        if link.url:match(".md$") and anchor ~= "" then
          if tab then
            vim.cmd([[tabe %]])
          end
          local matches = fn.search("^#* " .. anchor:gsub("-", "[%- ]"), "w")
          if matches > 0 then -- Only return if a match was actually found
            vim.cmd("normal! zz") -- center the cursor
            return
          end
        end
        return
      end
    end
  end

  -- then try to follow non-markdown link
  if word and word.text then
    word.text = word.text:gsub("[.,:]$", "") -- remove trailing periods or commas
    -- follow a bare links (not in markdown syntax)
    if word.text:match("^https?://") then -- a URL!
      vim.ui.open(word.text)
      return
    end

    -- cut out possible line number(s)
    local line_number = tonumber(word.text:match(":(%d+).*$")) or nil
    word.text = word.text:gsub(":(%d+).*$", "")

    if M.follow_path(word.text, tab) then
      if line_number then -- a file path!
        local success, _ = pcall(api.nvim_win_set_cursor, 0, { line_number, 0 }) -- go to line number
        if not success then
          vim.notify("Unable to go to line number " .. line_number, vim.log.levels.WARN)
        end
        api.nvim_win_set_cursor(0, { line_number, 0 }) -- go to line number
        vim.cmd("normal! zz")
      end
      return
    end
  end

  -- fallback to using the a similar stratefy as `gf`/`gx` (works on bare links)
  local current_word = vim.fn.expand("<cfile>")
  if current_word ~= "" then -- cfile defaults to "", not nil!
    if current_word:match("^https?://") then
      vim.ui.open(current_word)
      return
    elseif M.follow_path(current_word, tab) then
      return
    end
  end
  -- open empty tab if nothing was chosen
  if tab then
    vim.cmd([[tabe]])
  else
    api.nvim_feedkeys(api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)
  end
end

--- Toggles a Markdown-style checkbox on the current line.
-- If the line starts with "- ", it cycles between:
--   - "- "         → "- [ ] "
--   - "- [ ]"      → "- [x]"
--   - "- [x]"      → "- "
-- Only operates on lines that start with a dash and a space.
function M.toggle_checkbox()
  local line = api.nvim_get_current_line()
  local new_line = nil
  if line:match("^%s*%- ") then -- Ensure the line starts with a dash followed by a space
    if line:match("^%s*%- %[%s%]") then
      new_line = line:gsub("%[%s%]", "[x]") -- "- [ ]"  to "- [x]"
    elseif line:match("^%s*%- %[%s*x%s*%]") then
      new_line = line:gsub("%[%s*x%s*%]%s*", "") -- "- [x]" to "-"
    elseif line:match("^%s*%- ") and not line:match("%[.%]") then
      new_line = line:gsub("^(%s*%- )", "%1[ ] ") -- "-" to "- [ ]"
    end
    if new_line then
      api.nvim_set_current_line(new_line)
      return
    end
  end
end

return M
