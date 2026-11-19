local settings = require("settings")
local colors = require("colors")

local cal = sbar.add("item", "calendar", {
	position = "right",
	icon = {
		color = colors.text_secondary,
		padding_left = 12,
		padding_right = 3,
		font = {
			family = settings.font.text,
			style = "Regular",
			size = 13.0,
		},
	},
	label = {
		color = colors.text,
		padding_left = 3,
		padding_right = 12,
		font = {
			family = settings.font.numbers,
			style = "Semibold",
			size = 13.0,
		},
	},
	update_freq = 30,
	background = {
		color = colors.glass.fill,
		border_color = colors.glass.border,
		border_width = 1,
	},
	padding_left = 0,
	padding_right = 0,
	click_script = "open -a Calendar",
})

sbar.add("item", { position = "right", width = settings.group_paddings })

cal:subscribe({ "forced", "routine", "system_woke" }, function(env)
	local date = os.date("%a %b ") .. tonumber(os.date("%d"))
	local time = tonumber(os.date("%I")) .. os.date(":%M %p")
	cal:set({ icon = date, label = time })
end)
