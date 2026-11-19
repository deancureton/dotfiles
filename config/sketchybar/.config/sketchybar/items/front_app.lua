local colors = require("colors")

local front_app = sbar.add("item", "front_app", {
	display = "active",
	icon = { drawing = false },
	label = {
		font = { style = "Semibold", size = 13.0 },
		color = colors.text,
		padding_left = 10,
	},
	updates = true,
})

front_app:subscribe("front_app_switched", function(env)
	front_app:set({ label = { string = env.INFO } })
end)
