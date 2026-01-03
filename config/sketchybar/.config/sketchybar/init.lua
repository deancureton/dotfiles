-- Require the sketchybar module with error handling
local status, sketchybar_module = pcall(require, "sketchybar")
if not status then
	print("Error loading sketchybar module: " .. tostring(sketchybar_module))
	return
end
sbar = sketchybar_module

-- Bundle the entire initial configuration into a single message to sketchybar
local config_status, config_err = pcall(function()
	sbar.begin_config()
	require("bar")
	require("default")
	require("items")
	sbar.end_config()
end)

if not config_status then
	print("Error during configuration: " .. tostring(config_err))
	return
end

-- Run the event loop of the sketchybar module (without this there will be no
-- callback functions executed in the lua module)
sbar.event_loop()
