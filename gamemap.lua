local ROT = require("lib.rotLove.src.rot")
local Grid = ROT.Type.Grid
local PointSet = ROT.Type.PointSet
local GameMap = require("class"):extend("GameMap")
local utils = require("utils")

--Tiles reminder
local NULL_TILE = -1
local FLOOR = 0
local WALL = 1
local DOOR = 2

function GameMap:init(id, name, width, height, dark, wall_gfx, floor_gfx)
    self.tiles = Grid()
    self.floors = PointSet()
    self.width = width
    self.height = height
    self.dark = dark
    self.name = name
    self.id = id
    self.wall_gfx = wall_gfx
    self.floor_gfx = floor_gfx
end

function GameMap:inBounds(x, y)
    return utils.between(x, 0, self.width-1) and utils.between(y, 0, self.height-1)
end

function GameMap:getTile(x, y)
    if self:inBounds(x, y) then
        return self.tiles:getCell(x, y)
    end

    return NULL_TILE
end

function GameMap:setTile(x, y, t)
    if self:inBounds(x, y) then
        self.tiles:setCell(x, y, t)
        if t == FLOOR then
            self.floors:push(x, y)
        else
            self.floors:prune(x, y)
        end
    end
end