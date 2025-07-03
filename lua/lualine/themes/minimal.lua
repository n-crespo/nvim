local function to_hex(color)
  if not color then
    return nil
  end
  return string.format("#%06x", color)
end

local almost_white = to_hex(vim.api.nvim_get_hl(0, { name = "Normal" }).fg)
local subtle_grey = to_hex(vim.api.nvim_get_hl(0, { name = "Comment" }).fg)
local normal_bg = to_hex(vim.api.nvim_get_hl(0, { name = "Normal" }).bg)

local hls = {
  a = { fg = almost_white, bg = normal_bg, bold = true },
  b = { fg = subtle_grey, bg = normal_bg },
  c = { fg = almost_white, bg = normal_bg },
  z = { bg = normal_bg },
}

return {
  inactive = hls,
  visual = hls,
  replace = hls,
  normal = hls,
  insert = hls,
  command = hls,
}
