vim.keymap.set("", "<M-/>", "<C-/>", { remap = true })
local function insert_mode_comment()
  local line = vim.api.nvim_get_current_line()
  if line:match("^%s*$") then
    -- do special things when on a blank line
    require("Comment.api").insert.linewise.eol()
    vim.api.nvim_feedkeys(" ", "n", false) -- delete the stray "a"
    vim.api.nvim_feedkeys("", "n", false) -- de-indent once cus the eol function does strange things
    return
  else
    local U = require("Comment.utils")
    local ft = require("Comment.ft")
    local api = vim.api
    local cs = ft.get(vim.bo.filetype, U.ctype.linewise)

    -- allow fallback to some other buffer-local <C-/> keymap if comment string
    -- is not defined (snacks.picker uses this for help keymap for example)
    if not cs then
      api.nvim_feedkeys(api.nvim_replace_termcodes("<C-/>", true, false, true), "n", false)
      return
    end

    -- i just want one thing please
    cs = (type(cs) == "table") and cs[1] or cs

    -- split & trim around '%s'
    local prefix, postfix = tostring(cs):match("^(.-)%%s(.-)$")
    prefix = prefix:match("^%s*(.-)%s*$") or ""
    postfix = postfix:match("^%s*(.-)%s*$") or ""

    -- store initial cursor + line state
    local row, old_col = unpack(api.nvim_win_get_cursor(0)) -- store initial state of the cursor
    line = api.nvim_get_current_line():match("^%s*(.-)%s*$") or ""

    local is_comment_first
    if postfix == "" then
      -- single-sided (line) comment
      is_comment_first = line:sub(1, #prefix) == prefix
    else
      -- two-sided (block) comment
      is_comment_first = line:sub(1, #prefix) == prefix and line:sub(-#postfix) == postfix
    end

    -- shift the cursor left if we are about to uncomment
    if is_comment_first then
      api.nvim_win_set_cursor(0, { row, math.max(0, old_col - (#prefix + 1)) })
    end

    require("Comment.api").toggle.linewise.current()

    -- either need to shift the cursor forwards if we just commented!
    if not is_comment_first then
      api.nvim_win_set_cursor(0, { row, math.max(0, old_col + (#prefix + 1)) })
    end
  end
end

return {
  "numToStr/Comment.nvim",
  event = "LazyFile",
  vscode = true,
  opts = {},
  keys = {
    {
      "<C-/>",
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      mode = "n",
    },
    {
      "<C-/>",
      "<Plug>(comment_toggle_linewise_visual)gv",
      mode = "v",
    },
    {
      "<C-/>",
      -- super hacky way to insert mode commenting while retaining cursor
      -- position
      insert_mode_comment,
      mode = "i",
    },
    {
      "<C-_>",
      -- super hacky way to insert mode commenting while retaining cursor
      -- position
      insert_mode_comment,
      mode = "i",
    },
    -- some terminals read <C-/> as <C-_>, so define those as well
    {
      "<C-_>",
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      mode = "n",
    },
    {
      "<C-_>",
      "<Plug>(comment_toggle_linewise_visual)gv",
      mode = "v",
    },
  },
}
