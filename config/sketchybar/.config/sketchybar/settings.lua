return {
	paddings = 3,
	group_paddings = 5,

	icons = "NerdFont", -- alternatively available: sf-symbols

	-- This is a font configuration for JetBrainsMono Nerd Font
	font = {
		text = "JetBrainsMono Nerd Font", -- Used for text
		numbers = "JetBrainsMono Nerd Font", -- Used for numbers
		style_map = {
			["Regular"] = "Regular",
			["Semibold"] = "Medium",
			["Bold"] = "SemiBold",
			["Heavy"] = "Bold",
			["Black"] = "ExtraBold",
		},
	},

	-- Alternatively, this is a font config for SF Pro and SF Mono (installed manually)
	-- font = require("helpers.default_font"),
}
