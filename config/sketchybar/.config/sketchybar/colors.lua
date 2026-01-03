return {
	-- Core colors with improved contrast and depth
	black = 0xff0a0e14,
	white = 0xfff2f2f7,

	-- Refined accent palette
	red = 0xffff6b7f,
	green = 0xff98e6a8,
	blue = 0xff78c9ff,
	yellow = 0xffffe066,
	orange = 0xffffaa66,
	magenta = 0xffc792ff,
	cyan = 0xff6be6e6,

	-- Sophisticated greys
	grey = 0xff8a91a3,
	grey_dark = 0xff4a5060,
	grey_light = 0xffa8b0c2,

	transparent = 0x00000000,

	-- Bar styling with subtle depth
	bar = {
		bg = 0xf0151820,        -- Slightly more opaque for depth
		border = 0x60404859,     -- Subtle border
		shadow = 0x40000000,     -- Subtle shadow
	},

	-- Popup styling with glass morphism
	popup = {
		bg = 0xf01e222a,         -- Rich, darker background
		border = 0x80505768,     -- Defined but soft border
		shadow = 0x60000000,     -- Deeper shadow for elevation
	},

	-- Background accent colors
	bg1 = 0x4025293a,           -- Subtle highlight
	bg2 = 0xff2a2e38,           -- Stronger background accent
	bg_hover = 0x80353945,      -- Interactive hover state

	-- Gradient support
	gradient = {
		top = 0xff1a1e26,
		bottom = 0xff151920,
	},

	with_alpha = function(color, alpha)
		if alpha > 1.0 or alpha < 0.0 then
			return color
		end
		return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
	end,
}
