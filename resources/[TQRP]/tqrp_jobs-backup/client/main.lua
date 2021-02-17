ESX = nil
X = {}
X.isOpen = false
X.allDone = false
X.LastShop = nil
X.Material = nil
X.ActualWarehouse = nil
X.Option = nil
X.IsSelecting = false
X.IsCarrying = false
X.IsBacking = false
X.Tons = 0
X.Distance = 0
X.Charging = false
X.IsChargingBox = false

X.Clicks = 0

X.Level = 0
X.IsFunding = false

X.IsProcessing = false

X.IsPlanting = false

X.IsDoingSomething = false
X.GreenPeace = false
X.Capitalist = false

-----------------------------------
-----------INICIALIZADOR-----------
-----------------------------------

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	
	ESX.TriggerServerCallback('tm1_stores:getWarehouses', function(warehouses)
		Config.Warehouses = warehouses
    end)

    while Config.Warehouses == nil do
		Citizen.Wait(10)
	end

	ESX.TriggerServerCallback('tm1_stores:getRocks', function(rocks)
		Config.Rocks = rocks
    end)

    ESX.TriggerServerCallback('tm1_stores:getWoods', function(woods)
		Config.Woods = woods
    end)

    ESX.TriggerServerCallback('tm1_stores:getPlants', function(plants)
		Config.Plants = plants
    end)

    ESX.TriggerServerCallback('tm1_stores:getWaterPoints', function(waterpoints)
		Config.WaterPoints = waterpoints
    end)

    ESX.TriggerServerCallback('tm1_stores:getValves', function(valves)
		Config.Valves = valves
    end)

    while Config.Rocks == nil and Config.Woods == nil and Config.Plants == nil and Config.WaterPoints == nil and Config.Valves == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()

	for i,v in pairs(Config.NPCs) do
		X.SpawnPed(v.model, v.coords)
	end

	X.CreateDefaultBlips()
	X.allDone = true
end)

-----------------------------------
-------------TRANSLATES------------
-----------------------------------

Local = {
	enterWarehouse  = "Pressiona ~y~E ~w~para entrar no armazém.",
	cancelCharge    = "Pressiona ~y~E ~w~para ~r~cancelar a carga",
	warehouse       = "Armazém",
	wood            = "Madeira",
	food            = "Alimentos",
	mine            = "Mina",
	water           = "Água",
	loadTruck       = "Obter Carga de Camião",
	loadVan         = "Obter Caixas",
	getTruck        = "Pressiona ~y~E ~w~ para colher uma carga de ",
	truck           = "Camião",
	van             = "Carrinha",
	youSelect       = "Escolheste colher ~g~",
	inLabel         = "em",
	youNeed         = "Necesitas um/a",
	load            = "Carregar ",
	maxCharge       = "O máximo que podes carregar são ",
	tons            = "tns",
	notenough       = "Não há stock suficiente.",
	invalidAumont   = "Quantidade inválida",
	haveToDelivery  = "Tens que ~g~entregar ~w~a ~o~carga ~w~primeiro.",
	notTruckAllowed = "Não podes colher a carga com esse veículo.",
	haveToSit       = "Tens que estar montado em trabalho.",
	truckPlace      = "Descarregar materiais para exportar.",
	deliveryTruck   = "Pressiona ~o~E ~w~para entregar el trailer.",
	putTheTruck     = "Deixa o reboque neste ponto. Para retirar o gancho do reboque, pressiona H.",
	dontHaveAnyTrailer = "Não há nenhum reboque neste ponto.",
	trailerNotAllowed = "Este reboque não é da empresa",
	discharge       = "Espere um momento enquanto descarregamos a carga...",
	upToBack        = "Já ~g~podes ~w~regressar ao armazém para cobrar",
	succesfulDelivery = "Já fizeste a entrega ~g~correctamente",
	getBox            = "Pressiona ~o~E ~w~para carregar a carrrinha",
	isCharging        = "Espere un momento, estamos a carregar aa mercadoria",
	correctCharge     = "Carregaste corretamente a mercancía.",
	goToCharge        = "Carrega a mercadoria.",
	putTheVan         = "Deixa a carrinha e vai à oficina para descarregares.",
	infoTrucks        = "Obtém informação sobre os camiões.",
	infoVans          = "Obtém informação sobre as carrinhas.",
	haveToBuy         = "Tens que comprar um dos veículos seguintes para levar a mercadoria",


	carbon            = "Carvão",
	iron              = "Ferro",
	silver            = "Prata",
	gold              = "Ouro",
	rockOf            = "Rocha de ",
	getPickAxe        = "Pressiona ~INPUT_CONTEXT~ para colher a tua ferramenta de trabalho",
	goFundition       = "Pressiona E para fundir",
	youCantMine       = "Não podes picar este tipo de rocha.",
	fundition         = "Queres fundir algum desses materiais?",
	melt              = "Fundir ",
	funditionLingots  = "Fundir lingotes",



	pine              = "Pinheiro",
	treeOf            = "Árvore de ",
	woodProcesser     = "Queres processar essa madeira?",
	goProcesser       = "Pressiona E para abrir o posto de processamento",
	process           = "Processar ",
	sawmill           = "Serradeira",
	convertWood       = "Converter madeira",

	nearPlant         = "Há uma planta demasiado perto",
	noPHNear          = "Não existe nenhuma plantação perto",
	fertilizer        = "Fertilizante",
	tomato_seed       = "~r~Tomates",
	blueberry_seed    = "~p~Mirtilos",
	state             = "Estado",
	rotten            = "Podre",
	youArePlating     = "Já está plantado",
	seedNotAllowed    = "Essa semente não se pode plantar nesta plantação",
	noPlantNear       = "Não há plantas perto!",
	ready             = "Pronto",
	pressButton       = "Pressiona ~r~E ~w~para falar",
	wateringcan       = "Regador",
	--water_50          = "Garrafa de 50L",
	highgradefert     = "Fertilizante 25PXC",
	--fertilizer_50     = "Fertilizante de 50Kg",
	seedShop          = "Queres comprar sementes?",
	tomatoSeedLabel   = "Semente de tomate",
	blueberrySeedLabel= "Semente de mirtilos",
	ph                = "Plantação",
	playerNearby      = "Fique longe das pessoas próximas",
	packageTomato     = "Empacotar tomates",
	packageBlueberry  = "Empacotar mirtilos",

	salinity          = "~c~Salinidade",
	chemists          = "~g~Químicos",
	pollution         = "~y~Contaminação",
	pointWater        = "Ponto de recolha de água",
	dirtyWater        = "~o~Água suja",
	electricityDown   = "~b~Baixar salanidade com sistema de filtragem",
	dam               = "Barragem",
	allow             = "~g~Disponível",
	notAllow          = "~r~ Indisponível",
	noActionAllow     = "Essa ação não é permitida",
	catCall           = "~c~Chama o gato para receber o botão de poluição",
	greenpeaceAcept   = "~c~Alcance a sabedoria entrando em contacto com a natureza através da GreenPeace",
	youAreCapitalist  = "Agora queres que te ajude? Sócio capitalista de merda, embora daqui.",
	capitalistAccept  = "Queres unir-te ao sistema? Só tens que apoiar a minha causa. VIVA AO CAPITALISMO!",
	youAreGreenPeacer = "Tu queres montar aGora una empresa? Olá? Apoiando o meio ambiente? Por favor...",
	toxic1            = "Abrir a válvula para depositar químicos na água",
	salinity1         = "Rasgarum  pouco a filtragem do sal",
	salinity2         = "Despejar os produtos naturais",
	pollution1        = "Vigiar a gente que contamina o rio",
	pollution2        = "Tomar banho no rio",
	chemist1          = "Adora o deus salva-vidas",
	pollution3        = "Corrigir o filtro de contaminação",
	salinity3         = "Parece haver um rato ao lado da caixa, desculpa, és tu. Corrige o filtro de salinidade.",
	youAreDoingSomething = "Para o que estás a fazer!",
	noWaterPointsNearby = "Não há pontos de recolha de água nas proximidades",
	youAreRecolecting = "Estás a coletar água",
	waterBottle       = "Garrafa de água 1$",
	bottleShop        = "Loja de Garrafas de Água",
	washBottles       = "Desejas limpar as garrafas?",
	washSaltBottles   = "Desejas retirar a salinindade das garrafas",
	washBottle        = "Limpar garrafas",
	packageWater      = "Empacotar água",
	package           = "Sr.Diogo das Frutas",

	confirm_yes       = "Sim",
	confirm_no        = "Não",

	pine_processed    = "Madeira processada",
	lingot_carbon     = "Carvão processado",
	lingot_iron       = "Lingote de ferro",
	lingot_silver     = "Lingote de prata",
	lingot_gold       = "Lingote de ouro",
	bottleWater_package = "Pacote de água",
	blueberry_package = "Pacote de mirtilos",
	tomato_package    = "Pacote de tomates",

	sellToWarehouse   = "Desejas vender o material ao armazém?",
	noSpace           = "Não há espaço suficiente no armazém",
	downTheCar        = "Tens que sair do carro"
}

