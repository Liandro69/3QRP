ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

RegisterNetEvent('nfw_wep:SmallArmor')
AddEventHandler('nfw_wep:SmallArmor', function()
    local inventory = ESX.GetPlayerData().inventory
    local ped = PlayerPedId()
    local armor = GetPedArmour(ped)
    local item = 'SmallArmor'

    if(armor >= 100) or (armor+30 > 100) then
        exports['mythic_notify']:SendAlert('inform', 'A tua armadura está no máximo!')
        TriggerServerEvent('returnItem', item)
        return
    end

    if not IsPedInAnyVehicle(PlayerPedId()) then
        TriggerEvent('mythic_progbar:client:progress', {
            name = 'heavyb_armor',
            duration = 15000,
            label = 'A vestir colete...',
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "missmic4",
                anim = "michael_tux_fidget",
                flags = 49,
            },
            prop = {}
        }, function(status)
            if not status then
                SetPedComponentVariation(ped, 9, 7, 0, 0)
                AddArmourToPed(ped, 30)
                ClearPedTasks(ped)
                exports['mythic_notify']:SendAlert('inform', 'Meteste um colete a prova de balas.')
            end
        end)
    else
        TriggerEvent('mythic_progbar:client:progress', {
            name = 'heavyb_armor',
            duration = 15000,
            label = 'A vestir colete...',
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            }
        }, function(status)
            if not status then
                SetPedComponentVariation(ped, 9, 7, 0, 0)
                AddArmourToPed(ped, 30)
                exports['mythic_notify']:SendAlert('inform', 'Meteste um colete a prova de balas.')
            end
        end)
    end
end)

RegisterNetEvent('nfw_wep:MedArmor')
AddEventHandler('nfw_wep:MedArmor', function()
    local inventory = ESX.GetPlayerData().inventory
    local ped = PlayerPedId()
    local armor = GetPedArmour(ped)
    local item = 'MedArmor'

    if(armor >= 100) or (armor+30 > 100) then
        exports['mythic_notify']:SendAlert('inform', 'A tua armadura está no máximo!')
        TriggerServerEvent('returnItem', item)
        return
    end

    if not IsPedInAnyVehicle(PlayerPedId()) then
        TriggerEvent('mythic_progbar:client:progress', {
            name = 'heavyb_armor',
            duration = 10000,
            label = 'A vestir colete...',
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "missmic4",
                anim = "michael_tux_fidget",
                flags = 49,
            },
            prop = {}
        }, function(status)
            if not status then
                SetPedComponentVariation(ped, 9, 7, 0, 0)
                AddArmourToPed(ped, 60)
                ClearPedTasks(ped)
                exports['mythic_notify']:SendAlert('inform', 'Meteste um colete a prova de balas.')
            end
        end)
    else
        TriggerEvent('mythic_progbar:client:progress', {
            name = 'heavyb_armor',
            duration = 10000,
            label = 'A vestir colete...',
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "missmic4",
                anim = "michael_tux_fidget",
                flags = 49,
            },
            prop = {}
        }, function(status)
            if not status then
                SetPedComponentVariation(ped, 9, 7, 0, 0)
                AddArmourToPed(ped, 60)
                exports['mythic_notify']:SendAlert('inform', 'Meteste um colete a prova de balas.')
            end
        end)
    end
end)

RegisterNetEvent('nfw_wep:HeavyArmor')
AddEventHandler('nfw_wep:HeavyArmor', function()
    local inventory = ESX.GetPlayerData().inventory
    local ped = PlayerPedId()
    local armor = GetPedArmour(ped)
    local item = 'HeavyArmor'

    if(armor >= 100) or (armor+30 > 100) then
        exports['mythic_notify']:SendAlert('inform', 'A tua armadura está no máximo!')
        TriggerServerEvent('returnItem', item)
        return
    end
    if not IsPedInAnyVehicle(PlayerPedId()) then
        TriggerEvent('mythic_progbar:client:progress', {
            name = 'heavyb_armor',
            duration = 10000,
            label = 'A vestir colete...',
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "missmic4",
                anim = "michael_tux_fidget",
                flags = 49,
            },
            prop = {}
        }, function(status)
            if not status then
                SetPedComponentVariation(ped, 9, 27, 0, 0)
                AddArmourToPed(ped, 100)
                ClearPedTasks(ped)
                exports['mythic_notify']:SendAlert('inform', 'Meteste um colete a prova de balas.')
            end
        end)
    else
        TriggerEvent('mythic_progbar:client:progress', {
            name = 'heavyb_armor',
            duration = 10000,
            label = 'A vestir colete...',
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            }
        }, function(status)
            if not status then
                SetPedComponentVariation(ped, 9, 7, 0, 0)
                AddArmourToPed(ped, 100)
                exports['mythic_notify']:SendAlert('inform', 'Meteste um colete a prova de balas.')
            end
        end)
    end

end)

--USO FIO DE OURO
RegisterNetEvent('nfw_wep:FioOuro')
AddEventHandler('nfw_wep:FioOuro', function()
    local ped = PlayerPedId()


    if not IsPedInAnyVehicle(PlayerPedId()) and GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") then
        TriggerEvent('mythic_progbar:client:progress', {
            name = 'fio_ouro',
            duration = 3000,
            label = 'A meter o fio...',
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mp_clothing@female@shirt",
                anim = "michael_tux_fidget",
            },
            prop = {}
        }, function(status)
            if not status then
                SetPedComponentVariation(ped, 7, 94, 0, 0)
            end
        end)
    elseif	GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then
        TriggerEvent('mythic_progbar:client:progress', {
            name = 'fio_ouro',
            duration = 3000,
            label = 'A meter o fio...',
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mp_clothing@female@shirt",
                anim = "michael_tux_fidget",
            },
            prop = {}
        }, function(status)
            if not status then
                SetPedComponentVariation(ped, 7, 64, 0, 0)
            end
        end)
    end
end)

