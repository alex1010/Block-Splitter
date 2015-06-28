local blocks = {}
local ColoredRect = require "ColoredRect"
local Rect = require "Rect"
local Point = require "Vector2d"

function blocks:setup(setupTable)
	self.blocks = {}
	for i = 1, #setupTable do 
		local setupItem = setupTable[i]
		local rect = Rect:new(Point.new(setupItem[1], setupItem[2]), Point.new(setupItem[3], setupItem[4]))
		local color = setupItem[5]
		local coloredRect = ColoredRect:new(rect, color)
		self.blocks[i] = coloredRect
	end
end

function blocks:idForPoint(point)
	for i = 1, #self.blocks do

	end
end

function blocks:split(point)
end

function blocks:merge(point, direction)

end

function blocks:swap(point, direction)

end

return blocks