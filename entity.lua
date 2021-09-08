local Entity = (require 'class'):extend("Entity")
local utils = require 'utils'
local mixmod = require("mixin")
local _, MIXIN_DIR = table.unpack(mixmod)

function Entity:init(template, id, name)
    template = template or {}
    self.mixins = {}
    self.groups = {}
    self.x = 0
    self.y = 0
    self.id = id or utils.uuid()
    self.name = name or template.name or "No name"
    if template.mixins then
        for _, mixin in ipairs(template.mixins) do
            self:add(MIXIN_DIR[mixin], template)
        end
    end
end

function Entity:has(mixin_or_group)
    return self.mixins[mixin_or_group] or self.groups[mixin_or_group]
end

function Entity:add(mixin, template)
    local tmp = utils.clone(template)
    local exclude = "on_create"
    if self:has(mixin.name) then return end
    if mixin.name then self.mixins[mixin.name] = true end
    if mixin.groups then
        for g in (mixin.groups):gmatch("([^,]*)") do
            self.groups[g] = true
        end
    end
    if (mixin.iface) then
        for k, f in pairs(mixin.iface) do
            if type(f) == 'function' and not utils.contains(exclude, k) then
                self[k] = f
            end
        end
        if mixin.iface.on_create then mixin.iface.on_create(self, template) end     
    end
    
end

function Entity:__tostring()
    local base = "Name: %s\nMixins: %s\nGroups: %s"
    local mixins = ""
    local groups = ""
    for m, _ in pairs(self.mixins) do
        mixins = mixins .. m .. " "
    end
    for g, _ in pairs(self.groups) do
        groups = groups .. g .. " "
    end
    return base:format(self.name, mixins, groups)
end

return Entity