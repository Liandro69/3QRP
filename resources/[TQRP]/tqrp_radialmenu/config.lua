-- Menu configuration, array of menus to display
menuConfigs = {
    ['menu'] = {
        enableMenu = function()
            local player = PlayerPedId()
            if  GetPedInVehicleSeat(GetVehiclePedIsIn(player), -1) == player then
                return false
            else
                return true
            end
        end,
        data = {
            keybind = "Z",
            style = {
                sizePx = 800,
                slices = {
                    default = { ['fill'] = 'rgb(0, 0, 0)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.50 },
                    hover = { ['fill'] = 'rgb(255, 50, 50)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.60, },
                    selected = { ['fill'] = 'rgb(255, 50, 50)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.40 }
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
                    minRadiusPercent = 0.20,
                    maxRadiusPercent = 0.55,
                    labels = {"imgsrc:more.png", "imgsrc:anim.png", "imgsrc:anim2.png", "imgsrc:anim3.png", "imgsrc:docs.png", "imgsrc:locked.png"},
                    commands = {"submenu1", "submenu2", "submenu3", "submenu4", "submenu5", "submenu6"}
                }
            }
        }
    },
	['vehicles'] = {                                -- Example menu for vehicle controls when player is in a vehicle
        enableMenu = function()                     -- Function to enable/disable menu handling
            local player = PlayerPedId()
            return GetPedInVehicleSeat(GetVehiclePedIsIn(player), -1) == player
            
        end,
        data = {                                    -- Data that is passed to Javascript
            keybind = "Z",                         -- Wheel keybind to use (case sensitive, must match entry in keybindControls table)
            style = {                               -- Wheel style settings
                sizePx = 400,                       -- Wheel size in pixels
                slices = {                          -- Slice style settings
                    default = { ['fill'] = 'rgb(0, 0, 0)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.50 },
                    hover = { ['fill'] = 'rgb(255, 50, 50)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.80 },
                    selected = { ['fill'] = 'rgb(255, 50, 50)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.80 }
                },
                titles = {                          -- Text style settings
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {                              -- Array of wheels to display
				{
                    navAngle = 0,
                    minRadiusPercent = 0.0,
                    maxRadiusPercent = 0.0,
                    labels = {"imgsrc:logout.png"},
                    commands = {"e stop"}
                },
                {
                    navAngle = 270,                 -- Oritentation of wheel
                    minRadiusPercent = 0.4,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.9,         -- Maximum radius of wheel in percentage
                    labels = {"imgsrc:engine.png", "imgsrc:key.png", "imgsrc:save.png", "imgsrc:portas.png", "imgsrc:windows.png"},
                    commands = {"engine", "lock", "save", "portas", "windows"}
                }
            }
        }
    }
}

-- Submenu configuration
subMenuConfigs = {
    ['submenu1'] = {
        data = {
            keybind = "Z",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = 'rgb(0, 0, 0)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.50 },
                    hover = { ['fill'] = 'rgb(255, 50, 50)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.80},
                    selected = { ['fill'] = 'rgb(255, 50, 50)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.80 }
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
                    labels = {"imgsrc:more.png", "imgsrc:anim.png", "imgsrc:anim2.png", "imgsrc:anim3.png", "imgsrc:docs.png", "imgsrc:locked.png"},
                    commands = {"submenu1", "submenu2", "submenu3", "submenu4", "submenu5", "submenu6"}
                },
                {
                    navAngle = 190,
                    minRadiusPercent = 0.6,
                    maxRadiusPercent = 0.9,
                    labels = {"imgsrc:drag.png", "imgsrc:carry.png","imgsrc:search.png", "imgsrc:outveh.png", "imgsrc:inveh.png", "imgsrc:putouttrunk.png", "imgsrc:putintrunk.png", "imgsrc:entertrunk.png", "imgsrc:leavetrunk.png"},
                    commands = {"drag", "pegar", "steal", "outveh", "inveh", "retirarmala", "colocarmala", "entrarmala", "sairmala"}
                }
            }
        }
    },
    ['submenu2'] = {
        data = {
            keybind = "Z",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = 'rgb(0, 0, 0)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.50 },
                    hover = { ['fill'] = 'rgb(255, 50, 50)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.80 },
                    selected = { ['fill'] = 'rgb(255, 50, 50)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.80 }
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
                    labels = {"imgsrc:more.png", "imgsrc:anim.png", "imgsrc:anim2.png", "imgsrc:anim3.png", "imgsrc:docs.png", "imgsrc:locked.png"},
                    commands = {"submenu1", "submenu2", "submenu3", "submenu4", "submenu5", "submenu6"}
                },
                {
                    navAngle = 288,
                    minRadiusPercent = 0.6,
                    maxRadiusPercent = 0.9,
                    labels = {"ATÃOOOO", "DISCUTIR", "ASSOBIAR", "MIJAR", "CRUZ BRAÇ", "CELEBRAR", "ALONGAR", "CHAPADA", "MÃO COLDRE", "DEDO DO MEIO", "DESMAIADO", "OMG", "ASSOBIAR", "LAPDANCE", "AVIÃO", "DESALGEMAR"},
                    commands = {"e atao","e discutir2", "e assobiar", "e mijar", "e bracos", "e celebrar", "e alongar", "e estalo", "e coldre", "e dedo", "e desmaiar", "e facepalm", "e assobiar", "e lapdance2", "e aviao", "e desalgemar"}
                }
            }
        }
    },
    ['submenu3'] = {
        data = {
            keybind = "Z",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = 'rgb(0, 0, 0)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.50 },
                    hover = { ['fill'] = 'rgb(255, 50, 50)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.80 },
                    selected = { ['fill'] = 'rgb(255, 50, 50)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.80 }
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
                    labels = {"imgsrc:more.png", "imgsrc:anim.png", "imgsrc:anim2.png", "imgsrc:anim3.png", "imgsrc:docs.png", "imgsrc:locked.png"},
                    commands = {"submenu1", "submenu2", "submenu3", "submenu4", "submenu5", "submenu6"}
                },
                {
                    navAngle = 288,
                    minRadiusPercent = 0.6,
                    maxRadiusPercent = 0.9,
                    labels = {"BLOCO NOTAS ", "FUMAR ", "CAIXA", "ROSA", "MOCHILA", "MALA", "COGNAC", "CHARUTO", "CLIPBOARD", "BONGADA", "MAPA", "MAKEIT RAIN", "CHAMADA", "LIMPAR"},
                    commands = {"e notas", "e fumar2", "e caixa", "e rosa", "e mochila", "e mala", "e whiskey", "e charuto2", "e notas3", "e bongo", "e mapa", "e makeitrain", "e chamada", "e limpar2"}
                }
            }
        }
    },
    ['submenu4'] = {
        data = {
            keybind = "Z",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = 'rgb(0, 0, 0)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.50 },
                    hover = { ['fill'] = 'rgb(255, 50, 50)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.80 },
                    selected = { ['fill'] = 'rgb(255, 50, 50)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.80 }
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
                    labels = {"imgsrc:more.png", "imgsrc:anim.png", "imgsrc:anim2.png", "imgsrc:anim3.png", "imgsrc:docs.png", "imgsrc:locked.png"},
                    commands = {"submenu1", "submenu2", "submenu3", "submenu4", "submenu5", "submenu6"}
                },
                {
                    navAngle = 288,
                    minRadiusPercent = 0.6,
                    maxRadiusPercent = 0.9,
                    labels = {"APERTO MÃO ", "ABRAÇO", "BRO", "SOCO", "CABEÇADA", "CHAPADA", "LEVAR CABEÇ", "LEVAR SOCO", "BASEBALL", "DAR", "BRO 2"},
                    commands = {"nearby aperto", "nearby abraco ", "nearby bro", "nearby soco", "nearby cabecada", "nearby estalo2", "nearby levarcabeacda", "nearby levarsoco", "nearby baseball", "nearby dar2", "nearby bro2"}
                }
            }
        }
    },
    ['submenu5'] = {
        data = {
            keybind = "Z",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = 'rgb(0, 0, 0)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.50 },
                    hover = { ['fill'] = 'rgb(255, 50, 50)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.80 },
                    selected = { ['fill'] = 'rgb(255, 50, 50)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.80 }
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
                    labels = {"imgsrc:more.png", "imgsrc:anim.png", "imgsrc:anim2.png", "imgsrc:anim3.png", "imgsrc:docs.png", "imgsrc:locked.png"},
                    commands = {"submenu1", "submenu2", "submenu3", "submenu4", "submenu5", "submenu6"}
                },
                {
                    navAngle = 288,
                    minRadiusPercent = 0.6,
                    maxRadiusPercent = 0.9,
                    labels = {"PÚBLICOS", "LABORAIS", "GUARDADOS"},
                    commands = {"docpublicos", "doclaborais", "docguardados"}
                }
            }
        }
    },
	['submenu6'] = {
        data = {
            keybind = "Z",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = 'rgb(0, 0, 0)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.50 },
                    hover = { ['fill'] = 'rgb(255, 50, 50)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.80 },
                    selected = { ['fill'] = 'rgb(255, 50, 50)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.80 }
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
                    labels = {"imgsrc:more.png", "imgsrc:anim.png", "imgsrc:anim2.png", "imgsrc:anim3.png", "imgsrc:docs.png", "imgsrc:locked.png"},
                    commands = {"submenu1", "submenu2", "submenu3", "submenu4", "submenu5", "submenu6"}
                },
                {
                    navAngle = 288,
                    minRadiusPercent = 0.6,
                    maxRadiusPercent = 0.9,
                    labels = {"imgsrc:idcard.png", "imgsrc:idcar.png", "imgsrc:idgun.png", "imgsrc:job.png", "imgsrc:money.png","imgsrc:craft.png"},
                    commands = {"minimenu1", "minimenu2", "minimenu3", "minimenu4", "seemoney", "craftmenu"}
                }
            }
        }
    },
}
miniMenuConfigs = {
    ['minimenu1'] = {
        data = {
            keybind = "Z",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = 'rgb(0, 0, 0)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.50 },
                    hover = { ['fill'] = 'rgb(255, 50, 50)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.80 },
                    selected = { ['fill'] = 'rgb(255, 50, 50)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.80 }
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
                    labels = {"imgsrc:idcard.png", "imgsrc:idcar.png", "imgsrc:idgun.png", "imgsrc:job.png"},
                    commands = {"minimenu1", "minimenu2", "minimenu3", "minimenu4"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.6,
                    maxRadiusPercent = 0.9,
                    labels = {"imgsrc:see.png", "imgsrc:give.png"},
                    commands = {"seeidcard", "showidcard"}
                }
            }
        }
    },
	['minimenu2'] = {
        data = {
            keybind = "Z",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = 'rgb(0, 0, 0)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.50 },
                    hover = { ['fill'] = 'rgb(255, 50, 50)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.80 },
                    selected = { ['fill'] = 'rgb(255, 50, 50)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.80 }
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
                    labels = {"imgsrc:idcard.png", "imgsrc:idcar.png", "imgsrc:idgun.png", "imgsrc:job.png"},
                    commands = {"minimenu1", "minimenu2", "minimenu3", "minimenu4"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.6,
                    maxRadiusPercent = 0.9,
                    labels = {"imgsrc:see.png", "imgsrc:give.png"},
                    commands = {"seedriver", "showdriver"}
                }
            }
        }
    },
	['minimenu3'] = {
        data = {
            keybind = "Z",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = 'rgb(0, 0, 0)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.50 },
                    hover = { ['fill'] = 'rgb(255, 50, 50)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.80 },
                    selected = { ['fill'] = 'rgb(255, 50, 50)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.80 }
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
                    labels = {"imgsrc:idcard.png", "imgsrc:idcar.png", "imgsrc:idgun.png", "imgsrc:job.png"},
                    commands = {"minimenu1", "minimenu2", "minimenu3", "minimenu4"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.6,
                    maxRadiusPercent = 0.9,
                    labels = {"imgsrc:see.png", "imgsrc:give.png"},
                    commands = {"seegun", "showgun"}
                }
            }
        }
    },
	['minimenu4'] = {
        data = {
            keybind = "Z",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = 'rgb(0, 0, 0)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.50 },
                    hover = { ['fill'] = 'rgb(255, 50, 50)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.80 },
                    selected = { ['fill'] = 'rgb(255, 50, 50)', ['stroke'] = 'rgb(0, 0, 0)', ['stroke-width'] = 1, ['opacity'] = 0.80 }
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
                    labels = {"imgsrc:idcard.png", "imgsrc:idcar.png", "imgsrc:idgun.png", "imgsrc:job.png"},
                    commands = {"minimenu1", "minimenu2", "minimenu3", "minimenu4"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.6,
                    maxRadiusPercent = 0.9,
                    labels = {"imgsrc:see.png", "imgsrc:give.png"},
                    commands = {"seejob", "showjob"}
                }
            }
        }
    }
}