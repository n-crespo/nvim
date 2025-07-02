local function to_hex(color)
  if not color then
    return nil
  end
  return string.format("#%06x", color)
end

local almost_white = to_hex(vim.api.nvim_get_hl(0, { name = "Normal" }).fg)
local light_grey = to_hex(vim.api.nvim_get_hl(0, { name = "Visual" }).bg)
local subtle_grey = to_hex(vim.api.nvim_get_hl(0, { name = "Comment" }).fg)

local hls = {
  a = { fg = almost_white, bg = light_grey, bold = true },
  b = { fg = subtle_grey, bg = nil },
  c = { fg = almost_white, bg = nil },
  d = { bg = light_grey },
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