-----------------------------------
---------------CONFIG--------------
-----------------------------------

Config = {}
Config.Warehouses = nil
Config.MaxWeight = {
	truck = 41,
	van   = 11
}
Config.TrailersModels = {
	wood = {go = "trailerlogs", back = "trflat"},
	food = {go = "trailers", back = "trailers"},
	mine = {go = "docktrailer", back = "docktrailer"},
	water = {go = "tanker2", back = "tanker2"}
}
Config.AvaliableTrucks = {
	"man",
	"actros"
}
Config.AvaliableVans = {
	"renmaster",
	"kangoo"
}
Config.BlipsWarehouses = {
	id = 478,
	colour = 73
}
Config.Ports = {
	{name = Local.truckPlace, id = 479, colour = 58, x = 99.32, y = 6386.45, z = 31.23, point = {x = 96.08, y = 6363.14, z = 31.38}}
}

-----------------------
-------CONFIG MINE-----
-----------------------
Config.Blips = {
    mine = {title=Local.mine, colour=46, id=486, x = 2952.0, y = 2748.8, z = 43.48-1},
    fundition = {title=Local.funditionLingots, colour=46, id=486, x = 1110.03, y = -2008.15, z = 31.06-1},
    sawmill = {title=Local.sawmill, colour=56, id=486, x = -552.44, y = 5348.45, z = 74.74-1},
    woodProcesser = {title=Local.convertWood, colour=56, id=486, x = -584.23, y = 5285.78, z = 70.26},
    ph1 = {title=Local.ph, colour=71, id=439, x = 1278.67, y = 1808.94, z = 64.3},
    ph2 = {title=Local.ph, colour=71, id=439, x = 1319.46, y = 1868.47, z = 90.83},
    water = {title=Local.pointWater, colour=29, id=486, x = 1685.44, y = 42.81, z = 161.76},
    dam = {title=Local.dam, colour=29, id=486, x = 1660.05, y = -1.34, z = 173.77},
    waterWashBottle = {title=Local.washBottle, colour=29, id=486, x = -2238.62, y = 3481.89, z = 29.29},
    package = {title=Local.package, colour=50, id=486, x = 1175.56, y = -294.31, z = 67.93}
}

Config.isExperienceSystemActive = false

Config.ClicksToPickNeeded = 8
Config.DistanceToRemoveThePickaxe = 150
Config.Rocks = nil

Config.ClicksToCutNeeded = 5
Config.DistanceToRemoveTheAxe = 150
Config.Woods = nil

