local Point = require "Vector2d"

local RectMT = {}
RectMT.__index = RectMT

function RectMT:size()
	return self.rd - self.lu + Point.new(1, 1)
end

function RectMT:neighborDirection(otherRect)
	local function checkCoordForEquality(coord)
		return self.lu[coord] == otherRect.lu[coord] and
			self.rd[coord] == otherRect.rd[coord]
	end
	local dx, dy
	if checkCoordForEquality("x") then
		dx = 0
		dy = self.lu < otherRect.lu and 1 or -1
	elseif checkCoordForEquality("y") then
		dy = 0
		dx = self.lu < otherRect.lu and 1 or -1
	else
		return nil
	end
	return Vector2d.new(dx, dy)
end

function RectMT:__add(otherRect)

end

function RectMT:split()

end


local Rect = {}

function Rect:new(p1, p2)
	if p1 > p2 then 
		p1, p2 = p2, p1
	end
	local rect = {
		lu = p1,
		rd = p2
	}
	return setmetatable(rect, RectMT)
end


return Rect
