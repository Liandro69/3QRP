-- 2 = sangue

-- 1 = clip

-- 0 = bala

local parts = {
	['sobrancelha'] = 1356,
	['dedo do pé esquerdo'] = 2108,
	['cotovelo direito'] = 2992,
	['braço esquerdo'] = 5232,
	['mão direita'] = 6286,
	['coxa direita'] = 6442,
	['clavícula direita'] = 10706,
	['canto direito da boca'] = 11174,
	['corpo'] = 11816,
	['cabeça'] = 12844,
	['pé esquerdo'] =  14201,
	['joelho direito'] = 16335,
	['lábio inferior'] = 17188,
	['lábio'] = 17719,
	['mão esquerda'] = 18905,
	['bochecha direita'] = 19336,
	['dedo do pé direito'] = 20781,
	['nervo do lábio inferior']  = 20279,
	['lábio inferior'] = 20623,
	['dedo do pé']  = 20781,
	['bochecha esquerda'] = 21550,
	['cotovelo esquerdo'] = 22711,
	['raiz espinhal'] = 23553,
	['coxa esquerda'] = 23639,
	['pé direito'] = 24806,
	['parte inferior da coluna'] = 24816,
	['parte do meio da coluna'] = 24817,
	['parte superior da coluna'] = 24818,
	['olho esquerdo'] = 25260,
	['olho direito'] = 27474,
	['braço direito'] = 28252,
	['mão direita'] = 28422,
	['canto esquerdo da boca'] = 29868,
	['cabeça'] = 31086,
	['pé direito'] = 35502,
	['pescoço'] = 35731,
	['mão esquerda'] = 36029,
	['panturrilha direita'] = 36864,
	['braço direito'] = 37119,
	['sobrancelha'] = 37193,
	['pescoço'] = 39317,
	['braço direito'] = 40269,
	['antebraço direito'] = 43810,
	['ombro esquerdo'] = 45509,
	['joelho esquerdo'] = 46078,
	['mandíbula'] = 46240,
	['nervo do lábio inferior'] = 47419,
	['língua'] = 47495,
	['nervo do lábio superior'] = 49979,
	['coxa direita'] = 51826,
	['pé direito'] = 52301,
	['raiz'] = 56604,
	['mão direita'] = 57005,
	['coluna vertebral'] = 57597,
	['osso do pé esquerdo'] = 57717,
	['coxa esquerda'] = 58271,
	['sobrancelha esquerda'] = 58331,
	['osso da mão esquerda'] = 60309,
	['mão esquerda'] = 18905,
	['antebraço direito'] = 61007,
	['antebraço esquerdo'] = 61163,
	['lábio superior'] = 61839,
	['barriga da perna esquerda'] = 63931,
	['clavícula esquerda'] = 64729,
	['corpo'] = 65068,
	['pé esquerdo'] = 65245,
}


local weapons = {
    {name = "WEAPON_MARKSMANPISTOL", label = "Pistola Marksman", ammo = "Calibre 12"},
    {name = "WEAPON_PISTOL", label = "Pistola", ammo = "Calibre 9 mm"},
    {name = "WEAPON_REVOLVER", label = "Revolver", ammo = "Calibre .44" },
    {name = "WEAPON_COMBATPISTOL", label = "Pistola de combate", ammo = "Calibre 9 mm"},
    {name = "WEAPON_PISTOL50", label = "Pistola .50", ammo = "Calibre .50"},
    {name = "WEAPON_APPISTOL", label = "Pistola AP", ammo = "Calibre 9 mm"},
    {name = "WEAPON_HEAVYPISTOL", label = "Pistola Pesada", ammo = "Calibre 10 mm"},
    {name = "WEAPON_SNSPISTOL", label = "Pistola SNS", ammo = "Calibre .22"},
    {name = "WEAPON_PUMPSHOTGUN", label = "Caçadeira", ammo = "Calibre 12"},
    {name = "WEAPON_MUSKET", label = "Mosquete", ammo = "Calibre 18 mm"},
    {name = "WEAPON_ASSAULTRIFLE", label = "Rifle de assalto AK-47", ammo = "Calibre 7.62x39mm"},
    {name = "WEAPON_SNIPERRIFLE", label = "Sniper", ammo = "Calibre .300"},
    {name = "WEAPON_SPECIALCARBINE", label = "Carabina especial", ammo = "Calibre 5.56x45mm"},
    {name = "WEAPON_CARBINERIFLE", label = "Rifle M4", ammo = "Calibre 5.56x45mm"},
    {name = "WEAPON_ASSAULTSMG", label = "SMG de assalto", ammo = "Calibre 5.56x45mm"},
    {name = "WEAPON_HEAVYSNIPER", label = "Sniper Pesada", ammo = "Calibre .300"},
}

