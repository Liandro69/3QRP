Config = {
    Price = 2000,
    ReviveTime = 300, -- seconds until you are revived
    Hospitals = {
        {
            Bed = {coords = vector3(807.51, -495.7, 30.75), heading = 280.0, occupied = false},
            Peds = {
                pedHash = 1097048408,--436345731,
                reception = {coords = vector3(812.35, -495.16, 29.69), heading = 24.66},
                doctor = {coords = vector3(807.77, -496.72, 29.69), heading = 11.11},
            },
        },
    },
}

Strings = {
    ['get_help'] = [[ %s Precisas de ajuda? Paga ~g~$%s ~w~e falamos.]],
    ['not_enough'] = [[Não tens dinheiro!]],
    ['getting_help'] = [[Estás a receber ajuda, %s segundos restantes!]],
    ['occupied'] = [[A cama está ocupada!]]
}