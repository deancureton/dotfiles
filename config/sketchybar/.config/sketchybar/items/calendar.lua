local settings = require("settings")
local colors = require("colors")

-- Padding item required because of bracket
sbar.add("item", { position = "right", width = settings.group_paddings })

local cal = sbar.add("item", {
	icon = {
		color = colors.grey_light,
		padding_left = 8,
		padding_right = 4,
		font = {
			family = settings.font.text,
			style = settings.font.style_map["Semibold"],
			size = 13.0,
		},
	},
	label = {
		color = colors.white,
		padding_left = 4,
		padding_right = 8,
		width = 75,
		align = "right",
		font = {
			family = settings.font.numbers,
			style = settings.font.style_map["Semibold"],
			size = 13.0,
		},
	},
	position = "right",
	update_freq = 30,
	background = {
		color = colors.transparent,
		border_color = colors.grey_dark,
		border_width = 1,
		height = 28,
		corner_radius = 7,
	},
	padding_left = 2,
	padding_right = 2,
})

-- Padding item required because of bracket
sbar.add("item", { position = "right", width = settings.group_paddings })

cal:subscribe({ "forced", "routine", "system_woke" }, function(env)
	cal:set({ icon = os.date("%a %b %d"), label = os.date("%I:%M %p") })
end)