Config.PH = {
	{
		id = 1,
		x = 1278.67,
		y = 1808.94,
		z = 64.3,
		radio = 50.0,
		seedsAllowed = {'tomato_seed', 'blueberry_seed'}
	},
	{
		id = 2,
		x = 1319.46,
		y = 1868.47,
		z = 90.83,
		radio = 50.0,
		seedsAllowed = {'tomato_seed', 'blueberry_seed'}
	}
}
Config.Seeds = {
	tomato_seed = {
		seed = 'tomato_seed',
		distanceNeeded = 5.0,
		object = 'prop_veg_crop_01',
		reward = 'tomato_fruit',
		price = 18,
		maxPlants = 15
	},
	blueberry_seed = {
		seed = 'blueberry_seed',
		distanceNeeded = 5.0,
		object = 'prop_plant_cane_02a',
		reward = 'blueberry_fruit',
		price = 22,
		maxPlants = 15
	}
}
Config.NPCs = {
	{
		name = 'OpenSeedMenu',
		coords = {
			x = 1219.14,
			y = 1848.25,
			z = 77.96,
			h = 210.0
		},
		msg = Local.pressButton,
		model = -1806291497
	},
	{
		name = '',
		coords = {
			x = 1664.64,
			y = -28.04,
			z = -195.94,
			h = 300.0
		},
		msg = nil,
		model = -264140789
	},
	{
		name = '',
		coords = {
			x = 1660.83,
			y = -24.74,
			z = 172.77,
			h = 210.0
		},
		msg = nil,
		model = 1809430156
	},
	{
		name = 'OpenBottleMenu',
		coords = {
			x = 1664.62,
			y = -18.56,
			z = 171.77,
			h = 210.0
		},
		msg = Local.pressButton,
		model = -1806291497
	},
	{
		name = 'OpenProcesserMenu',
		coords = {
			x = -2238.62,
			y = 3481.89,
			z = 29.29,
			h = 172.69
		},
		msg = Local.pressButton,
		model = -1806291497
	},
	{
		name = 'OpenSaltMenu',
		coords = {
			x = 1904.91,
			y = 595.82,
			z = 177.4,
			h = 120.0
		},
		msg = Local.pressButton,
		model = -1806291497
	},
	{
		name = 'OpenPackageMenu',
		coords = {
			x = 1175.56,
			y = -294.31,
			z = 67.93,
			h = 315.93
		},
		msg = Local.pressButton,
		model = -1806291497
	}
}
Config.SeedShop = {
	{label = "Regador 28$", value = "wateringcan", price = 28},
	--{label = "Agua Purificada 50ph 38$ ", value = "water_50", price = 38},
	{label = "Fertilizante 25Px 128$", value = "fertilizer_25", price = 128},
	--{label = "Fertilizante 50PxPX 328$", value = "fertilizer_50", price = 328},
	{label = "Semente de Tomate 3$", value = "tomato_seed", price = 3},
	{label = "Semente de Mirtilos 5$", value = "blueberry_seed", price = 5},
}
Config.SecondNeededToPlant = 8 --[More than 3 seconds pls]

Config.BottleShop = {
	{label = Local.waterBottle, value = "waterBottle", price = 1},
}
Config.PackageShop = {
	{label = Local.packageTomato, from = "tomato_fruit", to = "tomato_package"},
	{label = Local.packageBlueberry, from = "blueberry_fruit", to = "blueberry_package"},
	{label = Local.packageWater, from = "full_waterBottle", to = "bottleWater_package"}
}

Config.Packages = {
	wood = {
		'pine_processed'
	},
	mine = {
		'lingot_carbon',
		'lingot_iron',
		'lingot_silver',
		'lingot_gold'
	},
	water = {
		'bottleWater_package'
	},
	food = {
		'blueberry_package',
		'tomato_package'
	}
}
-----------------------------------
-------------HILO PRINC------------
-----------------------------------

