local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

local battery = sbar.add("item", "widgets.battery", {
	position = "right",
	icon = {
		string = icons.battery._100,
		color = colors.text,
		padding_left = 10,
		padding_right = 2,
		font = {
			style = "Regular",
			size = 15.0,
		},
	},
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
	update_freq = 120,
	popup = { align = "center" },
})

local remaining_time = sbar.add("item", {
	position = "popup." .. battery.name,
	icon = {
		string = "Time remaining:",
		color = colors.text_secondary,
		width = 110,
		align = "left",
	},
	label = {
		string = "??:??h",
		width = 80,
		align = "right",
	},
})

battery:subscribe({ "forced", "routine", "power_source_change", "system_woke" }, function()
	sbar.exec("pmset -g batt", function(batt_info)
		local icon = "!"
		local label = "?"

		local found, _, charge = batt_info:find("(%d+)%%")
		if found then
			charge = tonumber(charge)
			label = charge .. "%"
		end

		local color = colors.text
		local charging = batt_info:find("AC Power")

		if charging then
			icon = icons.battery.charging
			color = colors.green
		elseif found and charge > 80 then
			icon = icons.battery._100
		elseif found and charge > 60 then
			icon = icons.battery._75
		elseif found and charge > 40 then
			icon = icons.battery._50
		elseif found and charge > 20 then
			icon = icons.battery._25
			color = colors.orange
		else
			icon = icons.battery._0
			color = colors.red
		end

		battery:set({
			icon = { string = icon, color = color },
			label = { string = label },
		})
	end)
end)

battery:subscribe("mouse.clicked", function(env)
	local drawing = battery:query().popup.drawing
	battery:set({ popup = { drawing = "toggle" } })

	if drawing == "off" then
		sbar.exec("pmset -g batt", function(batt_info)
			local found, _, remaining = batt_info:find(" (%d+:%d+) remaining")
			local label = found and remaining .. "h" or "No estimate"
			remaining_time:set({ label = { string = label } })
		end)
	end
end)

battery:subscribe("mouse.exited.global", function()
	battery:set({ popup = { drawing = false } })
end)
