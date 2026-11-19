local icons = require("icons")
local colors = require("colors")

-- Event provider: fires "network_update" for en0 every 2 seconds
sbar.exec(
	"killall network_load >/dev/null; $CONFIG_DIR/helpers/event_providers/network_load/bin/network_load en0 network_update 2.0"
)

local popup_width = 260

local wifi = sbar.add("item", "widgets.wifi", {
	position = "right",
	icon = {
		string = icons.wifi.connected,
		padding_left = 10,
		padding_right = 10,
		font = { size = 14.0 },
	},
	label = { drawing = false },
	padding_left = 0,
	padding_right = 0,
	updates = true,
	popup = { align = "center" },
})

local ssid = sbar.add("item", {
	position = "popup." .. wifi.name,
	icon = {
		font = { style = "Semibold" },
		string = icons.wifi.router,
	},
	width = popup_width,
	align = "center",
	label = {
		font = { size = 14, style = "Semibold" },
		max_chars = 20,
		string = "????????????",
	},
	background = {
		height = 1,
		corner_radius = 0,
		color = colors.glass.border,
		y_offset = -15,
	},
})

local function popup_row(key, value)
	return sbar.add("item", {
		position = "popup." .. wifi.name,
		icon = {
			align = "left",
			string = key,
			color = colors.text_secondary,
			width = popup_width / 2,
		},
		label = {
			string = value,
			max_chars = 20,
			width = popup_width / 2,
			align = "right",
		},
	})
end

local speed = popup_row("Speed", "↑ 0 B/s  ↓ 0 B/s")
local hostname = popup_row("Hostname", "????????????")
local ip = popup_row("IP", "???.???.???.???")
local mask = popup_row("Subnet mask", "???.???.???.???")
local router = popup_row("Router", "???.???.???.???")

wifi:subscribe("network_update", function(env)
	speed:set({ label = "↑ " .. env.upload .. "  ↓ " .. env.download })
end)

wifi:subscribe({ "wifi_change", "system_woke" }, function(env)
	sbar.exec("ipconfig getifaddr en0", function(result)
		local connected = result ~= ""
		wifi:set({
			icon = {
				string = connected and icons.wifi.connected or icons.wifi.disconnected,
				color = connected and colors.text or colors.text_tertiary,
			},
		})
	end)
end)

local function hide_details()
	wifi:set({ popup = { drawing = false } })
end

local function trim(result)
	return (tostring(result):gsub("%s+$", ""))
end

local function toggle_details()
	local should_draw = wifi:query().popup.drawing == "off"
	if not should_draw then
		hide_details()
		return
	end
	wifi:set({ popup = { drawing = true } })
	sbar.exec("networksetup -getcomputername", function(result)
		hostname:set({ label = trim(result) })
	end)
	sbar.exec("ipconfig getifaddr en0", function(result)
		ip:set({ label = trim(result) })
	end)
	sbar.exec("ipconfig getsummary en0 | awk -F ' SSID : '  '/ SSID : / {print $2}'", function(result)
		ssid:set({ label = trim(result) })
	end)
	sbar.exec("networksetup -getinfo Wi-Fi | awk -F 'Subnet mask: ' '/^Subnet mask: / {print $2}'", function(result)
		mask:set({ label = trim(result) })
	end)
	sbar.exec("networksetup -getinfo Wi-Fi | awk -F 'Router: ' '/^Router: / {print $2}'", function(result)
		router:set({ label = trim(result) })
	end)
end

wifi:subscribe("mouse.clicked", toggle_details)
wifi:subscribe("mouse.exited.global", hide_details)

local function copy_label_to_clipboard(env)
	local label = sbar.query(env.NAME).label
	sbar.exec("printf %s '" .. label.value:gsub("'", "'\\''") .. "' | pbcopy")
	sbar.set(env.NAME, { label = { string = icons.clipboard, align = "center" } })
	sbar.delay(1, function()
		sbar.set(env.NAME, { label = { string = label.value, align = label.align } })
	end)
end

ssid:subscribe("mouse.clicked", copy_label_to_clipboard)
hostname:subscribe("mouse.clicked", copy_label_to_clipboard)
ip:subscribe("mouse.clicked", copy_label_to_clipboard)
mask:subscribe("mouse.clicked", copy_label_to_clipboard)
router:subscribe("mouse.clicked", copy_label_to_clipboard)