local playerLoadedProvas = false

local provas          = {}

local PlayerData                = {}
ESX                           = nil



Citizen.CreateThread(function()
	while ESX == nil do
	    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	    Citizen.Wait(0)
	end
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	Wait(10000)
	if PlayerData.job.name == 'police' then
		CreateLabBlip()
	end
	playerLoadedProvas = true
  ESX.TriggerServerCallback('tqrp_provas:syncProvas', function(provas)
    provas = provas
  end)
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)


-------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------INÍCIO DO SISTEMA DE DANO
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------

local lastBone          = nil


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)

    local ped = PlayerPedId()
    local FoundLastDamagedBone, LastDamagedBone = GetPedLastDamageBone(ped)

    if FoundLastDamagedBone and LastDamagedBone ~= lastBone then
        local DamagedBone = GetBoneName(LastDamagedBone)
        if DamagedBone then
          if HasPedBeenDamagedByWeapon(ped, GetHashKey("WEAPON_MARKSMANPISTOL"), 0)
            or HasPedBeenDamagedByWeapon(ped, GetHashKey("WEAPON_PISTOL"), 0)
            or HasPedBeenDamagedByWeapon(ped, GetHashKey("WEAPON_REVOLVER"), 0)
            or HasPedBeenDamagedByWeapon(ped, GetHashKey("WEAPON_COMBATPISTOL"), 0)
            or HasPedBeenDamagedByWeapon(ped, GetHashKey("WEAPON_PISTOL50"), 0)
            or HasPedBeenDamagedByWeapon(ped, GetHashKey("WEAPON_APPISTOL"), 0)
            or HasPedBeenDamagedByWeapon(ped, GetHashKey("WEAPON_HEAVYPISTOL"), 0)
            or HasPedBeenDamagedByWeapon(ped, GetHashKey("WEAPON_SNSPISTOL"), 0)
            or HasPedBeenDamagedByWeapon(ped, GetHashKey("WEAPON_PUMPSHOTGUN"), 0)
            or HasPedBeenDamagedByWeapon(ped, GetHashKey("WEAPON_MUSKET"), 0)
            or HasPedBeenDamagedByWeapon(ped, GetHashKey("WEAPON_ASSAULTRIFLE"), 0)
            or HasPedBeenDamagedByWeapon(ped, GetHashKey("WEAPON_SNIPERRIFLE"), 0)
            or HasPedBeenDamagedByWeapon(ped, GetHashKey("WEAPON_SPECIALCARBINE"), 0)
            or HasPedBeenDamagedByWeapon(ped, GetHashKey("WEAPON_CARBINERIFLE"), 0) then
              if GetPedArmour(ped) == 0 then
                TriggerEvent("tqrp_provas:criarProvaCL", "Sangue", 2)
              else
                  if LastDamagedBone == 24816 -- com colete
                    or LastDamagedBone == 24817
                    or LastDamagedBone == 57597
                    or LastDamagedBone == 10706
                    or LastDamagedBone == 64729
                    or LastDamagedBone == 24818 then
                  else -- sem colete
                    TriggerEvent("tqrp_provas:criarProvaCL", "Sangue", 2)
                  end
              end
            elseif HasPedBeenDamagedByWeapon(ped, GetHashKey("WEAPON_UNARMED"), 0) then -- soco
              TriggerEvent("tqrp_provas:criarProvaCL", "Sangue", 2)
            else
              TriggerEvent("tqrp_provas:criarProvaCL", "Sangue", 2) -- Queda
            end
          lastBone = LastDamagedBone
      end
    end
  end
end)

function GetBoneName(boneId)
  for Key, Value in pairs(parts) do
      if boneId == Value then
          return Key
      end
  end
  return nil
end


-----------------------------------------------------------------------------------------------------------------INÍCIO DO SISTEMA DE PROVAS


