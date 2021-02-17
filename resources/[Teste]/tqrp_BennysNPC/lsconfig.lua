
local colors = {
{name = "Preto", colorindex = 0},{name = "Carbon Preto", colorindex = 147},
{name = "Hraphite", colorindex = 1},{name = "Anhracite Preto", colorindex = 11},
{name = "Preto Metálico", colorindex = 2},{name = "Escuro Metálico", colorindex = 3},
{name = "Cinzento", colorindex = 4},{name = "Bluish Cinzento", colorindex = 5},
{name = "Rolled Metálico", colorindex = 6},{name = "Shadow Cinzento", colorindex = 7},
{name = "Stone Cinzento", colorindex = 8},{name = "Midnight Cinzento", colorindex = 9},
{name = "Cast Iron Cinzento", colorindex = 10},{name = "Vermelho", colorindex = 27},
{name = "Torino Vermelho", colorindex = 28},{name = "Formula Vermelho", colorindex = 29},
{name = "Lava Vermelho", colorindex = 150},{name = "Blaze Vermelho", colorindex = 30},
{name = "Grace Vermelho", colorindex = 31},{name = "Garnet Vermelho", colorindex = 32},
{name = "Sunset Vermelho", colorindex = 33},{name = "Cabernet Vermelho", colorindex = 34},
{name = "Wine Vermelho", colorindex = 143},{name = "Candy Vermelho", colorindex = 35},
{name = "Hot Rosa", colorindex = 135},{name = "Pfsiter Rosa", colorindex = 137},
{name = "Salmon Rosa", colorindex = 136},{name = "Sunrise Laranja", colorindex = 36},
{name = "Laranja", colorindex = 38},{name = "Bright Laranja", colorindex = 138},
{name = "Ouro", colorindex = 99},{name = "Bronze", colorindex = 90},
{name = "Amarelo", colorindex = 88},{name = "Race Amarelo", colorindex = 89},
{name = "Dew Amarelo", colorindex = 91},{name = "Escuro Verde", colorindex = 49},
{name = "Racing Verde", colorindex = 50},{name = "Sea Verde", colorindex = 51},
{name = "Olive Verde", colorindex = 52},{name = "Bright Verde", colorindex = 53},
{name = "Gasoline Verde", colorindex = 54},{name = "Lime Verde", colorindex = 92},
{name = "Midnight Azul", colorindex = 141},
{name = "Galaxy Azul", colorindex = 61},{name = "Escuro Azul", colorindex = 62},
{name = "Saxon Azul", colorindex = 63},{name = "Azul", colorindex = 64},
{name = "Mariner Azul", colorindex = 65},{name = "Harbor Azul", colorindex = 66},
{name = "Diamond Azul", colorindex = 67},{name = "Surf Azul", colorindex = 68},
{name = "Nautical Azul", colorindex = 69},{name = "Racing Azul", colorindex = 73},
{name = "Ultra Azul", colorindex = 70},{name = "Leve Azul", colorindex = 74},
{name = "Chocolate Castanho", colorindex = 96},{name = "Bison Castanho", colorindex = 101},
{name = "Creeen Castanho", colorindex = 95},{name = "Feltzer Castanho", colorindex = 94},
{name = "Maple Castanho", colorindex = 97},{name = "Beechwood Castanho", colorindex = 103},
{name = "Sienna Castanho", colorindex = 104},{name = "Saddle Castanho", colorindex = 98},
{name = "Moss Castanho", colorindex = 100},{name = "Woodbeech Castanho", colorindex = 102},
{name = "Straw Castanho", colorindex = 99},{name = "Sandy Castanho", colorindex = 105},
{name = "Bleached Castanho", colorindex = 106},{name = "Schafter Lilas", colorindex = 71},
{name = "Spinnaker Lilas", colorindex = 72},{name = "Midnight Lilas", colorindex = 142},
{name = "Bright Lilas", colorindex = 145},{name = "Cream", colorindex = 107},
{name = "Ice Branco", colorindex = 111},{name = "Frost Branco", colorindex = 112}}
local metalcolors = {
{name = "Brushed Metálico",colorindex = 117},
{name = "Brushed Preto Metálico",colorindex = 118},
{name = "Brushed Aluminum",colorindex = 119},
{name = "Pure Ouro",colorindex = 158},
{name = "Brushed Ouro",colorindex = 159}
}
local mattecolors = {
{name = "Preto", colorindex = 12},
{name = "Cinzento", colorindex = 13},
{name = "Leve Cinzento", colorindex = 14},
{name = "Ice Branco", colorindex = 131},
{name = "Azul", colorindex = 83},
{name = "Escuro Azul", colorindex = 82},
{name = "Midnight Azul", colorindex = 84},
{name = "Midnight Lilas", colorindex = 149},
{name = "Schafter Lilas", colorindex = 148},
{name = "Vermelho", colorindex = 39},
{name = "Escuro Vermelho", colorindex = 40},
{name = "Laranja", colorindex = 41},
{name = "Amarelo", colorindex = 42},
{name = "Lime Verde", colorindex = 55},
{name = "Verde", colorindex = 128},
{name = "Frost Verde", colorindex = 151},
{name = "Foliage Verde", colorindex = 155},
{name = "Olive Darb", colorindex = 152},
{name = "Escuro Earth", colorindex = 153},
{name = "Desert Tan", colorindex = 154}
}



