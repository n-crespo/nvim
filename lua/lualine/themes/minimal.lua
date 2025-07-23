local function to_hex(color)
  if not color then
    return nil
  end
  return string.format("#%06x", color)
end

local white = to_hex(vim.api.nvim_get_hl(0, { name = "Normal" }).fg)
local grey = to_hex(vim.api.nvim_get_hl(0, { name = "Conceal" }).fg)

local hls = {
  a = { fg = white, bg = nil, bold = true },
  b = { fg = grey, bg = nil, bold = true },
  c = { fg = grey, bg = nil, bold = true },
  z = { bg = nil, bold = true },
}

return {
  inactive = hls,
  visual = hls,
  replace = hls,
  normal = hls,
  insert = hls,
  command = hls,
}
