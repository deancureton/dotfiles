local colors = require("colors")
local settings = require("settings")
local app_icons = require("helpers.app_icons")
app_icons["Spotifast"] = ":spotify:"

local spaces = {}
local active = {}
local WORKSPACE_COUNT = 5

sbar.add("event", "rift_update")

local function style(i, hovered)
	local selected = active[i] == true
	local fill = colors.transparent
	if selected then
		fill = colors.glass.active
	elseif hovered then
		fill = colors.glass.hover
	end
	spaces[i]:set({
		icon = { highlight = selected },
		label = { highlight = selected },
		background = { color = fill },
	})
end

local function update()
	sbar.exec(
		"rift-cli query workspaces 2>/dev/null | jq -r '.[] | \"\\(.index) \\(.is_active) \\([.windows[].app_name] | unique | join(\",\"))\"'",
		function(result)
			if type(result) ~= "string" then
				return
			end
			for line in result:gmatch("[^\n]+") do
				local idx, is_active, apps = line:match("^(%d+) (%a+) ?(.*)$")
				local i = tonumber(idx) and tonumber(idx) + 1
				if i and spaces[i] then
					active[i] = is_active == "true"
					style(i, false)

					local icons = {}
					for app_name in apps:gmatch("[^,]+") do
						icons[#icons + 1] = app_icons[app_name] or app_icons["Default"]
					end
					local empty = #icons == 0
					sbar.animate("tanh", 10, function()
						spaces[i]:set({
							icon = { padding_right = empty and 10 or 6 },
							label = {
								string = table.concat(icons, " "),
								padding_left = empty and 0 or 6,
								padding_right = empty and 0 or 11,
							},
						})
					end)
				end
			end
		end
	)
end

for i = 1, WORKSPACE_COUNT, 1 do
	local space = sbar.add("item", "space." .. i, {
		position = "left",
		icon = {
			font = { family = settings.font.numbers, style = "Semibold", size = 13.0 },
			string = i,
			padding_left = 10,
			padding_right = 10,
			color = colors.text_tertiary,
			highlight_color = colors.text,
		},
		label = {
			padding_left = 0,
			padding_right = 0,
			color = colors.text_secondary,
			highlight_color = colors.text,
			font = "sketchybar-app-font:Regular:14.0",
			-- the icon font has no space glyph; the fallback space shifts the line box up
			y_offset = -1,
			string = "",
		},
		padding_left = 1,
		padding_right = 1,
		background = {
			color = colors.transparent,
			height = 26,
			corner_radius = 13,
		},
	})

	spaces[i] = space

	space:subscribe("mouse.clicked", function(env)
		if env.BUTTON ~= "right" then
			sbar.exec("rift-cli execute workspace switch " .. (i - 1))
		end
	end)
	space:subscribe("mouse.entered", function()
		style(i, true)
	end)
	space:subscribe("mouse.exited", function()
		style(i, false)
	end)
end

local rift_observer = sbar.add("item", {
	drawing = false,
	updates = true,
})

rift_observer:subscribe("rift_update", update)

update()