LSC_Config = {}
LSC_Config.prices = {}

--------Prices---------
LSC_Config.prices = {

------Window tint------
	windowtint = {
		{ name = "Pure Preto", tint = 1, price = 250},
		{ name = "EscuroFumo", tint = 2, price = 250},
		{ name = "LeveFumo", tint = 3, price = 250},
		{ name = "Limo", tint = 4, price = 250},
		{ name = "Verde", tint = 5, price = 250},
	},

-------Respray--------
----Primary color---
	--Cromado 
	chrome = {
		colors = {
			{name = "Cromado", colorindex = 120}
		},
		price = 1500
	},
	--Classic 
	classic = {
		colors = colors,
		price = 250
	},
	--Matte 
	matte = {
		colors = mattecolors,
		price = 250
	},
	--Metallic 
	metallic = {
		colors = colors,
		price = 250
	},
	--Metals 
	metal = {
		colors = metalcolors,
		price = 250
	},

----Secondary color---
	--Cromado 
	chrome2 = {
		colors = {
			{name = "Cromado", colorindex = 120}
		},
		price = 1500
	},
	--Classic 
	classic2 = {
		colors = colors,
		price = 250
	},
	--Matte 
	matte2 = {
		colors = mattecolors,
		price = 250
	},
	--Metallic 
	metallic2 = {
		colors = colors,
		price = 250
	},
	--Metals 
	metal2 = {
		colors = metalcolors,
		price = 250
	},

------Neon layout------
	neonlayout = {
		{name = "Frontal,Traseiro and Lados", price = 250},
	},
	--Neon color
	neoncolor = {
		{ name = "Branco", neon = {255,255,255}, price = 250},
		{ name = "Azul", neon = {0,0,255}, price = 250},
		{ name = "Electric Azul", neon = {0,150,255}, price = 250},
		{ name = "Mint Verde", neon = {50,255,155}, price = 250},
		{ name = "Lime Verde", neon = {0,255,0}, price = 250},
		{ name = "Amarelo", neon = {255,255,0}, price = 250},
		{ name = "Ouroen Shower", neon = {204,204,0}, price = 250},
		{ name = "Laranja", neon = {255,128,0}, price = 250},
		{ name = "Vermelho", neon = {255,0,0}, price = 250},
		{ name = "Pony Rosa", neon = {255,102,255}, price = 250},
		{ name = "Hot Rosa",neon = {255,0,255}, price = 250},
		{ name = "Lilas", neon = {153,0,153}, price = 250},
		{ name = "Castanho", neon = {139,69,19}, price = 250},
	},
	
--------Plates---------
	plates = {
		{ name = "Azul on Branco 1", plateindex = 0, price = 150},
		{ name = "Azul On Branco 2", plateindex = 3, price = 150},
		{ name = "Azul On Branco 3", plateindex = 4, price = 150},
		{ name = "Amarelo on Azul", plateindex = 2, price = 150},
		{ name = "Amarelo on Preto", plateindex = 1, price = 150},
	},
	
--------Wheels--------
----Wheel accessories----
	wheelaccessories = {
		{ name = "Stock Pneus", price = 1500},
		{ name = "Custom Pneus", price = 1500},
		{ name = "Branco Pneus Fumo",Fumocolor = {254,254,254}, price = 1500},
		{ name = "Preto Pneus Fumo", Fumocolor = {1,1,1}, price = 1500},
		{ name = "Azul Pneus Fumo", Fumocolor = {0,150,255}, price = 1500},
		{ name = "Amarelo Pneus Fumo", Fumocolor = {255,255,50}, price = 1500},
		{ name = "Laranja Pneus Fumo", Fumocolor = {255,153,51}, price = 1500},
		{ name = "Vermelho Pneus Fumo", Fumocolor = {255,10,10}, price = 1500},
		{ name = "Verde Pneus Fumo", Fumocolor = {10,255,10}, price = 1500},
		{ name = "Lilas Pneus Fumo", Fumocolor = {153,10,153}, price = 1500},
		{ name = "Rosa Pneus Fumo", Fumocolor = {255,102,178}, price = 1500},
		{ name = "Cinzento Pneus Fumo",Fumocolor = {128,128,128}, price = 1500},
	},

----Wheel color----
	wheelcolor = {
		colors = colors,
		price = 250,
	},

----Front wheel (Bikes)----
	frontwheel = {
		{name = "Stock", wtype = 6, mod = -1, price = 250},
		{name = "Speedway", wtype = 6, mod = 0, price = 250},
		{name = "Streetspecial", wtype = 6, mod = 1, price = 250},
		{name = "Racer", wtype = 6, mod = 2, price = 250},
		{name = "Trackstar", wtype = 6, mod = 3, price = 250},
		{name = "Overlord", wtype = 6, mod = 4, price = 250},
		{name = "Trident", wtype = 6, mod = 5, price = 250},
		{name = "Triplethreat", wtype = 6, mod = 6, price = 250},
		{name = "Stilleto", wtype = 6, mod = 7, price = 250},
		{name = "Wires", wtype = 6, mod = 8, price = 250},
		{name = "Bobber", wtype = 6, mod = 9, price = 250},
		{name = "Solidus", wtype = 6, mod = 10, price = 250},
		{name = "Iceshield", wtype = 6, mod = 11, price = 250},
		{name = "Loops", wtype = 6, mod = 12, price = 250},
	},

----Back wheel (Bikes)-----
	backwheel = {
		{name = "Stock", wtype = 6, mod = -1, price = 250},
		{name = "Speedway", wtype = 6, mod = 0, price = 250},
		{name = "Streetspecial", wtype = 6, mod = 1, price = 250},
		{name = "Racer", wtype = 6, mod = 2, price = 250},
		{name = "Trackstar", wtype = 6, mod = 3, price = 250},
		{name = "Overlord", wtype = 6, mod = 4, price = 250},
		{name = "Trident", wtype = 6, mod = 5, price = 250},
		{name = "Triplethreat", wtype = 6, mod = 6, price = 250},
		{name = "Stilleto", wtype = 6, mod = 7, price = 250},
		{name = "Wires", wtype = 6, mod = 8, price = 250},
		{name = "Bobber", wtype = 6, mod = 9, price = 250},
		{name = "Solidus", wtype = 6, mod = 10, price = 250},
		{name = "Iceshield", wtype = 6, mod = 11, price = 250},
		{name = "Loops", wtype = 6, mod = 12, price = 250},
	},

----Sport wheels-----
	sportwheels = {
		{name = "Stock", wtype = 0, mod = -1, price = 250},
		{name = "Inferno", wtype = 0, mod = 0, price = 250},
		{name = "Deepfive", wtype = 0, mod = 1, price = 250},
		{name = "Lozspeed", wtype = 0, mod = 2, price = 250},
		{name = "Diamondcut", wtype = 0, mod = 3, price = 250},
		{name = "Chrono", wtype = 0, mod = 4, price = 250},
		{name = "Feroccirr", wtype = 0, mod = 5, price = 250},
		{name = "Fiftynine", wtype = 0, mod = 6, price = 250},
		{name = "Mercie", wtype = 0, mod = 7, price = 250},
		{name = "Syntheticz", wtype = 0, mod = 8, price = 250},
		{name = "Organictyped", wtype = 0, mod = 9, price = 250},
		{name = "Endov1", wtype = 0, mod = 10, price = 250},
		{name = "Duper7", wtype = 0, mod = 11, price = 250},
		{name = "Uzer", wtype = 0, mod = 12, price = 250},
		{name = "Groundride", wtype = 0, mod = 13, price = 250},
		{name = "Spacer", wtype = 0, mod = 14, price = 250},
		{name = "Venum", wtype = 0, mod = 15, price = 250},
		{name = "Cosmo", wtype = 0, mod = 16, price = 250},
		{name = "Dashvip", wtype = 0, mod = 17, price = 250},
		{name = "Icekid", wtype = 0, mod = 18, price = 250},
		{name = "Ruffeld", wtype = 0, mod = 19, price = 250},
		{name = "Wangenmaster", wtype = 0, mod = 20, price = 250},
		{name = "Superfive", wtype = 0, mod = 21, price = 250},
		{name = "Endov2", wtype = 0, mod = 22, price = 250},
		{name = "Slitsix", wtype = 0, mod = 23, price = 250},
	},
-----Suv wheels------
	suvwheels = {
		{name = "Stock", wtype = 3, mod = -1, price = 250},
		{name = "Vip", wtype = 3, mod = 0, price = 250},
		{name = "Benefactor", wtype = 3, mod = 1, price = 250},
		{name = "Cosmo", wtype = 3, mod = 2, price = 250},
		{name = "Bippu", wtype = 3, mod = 3, price = 250},
		{name = "Royalsix", wtype = 3, mod = 4, price = 250},
		{name = "Fagorme", wtype = 3, mod = 5, price = 250},
		{name = "Deluxe", wtype = 3, mod = 6, price = 250},
		{name = "Icedout", wtype = 3, mod = 7, price = 250},
		{name = "Cognscenti", wtype = 3, mod = 8, price = 250},
		{name = "Lozspeedten", wtype = 3, mod = 9, price = 250},
		{name = "Supernova", wtype = 3, mod = 10, price = 250},
		{name = "Obeyrs", wtype = 3, mod = 11, price = 250},
		{name = "Lozspeedballer", wtype = 3, mod = 12, price = 250},
		{name = "Extra vaganzo", wtype = 3, mod = 13, price = 250},
		{name = "Splitsix", wtype = 3, mod = 14, price = 250},
		{name = "EmpoweVermelho", wtype = 3, mod = 15, price = 250},
		{name = "Sunrise", wtype = 3, mod = 16, price = 250},
		{name = "Dashvip", wtype = 3, mod = 17, price = 250},
		{name = "Cutter", wtype = 3, mod = 18, price = 250},
	},
-----Offroad wheels-----
	offroadwheels = {
		{name = "Stock", wtype = 4, mod = -1, price = 250},
		{name = "Raider", wtype = 4, mod = 0, price = 250},
		{name = "Mudslinger", wtype = 4, modtype = 23, wtype = 4, mod = 1, price = 250},
		{name = "Nevis", wtype = 4, mod = 2, price = 250},
		{name = "Cairngorm", wtype = 4, mod = 3, price = 250},
		{name = "Amazon", wtype = 4, mod = 4, price = 250},
		{name = "Challenger", wtype = 4, mod = 5, price = 250},
		{name = "Dunebasher", wtype = 4, mod = 6, price = 250},
		{name = "Fivestar", wtype = 4, mod = 7, price = 250},
		{name = "Rockcrawler", wtype = 4, mod = 8, price = 250},
		{name = "MilspecMetálicoie", wtype = 4, mod = 9, price = 250},
	},
-----Tuner wheels------
	tunerwheels = {
		{name = "Stock", wtype = 5, mod = -1, price = 250},
		{name = "Cosmo", wtype = 5, mod = 0, price = 250},
		{name = "Supermesh", wtype = 5, mod = 1, price = 250},
		{name = "Outsider", wtype = 5, mod = 2, price = 250},
		{name = "Rollas", wtype = 5, mod = 3, price = 250},
		{name = "Driffmeister", wtype = 5, mod = 4, price = 250},
		{name = "Slicer", wtype = 5, mod = 5, price = 250},
		{name = "Elquatro", wtype = 5, mod = 6, price = 250},
		{name = "Dubbed", wtype = 5, mod = 7, price = 250},
		{name = "Fivestar", wtype = 5, mod = 8, price = 250},
		{name = "Slideways", wtype = 5, mod = 9, price = 250},
		{name = "Apex", wtype = 5, mod = 10, price = 250},
		{name = "Stancedeg", wtype = 5, mod = 11, price = 250},
		{name = "Countersteer", wtype = 5, mod = 12, price = 250},
		{name = "Endov1", wtype = 5, mod = 13, price = 250},
		{name = "Endov2dish", wtype = 5, mod = 14, price = 250},
		{name = "Guppez", wtype = 5, mod = 15, price = 250},
		{name = "Chokadori", wtype = 5, mod = 16, price = 250},
		{name = "Chicane", wtype = 5, mod = 17, price = 250},
		{name = "Saisoku", wtype = 5, mod = 18, price = 250},
		{name = "Dishedeight", wtype = 5, mod = 19, price = 250},
		{name = "Fujiwara", wtype = 5, mod = 20, price = 250},
		{name = "Zokusha", wtype = 5, mod = 21, price = 250},
		{name = "Battlevill", wtype = 5, mod = 22, price = 250},
		{name = "Rallymaster", wtype = 5, mod = 23, price = 250},
	},
-----Highend wheels------
	highendwheels = {
		{name = "Stock", wtype = 7, mod = -1, price = 250},
		{name = "Shadow", wtype = 7, mod = 0, price = 250},
		{name = "Hyper", wtype = 7, mod = 1, price = 250},
		{name = "Blade", wtype = 7, mod = 2, price = 250},
		{name = "Diamond", wtype = 7, mod = 3, price = 250},
		{name = "Supagee", wtype = 7, mod = 4, price = 250},
		{name = "Chromaticz", wtype = 7, mod = 5, price = 250},
		{name = "Merciechlip", wtype = 7, mod = 6, price = 250},
		{name = "Obeyrs", wtype = 7, mod = 7, price = 250},
		{name = "GtCromado", wtype = 7, mod = 8, price = 250},
		{name = "Cheetahr", wtype = 7, mod = 9, price = 250},
		{name = "Solar", wtype = 7, mod = 10, price = 250},
		{name = "Splitten", wtype = 7, mod = 11, price = 250},
		{name = "Dashvip", wtype = 7, mod = 12, price = 250},
		{name = "Lozspeedten", wtype = 7, mod = 13, price = 250},
		{name = "Carboninferno", wtype = 7, mod = 14, price = 250},
		{name = "Carbonshadow", wtype = 7, mod = 15, price = 250},
		{name = "Carbonz", wtype = 7, mod = 16, price = 250},
		{name = "Carbonsolar", wtype = 7, mod = 17, price = 250},
		{name = "Carboncheetahr", wtype = 7, mod = 18, price = 250},
		{name = "Carbonsracer", wtype = 7, mod = 19, price = 250},
	},
-----Lowrider wheels------
	lowriderwheels = {
		{name = "Stock", wtype = 2, mod = -1, price = 250},
		{name = "Flare", wtype = 2, mod = 0, price = 250},
		{name = "WiVermelho", wtype = 2, mod = 1, price = 250},
		{name = "TripleOuros", wtype = 2, mod = 2, price = 250},
		{name = "Bigworm", wtype = 2, mod = 3, price = 250},
		{name = "Sevenfives", wtype = 2, mod = 4, price = 250},
		{name = "Splitsix", wtype = 2, mod = 5, price = 250},
		{name = "Freshmesh", wtype = 2, mod = 6, price = 250},
		{name = "Leadsled", wtype = 2, mod = 7, price = 250},
		{name = "Turbine", wtype = 2, mod = 8, price = 250},
		{name = "Superfin", wtype = 2, mod = 9, price = 250},
		{name = "Classicrod", wtype = 2, mod = 10, price = 250},
		{name = "Dollar", wtype = 2, mod = 11, price = 250},
		{name = "Dukes", wtype = 2, mod = 12, price = 250},
		{name = "Lowfive", wtype = 2, mod = 13, price = 250},
		{name = "Gooch", wtype = 2, mod = 14, price = 250},
	},
-----Muscle wheels-----
	musclewheels = {
		{name = "Stock", wtype = 1, mod = -1, price = 250},
		{name = "Classicfive", wtype = 1, mod = 0, price = 250},
		{name = "Dukes", wtype = 1, mod = 1, price = 250},
		{name = "Musclefreak", wtype = 1, mod = 2, price = 250},
		{name = "Kracka", wtype = 1, mod = 3, price = 250},
		{name = "Azrea", wtype = 1, mod = 4, price = 250},
		{name = "Mecha", wtype = 1, mod = 5, price = 250},
		{name = "Pretotop", wtype = 1, mod = 6, price = 250},
		{name = "Dragspl", wtype = 1, mod = 7, price = 250},
		{name = "Revolver", wtype = 1, mod = 8, price = 250},
		{name = "Classicrod", wtype = 1, mod = 9, price = 250},
		{name = "Spooner", wtype = 1, mod = 10, price = 250},
		{name = "Fivestar", wtype = 1, mod = 11, price = 250},
		{name = "Oldschool", wtype = 1, mod = 12, price = 250},
		{name = "Eljefe", wtype = 1, mod = 13, price = 250},
		{name = "Dodman", wtype = 1, mod = 14, price = 250},
		{name = "Sixgun", wtype = 1, mod = 15, price = 250},
		{name = "Mercenary", wtype = 1, mod = 16, price = 250},
	},
	
---------Trim color--------
	trim = {
		colors = colors,
		price = 250
	},
	
----------Mods-----------
	mods = {
	
----------Liveries--------
	[48] = {
		startprice = 3000,
		increaseby = 1000
	},
	
----------Windows--------
	[46] = {
		startprice = 1000,
		increaseby = 500
	},
	
----------Tank--------
	[45] = {
		startprice = 1000,
		increaseby = 500
	},
	
----------Trim--------
	[44] = {
		startprice = 1000,
		increaseby = 500
	},
	
----------Aerials--------
	[43] = {
		startprice = 1000,
		increaseby = 500
	},

----------Arch cover--------
	[42] = {
		startprice = 2000,
		increaseby = 500
	},

----------Struts--------
	[41] = {
		startprice = 2000,
		increaseby = 500
	},
	
----------Air filter--------
	[40] = {
		startprice = 2000,
		increaseby = 500
	},
	
----------Engine block--------
	[39] = {
		startprice = 2000,
		increaseby = 500
	},

----------Hydraulics--------
	[38] = {
		startprice = 5000,
		increaseby = 500
	},
	
----------Trunk--------
	[37] = {
		startprice = 5000,
		increaseby = 500
	},

----------Speakers--------
	[36] = {
		startprice = 2000,
		increaseby = 500
	},

----------Plaques--------
	[35] = {
		startprice = 2000,
		increaseby = 500
	},
	
----------Shift leavers--------
	[34] = {
		startprice = 2000,
		increaseby = 500
	},
	
----------Steeringwheel--------
	[33] = {
		startprice = 2000,
		increaseby = 500
	},
	
----------Seats--------
	[32] = {
		startprice = 2000,
		increaseby = 500
	},
	
----------Door speaker--------
	[31] = {
		startprice = 2000,
		increaseby = 500
	},

----------Dial--------
	[30] = {
		startprice = 2000,
		increaseby = 500
	},
----------Dashboard--------
	[29] = {
		startprice = 2000,
		increaseby = 500
	},
	
----------Ornaments--------
	[28] = {
		startprice = 2000,
		increaseby = 500
	},
	
----------Trim--------
	[27] = {
		startprice = 2000,
		increaseby = 500
	},
	
----------Vanity plates--------
	[26] = {
		startprice = 2000,
		increaseby = 500
	},
	
----------Plate holder--------
	[25] = {
		startprice = 2000,
		increaseby = 500
	},
	
---------HeadLeves---------
	[22] = {
		{name = "Stock Leves", mod = 0, price = 0},
		{name = "Xenon Leves", mod = 1, price = 250},
	},
	
----------Turbo---------
	[18] = {
		--{ name = "None", mod = 0, price = 0},
		--{ name = "Turbo Tuning", mod = 1, price = 10000},
	},
	
-----------Armor-------------
	-- [16] = {
	-- 	{name = "Armor Upgrade 20%",modtype = 16, mod = 0, price = 10000},
	-- 	{name = "Armor Upgrade 40%",modtype = 16, mod = 1, price = 250000},
	-- 	{name = "Armor Upgrade 60%",modtype = 16, mod = 2, price = 500000},
	-- 	{name = "Armor Upgrade 80%",modtype = 16, mod = 3, price = 750000},
	-- 	{name = "Armor Upgrade 100%",modtype = 16, mod = 4, price = 1000000},
	-- },

---------Suspension-----------
	[15] = {
		--{name = "LoweVermelho Suspension",mod = 0, price = 250},
		--{name = "Street Suspension",mod = 1, price = 1000},
		--{name = "Sport Suspension",mod = 2, price = 2000},
		--{name = "Competition Suspension",mod = 3, price = 3000},
	},

-----------Horn----------
	[14] = {
		{name = "Truck Horn", mod = 0, price = 250},
		{name = "Police Horn", mod = 1, price = 250},
		{name = "Clown Horn", mod = 2, price = 250},
		{name = "Musical Horn 1", mod = 3, price = 250},
		{name = "Musical Horn 2", mod = 4, price = 250},
		{name = "Musical Horn 3", mod = 5, price = 250},
		{name = "Musical Horn 4", mod = 6, price = 250},
		{name = "Musical Horn 5", mod = 7, price = 250},
		{name = "Sadtrombone Horn", mod = 8, price = 250},
		{name = "Calssical Horn 1", mod = 9, price = 250},
		{name = "Calssical Horn 2", mod = 10, price = 250},
		{name = "Calssical Horn 3", mod = 11, price = 250},
		{name = "Calssical Horn 4", mod = 12, price = 250},
		{name = "Calssical Horn 5", mod = 13, price = 250},
		{name = "Calssical Horn 6", mod = 14, price = 250},
		{name = "Calssical Horn 7", mod = 15, price = 250},
		{name = "Scaledo Horn", mod = 16, price = 250},
		{name = "Scalere Horn", mod = 17, price = 250},
		{name = "Scalemi Horn", mod = 18, price = 250},
		{name = "Scalefa Horn", mod = 19, price = 250},
		{name = "Scalesol Horn", mod = 20, price = 250},
		{name = "Scalela Horn", mod = 21, price = 250},
		{name = "Scaleti Horn", mod = 22, price = 250},
		{name = "Scaledo Horn High", mod = 23, price = 250},
		{name = "Jazz Horn 1", mod = 25, price = 250},
		{name = "Jazz Horn 2", mod = 26, price = 250},
		{name = "Jazz Horn 3", mod = 27, price = 250},
		{name = "Jazzloop Horn", mod = 28, price = 250},
		{name = "Starspangban Horn 1", mod = 29, price = 250},
		{name = "Starspangban Horn 2", mod = 30, price = 250},
		{name = "Starspangban Horn 3", mod = 31, price = 250},
		{name = "Starspangban Horn 4", mod = 32, price = 250},
		{name = "Classicalloop Horn 1", mod = 33, price = 250},
		{name = "Classicalloop Horn 2", mod = 34, price = 250},
		{name = "Classicalloop Horn 3", mod = 35, price = 250},
	},

----------Transmission---------
	[13] = {
		--{name = "Street Transmission", mod = 0, price = 5000},
		--{name = "Sports Transmission", mod = 1, price = 10000},
		--{name = "Race Transmission", mod = 2, price = 15000},
	},
	
-----------Brakes-------------
	[12] = {
		--{name = "Street Brakes", mod = 0, price = 5000},
		--{name = "Sport Brakes", mod = 1, price = 10000},
		--{name = "Race Brakes", mod = 2, price = 15000},
	},
	
------------Engine----------
	[11] = {
		--{name = "EMS Upgrade, Level 2", mod = 0, price = 15000},
		--{name = "EMS Upgrade, Level 3", mod = 1, price = 30000},
		--{name = "EMS Upgrade, Level 4", mod = 2, price = 45000},
	},
	
-------------Roof----------
	[10] = {
		--startprice = 250,
		--increaseby = 250
	},
	
------------Fenders---------
	[8] = {
		startprice = 250,
		increaseby = 250
	},
	
------------Hood----------
	[7] = {
		--startprice = 250,
		--increaseby = 250
	},
	
----------Grille----------
	[6] = {
		startprice = 250,
		increaseby = 250
	},
	
----------Roll cage----------
	[5] = {
		startprice = 250,
		increaseby = 250
	},
	
----------Exhaust----------
	[4] = {
		startprice = 250,
		increaseby = 250
	},
	
----------Skirts----------
	[3] = {
		startprice = 250,
		increaseby = 250
	},
	
-----------Rear bumpers----------
	[2] = {
		startprice = 250,
		increaseby = 250
	},
	
----------Front bumpers----------
	[1] = {
		startprice = 250,
		increaseby = 250
	},
	
----------Spoiler----------
	[0] = {
		startprice = 250,
		increaseby = 250
	},
	}
	
}

