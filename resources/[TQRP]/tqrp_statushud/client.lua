local toghud = false

Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
      Citizen.Wait(10)
    end
  end
)

RegisterCommand('hud', function(source, args, rawCommand)

    if toghud then 
        toghud = false
    else
        toghud = true
        startUpdate()
        showhud()
    end

end)

RegisterNetEvent('hud:toggleui')
AddEventHandler('hud:toggleui', function(show)

    if show == true then
        toghud = true
        startUpdate()
        showhud()
    else
        toghud = false
    end

end)

function startUpdate()
    Citizen.CreateThread(function()
        local myhunger = nil
        local mythirst = nil
        local mystress = nil
        while toghud do    
            TriggerEvent('tqrp_status:getStatus', 'hunger', function(hunger)
                myhunger = hunger.getPercent()
            end)
            Citizen.Wait(1500)
            TriggerEvent('tqrp_status:getStatus', 'thirst', function(thirst)
                mythirst = thirst.getPercent()
            end)
            Citizen.Wait(1500)
            TriggerEvent('tqrp_status:getStatus','stress',function(stress)
                mystress = stress.getPercent()
            end)
            Citizen.Wait(1500)
            SendNUIMessage({
                action = "updateStatusHud",
                show = toghud,
                hunger = myhunger,
                thirst = mythirst,
                stress = mystress,
            })
            Citizen.Wait(500)
        end
    end)
end


function showhud()
    local player = PlayerPedId()
    local health = (GetEntityHealth(player) - 100)
    local armor = GetPedArmour(player)
    local oxy = nil
    while toghud do
        Citizen.Wait(10)
        player = PlayerPedId()
        health = (GetEntityHealth(player) - 100)
        Citizen.Wait(250)
        armor = GetPedArmour(player)
        Citizen.Wait(250)
        oxy = nil
        --local oxy = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 4
        if IsPedOnFoot(player) then
            if IsPedSwimmingUnderWater(player) then
                oxy = (GetPlayerUnderwaterTimeRemaining(PlayerId()))
            else
                oxy = (GetPlayerSprintStaminaRemaining(PlayerId()))
            end
        else
            oxy = 0
        end
        SendNUIMessage({
            action = 'updateStatusHud',
            show = toghud,
            health = health,
            armour = armor,
            oxygen = oxy,
        })
        Citizen.Wait(1000)
    end
    SendNUIMessage({
        action = 'updateStatusHud',
        show = toghud,
        health = health,
        armour = armor,
        oxygen = oxy,
    })
end
