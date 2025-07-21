local function to_hex(color)
  if not color then
    return nil
  end
  return string.format("#%06x", color)
end

local white = to_hex(vim.api.nvim_get_hl(0, { name = "Normal" }).fg)
local grey = to_hex(vim.api.nvim_get_hl(0, { name = "Comment" }).fg)

local hls = {
  a = { fg = white, bg = nil, bold = true },
  b = { fg = grey, bg = nil },
  c = { fg = grey, bg = nil },
  z = { bg = nil },
}

return {
  inactive = hls,
  visual = hls,
  replace = hls,
  normal = hls,
  insert = hls,
  command = hls,
}