--[[
Citizen.CreateThread( function()
  while true do
    local waitWe = 3000
    if playerLoadedProvas then
        local ped = PlayerPedId()
        if GetSelectedPedWeapon(ped) ~= GetHashKey("WEAPON_UNARMED") then
          if IsPedShooting(ped) and GetSelectedPedWeapon(ped) ~= 126349499 and GetSelectedPedWeapon(ped) ~= 101631238 then
              local coords    = GetEntityCoords(ped)
              if GetDistanceBetweenCoords(coords,  13.33, -1098.99, 29.79,  true) > 10.0 then
                  local weaponPed = GetSelectedPedWeapon(ped)
                  local weapon = "Arma desconhecida"
                  for i = 1, #weapons do
                    if GetHashKey(weapons[i].name) == weaponPed then
                        weapon = weapons[i].label
                        break
                    end
                  end
                  TriggerEvent("tqrp_provas:criarProvaCL", "Invólucro de munição ["..weapon.."]", 0)
                  Wait(2000)
              end
          end
          waitWe = 10
        else
          waitWe = 3000
        end
    end
    Wait(waitWe)
  end
end)
]]


RegisterNetEvent('tqrp_provas:criarProvaCL')
AddEventHandler('tqrp_provas:criarProvaCL', function(texto, tipo)
  local ped = GetPlayerPed(-1)
  local coords    = GetEntityCoords(ped)
  local unusedBool, spawnZ = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z+20, 1)


  ESX.TriggerServerCallback('tqrp_provas:getPlayerData', function(data)
    local dna_blood   = data.dna_blood
    local dna_weapon  = texto

    TriggerServerEvent("tqrp_provas:criarProva_sv", coords.x, coords.y, spawnZ+0.03, tipo, texto, dna_blood, dna_weapon)
  end)
end)


RegisterNetEvent('tqrp_provas:criarCustomProvaCL')
AddEventHandler('tqrp_provas:criarCustomProvaCL', function(texto,x,y,z)
  ESX.TriggerServerCallback('tqrp_provas:getPlayerData', function(data)
    local dna_blood   = data.dna_blood
    local dna_weapon  = texto

    TriggerServerEvent("tqrp_provas:criarProva_sv", x, y, z+0.03, 5, texto, dna_blood, dna_weapon)
  end)
end)

RegisterNetEvent('tqrp_provas:deleteProvas_cl')
AddEventHandler('tqrp_provas:deleteProvas_cl', function(x, y, z)
    for i, v in ipairs(provas) do
        if v.x == x and v.y == y and v.z == z then 
          provas[i] = {}
        end
    end
end)


RegisterNetEvent('tqrp_provas:criarProvaCL_ID')
AddEventHandler('tqrp_provas:criarProvaCL_ID', function(x,y,z)
    if not HasGloves() then
      ESX.TriggerServerCallback('tqrp_provas:getPlayerData', function(data)
          local dna_blood   = data.dna_blood
          local dna_weapon  = ""
          TriggerServerEvent("tqrp_provas:criarProva_sv", x,y,z, 4, 'Impressão digital', dna_blood, dna_weapon)
      end)
    end
end)


