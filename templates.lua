
local templates = {}

templates.monster = {
    name = "Monstro",
    desc = "A savage monster!",
    glyph = 'M',
    mixins = {"drawable", "blocker"},
}

templates.player = {
    name = "Hiro",
    desc = "Our beloved protag!",
    mixins = {"drawable", "blocker", "player", "stats"}
}

return templates