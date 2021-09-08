local Mixin = require("class"):extend("Mixin")

local MIXIN_DIR = {}

function Mixin:init(name, groups, level, iface)
    self.name = name --Name of the mixin
    self.groups = groups --Name of the groups it belongs to
    self.level = level 
    self.iface = iface 
    MIXIN_DIR[name] = self
end

return {Mixin, MIXIN_DIR}

