local mixins = {}
local utils = require 'utils'

mixins.Drawable = {
    name = 'drawable',
    init = function(self, opts)
        self.glyph = opts.glyph or '@'
        self.color = opts.color or 'white'
    end,
}

mixins.Position = {
    name = 'position',
    init = function(self, opts)
        self.x = opts.x or 0
        self.y = opts.y or 0
        self.map_id = opts.map_id or "none"
    end,
}

mixins.BasicHealth = {
    name = 'basic-health',
    group = 'health',
    change_hp = function(self, amt)
        self.hp = utils.clamp(self.hp + amt, 0, self.max_hp)
    end,
    alive = function(self)
        return self.hp > 0
    end,
    init = function(self, opts)
        self.max_hp = opts.hp or 10
        self.hp = opts.max_hp
    end
}

mixins.Battery = {
    name = 'battery',
    group = 'health,charge',
    change_hp = function(self, amt)
        self.hp = utils.clamp(self.hp + amt, 0, self.max_hp)
    end,
    change_charge = function(self, amt)
        self.charge = utils.clamp(self.charge + amt, 0, self.max_charge)
    end,
    change_reserve = function(self, amt)
        self.max_charge = self.max_charge - amt
        self.reserve_charge = self.reserve_charge + amt
        self.charge = math.min(self.max_charge, self.charge)
    end,
    alive = function(self)
        return not (self.hp <= 0 and self.charge <= 0)
    end,
    init = function(self, opts)
        self.max_hp = opts.hp or 10
        self.max_charge = opts.charge or 10
        self.hp = self.max_hp
        self.charge = self.max_charge
        self.reserve_charge = 0
    end,
}

mixins.Identity = {
    name = 'identity',
    init = function(self, opts)
        self.name = opts.name or 'No name'
        self.desc = opts.desc or 'No desc'
    end
}

mixins.Player = {
    name = 'player',
    group = 'actor',
    act = function(self) 
        print(string.format("%s acts", self.name))
    end,
}

mixins.Monster = {
    name = 'monster',
    group = 'actor',
    act = function(self)
        print(string.format("%s acts", self.name))
    end,
}

return mixins