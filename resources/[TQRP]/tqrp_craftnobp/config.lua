Config = {}

-- Isto é merda que nós usamos items
Config.WeaponAmmo = 42

Config.Recipes = {

	["pearl_b"] = {
		count = math.random(6,8),
		items =	{
			{item = "fabric", quantity = 5 },
			{item = "shell_a", quantity = 5 },
			{item = "fishingknife", quantity = 1 },
		}
	},

	["scrapmetal"] = {
		count = math.random(20,30),
		items =	{
			{item = "iron_piece", quantity = 5 },
			{item = "carbon_piece", quantity = 5 },
			{item = "blowtorch", quantity = 1 },
		}
	},

	["borracha"] = {
		count = math.random(20,25),
		items =	{
			{item = "water", quantity = 10 },
			{item = "pine_wood", quantity = 30 },
			{item = "blowtorch", quantity = 1 },
		}
	},

	["cabplastico"] = {
		count = math.random(5,10),
		items =	{
			{item = "borracha", quantity = 2 },
			{item = "fishingknife", quantity = 1 },
		}
	},

	["screwdriver"] = {
		count = math.random(2,4),
		items =	{
			{item = "cabplastico", quantity = 1 },
			{item = "lingot_iron", quantity = 1 },
			{item = "ducttape", quantity = 1 },
		}
	},

	["fishingknife"] = {
		count = math.random(3,5),
		items =	{
			{item = "lamina", quantity = 1 },
			{item = "cabplastico", quantity = 1 },
			{item = "lingot_iron", quantity = 1 },
			{item = "screw", quantity = 2 },
			{item = "screwdriver", quantity = 1 },
			{item = "blowtorch", quantity = 1 },
		}
	},

	["cabomadeira"] = {
		count = math.random(7,10),
		items =	{
			{item = "pine_processed", quantity = 20 },
			{item = "fishingknife", quantity = 1 },
			{item = "screwdriver", quantity = 1 },
		}
	},

	["copper"] = {
		count = math.random(8,10),
		items =	{
			{item = "blowtorch", quantity = 1 },
			{item = "lingot_gold", quantity = 1 },
			{item = "lingot_iron", quantity = 1 },
		}
	},

	["blowtorch"] = {
		count = math.random(3,5),
		items =	{
			{item = "lighter", quantity = 2 },
			{item = "copper", quantity = 2 },
			{item = "lingot_carbon", quantity = 2 },
		}
	},

	["wire"] = {
		count = math.random(5,10),
		items =	{
			{item = "lingot_iron", quantity = 10 },
			{item = "blowtorch", quantity = 1 },
		}
	},

	["lithium"] = {
		count = math.random(15,20),
		items =	{
			{item = "fishingknife", quantity = 1 },
			{item = "emptybottleglass", quantity = 10 },
			{item = "batteri", quantity = 20 },
		}
	},

	["fixkit"] = {
		count = math.random(8,10),
		items =	{
			{item = "lithium", quantity = 5 },
			{item = "borracha", quantity = 5 },
			{item = "screwdriver", quantity = 1 },
		}
	},

	["coffee"] = {
		count = math.random(8,10),
		items =	{
			{item = "water", quantity = 5 },
			{item = "graodecafe", quantity = 10 },
		}
	},

	["terra"] = {
		count = math.random(10,20),
		items =	{
			{item = "stone", quantity = 10 },
			{item = "blowtorch", quantity = 1 },
		}
	},

	["bobbypin"] = {
		count = math.random(10,15),
		items =	{
			{item = "scrapmetal", quantity = 10 },
			{item = "blowtorch", quantity = 1 },
		}
	},

	["saucisson"] = {
		count = math.random(20,30),
		items =	{
			{item = "fishingknife", quantity = 1 },
			{item = "jager", quantity = 20 },
			{item = "slaughtered_chicken", quantity = 10 },
		}
	},

	["highgradefert"] = {
		count = math.random(18,25),
		items =	{
			{item = "fishingknife", quantity = 1 },
			{item = "cascadebanana", quantity = 10 },
			{item = "terra", quantity = 10 },
		}
	},

	["Pentrite"] = {
		count = math.random(15,20),
		items =	{
			{item = "acidbat", quantity = 20 },
			{item = "borracha", quantity = 20 },
			{item = "fishingknife", quantity = 1 },
		}
	},

	["disc_ammo_smg"] = {
		count = math.random(8,10),
		items =	{
			{item = "Pentrite", quantity = 20 },
			{item = "scrapmetal", quantity = 20 },
			{item = "blowtorch", quantity = 1 },
		}
	},

	["disc_ammo_pistol"] = {
		count = math.random(8,10),
		items =	{
			{item = "Pentrite", quantity = 10 },
			{item = "scrapmetal", quantity = 20 },
			{item = "blowtorch", quantity = 1 },
		}
	},

	["HeavyArmor"] = {
		count = math.random(2,3),
		items =	{
			{item = "fabric", quantity = 2 },
			{item = "ducttape", quantity = 1 },
			{item = "fishingknife", quantity = 1 },
			{item = "copper", quantity = 2 },
			{item = "scrapmetal", quantity = 5 },
		}
	},

	["bandage"] = {
		count = math.random(15,20),
		items =	{
			{item = "fabric", quantity = 5 },
			{item = "bobbypin", quantity = 5 },
			{item = "fishingknife", quantity = 1 },
			{item = "ducttape", quantity = 5 },
		}
	},

	["gauze"] = {
		count = math.random(8,12),
		items =	{
			{item = "fabric", quantity = 5 },
			{item = "bobbypin", quantity = 5 },
			{item = "fishingknife", quantity = 1 },
		}
	},

	["md"] = {
		count = math.random(12,15),
		items =	{
			{item = "anchor", quantity = 5 },
			{item = "bagofdope", quantity = 1 },
			{item = "fishingknife", quantity = 1 },
		}
	}
}

-- Caga nisto,o Conde obrigou me a fazer isto por comando
Config.Shop = {
	useShop = false,
	shopCoordinates = { x=962.5, y=-1585.5, z=29.6 },
	shopName = "Crafting Station",
	shopBlipID = 446,
	zoneSize = { x = 2.5, y = 2.5, z = 1.5 },
	zoneColor = { r = 255, g = 0, b = 0, a = 100 }
}

-- AHAHAHA nem pensar
Config.Keyboard = {
	useKeyboard = false,
	keyCode = 10
}


