local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local popup_width = 250

local volume = sbar.add("item", "widgets.volume", {
	position = "right",
	icon = {
		string = icons.volume._100,
		color = colors.text,
		padding_left = 10,
		padding_right = 2,
		font = {
			style = "Regular",
			size = 14.0,
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
	popup = { align = "center" },
})

local volume_slider = sbar.add("slider", popup_width, {
	position = "popup." .. volume.name,
	slider = {
		highlight_color = colors.white,
		background = {
			height = 6,
			corner_radius = 3,
			color = colors.glass.active,
		},
		knob = {
			string = "􀀁",
			drawing = true,
		},
	},
	background = { color = colors.glass.border, height = 1, y_offset = -20 },
	click_script = 'osascript -e "set volume output volume $PERCENTAGE"',
})

volume:subscribe("volume_change", function(env)
	local vol = tonumber(env.INFO)
	local icon = icons.volume._0
	if vol > 60 then
		icon = icons.volume._100
	elseif vol > 30 then
		icon = icons.volume._66
	elseif vol > 10 then
		icon = icons.volume._33
	elseif vol > 0 then
		icon = icons.volume._10
	end

	volume:set({
		icon = { string = icon },
		label = vol .. "%",
	})
	volume_slider:set({ slider = { percentage = vol } })
end)

local function volume_collapse_details()
	local drawing = volume:query().popup.drawing == "on"
	if not drawing then
		return
	end
	volume:set({ popup = { drawing = false } })
	sbar.remove("/volume.device\\.*/")
end

local function volume_toggle_details(env)
	if env.BUTTON == "right" then
		sbar.exec("open /System/Library/PreferencePanes/Sound.prefpane")
		return
	end

	local should_draw = volume:query().popup.drawing == "off"
	if not should_draw then
		volume_collapse_details()
		return
	end

	volume:set({ popup = { drawing = true } })
	sbar.exec("SwitchAudioSource -t output -c", function(result)
		local current = result:sub(1, -2)
		sbar.exec("SwitchAudioSource -a -t output", function(available)
			local counter = 0
			for device in string.gmatch(available, "[^\r\n]+") do
				local color = colors.text_secondary
				if current == device then
					color = colors.text
				end
				sbar.add("item", "volume.device." .. counter, {
					position = "popup." .. volume.name,
					width = popup_width,
					align = "center",
					label = { string = device, color = color },
					click_script = 'SwitchAudioSource -s "'
						.. device
						.. '" && sketchybar --set /volume.device\\.*/ label.color='
						.. colors.text_secondary
						.. " --set $NAME label.color="
						.. colors.text,
				})
				counter = counter + 1
			end
		end)
	end)
end

local function volume_scroll(env)
	local delta = env.INFO.delta
	if not (env.INFO.modifier == "ctrl") then
		delta = delta * 10.0
	end

	sbar.exec('osascript -e "set volume output volume (output volume of (get volume settings) + ' .. delta .. ')"')
end

volume:subscribe("mouse.clicked", volume_toggle_details)
volume:subscribe("mouse.scrolled", volume_scroll)
volume:subscribe("mouse.exited.global", volume_collapse_details)
