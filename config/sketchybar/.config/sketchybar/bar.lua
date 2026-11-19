local colors = require("colors")
local settings = require("settings")

-- A native Liquid Glass window is drawn behind the bar; the bar itself only adds a faint overlay.
sbar.bar({
	height = settings.bar_height,
	color = colors.bar.overlay,
	border_width = 0,
	blur_radius = 0,
	position = "top",
	sticky = true,
	padding_left = 8,
	padding_right = 8,
	display = "all",
	shadow = false,
})

sbar.exec(
	"killall sketchybar-glass >/dev/null 2>&1; $CONFIG_DIR/helpers/glass/bin/sketchybar-glass " .. settings.bar_height
)
