local Point = require "Vector2d"

local RectMT = {}
RectMT.__index = RectMT

local Rect = {}

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
		dy = self.lu <= otherRect.lu and 1 or -1
	elseif checkCoordForEquality("y") then
		dy = 0
		dx = self.lu <= otherRect.lu and 1 or -1
	else
		return nil
	end
	return Point.new(dx, dy)
end

function RectMT:__add(otherRect)
	local direction = self:neighborDirection(otherRect)
	if direction then
		local minLU = self.lu < otherRect.lu and self.lu or otherRect.lu
		local maxRD = self.rd > otherRect.rd and self.rd or otherRect.rd
		return Rect:new(minLU, maxRD)
	else
		return nil
	end
end

function RectMT:split()
	local w, h = self:size()()
	local powerOf2 = 0
	local function canDivide(x)
		return x % 2 == 0 and x / 2 > 1
	end
	while canDivide(w) and canDivide(h) do
		w, h = w / 2, h / 2
		powerOf2 = powerOf2 + 1
	end
	local result = {}
	local twoPowered = 2^powerOf2
	for i = self.lu.x, self.rd.x, twoPowered do
		for j = self.lu.y, self.rd.y, twoPowered do
			local nextLU = Point.new(i, j)
			local nextRD = Point.new(i + twoPowered - 1, j + twoPowered - 1)
			result[#result + 1] = Rect:new(nextLU, nextRD)
		end
	end
	return result
end

function RectMT:containsPoint(p)
	return p >= self.lu and p <= self.rd
end


function Rect:new(p1, p2)
	local min, max = math.min, math.max
	local minX, minY = min(p1.x, p2.x), min(p1.y, p2.y)
	local maxX, maxY = max(p1.x, p2.x), max(p1.y, p2.y)
	p1, p2 = Point.new(minX, minY), Point.new(maxX, maxY)
	local rect = {
		lu = p1,
		rd = p2
	}
	return setmetatable(rect, RectMT)
end


return Rect
