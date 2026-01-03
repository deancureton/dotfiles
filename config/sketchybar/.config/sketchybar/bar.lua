local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
	height = 40,
	color = colors.bar.bg,
	border_color = colors.bar.border,
	border_width = 0,
	blur_radius = 30,
	position = "top",
	sticky = true,
	padding_right = 0,
	padding_left = 0,
	y_offset = 0,
	margin = 0,
	corner_radius = 0,
	notch_width = 0,
	display = "all",
	shadow = false,
})