Citizen.CreateThread(function()
	while X.allDone == false do
		Citizen.Wait(10)
	end
	X.CreateWarehousesBlips()
	X.CreatePortsBlips()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	local nearAny = false
	while true do
		Citizen.Wait(7)
		playerPed = PlayerPedId()
		coords    = GetEntityCoords(playerPed)
		nearAny = false
		for i,v in pairs(Config.Warehouses) do
			local distance = X.Get3DDistance(v.mainDoor.x, v.mainDoor.y, v.mainDoor.z, coords.x, coords.y, coords.z)

			-------------
			--ALMACENES--
			-------------
			if distance < 20.0 then
				X.DrawMarker(39,v.mainDoor.x, v.mainDoor.y, v.mainDoor.z,255,255,0,1.0,1.0,1.0)
				nearAny = true
				if distance < 1.5 then
					if X.IsSelecting == false and X.IsCarrying == false and X.IsBacking == false then
						ESX.ShowHelpNotification(Local.enterWarehouse)
						if IsControlJustReleased(0, 38) then
							ESX.TriggerServerCallback('tm1_stores:getWarehouse', function(warehouse)
								X.OpenWarehouse(warehouse)
						    end, v.storeID)
						end
					elseif X.IsSelecting == false and X.IsCarrying == true then
						ESX.ShowHelpNotification(Local.haveToDelivery)
					elseif X.IsSelecting == false and X.IsCarrying == false and X.IsBacking == true then
						ESX.ShowHelpNotification(Local.deliveryTruck)
						if IsControlJustReleased(0, 38) then
							local vehicle, distance = ESX.Game.GetClosestVehicle({x = v.leaveCharge.x, y = v.leaveCharge.y, z = v.leaveCharge.z})
							if distance <= 4.0 and X.Option == 'truck' then
								local plate = X.Trim(GetVehicleNumberPlateText(vehicle))
								ESX.TriggerServerCallback('tm1_stores:getTrailer', function(trailer)
									if trailer.plate == plate then
										ESX.ShowNotification(Local.succesfulDelivery)
										DeleteEntity(vehicle)
										ESX.Game.DeleteVehicle(vehicle)
										TriggerServerEvent('tm1_stores:payTons', X.Tons)
										X.ClearVars()
									else
										ESX.ShowNotification(Local.trailerNotAllowed)
									end
								end, plate)
							elseif distance <= 4.0 and X.Option == 'van' then
								local plate = X.Trim(GetVehicleNumberPlateText(vehicle))
								ESX.TriggerServerCallback('tm1_stores:getTrailer', function(trailer)
									if trailer.plate == plate then
										ESX.ShowNotification(Local.succesfulDelivery)
										TriggerServerEvent('tm1_stores:payTons',X.Tons)
										X.ClearVars()
									else
									end
								end, plate)
							else
								ESX.ShowNotification(Local.dontHaveAnyTrailer)
							end
						end
					elseif X.IsSelecting == false then
						ESX.ShowHelpNotification(Local.cancelCharge)
						if IsControlJustReleased(0, 38) then
							X.CancelCharging()
						end
					end
				end
			end

			------------
			--CARGADOR--
			------------
			if X.IsSelecting == true and X.ActualWarehouse ~= nil and X.Material ~= nil and (X.Option == 'truck' or X.Option == 'van') then
				local distanceToGet = X.Get3DDistance(v.getCharge.x, v.getCharge.y, v.getCharge.z, coords.x, coords.y, coords.z)
				if distanceToGet < 50.0 then
					X.DrawMarker(21,v.getCharge.x, v.getCharge.y, v.getCharge.z,0,0,255,1.0,1.0,1.0)
					nearAny = true
					if distanceToGet < 3.5 then
						ESX.ShowHelpNotification(Local.getTruck.."~g~"..Local[X.Material].."~w~. ("..Local.maxCharge.."~y~"..Config.MaxWeight[X.Option].."~w~ "..Local.tons..")")
						if IsControlJustReleased(0, 38) then
							if IsPedSittingInAnyVehicle(PlayerPedId()) then
								X.OpenGetCharge()
							else
								ESX.ShowNotification(Local.haveToSit)
							end
						end
					end
				end
			end

			---------------------
			---INDICADOR CARGA---
			---------------------
			if X.IsBacking == true and X.ActualWarehouse ~= nil and X.Material ~= nil and (X.Option == 'truck' or X.Option == 'van') then
				local distanceToLeave = X.Get3DDistance(v.leaveCharge.x, v.leaveCharge.y, v.leaveCharge.z, coords.x, coords.y, coords.z)
				if distanceToLeave < 20.0 then
					X.DrawMarker(29,v.leaveCharge.x, v.leaveCharge.y, v.leaveCharge.z,0,0,255,1.0,1.0,1.0)
					nearAny = true
					if distanceToLeave < 3.5 then				
						if distanceToLeave < 3.5 and X.Option == 'truck' then
							ESX.ShowHelpNotification(Local.putTheTruck)
						elseif distanceToLeave < 3.5 and X.Option == 'van' then
							ESX.ShowHelpNotification(Local.putTheVan)
						end
					end
				end
			end

			-----------------
			--COGER LA CAJA--
			-----------------
			if X.IsChargingBox == true and X.ActualWarehouse ~= nil and X.Material ~= nil then
				local distanceToBox = X.Get3DDistance(v.getBox.x, v.getBox.y, v.getBox.z, coords.x, coords.y, coords.z)
				if distanceToBox < 20.0 then
					X.DrawMarker(29,v.getBox.x, v.getBox.y, v.getBox.z,0,0,255,1.0,1.0,1.0)
					nearAny = true
					if distanceToBox < 3.5 then				
						ESX.ShowHelpNotification(Local.getBox)
						if IsControlJustReleased(0, 38) then
							if IsPedSittingInAnyVehicle(PlayerPedId()) then
								if X.IsAValidVan() then
									X.IsChargingBox = false
									ESX.ShowNotification(Local.isCharging)
									local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
									local plate = X.Trim(GetVehicleNumberPlateText(vehicle))
									FreezeEntityPosition(vehicle,true)
									Citizen.Wait(8000)
									FreezeEntityPosition(vehicle,false)
									TriggerServerEvent('tm1_stores:addTrailer', X.Trim(plate), X.Tons)
									X.IsChargingBox = false
									X.IsCarrying = true
								else
									ESX.ShowNotification(Local.notTruckAllowed)
								end
							else
								ESX.ShowNotification(Local.haveToSit)
							end
						end
					end
				end
			end

			-------
			--IDA--
			-------
			if X.IsCarrying == true and X.ActualWarehouse ~= nil and X.Material ~= nil and (X.Option == 'truck' or X.Option == 'van') then
				for i,v in pairs(Config.Ports) do
					local distanceToGet = X.Get3DDistance(v.x, v.y, v.z, coords.x, coords.y, coords.z)
					local distanceToDelivery = X.Get3DDistance(v.point.x, v.point.y, v.point.z, coords.x, coords.y, coords.z)
					if distanceToGet < 50.0 then
						nearAny = true
						X.DrawMarker(29,v.x, v.y, v.z,0,0,255,1.0,1.0,1.0)
						X.DrawMarker(21,v.point.x, v.point.y, v.point.z,0,0,255,1.0,1.0,1.0)
						if distanceToGet < 3.5 and X.Option == 'truck' then
							ESX.ShowHelpNotification(Local.putTheTruck)
						elseif distanceToGet < 3.5 and X.Option == 'van' then
							ESX.ShowHelpNotification(Local.putTheVan)
						end
						if distanceToDelivery < 3.5 and X.Charging == false then
							ESX.ShowHelpNotification(Local.deliveryTruck)
							if IsControlJustReleased(0, 38) then
								local vehicle, distance = ESX.Game.GetClosestVehicle({x = v.x, y = v.y, z = v.z})
								if distance <= 4.0 then
									local plate = X.Trim(GetVehicleNumberPlateText(vehicle))
									ESX.TriggerServerCallback('tm1_stores:getTrailer', function(trailer)
										if trailer ~= nil and trailer.plate == plate and X.Option == 'truck' then
											local coordsV = GetEntityCoords(vehicle)
											ESX.ShowNotification(Local.discharge)
											X.Charging = true
											Citizen.Wait(8000)
											ESX.ShowNotification(Local.upToBack)
											ESX.Game.DeleteVehicle(vehicle)
											DeleteEntity(vehicle)
											Citizen.Wait(1500)
											ESX.Game.SpawnVehicle(Config.TrailersModels[X.Material].back, coordsV, 0.0, function(vehicle)
												SetVehicleNumberPlateText(vehicle, plate)			
												X.Tons = trailer.tons
												X.IsCarrying = false
												X.IsBacking = true
												X.Distance = X.Get3DDistance(coords.x, coords.y, coords.z, X.LastShop.mainDoor.x, X.LastShop.mainDoor.y, X.LastShop.mainDoor.z)
												X.Charging = false

											end)
										elseif trailer ~= nil and trailer.plate == plate and X.Option == 'van' then
											ESX.ShowNotification(Local.discharge)
											X.Charging = true
											Citizen.Wait(8000)
											ESX.ShowNotification(Local.upToBack)
											X.Charging = false
											X.IsCarrying = false
											X.IsBacking = true
											X.Distance = X.Get3DDistance(coords.x, coords.y, coords.z, X.LastShop.mainDoor.x, X.LastShop.mainDoor.y, X.LastShop.mainDoor.z)
											X.Charging = false
										else
											--ESX.ShowNotification(Local.trailerNotAllowed)
											exports['mythic_notify']:SendAlert('error', 'Este reboque não é da empresa')
										end
									end, X.Trim(plate))
								else
									ESX.ShowNotification(Local.dontHaveAnyTrailer)
								end
							end
						end
					end
				end
			end
		end

		local distanceMine = X.Get3DDistance(Config.Blips.mine.x,Config.Blips.mine.y,Config.Blips.mine.z,coords.x,coords.y,coords.z)
		if distanceMine > Config.DistanceToRemoveThePickaxe then
	    	if GetCurrentPedWeapon(PlayerPedId(),"WEAPON_BATTLEAXE",true) then
	        	RemoveWeaponFromPed(PlayerPedId(),"WEAPON_BATTLEAXE")
	    	end
	    else
	    	X.CanPick(coords)
			if distanceMine < 5 then
				nearAny = true
	    		X.DrawMarker(27,Config.Blips.mine.x,Config.Blips.mine.y,Config.Blips.mine.z,132, 23,255,1.5001, 1.5001, 1.5001)
	        	if distanceMine < 1.5 then
	          		X.DisplayHelpText(Local.getPickAxe)
	          		if IsControlJustReleased(1,38) then
	              		GiveWeaponToPed(PlayerPedId(),"WEAPON_BATTLEAXE",1,false,true)
	          		end
	        	end
	      	end
	    end
		if X.Get3DDistance(coords.x,coords.y,coords.z,Config.Blips.fundition.x,Config.Blips.fundition.y,Config.Blips.fundition.z) < 1.5 then
			nearAny = true
	      	X.DrawText3D({x = Config.Blips.fundition.x, y = Config.Blips.fundition.y, z = Config.Blips.fundition.z}, Local.goFundition)
	      	if IsControlJustReleased(1,38) and X.IsFunding == false then
	       		X.OpenFundition()
	      	end
	    end

	    --------------
		--ASERRADERO--
		--------------
		local distanceWood = X.Get3DDistance(Config.Blips.sawmill.x,Config.Blips.sawmill.y,Config.Blips.sawmill.z,coords.x,coords.y,coords.z)
		if distanceWood > Config.DistanceToRemoveTheAxe then
	    	if GetCurrentPedWeapon(PlayerPedId(),"WEAPON_HATCHET",true) then
	        	RemoveWeaponFromPed(PlayerPedId(),"WEAPON_HATCHET")
	    	end
	    else
	    	X.CanPickW(coords)
			if distanceWood < 5 then
				nearAny = true
	    		X.DrawMarker(1,Config.Blips.sawmill.x,Config.Blips.sawmill.y,Config.Blips.sawmill.z,132, 23,255,1.5001, 1.5001, 1.5001)
	        	if distanceWood < 1.5 then
	          		X.DisplayHelpText(Local.getPickAxe)
	          		if IsControlJustReleased(1,38) then
	              		GiveWeaponToPed(PlayerPedId(),"WEAPON_HATCHET",1,false,true)
	          		end
	        	end
	      	end
	    end
		if X.Get3DDistance(coords.x,coords.y,coords.z,Config.Blips.woodProcesser.x,Config.Blips.woodProcesser.y,Config.Blips.woodProcesser.z) < 1.5 then
			nearAny = true
	      	X.DrawText3D({x = Config.Blips.woodProcesser.x, y = Config.Blips.woodProcesser.y, z = Config.Blips.woodProcesser.z}, Local.goProcesser)
	      	if IsControlJustReleased(1,38) and X.IsProcessing == false then
	       		X.OpenProcesser()
	      	end
	    end

	 	-----------
		--PLANTAS--
		-----------
	    for k1,v1 in pairs(Config.PH) do
	    	local distancePH = X.Get3DDistance(v1.x,v1.y,v1.z,coords.x,coords.y,coords.z)
	    	if distancePH <= v1.radio then
	    		if Config.Plants[v1.id] then
				    for k,v in pairs(Config.Plants[v1.id]) do
				    	if X.IsPlanting == false then
							if X.Get3DDistance(coords.x,coords.y,coords.z,v.x,v.y,v.z) < 3.0 then
								nearAny = true
					    		X.Draw3DTextPlants(v)
					    		if IsControlJustReleased(1,38) and X.IsPlanting == false then
					    			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				    				if closestDistance > 5.0 or closestDistance == -1 then
				    					if not IsPedSittingInAnyVehicle(PlayerPedId()) then
							    			if v.rot <= 0 then
							    				X.IsPlanting = true
							    				X.RemoveLowPlant({x = v.x, y = v.y, z = v.z + 1.55}, v.id, v.seed)
							    			elseif v.percent >= 100 then
							    				X.IsPlanting = true
							    				X.HarvestPlant({x = v.x, y = v.y, z = v.z + 1.55}, v.id, v.seed)
							    			end
							    		else
							    			ESX.ShowNotification(Local.downTheCar)
							    		end
						    		else
							    		ESX.ShowNotification(Local.playerNearby)
							    	end
					    		end
					    	end
					    end
				    end
				end
			end
	    end
	    for k,v in pairs(Config.NPCs) do
			if X.Get3DDistance(v.coords.x,v.coords.y,v.coords.z,coords.x,coords.y,coords.z) < 3.0 then
				nearAny = true
	    		X.DrawText3D({x = v.coords.x, y = v.coords.y, z = v.coords.z + 2}, v.msg)
	    		if IsControlJustReleased(1,38) and v.msg ~= nil then
	    			X[v.name]()
	    		end
	    	end
	    end

	    --------
		--AGUA--
		--------
		local distanceWater = X.Get3DDistance(Config.Blips.water.x,Config.Blips.water.y,Config.Blips.water.z,coords.x,coords.y,coords.z)
		if distanceWater < 20.0 then
			nearAny = true
			for k,v in pairs(Config.WaterPoints) do
				if X.Get3DDistance(v.x,v.y,v.z,coords.x,coords.y,coords.z) < 2.5 then
					X.Draw3DTextWater(v)
				end
			end
		end
		if Config.Valves then
			for k,v in pairs(Config.Valves) do
				if X.Get3DDistance(v.x,v.y,v.z,coords.x,coords.y,coords.z) < 2.5 then
					nearAny = true
					if v.isAvaliable == true then
						X.DrawText3D({x = v.x, y = v.y, z = v.z + 0.15}, "~w~["..Local.allow.."~w~]")
					else
						X.DrawText3D({x = v.x, y = v.y, z = v.z + 0.15}, "~w~["..Local.notAllow.."~w~]")
					end
					X.DrawText3D({x = v.x, y = v.y, z = v.z}, "~w~["..Local[v.name].."~w~]")
					if IsControlJustReleased(1,38) then
						if v.isAvaliable == true then
							local closestDistance = ESX.Game.GetClosestPlayer()
					    	if closestDistance > 5.0 or closestDistance == -1 then
					    		if X.IsDoingSomething == false then
					    			if v.name == 'greenpeaceAcept' and X.Capitalist == false then
					    				X.GreenPeace = true
					    				X.IsDoingSomething = true
						    			X.DoAction(v)
					    			elseif v.name == 'greenpeaceAcept' and X.Capitalist == true then 
					    				ESX.ShowNotification(Local.youAreCapitalist)
					    			elseif v.name == 'capitalistAccept' and X.GreenPeace == true then
					    				ESX.ShowNotification(Local.youAreGreenPeacer)
					    			elseif v.name == 'capitalistAccept' and X.GreenPeace == false then
					    				X.Capitalist = true
					    				X.IsDoingSomething = true
						    			X.DoAction(v)
						    		else
						    			X.Capitalist = true
					    				X.IsDoingSomething = true
						    			X.DoAction(v)
					    			end
					    		end
				    		else
					    		ESX.ShowNotification(Local.playerNearby)
					    	end
						else
							ESX.ShowNotification(Local.noActionAllow)
						end
					end
				end
			end
		end
		--[[if not nearAny then
			Citizen.Wait(1500)
		end]]
	end
end)

