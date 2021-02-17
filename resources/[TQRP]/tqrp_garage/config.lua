Config = {}

Config.VehicleMenu = true -- enable this if you wan't a vehicle menu.
Config.VehicleMenuButton = 344 -- change this to the key you want to open the menu with. buttons: https://docs.fivem.net/game-references/controls/
Config.RangeCheck = 25.0 -- this is the change you will be able to control the vehicle.

Config.Garages = {
    ["A"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(215.92279052734,-809.75280761719,30.730318069458),
                ["text"] = "[ ~o~E~s~ ] Garage",
            },
            ["vehicle"] = {
                ["position"] = vector3(229.96076965332,-798.373046875,30.470), 
                ["heading"] = 157.0,
                ["text"] = "[ ~o~E~s~ ] Store Vehicle",
            }
        },
        ["camera"] = {  -- camera is not needed just if you want cool effects.
            ["x"] = 227.534, 
            ["y"] = -791.370, 
            ["z"] = 33.560, 
            ["rotationX"] = -31.401574149728, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = -160.40157422423 
        }
    },

    ["B"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(273.67422485352, -344.15573120117, 44.919834136963),
                ["text"] = "[ ~o~E~s~ ] Garage",
            },
            ["vehicle"] = {
                ["position"] = vector3(272.50082397461, -337.40579223633, 44.919834136963), 
                ["heading"] = 160.0,
                ["text"] = "[ ~o~E~s~ ] Store Vehicle",
            }
        },
        ["camera"] = { 
            ["x"] = 283.28225708008, 
            ["y"] = -333.24017333984, 
            ["z"] = 50.004745483398, 
            ["rotationX"] = -21.637795701623, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 125.73228356242 
        }
    },

    ["C"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(387.37, -1680.91, 32.53),
                ["text"] = "[ ~o~E~s~ ] Garage",
            },
            ["vehicle"] = {
                ["position"] = vector3(383.91, -1679.75, 32.12), 
                ["heading"] = 317.83,
                ["text"] = "[ ~o~E~s~ ] Store Vehicle",
            }
        },
        ["camera"] = { 
            ["x"] = 385.33, 
            ["y"] = -1672.42, 
            ["z"] = 34.69, 
            ["rotationX"] = -26.27, 
            ["rotationY"] = 0.05, 
            ["rotationZ"] = 169.7 
        }
    },

    ["D"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(-1220.35, -640.08, 25.87),
                ["text"] = "[ ~o~E~s~ ] Garage",
            },
            ["vehicle"] = {
                ["position"] = vector3(-1219.39, -642.0, 25.55), 
                ["heading"] = 130.0,
                ["text"] = "[ ~o~E~s~ ] Store Vehicle",
            }
        },
        ["camera"] = { 
            ["x"] = -1225.2, 
            ["y"] = -646.66, 
            ["z"] = 28.01, 
            ["rotationX"] = -20.23, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = -51.110235854983 
        }
    },

    ["E"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(1738.005, 3711.975, 34.133),
                ["text"] = "[ ~o~E~s~ ] Garage",
            },
            ["vehicle"] = {
                ["position"] = vector3(1724.141, 3714.975, 34.177), 
                ["heading"] = 20.0,
                ["text"] = "[ ~o~E~s~ ] Store Vehicle",
            }
        },
        ["camera"] = { 
            ["x"] = 1728.876, 
            ["y"] = 3721.503, 
            ["z"] = 37.064, 
            ["rotationX"] = -30.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = -220.110235854983 
        }
    },

    ["F"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(125.202, 6644.688, 31.784),
                ["text"] = "[ ~o~E~s~ ] Garage",
            },
            ["vehicle"] = {
                ["position"] = vector3(117.742, 6652.241, 30.776), 
                ["heading"] = 134.0,
                ["text"] = "[ ~o~E~s~ ] Store Vehicle",
            }
        },
        ["camera"] = { 
            ["x"] = 117.909, 
            ["y"] = 6647.187, 
            ["z"] = 31.588, 
            ["rotationX"] = -0.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = -0.110235854983 
        }
    },

    ["Mission Row"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(441.99, -1014.0, 28.75),
                ["text"] = "[ ~o~E~s~ ] Garage",
            },
            ["vehicle"] = {
                ["position"] = vector3(434.01, -1017.08, 28.75), 
                ["heading"] = 90.0,
                ["text"] = "[ ~o~E~s~ ] Store Vehicle",
            }
        },
        ["camera"] = { 
            ["x"] = 428.37,
            ["y"] = -1012.33, 
            ["z"] = 33.31, 
            ["rotationX"] = -40.55,
            ["rotationY"] = 0.0, 
            ["rotationZ"] = -121.38
        }
    },
    

 --[[   ["MC"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(953.53881835938,-122.51171112061,74.353179931641),
                ["text"] = "[ ~o~E~s~ ] Garage",
            },
            ["vehicle"] = {
                ["position"] = vector3(956.79351806641,-128.50393676758,74.065739440918), 
                ["heading"] = 218.956,
                ["text"] = "[ ~o~E~s~ ] Store Vehicle",
            }
        },
        ["camera"] = { 
            ["x"] = 958.711, 
            ["y"] = -139.062, 
            ["z"] = 77.630, 
            ["rotationX"] = -0.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = -0.110235854983 
        }
    }, ]]

    ["Boat"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(-734.872, -1325.817, 1.595),
                ["text"] = "[ ~o~E~s~ ] Garage",
            },
            ["vehicle"] = {
                ["position"] = vector3(-721.329, -1348.540, 0.970), 
                ["heading"] = 137.780,
                ["text"] = "[ ~o~E~s~ ] Store Vehicle",
            }
        },
        ["camera"] = { 
            ["x"] = -709.066, 
            ["y"] = -1348.404, 
            ["z"] = 5.970, 
            ["rotationX"] = -29.637795701623, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 100.73228356242 
        }
    },

    ["Aircraft"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(-1237.556, -3384.547, 13.940),
                ["text"] = "[ ~o~E~s~ ] Garage",
            },
            ["vehicle"] = {
                ["position"] = vector3(-1275.560, -3388.017, 14.240), 
                ["heading"] = 328.940,
                ["text"] = "[ ~o~E~s~ ] Store Vehicle",
            }
        },
        ["camera"] = { 
            ["x"] = -1301.229, 
            ["y"] = -3385.397, 
            ["z"] = 24.265, 
            ["rotationX"] = -21.637795701623, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = -87.73228356242 
        }
    },

    ["Truck"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(913.513, -1273.216, 27.092),
                ["text"] = "[ ~o~E~s~ ] Garage",
            },
            ["vehicle"] = {
                ["position"] = vector3(912.942, -1259.862, 25.731), 
                ["heading"] = 5.744,
                ["text"] = "[ ~o~E~s~ ] Store Vehicle",
            }
        },
        ["camera"] = { 
            ["x"] = 901.102, 
            ["y"] = -1256.479, 
            ["z"] = 31.271, 
            ["rotationX"] = -21.637795701623, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = -120.73228356242 
        }
    },

    ["Apreendidos"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(409.12, -1623.01, 29.29),
                ["text"] = "[ ~o~E~s~ ] Apreendidos",
            },
            ["vehicle"] = {
                ["position"] = vector3(401.85, -1631.22, 29.29), 
                ["heading"] = 140.86,
            }
        },
        ["camera"] = { 
            ["x"] = 394.52,
            ["y"] = -1632.53, 
            ["z"] = 35.77, 
            ["rotationX"] = -45.88, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = -92.82 
        }
    }
}


Config.Trim = function(value)
	if value then
		return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
	else
		return nil
	end
end

Config.AlignMenu = "right" -- this is where the menu is located [left, right, center, top-right, top-left etc.]