local M = {}

---@diagnostic disable: undefined-field
local uv = vim.loop
local api = vim.api
local fn = vim.fn

--- Get the parent directory of a buffer's file.
--- Returns nil if the buffer has no associated filepath.
---
--- @param bufnr number Buffer number to inspect
--- @return string|nil Absolute path to the buffer's directory, or nil
local function buf_dir(bufnr)
  local name = api.nvim_buf_get_name(bufnr)
  if name ~= "" then
    -- make it absolute and strip to the parent directory
    return fn.fnamemodify(name, ":p:h")
  end
end

--- Select the first valid directory from a list of candidates.
--- A directory is valid if it's non-empty and, if filename is provided,
--- the file exists in that directory.
---
--- @param candidates (string|nil)[] List of directory paths to try in order
--- @param filename string Filename to check existence (optional)
--- @return string|nil First directory that passes checks, or nil
local function pick_dir(candidates, filename)
  for _, d in ipairs(candidates) do
    if type(d) == "string" and d ~= "" then
      if filename == "" or uv.fs_stat(d .. "/" .. filename) then
        return d
      end
    end
  end
end

--- Determines a directory based on buffer context, with fallbacks.
---
--- Priority order:
---   1. Current buffer's directory (if file-backed)
---   2. Alternate buffer's directory (#) (if valid)
---   3. Current working directory
---
--- If a filename is provided, appends it only if that file exists.
--- Otherwise returns just the directory.
---
--- @param filename string? Optional filename to append to the directory
--- @return string dir Absolute path to the chosen directory or file path
function M.get_dir_with_fallback(filename)
  filename = filename or ""
  -- Candidate 1: current buffer dir (nil if no file)
  local cur_dir = buf_dir(0)
  -- Candidate 2: alternate buffer dir (#), or nil
  local alt_bufnr = fn.bufnr("#")
  local alt_dir = nil
  if api.nvim_buf_is_valid(alt_bufnr) then
    alt_dir = buf_dir(alt_bufnr)
  end
  local cwd = uv.cwd() -- Candidate 3: fallback to cwd
  -- Pick the first that exists (and matches filename, if any)
  local dir = pick_dir({ cur_dir, alt_dir, cwd }, filename) or cwd
  -- If filename provided and the file exists, return full path
  if filename ~= "" then
    local full = dir .. "/" .. filename
    if uv.fs_stat(full) then
      return full
    end
  end
  -- Otherwise just return the directory
  return dir
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
  -- an absolute path
  if string.match(path, "^[~/]") and uv.fs_stat(fn.expand(path)) then
    vim.cmd(ecmd .. path)
  else
    -- follow relative path if it exists (relative to curent buffer)
    path = fn.expand("%:p:h") .. "/" .. path
    if uv.fs_stat(fn.expand(path)) then
      vim.cmd(ecmd .. path)
    else
      return false
    end
  end
  return true
end

--- Follow a link or toggle a fold. Optionally opens links in new tabs and
--- toggles checkboxes.
---
--- Combines the functionality of `gf`, `za` and `gx`, with markdown support and
--- other improvements. Inspired by http://github.com/ixru/nvim-markdown.
---
--- @param tab boolean? When true, links open in a new tab/checkboxes are toggled.
function M.follow_link(tab)
  tab = tab or false
  local word = M.find_word_under_cursor()
  local link = M.find_link_under_cursor() -- matches []() links only

  -- toggle markdown checkboxes with <S-CR> on a '-'
  if tab and word and word.text == "-" and vim.bo.filetype == "markdown" then
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

  -- don't break qflists
  if vim.bo.filetype == "qf" then
    api.nvim_feedkeys(api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)
    return
  end
  -- follow a markdown formatted link (prioritized)
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
        fn.search("^#* " .. anchor:gsub("-", "[%- ]"))
        return
      end
      -- try to follow a file path (assume relative since expected in markdown)
      if M.follow_path(link.url, tab) then
        -- try to go to anchor e.g. file.md#my-header or just #my-header
        local matches = fn.search("^#* " .. anchor:gsub("-", "[%- ]"))
        if matches == 0 and anchor:match("^L?(%d+)") then
          -- try to go to line number
          local line_number = anchor:gsub("L", "")
          if line_number then
            api.nvim_win_set_cursor(0, { tonumber(line_number), 0 })
            vim.cmd("normal! zz") -- center the cursor
            return
          end
        end
      end
    end
  elseif word and word.text then
    word.text = word.text:gsub("[.,:]$", "") -- remove trailing periods or commas
    -- follow a bare links (not in markdown syntax)
    if word.text:match("^https?://") then -- a URL!
      vim.ui.open(word.text)
      return
    else
      local line_number = tonumber(word.text:match(":(%d+)$")) or nil
      word.text = word.text:gsub(":(%d+)$", "") -- cut out line numbers
      local abs_path = vim.fn.getcwd() .. "/" .. word.text -- try abs path as fallback
      -- try to follow absolute or relative file path
      if (M.follow_path(word.text, tab) or M.follow_path(abs_path, tab)) and line_number then -- a file path!
        local success, _ = pcall(api.nvim_win_set_cursor, 0, { line_number, 0 }) -- go to line number
        if not success then
          vim.notify("Unable to go to line number " .. line_number, vim.log.levels.WARN)
        end
        api.nvim_win_set_cursor(0, { line_number, 0 }) -- go to line number
        vim.cmd("normal! zz") -- center the cursor
        return
      end
    end
  end
  -- just sent <CR> if no case was chosen
  api.nvim_feedkeys(api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)
end

return M
