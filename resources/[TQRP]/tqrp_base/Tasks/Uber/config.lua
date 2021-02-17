
-- EDITED BY B1G --]]

Knock = '~w~[~g~K~w~] Bater à porta'
Delivery = '~w~[~g~K~w~] Deixar pacote'

DeliveryLocations = {  --- Coords [x] = Door Coords [x2] = package drop location if need be
    [1] = {["x"] = 8.91, ["y"] = -242.82, ["z"] = 51.86, ["x2"] = 9.99, ["y2"] = -243.67, ["z2"] = 51.86, ["isHome"] = math.random(1,2)},
    [2] = {["x"] = 113.74, ["y"] = -277.95, ["z"] = 54.51, ["x2"] = 112.59, ["y2"] = -278.71, ["z2"] = 54.51, ["isHome"] = math.random(1,2)},
    [3] = {["x"] = 201.56, ["y"] = -148.76, ["z"] = 61.47, ["x2"] = 201.55, ["y2"] = -150.31, ["z2"] = 60.48, ["isHome"] = math.random(1,2)},
    [4] = {["x"] = -206.84, ["y"] = 159.49, ["z"] = 74.08, ["x2"] = -208.98, ["y2"] = 161.16, ["z2"] = 73.19, ["isHome"] = math.random(1,2)},
    [5] = {["x"] = 38.83, ["y"] = -71.64, ["z"] = 63.83, ["x2"] = 38.75, ["y2"] = -70.58, ["z2"] = 63.16, ["isHome"] = math.random(1,2)},
    [6] = {["x"] = 47.84, ["y"] = -29.16, ["z"] = 73.71, ["x2"] = 47.76, ["y2"] = -28.01, ["z2"] = 73.24, ["isHome"] = math.random(1,2)},
    [7] = {["x"] = -264.41, ["y"] = 98.82, ["z"] = 69.27, ["x2"] = -263.97, ["y2"] = 97.78, ["z2"] = 68.85, ["isHome"] = math.random(1,2)},
    [8] = {["x"] = -419.34, ["y"] = 221.12, ["z"] = 83.6, ["x2"] = -418.33, ["y2"] = 221.3, ["z2"] = 83.13, ["isHome"] = math.random(1,2)},
    [9] = {["x"] = -998.43, ["y"] = 158.42, ["z"] = 62.31, ["x2"] = -998.7, ["y2"] = 157.24, ["z2"] = 61.65, ["isHome"] = math.random(1,2)},
    [10] = {["x"] = -1026.57, ["y"] = 360.64, ["z"] = 71.36, ["x2"] = -1026.37, ["y2"] = 359.52, ["z2"] = 70.83, ["isHome"] = math.random(1,2)},
    [11] = {["x"] = -967.06, ["y"] = 510.76, ["z"] = 82.07, ["x2"] = -968.07, ["y2"] = 510.76, ["z2"] = 81.31, ["isHome"] = math.random(1,2)},
    [12] = {["x"] = -1009.64, ["y"] = 478.93, ["z"] = 79.41, ["x2"] = -1008.37, ["y2"] = 478.9, ["z2"] = 78.79, ["isHome"] = math.random(1,2)},
    [13] = {["x"] = -1308.05, ["y"] = 448.59, ["z"] = 100.86, ["x2"] = -1309.12, ["y2"] = 449.41, ["z2"] = 100.57, ["isHome"] = math.random(1,2)},
    [14] = {["x"] = 557.39, ["y"] = -1759.57, ["z"] = 29.31, ["x2"] = 557.52, ["y2"] = -1760.54, ["z2"] = 28.89, ["isHome"] = math.random(1,2)},
}

List = {
    [1] =   {Name = "blueberry_fruit",         Label = "Mirtilo",               Max = 5, Payout = math.random(12,20)},
    [2] =   {Name = "blueberry_package",       Label = "Caixa-Mirtilo",         Max = 5, Payout = math.random(30,45)},
    [3] =   {Name = "bread",                   Label = "Pão",                   Max = 20, Payout = math.random(5,15)},
    [4] =   {Name = "cigarett",                Label = "Cigarros",              Max = 20, Payout = math.random(5,15)},
    [5] =   {Name = "fish",                    Label = "Peixe",                 Max = 20, Payout = math.random(10,20)},
    [6] =   {Name = "screw",                   Label = "Parafusos",             Max = 20, Payout = math.random(5,15)},
    [7] =   {Name = "screwdriver",             Label = "Chave de Fendas",       Max = 5, Payout = math.random(100,150)},
    [8] =   {Name = "shell_a",                 Label = "Concha de Ostra",       Max = 10, Payout = math.random(50,75)},
    [9] =   {Name = "silver_piece",            Label = "Pepita de Prata",       Max = 10, Payout = math.random(30,80)},
    [10] =  {Name = "slaughtered_chicken",     Label = "Filetes de Frango",     Max = 20, Payout = math.random(50,125)},
    [11] =  {Name = "slaughtered_pig",         Label = "Filetes de Porco",      Max = 20, Payout = math.random(50,125)},
    [12] =  {Name = "tomato_fruit",            Label = "Tomates",               Max = 20, Payout = math.random(30,80)}
}