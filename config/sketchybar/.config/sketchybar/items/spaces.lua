local colors = require("colors")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

local spaces = {}
local WORKSPACE_COUNT = 5

-- Register custom rift event
sbar.add("event", "rift_update")

-- Add left padding to avoid notch
sbar.add("item", { position = "left", width = 8 })

-- Helper: query rift and update all workspace icons
local function update_all_icons()
	sbar.exec(
		"rift-cli query workspaces 2>/dev/null | jq -r '.[] | \"\\(.index) \\([.windows[].app_name] | unique | join(\",\"))\"'",
		function(result)
			if not result then return end
			for line in result:gmatch("[^\n]+") do
				local idx_str, apps_str = line:match("^(%d+)%s*(.*)")
				local idx = tonumber(idx_str)
				if idx and spaces[idx + 1] then
					local icon_line = ""
					if apps_str and apps_str ~= "" then
						for app_name in apps_str:gmatch("[^,]+") do
							local lookup = app_icons[app_name]
							icon_line = icon_line .. (lookup or app_icons["Default"])
						end
					end
					if icon_line == "" then icon_line = "—  " end
					sbar.animate("tanh", 10, function()
						spaces[idx + 1]:set({ label = icon_line })
					end)
				end
			end
		end
	)
end

-- Helper: query rift and highlight active workspace
local function update_highlight()
	sbar.exec(
		"rift-cli query workspaces 2>/dev/null | jq -r '.[] | \"\\(.index) \\(.is_active)\"'",
		function(result)
			if not result then return end
			for line in result:gmatch("[^\n]+") do
				local idx_str, active_str = line:match("^(%d+)%s+(%a+)")
				local idx = tonumber(idx_str)
				if idx and spaces[idx + 1] then
					local selected = (active_str == "true")
					spaces[idx + 1]:set({
						icon = { highlight = selected },
						label = { highlight = selected },
						background = {
							color = selected and colors.bg1 or colors.transparent,
							border_color = selected and colors.blue or colors.grey_dark,
						},
					})
				end
			end
		end
	)
end

for i = 1, WORKSPACE_COUNT, 1 do
	local space = sbar.add("item", "space." .. i, {
		position = "left",
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
			string = "—  ",
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
	})

	spaces[i] = space

	-- Padding item
	sbar.add("item", "space.padding." .. i, {
		position = "left",
		width = settings.group_paddings,
	})

	-- Click to switch rift workspace (0-indexed)
	space:subscribe("mouse.clicked", function(env)
		if env.BUTTON ~= "right" then
			sbar.exec("rift-cli execute workspace switch " .. (i - 1))
		end
	end)
end

-- Single observer for all rift events
local rift_observer = sbar.add("item", {
	drawing = false,
	updates = true,
})

rift_observer:subscribe("rift_update", function(_)
	update_highlight()
	update_all_icons()
end)

-- Set initial state
update_highlight()
update_all_icons()
