local luaunit = require "luaunit"
local Rect = require "Rect"
local Point = require "Vector2d"
local blocks = require "blocks"

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

function testSplit()
	local splitResult = rect:split()
	luaunit.assertEquals(#splitResult, 21)
end

local r1 = Rect:new(Point.new(1, 1), Point.new(2, 2))
local r2 = Rect:new(Point.new(3, 1), Point.new(5, 3))
local r3 = Rect:new(Point.new(3, 1), Point.new(5, 2))

function testAdd()
	luaunit.assertNil(r1 + r2)
	luaunit.assertNotNil(r1 + r3)
end

function testNeighborDirection()
	local direction = r1:neighborDirection(r3)
	luaunit.assertEquals(direction.x, 1)
	luaunit.assertEquals(direction.y, 0)
end

function testContainsPoint()
	local p1 = Point.new(3, 3)
	local p2 = Point.new(10, 20)
	local p3 = Point.new(3, 20)
	local p4 = Point.new(5, 2)
	luaunit.assertTrue(rect:containsPoint(p1))
	luaunit.assertFalse(rect:containsPoint(p2))
	luaunit.assertFalse(rect:containsPoint(p3))
	luaunit.assertTrue(rect:containsPoint(p4))
end

blocks:setup {
	{1, 1, 2, 2, 1},
	{3, 1, 5, 3, 2},
	{1, 3, 2, 3, 3}
}

function testSetup()

	luaunit.assertEquals(blocks.blocks[1].rect.lu.y, 1)
	luaunit.assertEquals(blocks.blocks[2].color, 2)
	luaunit.assertEquals(blocks.blocks[3].rect.rd.x, 2)
end

function testIdForPoint()
	luaunit.assertEquals(blocks:idForPoint(Point.new(2, 1)), 1)
	luaunit.assertNil(blocks:idForPoint(Point.new(100, 100)))
	luaunit.assertEquals(blocks:idForPoint(Point.new(3, 1)), 2)
end

function testFreeId()
	luaunit.assertEquals(blocks:getFreeId(), 4)
end


luaunit.LuaUnit.run()
-- os.exit( luaunit.LuaUnit.run() )