-----------------------------------
-----------NUI CALLBACKS-----------
-----------------------------------

RegisterNUICallback('NUIFocusOff', function()
    X.isOpen = false
    SetNuiFocus(false, false)
    SendNUIMessage({type = 'closeUI'})
end)

RegisterNUICallback('sell', function(data, cb)
	local myData = data
	local warehouse = data.companyName
    X.OpenSetMenu(warehouse)
end)

RegisterNUICallback('get', function(data, cb)
	local myData = data
	local warehouse = data.companyName
    X.OpenGetMenu(warehouse)
end)

-----------------------------------
-------------FUNCIONES-------------
-----------------------------------
X.GetPercent = function(actual, max)
	return X.Round(((actual * 100) / max), 1)
end

X.IsAValidTruck = function()
	for i,v in pairs(Config.AvaliableTrucks) do
		if IsVehicleModel(GetVehiclePedIsIn(PlayerPedId(), true), GetHashKey(v)) then 
			return true
		end
	end

	return false
end

X.IsAValidVan = function()
	for i,v in pairs(Config.AvaliableVans) do
		if IsVehicleModel(GetVehiclePedIsIn(PlayerPedId(), true), GetHashKey(v)) then 
			return true
		end
	end

	return false
end

X.OpenWarehouse = function(warehouse)
    X.isOpen = true
    SetNuiFocus(true, true)
    SendNUIMessage({type = 'openNUI',
    storeName = warehouse.storeName,
    storeID = warehouse.storeID,
    wood  = X.GetPercent(warehouse.materials.wood, warehouse.maxMaterials.wood),
    food  = X.GetPercent(warehouse.materials.food, warehouse.maxMaterials.food),
    mine  = X.GetPercent(warehouse.materials.mine, warehouse.maxMaterials.mine),
    water = X.GetPercent(warehouse.materials.water, warehouse.maxMaterials.water)})
