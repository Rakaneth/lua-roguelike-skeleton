local utils = require("utils")
local Mixin = require("mixin")[1]
local mixins = {}

--basic
mixins.drawable = Mixin("drawable", "drawable", 1, {
    on_create = function(self, template)
        self.glyph = template.glyph or '@'
        self.color = template.color or "White"
    end
})

--flags
mixins.blocking = Mixin("blocker", "blocker", 1)
mixins.player = Mixin("player", "actor", 1)

--interface
mixins.stats = Mixin("stats", "stats", 1, {
    get_stat = function(self, stat)
        if self.stats[stat] ~= nil then
            return 0
        end
        return self.stats[stat]
    end,
    print_stats = function(self)
        local base = "Str: %d, Stam: %d, Mgc: %d"
        return string.format(base, self.stats.str, self.stats.stam, self.stats.mgc)
    end,
    on_create = function(self, template)
        self.stats = {str = 10, stam = 5, mgc = 0}
    end,
})

return mixins




