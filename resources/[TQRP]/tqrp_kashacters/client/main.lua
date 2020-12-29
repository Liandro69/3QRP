ESX = nil
local Logouts = {
    vector3(-211.965, -1034.459, 30.139)
}
Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(200)
        TriggerEvent('esx:getSharedObject', function (obj) ESX = obj end)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if NetworkIsSessionStarted() then
            Citizen.Wait(100)
            TriggerServerEvent("kashactersS:SetupCharacters")
            TriggerEvent("kashactersC:SetupCharacters")
            return -- break the loop
        end
    end
end)

local cam = nil
local cam2 = nil
RegisterNetEvent('kashactersC:SetupCharacters')
AddEventHandler('kashactersC:SetupCharacters', function()
    DoScreenFadeOut(10)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
    SetTimecycleModifier('hud_def_blur')
    FreezeEntityPosition(PlayerPedId(), true)
    --cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1355.93,-1487.78,520.75, 300.00,0.00,0.00, 100.00, false, 0)
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 288.1, -1090.49, 208.49, 0.00, 0.00, 0.00, 140.00, false, 0)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
end)

RegisterNetEvent('kashactersC:WelcomePage')
AddEventHandler('kashactersC:WelcomePage', function()
    SetNuiFocus(true, true)
	SendNUIMessage({
        action = "openwelcome"
    })
end)

RegisterNetEvent('kashactersC:SetupUI')
AddEventHandler('kashactersC:SetupUI', function(Characters)
    DoScreenFadeIn(500)
    Citizen.Wait(1500)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "openui",
        characters = Characters,
    })
end)

RegisterNetEvent('kashactersC:SpawnCharacter')
AddEventHandler('kashactersC:SpawnCharacter', function(spawn)
    TriggerServerEvent('es:firstJoinProper')
    TriggerEvent('es:allowedToSpawn')
    local coords = spawn
    SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z)
    DoScreenFadeIn(5000)
    Citizen.Wait(1500)
    --cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1355.93,-1487.78,520.75, 300.00,0.00,0.00, 100.00, false, 0)
    cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 288.1, -1090.49, 208.49, 0.00, 0.00, 0.00, 100.00, false, 0)
    PointCamAtCoord(cam2, coords.x,coords.y,coords.z+200)
    SetCamActiveWithInterp(cam2, cam, 900, true, true)
    Citizen.Wait(900)

    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coords.x,coords.y,coords.z+200, 0.00,0.00,0.00, 100.00, false, 0)
    PointCamAtCoord(cam, coords.x,coords.y,coords.z+2)
    SetCamActiveWithInterp(cam, cam2, 3700, true, true)
    Citizen.Wait(3700)
    PlaySoundFrontend(-1, "Zoom_Out", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
    RenderScriptCams(false, true, 500, true, true)
    SetTimecycleModifier('default')
    PlaySoundFrontend(-1, "CAR_BIKE_WHOOSH", "MP_LOBBY_SOUNDS", 1)
    FreezeEntityPosition(PlayerPedId(), false)
    Citizen.Wait(1500)
    SetCamActive(cam, false)
    DestroyCam(cam, true)
    DisplayHud(true)
    DisplayRadar(false)
end)

RegisterNetEvent('kashactersC:ReloadCharacters')
AddEventHandler('kashactersC:ReloadCharacters', function()
    TriggerServerEvent("kashactersS:SetupCharacters")
    TriggerEvent("kashactersC:SetupCharacters")
end)

RegisterNUICallback("CharacterChosen", function(data, cb)
    SetNuiFocus(false,false)
    DoScreenFadeOut(500)
    TriggerServerEvent('kashactersS:CharacterChosen', data.charid, data.ischar)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
    cb("ok")
end)
RegisterNUICallback("DeleteCharacter", function(data, cb)
    SetNuiFocus(false,false)
    DoScreenFadeOut(500)
    TriggerServerEvent('kashactersS:DeleteCharacter', data.charid)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
    cb("ok")
end)