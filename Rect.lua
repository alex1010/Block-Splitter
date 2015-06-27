local Point = require "Vector2d"

local RectMT = {}
RectMT.__index = RectMT

function RectMT:size()
	return self.rd - self.lu + Point.new(1, 1)
end

function RectMT:neighborDirection(otherRect)

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
