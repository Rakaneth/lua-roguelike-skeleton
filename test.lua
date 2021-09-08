require("test_mixins")

local Entity = require("entity")
local templates = require("templates")

local good_guy = Entity(templates.player)
local bad_guy = Entity(templates.monster)

print(good_guy)
print(good_guy:print_stats())
print(bad_guy)