RegisterCommand("numprovas", function()
    print(#provas)
end,false)


RegisterNetEvent('tqrp_provas:criarProva_cl')
AddEventHandler('tqrp_provas:criarProva_cl', function(x, y, z, tipo, text, dna_blood, dna_weapon)
    table.insert(provas, {tipo = tipo, value = text, x = x , y = y , z = z, dna_blood = dna_blood, dna_weapon = dna_weapon})
end)


function HasGloves()
  local gloves = {'16','17','19','20','21','22','23','24','25','26','27','28','29','30','31','32','33','34','35','36','37','38','39','40','41','42','43','44','45','46','47','48','49','50','51','63','64','65','66','67','68','69','70','71','72','73','74','75','76','77','78','79','80','81','82','83','84','85','86','87','88','89','90','91','92','93','94','95','96','99','100','101','102','103','104','105','106','107','108','109','110','111','115','116','117','119','120','121','122','123','124','126','127','128','129','130','131','133','134','135','136','137','138','139','140','141','142','143','144','145','146','147','148','149','150','151','152','153','154','155','156','157','158','159','160','161','162','163','165','166','167'}
  local hasGloves = false
  local arms = GetPedDrawableVariation(GetPlayerPed(-1), 3)
  for k,v in pairs(gloves) do
      if arms == tonumber(v) then
        hasGloves = true
        break
      end
  end
  return hasGloves
end

------------- MARKERS + 3D TEXT + LAB

CreateThread(function()
  while true do
      local waitPrincipal = 3000
      local ped = PlayerPedId()
      local coords = GetEntityCoords(ped)
      local renderdistance = 0.5
      if PodeVerProvas(ped) then
        renderdistance = 4.5
      end

      for i, v in ipairs(provas) do
        if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, false) < 6.0 then
          waitPrincipal = 7
          if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, false) < renderdistance then
            if PlayerData.job.name ~= nil and PlayerData.job.name ~= 'police' then
                if tonumber(v.tipo) == 2 then -- sangue
                  DrawMarker(25, v.x, v.y, v.z+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.2, 255, 10, 10, 100, false, true, 2, false, false, false, false)
                elseif tonumber(v.tipo) == 0 or tonumber(v.tipo) == 1 then --tiro + carregador
                  DrawMarker(25, v.x, v.y, v.z+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.1, 0.1, 0.1, 255, 255, 255, 100, false, true, 2, false, false, false, false)
                end
            else
                if tonumber(v.tipo) == 2 then
                  DrawMarker(25, v.x, v.y, v.z+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.25, 0.25, 0.25, 255, 10, 10, 100, false, true, 2, false, false, false, false)
                elseif tonumber(v.tipo) == 0 or tonumber(v.tipo) == 1 then
                  DrawMarker(25, v.x, v.y, v.z+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.15, 0.15, 0.15, 255, 255, 255, 100, false, true, 2, false, false, false, false)
                elseif tonumber(v.tipo) == 4 then
                  DrawMarker(25, v.x, v.y, v.z+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.15, 0.15, 0.15, 255, 255, 255, 100, false, true, 2, false, false, false, false)
                else
                  DrawMarker(25, v.x, v.y, v.z+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 255, 100, false, true, 2, false, false, false, false)
                  DrawMarker(20, v.x, v.y, v.z+0.5, 0.0, 0.0, 0.0, -180.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 255, 255, 100, true, true, 2, false, false, false, false)
                end
            end
            if not IsPedInAnyVehicle(ped, false) then
              if PlayerData.job.name ~= nil and PlayerData.job.name ~= 'police' then
                  if v.tipo == 2 then
                    DrawText3Ds(v.x, v.y, v.z, "[~g~E~w~] limpar sangue")
                  elseif v.tipo == 0 or v.tipo == 1 then
                    DrawText3Ds(v.x, v.y, v.z, "[~g~E~w~] destruir prova")
                  end

                  if (IsControlPressed(1, 38)) and v.tipo ~= 5 then
                      if v.tipo ~= 2 then
                        Anim1()
                      else
                        Anim2()
                      end
                      TriggerServerEvent("tqrp_provas:deleteProvas_sv", v.x, v.y, v.z)
                      Wait(2000)
                  end
              else
                if v.tipo == 2 then
                    DrawText3Ds(v.x, v.y, v.z, "[~g~E~w~] limpar sangue | [~r~H~w~] recolher")
                elseif v.tipo == 0 or v.tipo == 1 then
                    DrawText3Ds(v.x, v.y, v.z, "[~g~E~w~] destruir prova | [~r~H~w~] recolher")
                end

                if v.tipo == 5 then
                    DrawText3Ds2(v.x, v.y, v.z+0.5, "[~g~E~w~] "..v.value)
                end

                if v.tipo == 4 then
                  DrawText3Ds2(v.x, v.y, v.z+0.2, "[~g~E~w~] "..v.value)
                  if (IsControlPressed(1, 47)) then
                    PickUpID(v.x, v.y, v.z, v.dna_blood, v.dna_weapon, v.tipo)
                    Wait(35000)
                  end
                end

                if (IsControlPressed(1, 38)) then
                  if v.tipo == 0 or v.tipo == 1 then
                    Anim1()
                  elseif v.tipo == 2 then
                    Anim2()
                  elseif v.tipo == 5 then
                    Anim3()
                  end
                    TriggerServerEvent("tqrp_provas:deleteProvas_sv", v.x, v.y, v.z)
                    Wait(2000)
                end

                if (IsControlPressed(1, 74)) and (v.tipo == 0 or v.tipo == 1 or v.tipo == 2) then
                  if v.tipo ~= 2 then
                      Anim1()
                  else
                      Anim3()
                  end
                    TriggerServerEvent("tqrp_provas:saveProva_sv", v.x, v.y, v.z, v.tipo, v.dna_blood, v.dna_weapon)
                    TriggerServerEvent("tqrp_provas:deleteProvas_sv", v.x, v.y, v.z)
                    Wait(2000)
                end
              end
            end
          end
        end
      end
      Wait(waitPrincipal)
  end
