local labels = {
  ['en'] = {
    ['Entry']       = "Entrar",
    ['Exit']        = "Sair",
    ['Garage']      = "Garagem",
    ['Wardrobe']    = "Roupeiro",
    ['Inventory']   = "Armário",
    ['InventoryLocation']   = "Inventário",


    ['LeavingHouse']      = "Sair casa",

    ['AccessHouseMenu']   = "Acede ao menu da casa",

    ['InteractDrawText']  = "["..Config.TextColors[Config.MarkerSelection].."E~s~] ",
    ['InteractHelpText']  = "~INPUT_PICKUP~ ",

    ['AcceptDrawText']    = "["..Config.TextColors[Config.MarkerSelection].."G~s~] ",
    ['AcceptHelpText']    = "~INPUT_DETONATE~ ",

    ['FurniDrawText']     = "["..Config.TextColors[Config.MarkerSelection].."F~s~] ",
    ['CancelDrawText']    = "["..Config.TextColors[Config.MarkerSelection].."F~s~] ",

    ['VehicleStored']     = "Carro Guardado",
    ['CantStoreVehicle']  = "Não consegues guardar o carro",

    ['HouseNotOwned']     = "Esta casa não é tua",
    ['InvitedInside']     = "Aceitar convite",
    ['MovedTooFar']       = "Estás muito longe da porta",
    ['KnockAtDoor']       = "Alguém está a bater à porta",

    ['TrackMessage']      = "Track message",

    ['Unlocked']          = "Casa destrancada",
    ['Locked']            = "Casa trancada",

    ['WardrobeSet']       = "Colocar roupeiro",
    ['InventorySet']      = "Colocar armário",

    ['ToggleFurni']       = "Toggle furniture UI",

    ['GivingKeys']        = "Dar chaves",
    ['TakingKeys']        = "Recebeste chaves",

    ['GarageSet']         = "Colocar local de garagem",
    ['GarageTooFar']      = "Garagem está muito longe",

    ['PurchasedHouse']    = "Compraste a casa por $%d",
    ['SolddHouse']        = "Vendeste a casa por $%d",
    
    ['CantAffordHouse']   = "Não consegues comprar esta casa",

    ['MortgagedHouse']    = "Hipotecaste a casa por $%d",

    ['NoLockpick']        = "Não tens uma gazua",
    ['LockpickFailed']    = "Falhaste ao arrombar fechadura",
    ['LockpickSuccess']   = "Conseguiste arrombar a fechadura",

    ['NotifyRobbery']     = "Alguém está a tentar roubar uma casa em %s",

    ['ProgressLockpicking'] = "A arrombar porta",

    ['InvalidShell']        = "Invalid house shell: %s, please report to your server owner.",
    ['ShellNotLoaded']      = "Shell would not load: %s, please report to your server owner.",
    ['BrokenOffset']        = "Offset is messed up for house with ID %s, please report to your server owner.",

    ['UpgradeHouse']        = "Modificar casa para: %s",
    ['CantAffordUpgrade']   = "Não consegues comprar esta modificação",

    ['SetSalePrice']        = "Definir preço de venda",
    ['InvalidAmount']       = "Valor inválido inserido",
    ['InvalidSale']         = "Não consegues vender esta casa porque ainda deves dinheiro",
    ['InvalidMoney']        = "Não tens dinheiro suficiente",

    ['EvictingTenants']     = "Evicting tenants",

    ['NoOutfits']           = "Não tens nenhuma roupa guardada no armário",

    ['EnterHouse']          = "Entrar em casa",
    ['KnockHouse']          = "Bater à porta",
    ['RaidHouse']           = "Raidar casa",
    ['BreakIn']             = "Invadir a casa",
    ['InviteInside']        = "Convidar para dentro de casa",
    ['HouseKeys']           = "Chaves de casa",
    ['UpgradeHouse2']       = "Modificar casa",
    ['UpgradeShell']        = "Upgrade Interior",
    ['SellHouse']           = "Vender casa",
    ['FurniUI']             = "Furni UI",
    ['SetWardrobe']         = "Definir roupeiro",
    ['SetInventory']        = "Definir armário",
    ['SetGarage']           = "Definir garagem",
    ['LockDoor']            = "Trancar porta de casa",
    ['UnlockDoor']          = "Abrir porta de casa",
    ['LeaveHouse']          = "Sair da casa",
    ['Mortgage']            = "Hipoteca",
    ['Buy']                 = "Comprar",
    ['View']                = "Ver",
    ['Upgrades']            = "Modificações",
    ['MoveGarage']          = "Mover a garagem",

    ['GiveKeys']            = "Dar chaves",
    ['TakeKeys']            = "Pegar chaves",

    ['MyHouse']             = "Minha casa",
    ['PlayerHouse']         = "Casa jogador",
    ['EmptyHouse']          = "Casa vazia",

    ['NoUpgrades']          = "Sem modificações disponíveis",
    ['NoVehicles']          = "Sem veículos",
    ['NothingToDisplay']    = "Nada para mostrar",

    ['ConfirmSale']         = "Sim, vender a minha casa",
    ['CancelSale']          = "Não, não vender a minha casa",
    ['SellingHouse']        = "Vender casa ($%d)",

    ['MoneyOwed']           = "Dinheiro em dívida: $%s",
    ['LastRepayment']       = "último pagamento: %s",
    ['PayMortgage']         = "Pagar hipoteca",
    ['MortgageInfo']        = "Informações sobre hipoteca",

    ['SetEntry']            = "Definir entrada",
    ['CancelGarage']        = "Cancelar Garagem",
    ['UseInterior']         = "Usar interiror",
    ['UseShell']            = "Use Shell",
    ['InteriorType']        = "Definir tipo de interior",
    ['SetInterior']         = "Escolher interior atual",
    ['SelectDefaultShell']  = "Select default house shell",
    ['ToggleShells']        = "Toggle shells available for this property",
    ['AvailableShells']     = "Available Shells",
    ['Enabled']             = "~g~ENABLED~s~",
    ['Disabled']            = "~r~DISABLED~s~",
    ['NewDoor']             = "Adicionar porta nova",
    ['Done']                = "Feito",
    ['Doors']               = "Portas",
    ['Interior']            = "Interior",

    ['CreationComplete']    = "Criação da casa completa.",
  }
}

Labels = labels[Config.Locale]

