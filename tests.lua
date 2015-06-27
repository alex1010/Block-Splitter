local luaunit = require "luaunit"
local Rect = require "Rect"
local Point = require "Vector2d"

local lu = Point.new(5, 2)
local rd = Point.new(3, 8)
local rect = Rect:new(lu, rd)

function testRectCreation()
	
	luaunit.assertEquals(rect.lu.x, 3)
	luaunit.assertEquals(rect.lu.y, 2)
	luaunit.assertEquals(rect.rd.x, 5)
	luaunit.assertEquals(rect.rd.y, 8)
end

function testRectSize()
	local w, h = rect:size()()
	luaunit.assertEquals(w, 3)
	luaunit.assertEquals(h, 7)
end

luaunit.LuaUnit.run()
-- os.exit( luaunit.LuaUnit.run() )