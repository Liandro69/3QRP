Config        = {}
Config.Locale = 'en'

--[[
	You can add more places by copying the template
]]

Config.Zones = {
	[1] = { -- This is the place name/tag

		["Blip"] = {
			["Name"] 	 = _U('boathiring'),
			["Position"] = vector3(-879.37, -1454.65, 1.6),
			["Sprite"]	 = 410,
			["Display"]	 = 4,
			["Scale"]	 = 0.6,
			["Color"] 	 = 57,
		},

		["LeaveBoatBlip"] = {
			["Name"] 	 = _U('boathiring'),
			["Position"] = vector3(-891.65, -1451.95, 0.52),
			["Sprite"]	 = 1,
			["Display"]	 = 4,
			["Scale"]	 = 0.6,
			["Color"] 	 = 57,
		},

		["Info"] = {
			{
				["Title"] 			= _U('boathiring'),
				["BridgePosition"]	= vector3(-882.11, -1442.23, 3.7),
				["BridgeHeading"]	= 87.93,
				-- Boat Spawning position
				["SpawnPosition"] = {
					["Coords"]	= vector3(-882.11, -1442.23, 3.7),
					["Heading"] = 87.93,
				},
				-- Camera position and rotation
				["Camera"] = {
					['Pos'] 	 = vector3(-882.37, -1454.65, 8.6),
					["Rotation"] = vector3(-30.0, -5.0, -20.0)
				}
			}
		},

		["HireBoat"] = {
			{
				["Coords"] 		 = vector3(-879.37, -1454.65, 1.6),
				["Text"] 		 = _U('boathiring'),
				["Color"] 		 = { r = 242, g = 127, b = 5 },
				["Radius"] 		 = 0.6,
				["DrawDistance"] = 10.0,
				["Opacity"] 	 = 150,
				["Type"] 		 = 6
			}
		},

		["LeaveBoat"] = {
			{
				["Text"] 		 = _U('Leave_Boat'),
				["Coords"] 		 = vector3(-884.66, -1460.12, 0.09),
				["Color"] 		 = { r = 242, g = 127, b = 5 },
				["Radius"] 		 = 4.6,
				["DrawDistance"] = 25.0,
				["Opacity"] 	 = 150,
				["Type"] 		 = 6
			}
		},

	}
}

Config.Boats = { -- You can add more boats here..
	[1] = { -- This must match with the right place
		{ model = 'TORO', 			plate = 'HYRES', price = 800, job = nil, label = 'Lampadati Toro' },
		{ model = 'TORO2', 			plate = 'HYRES', price = 1000, job = nil, label = 'Lampadati Toro 2.0' },
		{ model = 'SUNTRAP',	 	plate = 'HYRES', price = 750, job = nil, label = 'Shitzu Soundtrap' },
		{ model = 'Dinghy4',	 	plate = 'HYRES', price = 1200, job = nil, label = 'Nagasaki Dinghy' },
		{ model = 'Dinghy', 		plate = 'HYRES', price = 1500, job = nil, label = 'Nagasaki Dinghy 2.0' },
		{ model = 'Jetmax', 		plate = 'HYRES', price = 2000, job = nil, label = 'Shitzu Jetmax' },
		{ model = 'Marquis', 		plate = 'HYRES', price = 2500, job = nil, label = 'Dinka Marquis' },
		{ model = 'Speeder', 		plate = 'HYRES', price = 1500, job = nil, label = 'Pegassi Speeder'},
		{ model = 'Speeder2', 		plate = 'HYRES', price = 1750, job = nil, label = 'Pegassi Speed 2.0' },
		{ model = 'Squalo', 		plate = 'HYRES', price = 1500, job = nil, label = 'Shitzu Squalo' },
		{ model = 'Tropic', 		plate = 'HYRES', price = 500, job = nil, label = 'Shitzu Tropic' },
		{ model = 'Tropic2', 		plate = 'HYRES', price = 750, job = nil, label = 'Shitzu Tropic' },
		{ model = 'Tug', 			plate = 'HYRES', price = 150, job = nil, label = 'Tug' },
		{ model = 'Seashark', 		plate = 'HYRES', price = 1200, job = nil, label = 'Speedophile Seashark' },
		{ model = 'Seashark3', 		plate = 'HYRES', price = 1200, job = nil, label = 'Speedophile Seashark 2.0' },
		--{ model = 'Submersible', 	plate = 'HYRES', price = 15000, job = nil, label = 'Submersible' },
		--{ model = 'Submersible2', 	plate = 'HYRES', price = 15500, job = nil, label = 'Kraken' },
	}
}