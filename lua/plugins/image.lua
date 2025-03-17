local formats =
  { "png", "jpg", "jpeg", "gif", "bmp", "webp", "tiff", "heic", "avif", "mp4", "mov", "avi", "mkv", "webm", "pdf" }

vim.api.nvim_create_autocmd({ "FileType", "BufReadCmd" }, {
  desc = "Set image filetypes",
  pattern = "*." .. table.concat(formats, ",*."),
  callback = function(e)
    Snacks.util.bo(e.buf, {
      filetype = "image",
      modifiable = false,
      modified = false,
      swapfile = false,
    })
  end,
})
return {
  -- this doesn't work in windows terminal but sixel does (used in yazi)
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    image = { enabled = false },
  },
  keys = {
    {
      "<CR>",
      "<cmd>silent! !open %<CR>",
      ft = "image",
      buffer = true,
      desc = "Open Image in System Viewer",
    },
  },
}
