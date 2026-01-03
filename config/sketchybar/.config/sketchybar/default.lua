local settings = require("settings")
local colors = require("colors")

-- Equivalent to the --default domain
sbar.default({
	updates = "when_shown",
	icon = {
		font = {
			family = settings.font.text,
			style = settings.font.style_map["Regular"],
			size = 14.0,
		},
		color = colors.white,
		padding_left = 6,
		padding_right = 2,
		background = { image = { corner_radius = 6 } },
	},
	label = {
		font = {
			family = settings.font.text,
			style = settings.font.style_map["Regular"],
			size = 13.5,
		},
		color = colors.white,
		padding_left = 4,
		padding_right = 6,
	},
	background = {
		height = 26,
		corner_radius = 6,
		border_width = 1,
		border_color = colors.transparent,
		color = colors.transparent,
		image = {
			corner_radius = 6,
			border_color = colors.transparent,
			border_width = 0,
		},
	},
	popup = {
		background = {
			border_width = 1,
			corner_radius = 11,
			border_color = colors.popup.border,
			color = colors.popup.bg,
			shadow = { drawing = true, color = colors.bar.shadow, angle = 90, distance = 8 },
		},
		blur_radius = 70,
		y_offset = -8,
	},
	padding_left = 4,
	padding_right = 4,
	scroll_texts = true,
})
