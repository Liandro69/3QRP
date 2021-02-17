Config = {}

Config.Debug = false -- only in dev mode.

Config.MarkerData = {
    ["type"] = 6,
    ["size"] = vector3(2.0, 2.0, 2.0),
    ["color"] = vector3(0, 255, 150)
}

Config.FishingRestaurant = {
    ["name"] = "La Spada Marisqueira",
    ["blip"] = {
        ["sprite"] = 628,
        ["color"] = 3
    },
    ["ped"] = {
        ["model"] = 0xED0CE4C6,
        ["position"] = vector3(271.38, -979.01, 29.37),
        ["heading"] = 174.69
    }
}

Config.FishingItems = {
    ["rod"] = {
        ["name"] = "fishingrod",
        ["label"] = "Cana de Pesca"
    },
    ["bait"] = {
        ["name"] = "fishbait",
        ["label"] = "Isco de Peixe"
    },
    ["fish"] = {
        ["name"] = "fish",
        ["label"] = "Peixe cru",
        ["price"] = math.random( 15,20 ) -- Preço random
    }
}

Config.Command = "none" -- if set to "" or "none" command will not work. otherwise item use will be used.