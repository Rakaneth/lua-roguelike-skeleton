local mixins = require 'mixins'
local draw = mixins.Drawable
local pos = mixins.Position
local health = mixins.BasicHealth
local id = mixins.Identity
local battery = mixins.Battery
local player = mixins.Player
local monster = mixins.Monster
local templates = {}

templates.orc = {
    mixins = {draw, pos, health, id, monster},
    x = 12,
    y = 7,
    glyph = 'o',
    color = 'green',
    hp = 25,
    name = 'orc',
    desc = 'A bigass smelly Orc',
    tier = 2,
    freq = 5,
}

templates.rat = {
    mixins = {draw, pos, health, id},
    glyph = 'r',
    color = 'brown',
    hp = 4,
    name = 'rat',
    desc = 'A tiny rat',
    tier = 1,
    freq = 10,
}

templates.wolf = {
    mixins = {draw, pos, health, id},
    glyph = 'W',
    color = 'grey',
    hp = 15,
    name = 'wolf',
    desc = 'A big scary wolf',
    tier = 1,
    freq = 4,
}

templates.gobbo = {
    mixins = {draw, pos, health, id, monster},
    glyph = 'g',
    color = 'red',
    hp = 10,
    name = 'gobbo',
    desc = 'A smol reeky gobbo',
    tier = 1,
    freq = 15,
}

templates.player = {
    mixins = {draw, pos, id, battery, player},
    glyph = '@',
    color = 'white',
    hp = 15,
    charge = 5,
    name = 'Player',
    desc = 'The heroic Player!',
}

return templates