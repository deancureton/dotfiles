local settings = require("settings")
local colors = require("colors")

sbar.default({
	updates = "when_shown",
	icon = {
		font = {
			family = settings.font.text,
			style = "Regular",
			size = 14.0,
		},
		color = colors.text,
		padding_left = 6,
		padding_right = 2,
	},
	label = {
		font = {
			family = settings.font.text,
			style = "Regular",
			size = 13.0,
		},
		color = colors.text,
		padding_left = 4,
		padding_right = 6,
	},
	background = {
		height = 26,
		corner_radius = 13,
		border_width = 0,
		color = colors.transparent,
		image = { corner_radius = 6 },
	},
	popup = {
		background = {
			border_width = 1,
			corner_radius = 14,
			border_color = colors.popup.border,
			color = colors.popup.bg,
			shadow = { drawing = true, color = colors.popup.shadow, angle = 90, distance = 10 },
		},
		blur_radius = 60,
		y_offset = -6,
	},
	padding_left = 2,
	padding_right = 2,
	scroll_texts = true,
})
