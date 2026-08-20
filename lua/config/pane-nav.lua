local M = {}

M.defaults = {
  noremap = true,
  silent = true,
  debug = false,
  map_backspace = true,
}

M.config = vim.deepcopy(M.defaults)

local ffi
local ffi_initialized = false

local KEYEVENTF_KEYUP = 0x0002
local VK_MENU = 0x12 -- Alt

local function is_windows()
  local uv = vim.uv or vim.loop
  return uv.os_uname().sysname == "Windows_NT"
end

function M.dbg(msg)
  if M.config.debug then
    vim.notify(msg, vim.log.levels.INFO, { title = "pane-nav" })
  end
end

function M.ensure_ffi()
  if ffi_initialized then
    return true
  end

  if not is_windows() then
    vim.notify("pane-nav: Windows Terminal fallback only works on Windows", vim.log.levels.WARN)
    return false
  end

  local ok, loaded_ffi = pcall(require, "ffi")
  if not ok then
    vim.notify("pane-nav: LuaJIT FFI is not available", vim.log.levels.ERROR)
    return false
  end

  ffi = loaded_ffi

  ffi.cdef([[
    typedef unsigned char BYTE;
    typedef unsigned long DWORD;
    typedef unsigned long ULONG_PTR;
    void keybd_event(BYTE bVk, BYTE bScan, DWORD dwFlags, ULONG_PTR dwExtraInfo);
  ]])

  ffi_initialized = true
  return true
end

function M.send_alt_letter(letter)
  if not M.ensure_ffi() then
    return
  end

  local vk = string.byte(string.upper(letter))

  -- Ctrl is physically held by the user.
  -- We only add Alt temporarily.
  ffi.C.keybd_event(VK_MENU, 0, 0, 0)
  ffi.C.keybd_event(vk, 0, 0, 0)

  ffi.C.keybd_event(vk, 0, KEYEVENTF_KEYUP, 0)
  ffi.C.keybd_event(VK_MENU, 0, KEYEVENTF_KEYUP, 0)
end

function M.smart_move(direction)
  M.dbg("smart moving " .. direction)

  local mode = vim.fn.mode()

  if mode:sub(1, 1) == "t" then
    vim.cmd("stopinsert")
  end

  local before = vim.api.nvim_get_current_win()

  vim.cmd("wincmd " .. direction)

  local after = vim.api.nvim_get_current_win()

  if before == after then
    M.dbg("sending Alt+" .. direction)
    M.send_alt_letter(direction)
  else
    M.dbg("moved inside nvim: " .. direction)
  end
end

function M.clear_keymaps()
  for _, mode in ipairs({ "n", "t" }) do
    for _, lhs in ipairs({ "<C-h>", "<C-j>", "<C-k>", "<C-l>" }) do
      pcall(vim.keymap.del, mode, lhs)
    end
  end

  pcall(vim.keymap.del, "n", "<BS>")
end

function M.has_keymaps()
  local map = vim.fn.maparg("<C-l>", "n", false, true)
  return type(map) == "table" and map.desc == "Smart pane right"
end

function M.setup_keymaps(opts)
  M.config = vim.tbl_deep_extend("force", M.defaults, opts or {})

  M.clear_keymaps()

  local base_opts = {
    noremap = M.config.noremap,
    silent = M.config.silent,
  }

  vim.keymap.set(
    "n",
    "<C-h>",
    function()
      M.smart_move("h")
    end,
    vim.tbl_extend("force", base_opts, {
      desc = "Smart pane left",
    })
  )

  vim.keymap.set(
    "n",
    "<C-j>",
    function()
      M.smart_move("j")
    end,
    vim.tbl_extend("force", base_opts, {
      desc = "Smart pane down",
    })
  )

  vim.keymap.set(
    "n",
    "<C-k>",
    function()
      M.smart_move("k")
    end,
    vim.tbl_extend("force", base_opts, {
      desc = "Smart pane up",
    })
  )

  vim.keymap.set(
    "n",
    "<C-l>",
    function()
      M.smart_move("l")
    end,
    vim.tbl_extend("force", base_opts, {
      desc = "Smart pane right",
    })
  )

  -- Ctrl+h often arrives as Backspace.
  if M.config.map_backspace then
    vim.keymap.set(
      "n",
      "<BS>",
      function()
        M.smart_move("h")
      end,
      vim.tbl_extend("force", base_opts, {
        desc = "Smart pane left via Backspace/Ctrl-h",
      })
    )
  end

  M.dbg("pane-nav keymaps registered")
end

M.setup = M.setup_keymaps

return M
