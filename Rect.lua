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
		return x % 2 == 0 and x / 2 ~= 1
	end
	while canDivide(w) and canDivide(h) do
		w, h = w / 2, h / 2
		powerOf2 = powerOf2 + 1
	end
	if powerOf2 == 0 then return nil end
	local result = {}
	for i = self.lu.x, self.rd.x, powerOf2 do
		for j = self.lu.y, self.rd.y, powerOf2 do
			local nextLU = Point.new(i, j)
			local nextRD = Point.new(i + powerOf2 - 1, j + powerOf2 - 1)
			result[#result + 1] = Rect:new(nextLU, nextRD)
		end
	end
	return result
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