end)



CreateThread(function()
    while true do
      local coords = GetEntityCoords(GetPlayerPed(-1))
      local WaitDrawProvas = 10000
      if GetDistanceBetweenCoords(coords,  458.898, -981.329, 24.914,  true) < 20.0 or GetDistanceBetweenCoords(coords,  440.13729858398, -975.64056396484, 30.68967628479,  true) < 60.0 then
        if GetDistanceBetweenCoords(coords,  458.898, -981.329, 24.914,  true) < 2.0 then
          DrawText3Ds2(458.898, -981.329, 24.914, "[~g~E~w~] verificar")
          if (IsControlPressed(1, 51)) then
            OpenMenuPrincipalProvas()
            Wait(2500)
          end
        end
        if GetDistanceBetweenCoords(coords,  458.97, -975.96, 24.92,  true) < 2.0 then
          DrawText3Ds2(458.97, -975.96, 24.92, "[~g~E~w~] verificar")
          if (IsControlPressed(1, 51)) then
            OpenMenuProvasPolice()
            Wait(2500)
          end
        end
          WaitDrawProvas = 5
      end
      Wait(WaitDrawProvas)
    end
end)



function PickUpID(x,y,z,dna_blood,dna_weapon,tipo)
  local ped = GetPlayerPed(-1)
    loadAnimDict("anim@amb@business@coc@coc_packing_hi@")
    TaskPlayAnim(ped, "anim@amb@business@coc@coc_packing_hi@", "full_cycle_v3_pressoperator", 2.0, 1.0, 50.0, 0, 1, 0, 0, 0)
    exports['mythic_progbar']:Progress({
      name = "pickup1",
      duration = 1000,
      label = "A Colocar pó...",
      useWhileDead = false,
      canCancel = false,
      controlDisables = {},
      prop = {},  
      })
    Wait(10500)
    exports['mythic_progbar']:Progress({
      name = "pickup1",
      duration = 1000,
      label = "A espalhar o pó...",
      useWhileDead = false,
      canCancel = false,
      controlDisables = {},
      prop = {},  
      })
    Wait(10500)
    exports['mythic_progbar']:Progress({
      name = "pickup1",
      duration = 1000,
      label = "A colocar fita adesiva...",
      useWhileDead = false,
      canCancel = false,
      controlDisables = {},
      prop = {},  
      })
    Wait(5500)
    exports['mythic_progbar']:Progress({
      name = "pickup1",
      duration = 1000,
      label = "A retirar impressão digital...",
      useWhileDead = false,
      canCancel = false,
      controlDisables = {},
      prop = {},  
      })
    Wait(5500)
    ClearPedTasksImmediately(ped)
  TriggerServerEvent("tqrp_provas:saveProva_sv", x,y,z,tipo,dna_blood,dna_weapon)
  TriggerServerEvent("tqrp_provas:deleteProvas_sv", x, y, z)
end



function OpenMenuPrincipalProvas()
  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'menu_principal',
    {
        title    = "Laboratório",
        align    = 'top-left',
        elements = {
          {label = "Colocar para análise",   value = "coloc_prova"},
          {label = "Verificar estado",   value = "verif_prova"},
        },
    },
    function(data, menu)
        if data.current.value == "coloc_prova" then
          menu.close()
          ESX.UI.Menu.Open(
            'dialog', GetCurrentResourceName(), 'coloc_prova_menu',
            {
              title = "Número da prova"
            },
            function(data2, menu2)
            local num = data2.value
            if num == nil then
              exports['mythic_notify']:SendAlert('error', 'Número de prova inválida!')
            else
              ESX.UI.Menu.CloseAll()
              TriggerServerEvent("tqrp_provas:coloc_prova_sv", num)
            end
            end,
            function(data2, menu2)
            menu2.close()
            end
          )
        end
        if data.current.value == "verif_prova" then
          menu.close()
          ESX.UI.Menu.Open(
            'dialog', GetCurrentResourceName(), 'verif_prova_menu',
            {
              title = "Número da prova"
            },
            function(data3, menu3)
              local num = data3.value
              if num == nil then
                exports['mythic_notify']:SendAlert('error', 'Número de prova inválida!')
              else
                ESX.UI.Menu.CloseAll()
                TriggerServerEvent("tqrp_provas:verif_prova_sv", num)
              end
            end,
            function(data3, menu3)
              menu3.close()
            end
          )
        end
    end,
    function(data, menu)
      menu.close()
    end
  )
