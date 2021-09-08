local Entity = require 'entity'
local utils = require 'utils'
local terminal = require 'BearLibTerminal'
local templates = require 'templates'
local ROT = require 'lib.rotLove.src.rot'

local player = Entity(templates.player)

print(player.name)