local ColoredRect = {}

function ColoredRect:new(rect, color)
	return {
		rect = rect,
		color = color
	}
end

return ColoredRect