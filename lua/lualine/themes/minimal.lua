local white = "#C9C9C9"
local grey = "#898989"

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
