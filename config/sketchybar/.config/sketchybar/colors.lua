local function with_alpha(color, alpha)
	if alpha > 1.0 or alpha < 0.0 then
		return color
	end
	return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
end

local white = 0xffffffff

return {
	white = white,
	transparent = 0x00000000,

	-- macOS dark-mode system palette
	red = 0xffff453a,
	green = 0xff30d158,
	blue = 0xff0a84ff,
	yellow = 0xffffd60a,
	orange = 0xffff9f0a,

	text = white,
	text_secondary = with_alpha(white, 0.8),
	text_tertiary = with_alpha(white, 0.5),

	bar = {
		overlay = 0x0a000000,
	},

	glass = {
		fill = with_alpha(white, 0.12),
		border = with_alpha(white, 0.15),
		hover = with_alpha(white, 0.08),
		active = with_alpha(white, 0.25),
	},

	popup = {
		bg = 0x991a1d24,
		border = with_alpha(white, 0.15),
		shadow = 0x50000000,
	},

	with_alpha = with_alpha,
}
