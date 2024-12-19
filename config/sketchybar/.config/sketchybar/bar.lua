local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
	height = 43, -- for some reason this is the same as the default macos bar
	color = colors.bar.bg,
	blur_radius = 50,
	margin = 0,
	y_offset = 0,
	corner_radius = 0,
	padding_right = 6,
	padding_left = 6,
})