end

X.CloseWarehouse = function()
	X.isOpen = false
    SetNuiFocus(false, false)
    SendNUIMessage({type = 'closeUI'})
end

X.Get3DDistance = function(x1, y1, z1, x2, y2, z2)
	local a = (x1 - x2) * (x1 - x2)
	local b = (y1 - y2) * (y1 - y2)
	local c = (z1 - z2) * (z1 - z2)
    return math.sqrt(a + b + c)
end

X.DrawMarker = function(typeOfMarker,x,y,z,r,g,b,sizeX,sizeY,SizeZ)
	DrawMarker(typeOfMarker, x, y, z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, sizeX,sizeY,SizeZ, r,g,b, 100, false, true, 2, true, false, false, false)
end

X.Round = function(value, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", value))
end

Citizen.CreateThread(function ()
	X.isOpen = false
    SetNuiFocus(false, false)
    SendNUIMessage({type = 'closeUI'})
end)

X.CreateWarehousesBlips = function()
	Citizen.CreateThread(function()
	    for _, info in pairs(Config.Warehouses) do
	      info.blip = AddBlipForCoord(info.mainDoor.x, info.mainDoor.y, info.mainDoor.z)
	      SetBlipSprite(info.blip, Config.BlipsWarehouses.id)
	      SetBlipDisplay(info.blip, 4)
	      SetBlipScale(info.blip,0.6)
	      SetBlipColour(info.blip, Config.BlipsWarehouses.colour)
	      SetBlipAsShortRange(info.blip, true)
		  BeginTextCommandSetBlipName("STRING")
	      AddTextComponentString(info.storeName)
	      EndTextCommandSetBlipName(info.blip)
	    end
	end)
end

X.CreatePortsBlips = function()
	Citizen.CreateThread(function()
	    for _, info in pairs(Config.Ports) do
	      info.blip = AddBlipForCoord(info.x, info.y, info.z)
	      SetBlipSprite(info.blip, info.id)
	      SetBlipDisplay(info.blip, 4)
	      SetBlipScale(info.blip,0.6)
	      SetBlipColour(info.blip, info.colour)
	      SetBlipAsShortRange(info.blip, true)
		  BeginTextCommandSetBlipName("STRING")
	      AddTextComponentString(info.name)
	      EndTextCommandSetBlipName(info.blip)
	    end
	end)
end

X.DisplayHelpText = function(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

X.startAnim = function(lib, anim)
  ESX.Streaming.RequestAnimDict(lib, function()
    TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
  end)
end

X.startScenario = function(anim)
	TaskStartScenarioInPlace(PlayerPedId(), anim, 0, false)
end

X.DrawText3D = function(coords, text, size)
	local onScreen, x, y = World3dToScreen2d(coords.x, coords.y, coords.z)
	local camCoords      = GetGameplayCamCoords()
	local dist           = GetDistanceBetweenCoords(camCoords, coords.x, coords.y, coords.z, true)
	local size           = size

	if size == nil then
		size = 1
	end

	local scale = (size / dist) * 2
	local fov   = (1 / GetGameplayCamFov()) * 100
	local scale = scale * fov

	if onScreen then
		SetTextScale(0.0 * scale, 0.55 * scale)
		SetTextFont(0)
		SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry('STRING')
		SetTextCentre(1)

		AddTextComponentString(text)
		DrawText(x, y)
	end
end

X.Trim = function(str)
	if str then 
		if type(str) ~= "string" then str = tostring(str) end
		return (str:gsub("^%s*(.-)%s*$", "%1"))
	end

	return ""
end

X.FinishWork = function()
	
end

X.ClearVars = function()
	X.LastShop = nil
	X.Material = nil
	X.ActualWarehouse = nil
	X.Option = nil
	X.IsSelecting = false
	X.IsCarrying = false
	X.IsBacking = false
	X.Tons = 0
	X.Distance = 0
	X.Charging = false
	X.IsChargingBox = false
end

X.SpawnPed = function(model, coords)
	model           = (tonumber(model) ~= nil and tonumber(model) or GetHashKey(model))
	local x = coords.x
	local y = coords.y
	local z = coords.z
	local h = coords.h

	Citizen.CreateThread(function()
		RequestModel(model)

		while not HasModelLoaded(model) do
			Citizen.Wait(1)
		end

		ped = CreatePed(5, model, x, y, z, h, false, false)
		FreezeEntityPosition(ped,true)
	end)
end

X.OpenSetMenu = function(id)
	local elements = {}

	ESX.TriggerServerCallback('tm1_stores:getWarehouse', function(warehouse)
		X.LastShop = warehouse
	    table.insert(elements, {value = "wood" , valueLabel = Local.wood ,  material = X.LastShop.materials.wood, maxMaterial =  X.LastShop.maxMaterials.wood, label = "<span style='color: orange;'>Madeira</span><b> : "..X.LastShop.materials.wood.."/"..X.LastShop.maxMaterials.wood.."</b>"})
	    table.insert(elements, {value = "food" , valueLabel = Local.food ,  material = X.LastShop.materials.food, maxMaterial =  X.LastShop.maxMaterials.food, label = "<span style='color: green;'>Comida</span><b> : "..X.LastShop.materials.food.."/"..X.LastShop.maxMaterials.food.."</b>"})
	    table.insert(elements, {value = "mine" , valueLabel = Local.mine ,  material = X.LastShop.materials.mine, maxMaterial =  X.LastShop.maxMaterials.mine, label = "<span style='color: yellow;'>Minerais</span><b> : "..X.LastShop.materials.mine.."/"..X.LastShop.maxMaterials.mine.."</b>"})
	    table.insert(elements, {value = "water", valueLabel = Local.water,  material = X.LastShop.materials.water, maxMaterial = X.LastShop.maxMaterials.water, label = "<span style='color: cyan;'>Agua</span><b> : "..X.LastShop.materials.water.."/"..X.LastShop.maxMaterials.water.."</b>"})

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'warehouse', {
			title    = Local.warehouse,
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)
			if data.current.value then
				X.OpenMaterials(id, data.current.value)
			end
		end,
		function(data, menu)
			isMenuOpened = false
			menu.close()
		end
		)
    end, id)
end

X.OpenMaterials = function(id, material)
	local elements = {}

	for k,v in pairs(Config.Packages[material]) do
		table.insert(elements, {value = v, label = Local[v]} )
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'warehouse_packages', {
		title    = Local.warehouse,
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		if data.current.value then
			X.OpenGetterMenu(id, material, data.current.value)
		end
	end,
	function(data, menu)
		isMenuOpened = false
		menu.close()
	end
	)
end

X.OpenGetterMenu = function(id, material, item)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'warehouse_charge',
	{
		title = Local.sellToWarehouse,
	}, function(data, menu)
		local parameter = data.value
		local tons = tonumber(parameter)
		if tons then
			ESX.TriggerServerCallback('tm1_stores:getWarehouse', function(warehouse)
				local quantityInWarehouse = warehouse.materials[material]
				local maxCapacity = warehouse.maxMaterials[material]
				if quantityInWarehouse + tons <= maxCapacity then
					TriggerServerEvent('tm1_stores:fillWarehouses', id, material, item, tons)
				else
					ESX.ShowNotification(Local.noSpace)
				end
				menu.close()
			end, id)
		end
		ESX.UI.Menu.CloseAll()
	end, function(data, menu)
		menu.close()
	end)
