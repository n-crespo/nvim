local ok, pane_nav = pcall(require, "config.pane-nav")

if not ok then
  vim.notify("failed to load config.pane-nav: " .. pane_nav, vim.log.levels.ERROR)
  return
end

local group = vim.api.nvim_create_augroup("PaneNavAfterPlugins", {
  clear = true,
})

local function register()
  pane_nav.setup_keymaps({
    silent = false,
    debug = false,
    map_backspace = true,
  })
end

-- LazyVim/lazy.nvim path: run after VeryLazy, then defer slightly so we win
-- against late keymap setup.
vim.api.nvim_create_autocmd("User", {
  group = group,
  pattern = "VeryLazy",
  once = true,
  callback = function()
    vim.defer_fn(register, 100)
  end,
})

-- Fallback path: if VeryLazy does not fire, still register after startup.
vim.api.nvim_create_autocmd("VimEnter", {
  group = group,
  once = true,
  callback = function()
    vim.defer_fn(function()
      if not pane_nav.has_keymaps() then
        register()
      end
    end, 500)
  end,
})
