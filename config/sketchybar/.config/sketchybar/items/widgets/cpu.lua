local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

-- Event provider: fires "cpu_update" every 2 seconds
sbar.exec("killall cpu_load >/dev/null; $CONFIG_DIR/helpers/event_providers/cpu_load/bin/cpu_load cpu_update 2.0")

local cpu_value = sbar.add("item", "widgets.cpu.value", {
	position = "right",
	icon = { drawing = false },
	label = {
		string = "??%",
		color = colors.text_secondary,
		padding_left = 2,
		padding_right = 10,
		font = {
			family = settings.font.numbers,
			style = "Regular",
			size = 12.0,
		},
	},
	padding_left = 0,
	padding_right = 0,
})

local cpu = sbar.add("graph", "widgets.cpu", 30, {
	position = "right",
	graph = { color = colors.blue, fill_color = colors.with_alpha(colors.blue, 0.4), line_width = 1.5 },
	background = {
		height = 16,
		color = colors.transparent,
		drawing = true,
	},
	icon = {
		string = icons.cpu,
		padding_left = 10,
		padding_right = 4,
		font = {
			style = "Regular",
			size = 14.0,
		},
	},
	label = { drawing = false },
	padding_left = 0,
	padding_right = 0,
})

cpu:subscribe("cpu_update", function(env)
	local load = tonumber(env.total_load)
	cpu:push({ load / 100.0 })

	local color = colors.blue
	if load >= 80 then
		color = colors.red
	elseif load >= 60 then
		color = colors.orange
	elseif load >= 30 then
		color = colors.yellow
	end

	cpu:set({ graph = { color = color, fill_color = colors.with_alpha(color, 0.4) } })
	cpu_value:set({ label = env.total_load .. "%" })
end)

local function open_activity_monitor()
	sbar.exec("open -a 'Activity Monitor'")
end

cpu:subscribe("mouse.clicked", open_activity_monitor)
cpu_value:subscribe("mouse.clicked", open_activity_monitor)
