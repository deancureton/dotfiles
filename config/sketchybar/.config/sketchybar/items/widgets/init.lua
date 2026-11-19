local colors = require("colors")
local settings = require("settings")

require("items.widgets.battery")
require("items.widgets.volume")
require("items.widgets.wifi")
require("items.widgets.cpu")

sbar.add("bracket", "widgets.bracket", { "/widgets\\..*/" }, {
	background = {
		color = colors.glass.fill,
		border_color = colors.glass.border,
		border_width = 1,
		height = 26,
		corner_radius = 13,
	},
})

sbar.add("item", { position = "right", width = settings.group_paddings })