end



function OpenMenuProvasPolice()
  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'menu_principal',
    {
        title    = "Polícia de Los Santos",
        align    = 'top-left',
        elements = {
          {label = "Verificar ADN",   value = "search_adn"},
        },
    },
    function(data, menu)
        if data.current.value == "search_adn" then
            menu.close()
            ESX.UI.Menu.Open(
              'dialog', GetCurrentResourceName(), 'verif_prova_menu',
              {
                  title = "ADN"
              },
            function(data3, menu3)
                local num = data3.value
                if num == nil then
                  exports['mythic_notify']:SendAlert('error', 'Número de prova inválido!')
                else
                  ESX.UI.Menu.CloseAll()
            ESX.TriggerServerCallback('tqrp_provas:getADNCivName', function(status)
                if status then
                    exports['mythic_notify']:SendAlert('inform', "ADN: "..num.." | Proprietário: "..status)
                else
                    exports['mythic_notify']:SendAlert('error', 'Número de prova inexistente na base de dados!')
                end
            end, num)
                end
            end,
            function(data3, menu3)
              menu3.close()
            end
          )
        end
    end,
    function(data, menu)
      menu.close()
    end
  )
end


function Anim1()
    local ped = GetPlayerPed(-1)
    SetCurrentPedWeapon(ped, "WEAPON_UNARMED", true)
    loadAnimDict("missheist_agency2aig_13")
    TaskPlayAnim(ped, "missheist_agency2aig_13", "pickup_briefcase", 2.0, 1.0, 50.0, 0, 1, 0, 0, 0)
    Wait(1800)
    ClearPedTasks(ped)
end



function Anim2()
    local ped = GetPlayerPed(-1)
    SetCurrentPedWeapon(ped, "WEAPON_UNARMED", true)
    loadAnimDict("amb@world_human_bum_wash@male@high@idle_a")
    TaskPlayAnim(ped, "amb@world_human_bum_wash@male@high@idle_a", "idle_a", 2.0, 1.0, 50.0, 0, 1, 0, 0, 0)
    Wait(1800)
    ClearPedTasks(ped)
end



function Anim3()
    local ped = GetPlayerPed(-1)
    SetCurrentPedWeapon(ped, "WEAPON_UNARMED", true)
    loadAnimDict("amb@code_human_police_investigate@idle_b")
    TaskPlayAnim(ped, "amb@code_human_police_investigate@idle_b", "idle_f", 2.0, 1.0, 50.0, 0, 1, 0, 0, 0)
    Wait(5000)
    ClearPedTasks(ped)
end



function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end



function DrawText3Ds(x,y,z, text)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
  SetTextScale(0.3, 0.3)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextEntry("STRING")
  SetTextCentre(1)
  SetTextColour(255, 255, 255, 255)
  SetTextOutline()
  AddTextComponentString(text)
  DrawText(_x, _y)
  local factor = (string.len(text)) / 500
  DrawRect(_x, _y + 0.011, 0.005 + factor, 0.016, 31, 31, 31, 10)
end



function DrawText3Ds2(x,y,z, text)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
  SetTextScale(0.35, 0.35)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextEntry("STRING")
  SetTextCentre(1)
  SetTextColour(255, 255, 255, 255)
  SetTextOutline()
  AddTextComponentString(text)
  DrawText(_x, _y)
  local factor = (string.len(text)) / 370
  DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 31, 31, 31, 10)
end



function CreateLabBlip()
  local blip = AddBlipForCoord(337.89, -1561.59, 30.29)
  SetBlipSprite (blip, 408)
  SetBlipDisplay(blip, 4)
  SetBlipScale  (blip, 0.8)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("Laboratório Forense e Criminal")
  EndTextCommandSetBlipName(blip)
end


function PodeVerProvas(ped)
	if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_FLASHLIGHT") then
		if IsPlayerFreeAiming(PlayerId()) then
			return true
		end
	end

	if IsEntityPlayingAnim(ped, 'amb@code_human_police_investigate@idle_b', 'idle_f', 3) then
		return true
	end

	if IsPedUsingScenario(ped, "WORLD_HUMAN_PAPARAZZI") then
		return true
	end
	return false
end