end
------------------------------
-------------BLIPS------------
------------------------------
X.CreateDefaultBlips = function()
Citizen.CreateThread(function()
  Citizen.Wait(10)
  for _, info in pairs(Config.Blips) do
    info.blip = AddBlipForCoord(info.x, info.y, info.z)
    SetBlipSprite(info.blip, info.id)
    SetBlipDisplay(info.blip, 4)
    SetBlipScale(info.blip,0.6)
    SetBlipColour(info.blip, info.colour)
    SetBlipAsShortRange(info.blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(info.title)
    EndTextCommandSetBlipName(info.blip)
  end
end)
end

--------------------------------
-------------EVENTOS------------
--------------------------------

RegisterNetEvent('tm1_stores:getDataClientsWoods')
AddEventHandler('tm1_stores:getDataClientsWoods',function(data)
    Config.Woods = data
end)

RegisterNetEvent('pop_university:setMineLevel')
AddEventHandler('pop_university:setMineLevel',function(totalLevel)
    X.Level = totalLevel
end)

RegisterNetEvent('tm1_stores:getDataClientsRocks')
AddEventHandler('tm1_stores:getDataClientsRocks',function(data)
    Config.Rocks = data
end)

RegisterNetEvent('tm1_stores:plant')
AddEventHandler('tm1_stores:plant', function(seed)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	if not IsPedSittingInAnyVehicle(PlayerPedId()) then
		if X.IsPlanting == false then
			for k,v in pairs(Config.PH) do
				if X.Get3DDistance(v.x, v.y, v.z, coords.x, coords.y, coords.z) < v.radio then
					local minDistance = 999999.0
					if Config.Plants[v.id] ~= nil then
						for k1,v1 in pairs(Config.Plants[v.id]) do
							local distance = X.Get3DDistance(v1.x, v1.y, v1.z, coords.x, coords.y, coords.z)
							if distance < minDistance then
								minDistance = distance
							end
						end
					end
					if Config.Seeds[seed].distanceNeeded < minDistance or minDistance == 999999.0 then
						if X.IsThisSeedAllowed(seed, v) then
							TriggerServerEvent('tm1_stores:plant', Config.Seeds[seed], coords.x, coords.y, coords.z, v.id)
							return nil
						else
							ESX.ShowNotification(Local.seedNotAllowed)
							return nil
						end
					else
						ESX.ShowNotification(Local.nearPlant)
						return nil
					end
				end
			end
		else
			ESX.ShowNotification(Local.youArePlating)
			return nil
		end
	else
		ESX.ShowNotification(Local.downTheCar)
		return nil
	end
	ESX.ShowNotification(Local.noPHNear)
end)

RegisterNetEvent('tm1_stores:plantSeed')
AddEventHandler('tm1_stores:plantSeed', function(seed, coords)
	X.IsPlanting = true
	X.Plant(seed, coords)
end)

RegisterNetEvent('tm1_stores:refreshPlants')
AddEventHandler('tm1_stores:refreshPlants', function(plants)
	Config.Plants = plants
end)

RegisterNetEvent('tm1_stores:addWater')
AddEventHandler('tm1_stores:addWater', function(quantity)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	for k,v in pairs(Config.Plants) do
		for k1,v1 in pairs(v) do
			if X.Get3DDistance(v1.x, v1.y, v1.z, coords.x, coords.y, coords.z) < 3.0 then
				X.IsPlanting = true
				print("found")
				X.AddWater(v1.id, quantity)
				return
			end
		end
	end
end)

RegisterNetEvent('tm1_stores:addFertilizer')
AddEventHandler('tm1_stores:addFertilizer', function(quantity)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	for k,v in pairs(Config.Plants) do
		for k1,v1 in pairs(v) do
			if X.Get3DDistance(v1.x, v1.y, v1.z, coords.x, coords.y, coords.z) < 3.0 then
				X.IsPlanting = true
				X.AddFertilizer(v1.id, quantity)
				return nil
			end
		end
	end
	ESX.ShowNotification(Local.noPlantNear)
end)

RegisterNetEvent('tm1_stores:refreshWater')
AddEventHandler('tm1_stores:refreshWater', function(water)
	Config.WaterPoints = water
end)

RegisterNetEvent('tm1_stores:refreshValves')
AddEventHandler('tm1_stores:refreshValves', function(valves)
	Config.Valves = valves
end)

RegisterNetEvent('tm1_stores:takeWater')
AddEventHandler('tm1_stores:takeWater', function(seed)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	if X.IsDoingSomething == false then
		for k,v in pairs(Config.WaterPoints) do
			if X.Get3DDistance(v.x, v.y, v.z, coords.x, coords.y, coords.z) < 3.0 then
				exports['mythic_progbar']:Progress({
					name = "coletar_agua",
					duration = 15000,
					label = "A coletar agua...",
					useWhileDead = false,
					canCancel = true,
					controlDisables = {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					},
					animation = {},
					prop = {},
					propTwo = {},
				}, function (status)
					if not status then
						X.GetWater(v)
						return nil
					end
				end)
			end
		end
	else
		ESX.ShowNotification(Local.youAreDoingSomething)
		return nil
	end
	ESX.ShowNotification(Local.noWaterPointsNearby)
end)

RegisterNetEvent('tm1_stores:removePlant')
AddEventHandler('tm1_stores:removePlant', function(coords)
	local object, distance = ESX.Game.GetClosestObject('', coords)
	ESX.Game.DeleteObject(object)
end)

Citizen.CreateThread(function() while true do Citizen.Wait(30000) collectgarbage() end end)-- Prevents RAM LEAKS :)