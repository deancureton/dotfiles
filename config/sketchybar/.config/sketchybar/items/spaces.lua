local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

local spaces = {}

-- Add left padding to avoid notch
sbar.add("item", { position = "left", width = 8 })

for i = 1, 10, 1 do
	local space = sbar.add("space", "space." .. i, {
		space = i,
		icon = {
			font = { family = settings.font.numbers, style = settings.font.style_map["Bold"], size = 13.0 },
			string = i,
			padding_left = 10,
			padding_right = 12,
			color = colors.grey,
			highlight_color = colors.white,
		},
		label = {
			padding_right = 10,
			padding_left = 0,
			color = colors.grey_light,
			highlight_color = colors.white,
			font = "sketchybar-app-font:Regular:15.0",
		},
		padding_right = 2,
		padding_left = 2,
		background = {
			color = colors.transparent,
			border_color = colors.grey_dark,
			border_width = 1,
			height = 28,
			corner_radius = 7,
		},
		popup = { background = { border_width = 1, corner_radius = 9 } },
	})

	spaces[i] = space

	-- Padding space
	sbar.add("space", "space.padding." .. i, {
		space = i,
		script = "",
		width = settings.group_paddings,
	})

	local space_popup = sbar.add("item", {
		position = "popup." .. space.name,
		padding_left = 0,
		padding_right = 0,
		background = {
			drawing = true,
			image = {
				corner_radius = 9,
				scale = 0.2,
			},
		},
	})

	space:subscribe("space_change", function(env)
		local selected = env.SELECTED == "true"
		space:set({
			icon = { highlight = selected },
			label = { highlight = selected },
			background = {
				color = selected and colors.bg1 or colors.transparent,
				border_color = selected and colors.blue or colors.grey_dark,
			},
		})
	end)

	space:subscribe("mouse.clicked", function(env)
		if env.BUTTON == "other" then
			space_popup:set({ background = { image = "space." .. env.SID } })
			space:set({ popup = { drawing = "toggle" } })
		elseif env.BUTTON ~= "right" then
			sbar.exec("yabai -m space --focus " .. env.SID)
		end
	end)

	space:subscribe("mouse.exited", function(_)
		space:set({ popup = { drawing = false } })
	end)
end

local space_window_observer = sbar.add("item", {
	drawing = false,
	updates = true,
})

space_window_observer:subscribe("space_windows_change", function(env)
	local icon_line = ""
	local no_app = true
	for app, count in pairs(env.INFO.apps) do
		no_app = false
		local lookup = app_icons[app]
		local icon = ((lookup == nil) and app_icons["Default"] or lookup)
		icon_line = icon_line .. icon
	end

	if no_app then
		icon_line = "—  "
	end
	sbar.animate("tanh", 10, function()
		spaces[env.INFO.space]:set({ label = icon_line })
	end)
end)