------Model Pretolist--------
--Does'nt allow specific vehicles to be upgraded
LSC_Config.ModelPretolist = {
	"police",
}

--Sets if garage will be locked if someone is inside it already
LSC_Config.lock = false

--Enable/disable old entering way
LSC_Config.oldenter = false

--Menu settings
LSC_Config.menu = {

-------Controls--------
	controls = {
		menu_up = 27,
		menu_down = 173,
		menu_left = 174,
		menu_right = 175,
		menu_select = 201,
		menu_back = 177
	},

	
-------Menu position-----
	--Possible positions:
	--Left
	--Right
	--Custom position, example: position = {x = 0.2, y = 0.2}
	position = "left",

-------Menu theme--------
	--Possible themes: Leve, EscuroVermelho, bluish, Verdeish
	--Custom example:
	--[[theme = {
		text_color = { r = 255,g = 255, b = 255, a = 255},
		bg_color = { r = 0,g = 0, b = 0, a = 155},
		--Colors when button is selected
		stext_color = { r = 0,g = 0, b = 0, a = 255},
		sbg_color = { r = 255,g = 255, b = 0, a = 200},
	},]]
	theme = "light",
	
--------Max buttons------
	--Default: 10
	maxbuttons = 10,

-------Size---------
	--[[
	Default:
	width = 0.24
	height = 0.36
	]]
	width = 0.24,
	height = 0.36

}


-- Citizen.CreateThread(function()
-- 	while true do
--       if ( LSC_Config.menu ) then
--             local veh = GetVehiclePedIsIn( -1, false )	
--             DisableControlAction( 0, 80, true ) -- Cinematic View	
--         end  
--         Citizen.Wait(0)
--     end
-- end)
