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

function blocks:enumerate(f)
	for id, coloredRect in pairs(self.blocks) do
		local skip = f(id, coloredRect)
		if skip then return end
	end	
end

function blocks:idForPoint(point)
	local result
	self:enumerate(function (id, coloredRect)
		if coloredRect.rect:containsPoint(point) then
			result = id
			return true
		end
	end)
	return result
end

function blocks:getFreeId()
	local id = 1
	while self.blocks[id] do
		id = id + 1
	end
	return id
end

function blocks:split(point)
	local id = self:idForPoint(point)
	local coloredRect = self.blocks[id]
	local rect = coloredRect.rect
	local color = coloredRect.color
	local subrects = rect:split()
	self.blocks[id] = nil
	for i = 1, #subrects do
		local nextId = self:getFreeId()
		local subrect = subrects[i]
		local coloredSubRect = ColoredRect:new(subrect, color)
		self.blocks[nextId] = coloredSubRect
	end
end

function blocks:merge(point, direction)

end

function blocks:swap(point, direction)

end

return blocks