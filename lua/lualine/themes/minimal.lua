local grey = "#898989"
local bg_color = "NONE"

local config = { fg = grey, bg = bg_color, bold = true }
local hls = { a = config, b = config, c = config, z = config }

return {
  inactive = hls,
  visual = hls,
  replace = hls,
  normal = hls,
  insert = hls,
  command = hls,
}
