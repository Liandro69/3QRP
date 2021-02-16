RegisterNetEvent("mythic_hospital:items:bandage")
AddEventHandler("mythic_hospital:items:bandage", function(item)
    exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 7000,
        label = "Usando Bandagem",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "missheistdockssetup1clipboard@idle_a",
            anim = "idle_a",
            flags = 49,
        },
        prop = {
            model = "prop_paper_bag_small",
        }
    }, function(status)
        if not status then
            local maxHealth = GetEntityMaxHealth(PlayerPedId())
            local health = GetEntityHealth(PlayerPedId())
            local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 16))
            SetEntityHealth(PlayerPedId(), newHealth)
            TriggerEvent('mythic_hospital:client:FieldTreatBleed')
            ClearPedTasks(ped)
            SetPedMoveRateOverride(ped, 1.0)
            ResetPedMovementClipset(ped, 1.0)
        end
        ClearPedTasksImmediately(ped)
    end)
end)

RegisterNetEvent("mythic_hospital:items:vicodin")
AddEventHandler("mythic_hospital:items:vicodin", function()
    exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 7000,
        label = "A tomar comprimidos...",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "mp_suicide",
            anim = "pill",
            flags = 49,
        },
        prop = {
            model = "prop_cs_pills",
            bone = 58866,
            coords = { x = 0.1, y = 0.0, z = 0.001 },
            rotation = { x = -60.0, y = 0.0, z = 0.0 },
        },
    }, function(status)
        if not status then
            TriggerEvent('mythic_hospital:client:UsePainKiller', 1)
            StopScreenEffect('Rampage')
            SetPedMoveRateOverride(ped, 1.0)
            ResetPedMovementClipset(ped, 1.0)
            TriggerServerEvent("big_skills:removeStress", 100000)
        end
    end)
end)

RegisterNetEvent("mythic_hospital:items:hydrocodone")
AddEventHandler("mythic_hospital:items:hydrocodone", function()
    exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 7000,
        label = "A tomar comprimidos...",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "mp_suicide",
            anim = "pill",
            flags = 49,
        },
        prop = {
            model = "prop_cs_pills",
            bone = 58866,
            coords = { x = 0.1, y = 0.0, z = 0.001 },
            rotation = { x = -60.0, y = 0.0, z = 0.0 },
        },
    }, function(status)
        if not status then
            TriggerEvent('mythic_hospital:client:UsePainKiller', 2)
            StopScreenEffect('Rampage')
            SetPedMoveRateOverride(ped, 1.0)
            ResetPedMovementClipset(ped, 1.0)
            TriggerServerEvent("big_skills:removeStress", 200000)
        end
    end)
end)

RegisterNetEvent("mythic_hospital:items:morphine")
AddEventHandler("mythic_hospital:items:morphine", function()
    exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 7000,
        label = "A tomar comprimidos...",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "mp_suicide",
            anim = "pill",
            flags = 49,
        },
        prop = {
            model = "prop_cs_pills",
            bone = 58866,
            coords = { x = 0.1, y = 0.0, z = 0.001 },
            rotation = { x = -60.0, y = 0.0, z = 0.0 },
        },
    }, function(status)
        if not status then
            TriggerEvent('mythic_hospital:client:UsePainKiller', 6)
            StopScreenEffect('Rampage')
            TriggerServerEvent("big_skills:removeStress", 600000)
        end
    end)
end)