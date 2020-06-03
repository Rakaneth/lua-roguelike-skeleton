local Entity = (require 'class'):extend("Entity")
local utils = require 'utils'

function Entity:init(opts)
    opts = opts or {}
    self.mixins = {}
    self.groups = {}
    self.id = opts.id or utils.uuid()
    if opts.mixins then
        for _, mixin in ipairs(opts.mixins) do
            self:add(mixin, opts)
        end
    end
end

function Entity:has(mixin_or_group)
    return self.mixins[mixin_or_group] or self.groups[mixin_or_group]
end

function Entity:add(mixin, opts)
    opts = opts or {}
    if mixin.name then self.mixins[mixin.name] = true end
    if mixin.group then
        for g in (mixin.group):gmatch("([^,]*)") do
            self.groups[g] = true
        end
    end
    for k, f in pairs(mixin) do 
        if type(f) == 'function' and k ~= 'init' then
            self[k] = f
        end
    end
    if mixin.init then mixin.init(self, opts) end
end

return Entity