Config = {}
Config.Locale = 'en'
Config.DrawDistance = 1.5
Config.AntiCombatLog              = false
Config.EarlyRespawnTimer          = 5 * (60 * 1000)
Config.BleedoutTimer              = 2 * (60 * 1000)
Config.ReviveReward 			  = 200
Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true
Config.Jobs = {
	mechanic = {
		Label = "Benny'S",
		BuyItems  = 25,
		EnablePlayerManagement = true,
		EnableSocietyOwnedVehicles = false,
		modEngine = 5,
		modBrakes = 5,
		modTransmission = 5,
		modSuspension = 5,
		modTurbo = true,
		PrimaryColour = {r = 110, g = 0, b = 0},
		SecondaryColour = {r = 255, g = 255, b = 255},
		ActionsMenu = {
			elements = {
				normal = {
					{label = _U('vehicle_list'),   value = 'vehicle_list'},
					{label = _U('work_wear'),      value = 'cloakroom'},
					{label = _U('civ_wear'),       value = 'cloakroom2'}
				},
				boss = {
					{label = _U('vehicle_list'),   value = 'vehicle_list'},
					{label = _U('work_wear'),      value = 'cloakroom'},
					{label = _U('civ_wear'),       value = 'cloakroom2'},
					{label = _U('boss_actions'), value = 'boss_actions'},
					--{label = "Compra de Items",      value = 'buy'}
				}
			}
		},
		Blip = {
			Pos     = { x = -200.74, y = -1318.69, z = 31.09 },
			Sprite  = 446,
			Display = 4,
			Scale   = 0.6,
			Colour  = 14,
		},
		Zones = {

			CarLift = {
				Pos = { x = -219.3204, y = -1326.43, z = 31.00041},
				Text = 'Clica [~g~E~w~] para controlar máquina'
			},

			MechanicActions = {
				Pos   = { x = -200.74, y = -1318.69, z = 31.09 },
				Size  = { x = 1.5, y = 1.5, z = 1.0 },
				Type  = 0,
				Text  = 'Clique [~g~H~w~] para ~g~abrir~w~ menu'
			},

			Garage = {
				Pos   = { x = 1991.04, y = 3790.29, z = 32.18 },
				Size  = { x = 1.5, y = 1.5, z = 1.0 },
				Type  = 1,
				Text  = 'Clique [~g~H~w~] para apanhar~y~ ferramentas'
			},

			Craft = {
				Pos   = { x = -323.140, y = -129.882, z = 38.999 },
				Size  = { x = 1.5, y = 1.5, z = 1.0 },
				Type  = 1,
				Text  = 'Clique [~g~H~w~] para criar~y~ ferramentas'
			},

			VehicleSpawnPoint = {
				Pos   = {x = -203.56, y = -1305.43, z = 30.37 },
				Size  = { x = 1.5, y = 1.5, z = 1.0 },
				Type  = -1,
				Text  = ''
			},

			VehicleDeleter = {
				Pos   = { x = -193.56, y = -1305.43, z = 31.37 },
				Size  = { x = 3.0, y = 3.0, z = 1.0 },
				Type  = 1,
				Text  = 'Clique [~g~H~w~] para ~g~guardar~w~ carro'
			},

			VehicleDelivery = {
				Pos   = { x = -221, y = -1294.16, z = 31.3 },
				Size  = { x = 20.0, y = 20.0, z = 3.0 },
				Type  = -1,
				Text  = ''
			},

			ls1 = {
				Pos   = { x = -222.25, y = -1329.58, z = 30.89 },
				Size  = {x = 3.0, y = 3.0, z = 0.2},
				Marker= 1,
				Text  = 'Clique [~g~H~w~] para ~g~costumizar~w~ carro'

			},

			ls2 = {
				Pos   = { x = -199.11, y = -1324.4, z = 31.13 },
				Size  = {x = 3.0, y = 3.0, z = 0.2},
				Marker= 1,
				Text  = 'Clique [~g~H~w~] para ~g~costumizar~w~ carro'
			},

			ls3 = {
				Pos   = { x = -221.82, y = -1324.24, z = 31.13 },
				Size  = {x = 3.0, y = 3.0, z = 0.2},
				Marker= 1,
				Text  = 'Clique [~g~H~w~] para ~g~costumizar~w~ carro'
			},

			ls4 = {
				Pos   = { x = -186.34, y = -1280.12, z = 31.3 },
				Size  = {x = 3.0, y = 3.0, z = 0.2},
				Marker= 1,
				Text  = 'Clique [~g~H~w~] para ~g~costumizar~w~ carro'
			},

			ls5 = {
				Pos   = { x = -181.54, y = -1287.18, z = 31.3 },
				Size  = {x = 3.0, y = 3.0, z = 0.2},
				Marker= 1,
				Text  = 'Clique [~g~H~w~] para ~g~costumizar~w~ carro'
			},

			ls6 = {
				Pos   = { x = 965.21, y = -108.29, z = 74.36 },
				Size  = {x = 3.0, y = 3.0, z = 0.2},
				Marker= 1,
				Text  = 'Clique [~g~H~w~] para ~g~costumizar~w~ carro'
			},

			ls7 = {
				Pos   = { x = 983.54, y = -134.25, z = 74.06 },
				Size  = {x = 3.0, y = 3.0, z = 0.2},
				Marker= 1,
				Text  = 'Clique [~g~H~w~] para ~g~costumizar~w~ carro'
			},

			ls8 = {
				Pos   = { x = 994.83, y = -113.39, z = 74.08 },
				Size  = {x = 3.0, y = 3.0, z = 0.2},
				Marker= 1,
				Text  = 'Clique [~g~H~w~] para ~g~costumizar~w~ carro'
			}

		},
		Colors = {
			{ label = _U('black'), value = 'black'},
			{ label = _U('white'), value = 'white'},
			{ label = _U('grey'), value = 'grey'},
			{ label = _U('red'), value = 'red'},
			{ label = _U('pink'), value = 'pink'},
			{ label = _U('blue'), value = 'blue'},
			{ label = _U('yellow'), value = 'yellow'},
			{ label = _U('green'), value = 'green'},
			{ label = _U('orange'), value = 'orange'},
			{ label = _U('brown'), value = 'brown'},
			{ label = _U('purple'), value = 'purple'},
			{ label = _U('chrome'), value = 'chrome'},
			{ label = _U('gold'), value = 'gold'}
		},
		Menu = {
			['mechanic'] = {
				enableMenu = function()
					return true
				end,
				data = {
					keybind = 289,
					style = {
						sizePx = 600,
						slices = {
							default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 1, ['opacity'] = 0.60 },
							hover = { ['fill'] = '#ffcc00', ['stroke'] = '#000000', ['stroke-width'] = 1, ['opacity'] = 0.80 },
							selected = { ['fill'] = '#ffcc00', ['stroke'] = '#000000', ['stroke-width'] = 1, ['opacity'] = 0.80 }
						},
						titles = {
							default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 12, ['font-weight'] = 'bold' },
							hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 12, ['font-weight'] = 'bold' },
							selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 12, ['font-weight'] = 'bold' }
						},
						icons = {
							width = 64,
							height = 64
						}
					},
					wheels = {
						{
							navAngle = 0,
							minRadiusPercent = 0.0,
							maxRadiusPercent = 0.0,
							labels = {"imgsrc:logout.png"},
							commands = {"re"}
						},
						{
							navAngle = 270,
							minRadiusPercent = 0.25,
							maxRadiusPercent = 0.55,
							labels = {"imgsrc:faturas.png", "imgsrc:limp.png", "imgsrc:del.png", "imgsrc:rebocar.png", "imgsrc:spawn.png"},
							commands = {"faturas","limparveiculo", "delveiculo", "rebveiculo","MECsubmenu2"}
						}
					}
				}
			}
		},
		SubMenu = {
			['mechanic'] = {
				data = {
					keybind = 289,
					style = {
						sizePx = 600,
						slices = {
							default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 1, ['opacity'] = 0.60 },
							hover = { ['fill'] = '#ffcc00', ['stroke'] = '#000000', ['stroke-width'] = 1, ['opacity'] = 0.80 },
							selected = { ['fill'] = '#ffcc00', ['stroke'] = '#000000', ['stroke-width'] = 1, ['opacity'] = 0.80 }
						},
						titles = {
							default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 12, ['font-weight'] = 'bold' },
							hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 12, ['font-weight'] = 'bold' },
							selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 12, ['font-weight'] = 'bold' }
						},
						icons = {
							width = 64,
							height = 64
						}
					},
					wheels = {
						{
							navAngle = 0,
							minRadiusPercent = 0.0,
							maxRadiusPercent = 0.0,
							labels = {"imgsrc:logout.png"},
							commands = {"e stop"}
						},
						{
							navAngle = 270,
							minRadiusPercent = 0.25,
							maxRadiusPercent = 0.55,
							labels = {"imgsrc:faturas.png", "imgsrc:anim.png", "imgsrc:limp.png", "imgsrc:del.png", "imgsrc:rebocar.png", "imgsrc:spawn.png"},
							commands = {"faturas","MECsubmenu1" ,"limparveiculo", "delveiculo", "tow","MECsubmenu2"}
						},
						{
							navAngle = 270,
							minRadiusPercent = 0.6,
							maxRadiusPercent = 0.9,
							labels = {"imgsrc:cone.png", "imgsrc:macaco.png", "imgsrc:exhaust.png", "imgsrc:ferramentas.png"},
							commands = {"p cone", "p trolley", "p hoist", "p ferramentas"}
						}
					}
				}
			}
		}
	},
	mechanic2 = {
		Label = "LS Custom'S",
		BuyItems  = 25,
		EnablePlayerManagement = true,
		EnableSocietyOwnedVehicles = false,
		modEngine = 5,
		modBrakes = 5,
		modTransmission = 5,
		modSuspension = 5,
		modTurbo = true,
		PrimaryColour = {r = 255, g = 255, b = 10},
		SecondaryColour = {r = 255, g = 255, b = 10},
		ActionsMenu = {
			elements = {
				normal = {
					{label = _U('vehicle_list'),   value = 'vehicle_list'},
					{label = _U('work_wear'),      value = 'cloakroom'},
					{label = _U('civ_wear'),       value = 'cloakroom2'}
				},
				boss = {
					{label = _U('vehicle_list'),   value = 'vehicle_list'},
					{label = _U('work_wear'),      value = 'cloakroom'},
					{label = _U('civ_wear'),       value = 'cloakroom2'},
					{label = _U('boss_actions'), value = 'boss_actions'},
					--{label = "Compra de Items",      value = 'buy'}
				}
			}
		},
		Blip = {
			Pos     = { x = -361.61, y = -123.5, z = 31.09 },
			Sprite  = 446,
			Display = 4,
			Scale   = 0.6,
			Colour  = 37,
		},
		Zones = {

			CarLift = {
				Pos = { x = 0.0, y = 0.0, z = 0.0},
				Text = ''
			},

			MechanicActions = {
				Pos   = { x = -345.23, y = -122.92, z = 39.01 },
				Size  = { x = 1.5, y = 1.5, z = 1.0 },
				Type  = 0,
				Text  = 'Clique [~g~H~w~] para ~g~abrir~w~ menu'
			},

			--[[Garage = {
				Pos   = { x = 1991.04, y = 3790.29, z = 32.18 },
				Size  = { x = 1.5, y = 1.5, z = 1.0 },
				Type  = 1,
				Text  = 'Clique [~g~H~w~] para apanhar~y~ ferramentas'
			},

			Craft = {
				Pos   = { x = -323.140, y = -129.882, z = 38.999 },
				Size  = { x = 1.5, y = 1.5, z = 1.0 },
				Type  = 1,
				Text  = 'Clique [~g~H~w~] para criar~y~ ferramentas'
			},]]

			VehicleSpawnPoint = {
				Pos   = {x = -358.28, y = -114.22, z = 38.07 },
				Size  = { x = 1.5, y = 1.5, z = 1.0 },
				Type  = -1,
				Text  = ''
			},

			VehicleDeleter = {
				Pos   = {x = -358.28, y = -114.22, z = 38.77 },
				Size  = { x = 3.0, y = 3.0, z = 1.0 },
				Type  = 1,
				Text  = 'Clique [~g~H~w~] para ~g~guardar~w~ carro'
			},

			--[[VehicleDelivery = {
				Pos   = { x = -221, y = -1294.16, z = 31.3 },
				Size  = { x = 20.0, y = 20.0, z = 3.0 },
				Type  = -1,
				Text  = ''
			},]]

			ls1 = {
				Pos   = { x = -323.7, y = -132.51, z = 38.96 },
				Size  = {x = 3.0, y = 3.0, z = 0.2},
				Marker= 1,
				Text  = 'Clique [~g~H~w~] para ~g~costumizar~w~ carro'

			},

			ls2 = {
				Pos   = { x = -327.32, y = -144.64, z = 39.06 },
				Size  = {x = 3.0, y = 3.0, z = 0.2},
				Marker= 1,
				Text  = 'Clique [~g~H~w~] para ~g~costumizar~w~ carro'
			},

			ls3 = {
				Pos   = { x = -338.76, y = -136.33, z = 39.01 },
				Size  = {x = 3.0, y = 3.0, z = 0.2},
				Marker= 1,
				Text  = 'Clique [~g~H~w~] para ~g~costumizar~w~ carro'
			},

			ls4 = { 
				Pos   = { x = -360.57, y = -128.2, z = 38.86 },
				Size  = {x = 3.0, y = 3.0, z = 0.2},
				Marker= 1,
				Text  = 'Clique [~g~H~w~] para ~g~costumizar~w~ carro'
			},

			ls7 = { 
				Pos   = { x = -366.35, y = -110.29, z = 38.86 },
				Size  = {x = 3.0, y = 3.0, z = 0.2},
				Marker= 1,
				Text  = 'Clique [~g~H~w~] para ~g~costumizar~w~ carro'
			},

			ls8 = { 
				Pos   = { x = -374.55, y = -107.4, z = 38.86 },
				Size  = {x = 3.0, y = 3.0, z = 0.2},
				Marker= 1,
				Text  = 'Clique [~g~H~w~] para ~g~costumizar~w~ carro'
			}

		},
		Colors = {
			{ label = _U('black'), value = 'black'},
			{ label = _U('white'), value = 'white'},
			{ label = _U('grey'), value = 'grey'},
			{ label = _U('red'), value = 'red'},
			{ label = _U('pink'), value = 'pink'},
			{ label = _U('blue'), value = 'blue'},
			{ label = _U('yellow'), value = 'yellow'},
			{ label = _U('green'), value = 'green'},
			{ label = _U('orange'), value = 'orange'},
			{ label = _U('brown'), value = 'brown'},
			{ label = _U('purple'), value = 'purple'},
			{ label = _U('chrome'), value = 'chrome'},
			{ label = _U('gold'), value = 'gold'}
		},
		Menu = {
			['mechanic2'] = {
				enableMenu = function()
					return true
				end,
				data = {
					keybind = 289,
					style = {
						sizePx = 600,
						slices = {
							default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 1, ['opacity'] = 0.60 },
							hover = { ['fill'] = '#ffcc00', ['stroke'] = '#000000', ['stroke-width'] = 1, ['opacity'] = 0.80 },
							selected = { ['fill'] = '#ffcc00', ['stroke'] = '#000000', ['stroke-width'] = 1, ['opacity'] = 0.80 }
						},
						titles = {
							default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 12, ['font-weight'] = 'bold' },
							hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 12, ['font-weight'] = 'bold' },
							selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 12, ['font-weight'] = 'bold' }
						},
						icons = {
							width = 64,
							height = 64
						}
					},
					wheels = {
						{
							navAngle = 0,
							minRadiusPercent = 0.0,
							maxRadiusPercent = 0.0,
							labels = {"imgsrc:logout.png"},
							commands = {"re"}
						},
						{
							navAngle = 270,
							minRadiusPercent = 0.25,
							maxRadiusPercent = 0.55,
							labels = {"imgsrc:faturas.png", "imgsrc:limp.png", "imgsrc:del.png", "imgsrc:rebocar.png", "imgsrc:spawn.png"},
							commands = {"faturas","limparveiculo", "delveiculo", "rebveiculo","MECsubmenu2"}
						}
					}
				}
			}
		},
		SubMenu = {
			['mechanic2'] = {
				data = {
					keybind = 289,
					style = {
						sizePx = 600,
						slices = {
							default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 1, ['opacity'] = 0.60 },
							hover = { ['fill'] = '#ffcc00', ['stroke'] = '#000000', ['stroke-width'] = 1, ['opacity'] = 0.80 },
							selected = { ['fill'] = '#ffcc00', ['stroke'] = '#000000', ['stroke-width'] = 1, ['opacity'] = 0.80 }
						},
						titles = {
							default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 12, ['font-weight'] = 'bold' },
							hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 12, ['font-weight'] = 'bold' },
							selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 12, ['font-weight'] = 'bold' }
						},
						icons = {
							width = 64,
							height = 64
						}
					},
					wheels = {
						{
							navAngle = 0,
							minRadiusPercent = 0.0,
							maxRadiusPercent = 0.0,
							labels = {"imgsrc:logout.png"},
							commands = {"e stop"}
						},
						{
							navAngle = 270,
							minRadiusPercent = 0.25,
							maxRadiusPercent = 0.55,
							labels = {"imgsrc:faturas.png", "imgsrc:anim.png", "imgsrc:limp.png", "imgsrc:del.png", "imgsrc:rebocar.png", "imgsrc:spawn.png"},
							commands = {"faturas","MECsubmenu1" ,"limparveiculo", "delveiculo", "tow","MECsubmenu2"}
						},
						{
							navAngle = 270,
							minRadiusPercent = 0.6,
							maxRadiusPercent = 0.9,
							labels = {"imgsrc:cone.png", "imgsrc:macaco.png", "imgsrc:exhaust.png", "imgsrc:ferramentas.png"},
							commands = {"p cone", "p trolley", "p hoist", "p ferramentas"}
						}
					}
				}
			}
		}
	},
	unicorn = {
		Label = "Vanilla",
		EnablePlayerManagement = true,
		EnableSocietyOwnedVehicles = false,
		modEngine = 5,
		modBrakes = 5,
		modTransmission = 5,
		modSuspension = 5,
		modTurbo = true,
		PrimaryColour = {r = 0, g = 0, b = 0},
		SecondaryColour = {r = 0, g = 0, b = 0},
		ActionsMenu = {
			elements = {
				normal = {
					{label = _U('vehicle_list'),   value = 'vehicle_list'},
					{label = _U('work_wear'),      value = 'cloakroom'},
					{label = _U('civ_wear'),       value = 'cloakroom2'}
				},
				boss = {
					{label = _U('vehicle_list'),   value = 'vehicle_list'},
					{label = _U('work_wear'),      value = 'cloakroom'},
					{label = _U('civ_wear'),       value = 'cloakroom2'},
					{label = _U('boss_actions'), value = 'boss_actions'}
				}
			}
		},
		Blip = {
			Pos     = { x = 129.246, y = -1299.363, z = 29.501 },
			Sprite  = 121,
			Display = 4,
			Scale   = 0.6,
			Colour  = 27
		},
		--AuthorizedVehicles = {},
		Zones = {

			Cloakrooms = {
				Pos   = { x = 105.111, y = -1303.221, z = 28.788 },
				Text = 'Clica [~g~H~w~] para abrir ~b~Cacifo',
				Size  = { x = 1.5, y = 1.5, z = 1.0 }
			},

			--[[Vehicles = {
				Pos          = { x = 137.177, y = -1278.757, z = 29.371 },
				Text = 'Clica [~g~H~w~] para abrir ~b~Garagem',
				SpawnPoint   = { x = 138.436, y = -1263.095, z = 28.626 },
				Size         = { x = 1.8, y = 1.8, z = 1.0 },
				Heading      = 207.43
			},

			VehicleDeleters = {
				Pos   = { x = 145.02, y = -1287.58, z = 30.34 },
				Text = 'Clica [~g~H~w~] para ~b~Guardar',
				Size  = { x = 3.0, y = 3.0, z = 0.2 }
			},]]
			BossActions = {
				Pos   = { x = 94.951, y = -1294.021, z = 29.268 },
				Text = 'Clica [~g~H~w~] para ~y~Administração',
				Size  = { x = 1.5, y = 1.5, z = 1.0 },
				Color = { r = 0, g = 100, b = 0 },
				Type  = 27,
			}

		},
		Uniforms = {
			barman_outfit = {
			  male = {
				  ['tshirt_1'] = 6,  ['tshirt_2'] = 0,
				  ['torso_1'] = 25,   ['torso_2'] = 5,
				  ['decals_1'] = 0,   ['decals_2'] = 0,
				  ['arms'] = 81,
				  ['pants_1'] = 24,   ['pants_2'] = 0,
				  ['shoes_1'] = 18,   ['shoes_2'] = 1,
				  ['chain_1'] = 22, ['chain_2']  = 14
			  },
			  female = {
				  ['tshirt_1'] = 3,   ['tshirt_2'] = 0,
				  ['torso_1'] = 8,    ['torso_2'] = 2,
				  ['decals_1'] = 0,   ['decals_2'] = 0,
				  ['arms'] = 5,
				  ['pants_1'] = 44,   ['pants_2'] = 4,
				  ['shoes_1'] = 0,    ['shoes_2'] = 0,
				  ['chain_1'] = 0,    ['chain_2'] = 2
			  }
			},
			dancer_outfit_1 = {
			  male = {
				  ['tshirt_1'] = 6,  ['tshirt_2'] = 2,
				  ['torso_1'] = 11,   ['torso_2'] = 1,
				  ['decals_1'] = 0,   ['decals_2'] = 0,
				  ['arms'] = 37,
				  ['pants_1'] = 24,   ['pants_2'] = 0,
				  ['shoes_1'] = 20,   ['shoes_2'] = 7,
				  ['chain_1'] = 25,  ['chain_2'] = 15,
				  ['watches_1'] = 4,   ['watches_2'] = 2
			  },
			  female = {
				  ['tshirt_1'] = 14,   ['tshirt_2'] = 0,
				  ['torso_1'] = 111,   ['torso_2'] = 10,
				  ['decals_1'] = 0,   ['decals_2'] = 0,
				  ['arms'] = 4,
				  ['pants_1'] = 20,   ['pants_2'] = 2,
				  ['shoes_1'] = 41,   ['shoes_2'] = 10,
				  ['chain_1'] = 1,   ['chain_2'] = 0
			  }
			},
			dancer_outfit_2 = {
			  male = {
				  ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
				  ['torso_1'] = 62,   ['torso_2'] = 0,
				  ['decals_1'] = 0,   ['decals_2'] = 0,
				  ['arms'] = 14,
				  ['pants_1'] = 4,    ['pants_2'] = 0,
				  ['shoes_1'] = 34,   ['shoes_2'] = 0,
				  ['chain_1'] = 118,  ['chain_2'] = 0
			  },
			  female = {
				  ['tshirt_1'] = 14,   ['tshirt_2'] = 0,
				  ['torso_1'] = 111,   ['torso_2'] = 2,
				  ['decals_1'] = 0,   ['decals_2'] = 0,
				  ['arms'] = 4,
				  ['pants_1'] = 63,   ['pants_2'] = 2,
				  ['shoes_1'] = 41,   ['shoes_2'] = 2,
				  ['chain_1'] = 0,    ['chain_2'] = 0
			  }
			},
			dancer_outfit_3 = {
			  male = {
				  ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
				  ['torso_1'] = 15,   ['torso_2'] = 0,
				  ['decals_1'] = 0,   ['decals_2'] = 0,
				  ['arms'] = 15,
				  ['pants_1'] = 4,    ['pants_2'] = 0,
				  ['shoes_1'] = 34,   ['shoes_2'] = 0,
				  ['chain_1'] = 118,  ['chain_2'] = 0
			  },
			  female = {
				  ['tshirt_1'] = 14,   ['tshirt_2'] = 0,
				  ['torso_1'] = 22,   ['torso_2'] = 1,
				  ['decals_1'] = 0,   ['decals_2'] = 0,
				  ['arms'] = 4,
				  ['pants_1'] = 19,   ['pants_2'] = 1,
				  ['shoes_1'] = 19,   ['shoes_2'] = 3,
				  ['chain_1'] = 0,    ['chain_2'] = 0
			  }
			},
			dancer_outfit_4 = {
			  male = {
				  ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
				  ['torso_1'] = 15,   ['torso_2'] = 0,
				  ['decals_1'] = 0,   ['decals_2'] = 0,
				  ['arms'] = 15,
				  ['pants_1'] = 61,   ['pants_2'] = 5,
				  ['shoes_1'] = 34,   ['shoes_2'] = 0,
				  ['chain_1'] = 118,  ['chain_2'] = 0
			  },
			  female = {
				  ['tshirt_1'] = 14,   ['tshirt_2'] = 0,
				  ['torso_1'] = 22,   ['torso_2'] = 0,
				  ['decals_1'] = 0,   ['decals_2'] = 0,
				  ['arms'] = 4,
				  ['pants_1'] = 28,   ['pants_2'] = 0,
				  ['shoes_1'] = 19,   ['shoes_2'] = 6,
				  ['chain_1'] = 0,    ['chain_2'] = 0
			  }
			},
			dancer_outfit_5 = {
			  male = {
				  ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
				  ['torso_1'] = 15,   ['torso_2'] = 0,
				  ['decals_1'] = 0,   ['decals_2'] = 0,
				  ['arms'] = 15,
				  ['pants_1'] = 21,   ['pants_2'] = 0,
				  ['shoes_1'] = 34,   ['shoes_2'] = 0,
				  ['chain_1'] = 118,  ['chain_2'] = 0
			  },
			  female = {
				  ['tshirt_1'] = 14,   ['tshirt_2'] = 0,
				  ['torso_1'] = 22,   ['torso_2'] = 4,
				  ['decals_1'] = 0,   ['decals_2'] = 0,
				  ['arms'] = 4,
				  ['pants_1'] = 19,   ['pants_2'] = 4,
				  ['shoes_1'] = 23,   ['shoes_2'] = 2,
				  ['chain_1'] = 0,    ['chain_2'] = 0
			  }
			},
			dancer_outfit_6 = {
			  male = {
				  ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
				  ['torso_1'] = 15,   ['torso_2'] = 0,
				  ['decals_1'] = 0,   ['decals_2'] = 0,
				  ['arms'] = 15,
				  ['pants_1'] = 81,   ['pants_2'] = 0,
				  ['shoes_1'] = 34,   ['shoes_2'] = 0,
				  ['chain_1'] = 118,  ['chain_2'] = 0
			  },
			  female = {
				  ['tshirt_1'] = 3,   ['tshirt_2'] = 0,
				  ['torso_1'] = 18,   ['torso_2'] = 3,
				  ['decals_1'] = 0,   ['decals_2'] = 0,
				  ['arms'] = 15,
				  ['pants_1'] = 63,   ['pants_2'] = 10,
				  ['shoes_1'] = 41,   ['shoes_2'] = 10,
				  ['chain_1'] = 0,    ['chain_2'] = 0
			  }
			},
			dancer_outfit_7 = {
			  male = {
				  ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
				  ['torso_1'] = 15,   ['torso_2'] = 0,
				  ['decals_1'] = 0,   ['decals_2'] = 0,
				  ['arms'] = 40,
				  ['pants_1'] = 61,   ['pants_2'] = 9,
				  ['shoes_1'] = 16,   ['shoes_2'] = 9,
				  ['chain_1'] = 118,  ['chain_2'] = 0
			  },
			  female = {
				  ['tshirt_1'] = 3,   ['tshirt_2'] = 0,
				  ['torso_1'] = 111,  ['torso_2'] = 6,
				  ['decals_1'] = 0,   ['decals_2'] = 0,
				  ['arms'] = 15,
				  ['pants_1'] = 63,   ['pants_2'] = 6,
				  ['shoes_1'] = 41,   ['shoes_2'] = 6,
				  ['chain_1'] = 0,    ['chain_2'] = 0
			  }
			}
		}
	},
	ambulance = {
		Label = "Ambulance",
		EnablePlayerManagement = true,
		EnableSocietyOwnedVehicles = false,
		modEngine = 5,
		modBrakes = 5,
		modTransmission = 5,
		modSuspension = 5,
		modTurbo = true,
		ReviveReward = 200,
		ActionsMenu = {
			elements = {
				normal = {
					{label = _U('work_wear'), value = 'cloakroom'}
				},
				boss = {
					{label = _U('work_wear'), value = 'cloakroom'},
					{label = _U('boss_actions'), value = 'boss_actions'}
				}
			}
		},
		Blip = {
			Pos     = { x = 327.74, y = -597.69, z = 28.79 },
			Sprite  = 61,
			Display = 4,
			Scale   = 0.6,
			Colour  = 2,
		},
		Zones = {

			AmbulanceActions = {
				{
					Pos = vector3(299.04, -598.2, 42.3),
					Text = 'Clica [~g~H~w~] para abrir ~y~Armário'
				}
			},

			Pharmacies = {
				{
					Pos = vector3(312.04, -597.58, 42.3),
					Text = 'Clica [~g~H~w~] para abrir ~b~Farmácia'
				}
			},

			Vehicles = {
				{
					Spawner = vector3(328.38, -556.73, 27.75),
					Text = 'Clica [~g~H~w~] para abrir ~b~Garagem',
					InsideShop = vector3(338.92, -559.36, 28.74),
					Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
					SpawnPoints = vector3(338.92, -559.36, 28.74)
				}
			},

			Helicopters = {
				{
					Spawner = vector3(339.27, -586.99, 73.2),
					Text = 'Clica [~g~H~w~] para abrir ~b~Heliporto',
					InsideShop = vector3(351.86, -588.16, 74.17),
					Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true },
					SpawnPoints = vector3(351.86, -588.16, 74.17)
				}
			},

			AuthorizedVehicles = {

				ambulance = {
					{ model = 'qrv', label = 'SUV S.E.M', price = 0},
					{ model = 'ambulance', label = 'Ambulância', price = 0}
				},

				doctor = {
					{ model = 'qrv', label = 'SUV S.E.M', price = 0},
					{ model = 'ambulance', label = 'Ambulância', price = 0}
				},

				chief_doctor = {
					{ model = 'qrv', label = 'SUV S.E.M', price = 0},
					{ model = 'ambulance', label = 'Ambulância', price = 0}
				},

				boss = {
					{ model = 'qrv', label = 'SUV S.E.M', price = 0},
					{ model = 'ambulance', label = 'Ambulância', price = 0}
				}

			},

			AuthorizedHelicopters = {

				ambulance = {},

				doctor = {
					{ model = 'swift', label = 'Helicóptero SEM', price = 0 }
				},

				chief_doctor = {
					{ model = 'swift', label = 'Helicóptero SEM', price = 0 }
				},

				boss = {
					{ model = 'swift', label = 'Helicóptero SEM', price = 0 }
				}
			}

		},
		Menu = {
			['ambulance'] = {
				enableMenu = function()
					return true
				end,
				data = {
					keybind = 289,
					style = {
						sizePx = 600,
						slices = {
							default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 1, ['opacity'] = 0.60 },
							hover = { ['fill'] = '#ffcc00', ['stroke'] = '#000000', ['stroke-width'] = 1, ['opacity'] = 0.80 },
							selected = { ['fill'] = '#ffcc00', ['stroke'] = '#000000', ['stroke-width'] = 1, ['opacity'] = 0.80 }
						},
						titles = {
							default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 12, ['font-weight'] = 'bold' },
							hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 12, ['font-weight'] = 'bold' },
							selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 12, ['font-weight'] = 'bold' }
						},
						icons = {
							width = 64,
							height = 64
						}
					},
					wheels = {
						{
							navAngle = 0,
							minRadiusPercent = 0.0,
							maxRadiusPercent = 0.0,
							labels = {"imgsrc:logout.png"},
							commands = {"re"}
						},
						{
							navAngle = 270,
							minRadiusPercent = 0.25,
							maxRadiusPercent = 0.55,
							labels = {"imgsrc:faturas.png", "imgsrc:luvas.png", "imgsrc:life.png", "imgsrc:bandage.png"},
							commands = {"fatura","MEDsubmenu1" ,"medic_revive", "bandage"}
						}
					}
				}
			}
		},
		SubMenu = {
			['ambulance'] = {
				data = {
					keybind = 289,
					style = {
						sizePx = 600,
						slices = {
							default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 1, ['opacity'] = 0.60 },
							hover = { ['fill'] = '#ffcc00', ['stroke'] = '#000000', ['stroke-width'] = 1, ['opacity'] = 0.80 },
							selected = { ['fill'] = '#ffcc00', ['stroke'] = '#000000', ['stroke-width'] = 1, ['opacity'] = 0.80 }
						},
						titles = {
							default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 12, ['font-weight'] = 'bold' },
							hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 12, ['font-weight'] = 'bold' },
							selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 12, ['font-weight'] = 'bold' }
						},
						icons = {
							width = 64,
							height = 64
						}
					},
					wheels = {
						{
							navAngle = 0,
							minRadiusPercent = 0.0,
							maxRadiusPercent = 0.0,
							labels = {"imgsrc:logout.png"},
							commands = {"e stop"}
						},
						{
							navAngle = 270,
							minRadiusPercent = 0.25,
							maxRadiusPercent = 0.55,
							labels = {"imgsrc:faturas.png", "imgsrc:luvas.png", "imgsrc:life.png", "imgsrc:bandage.png", "imgsrc:medkit.png", "imgsrc:amb.png"},
							commands = {"fatura","MEDsubmenu1" ,"medic_revive", "bandage", "medicKit","PutInVeh"}
						},
						{
							navAngle = 270,
							minRadiusPercent = 0.6,
							maxRadiusPercent = 0.9,
							labels = {"imgsrc:medbox.png", "imgsrc:medkit.png"},
							commands = {"prop MedBox", "prop MedBag"}
						}
					}
				}
			}
		}
	},
	police = {
		Label = "D.P.L.S",
		EnablePlayerManagement = true,
		modEngine = 5,
		modBrakes = 5,
		modTransmission = 5,
		modSuspension = 5,
		modTurbo = true,
		Blip = {
			Pos     = { x = 425.130, y = -979.558, z = 30.711 },
			Sprite  = 60,
			Display = 4,
			Scale   = 0.6,
			Colour  = 4,
		},
		Zones = {
			BossActions = { x = 451.60140991211, y = -973.38153076172, z = 30.689582824707 }
		}
	},
	sheriff = {
		Label = "D.P.B.C",
		EnablePlayerManagement = true,
		modEngine = 5,
		modBrakes = 5,
		modTransmission = 5,
		modSuspension = 5,
		modTurbo = true,
		Blip = {
			Pos     = { x = 1853.86, y = 3687.88, z = 34.711 },
			Sprite  = 60,
			Display = 4,
			Scale   = 0.8,
			Colour  = 71,
		},
		Zones = {
			BossActions = { x = 1841.8198242188, y = 3691.2978515625, z = 34.202377319336 }
		}
	}
}
