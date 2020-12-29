JAM.VehicleShop = {}
local JVS = JAM.VehicleShop
JVS.ESX = JAM.ESX

JVS.DrawTextDist = 4.0
JVS.MenuUseDist = 3.0
JVS.SpawnVehDist = 50.0
JVS.VehRetDist = 5.0

JVS.CarDealerJobLabel = "cardealer"
JVS.DealerMarkerPos = vector3(-807.61, -203.4, 37.08)

-- Why vector4's, you ask?
-- X, Y, Z, Heading.

JVS.PurchasedCarPos = vector4(-768.54, -244.59, 37.08, 204.51)
JVS.PurchasedUtilPos = vector4(-17.88, -1113.94, 26.67, 158.04)

JVS.SmallSpawnVeh = 'monroe'
JVS.SmallSpawnPos = vector4(-783.11, -223.33, 36.05, 136.79)

JVS.LargeSpawnVeh = 'actros'
JVS.LargeSpawnPos = vector4(-764.07, -242.43, 36.81, 197.14)

JVS.DisplayPositions = {
	[1] = vector4(-787.32, -242.27, 36.81, 79.91),
	[2] = vector4(-789.36, -237.88, 36.81, 76.18),
	[3] = vector4(-793.01, -233.50, 36.81, 79.2),
	[4] = vector4(-794.41, -227.44, 37.08, 76.10),
	[5] = vector4(-790.64, -224.2, 36.81, 146.53),
	[6] = vector4(-788.07, -230.81, 36.58, 43.20)
}

JVS.Blips = {
	CityShop = {
		Zone = "Lux Concessionária",
		Sprite = 225,
		Scale = 0.6,
		Display = 1,
		Color = 4,
		Pos = { x = -806.75, y = -225.8, z = 37.23 },
	}
}
