local firstSpawn = true
local componentScroller = 0
local subComponentScroller = 0
local textureScroller = 0
local paletteScroller = 0
local removeScroller = 0
local opacityScroller = 0
local colourScroller = 0
local carregado = false

AddEventHandler('playerSpawned', function(spawn)
    if firstSpawn then
        Citizen.Wait(3000)
        TriggerServerEvent("clothes:firstspawn")
        firstSpawn = false
    end
end)

RegisterCommand('pedmenur10', function(source)
    OpenClothes()
end)

function OpenClothes()
    Menu.SetupMenu("clothing_main","Roupas")
    Menu.Switch(nil, "clothing_main")

    if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") or GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then
        for k,v in pairs(menu_options_mp) do
            Menu.addOption("clothing_main", function()
                if(Menu.Option(v.name))then
                     v.f(v.name,v.param)
                end
            end)
        end
    else
        for k,v in pairs(menu_options) do
            Menu.addOption("clothing_main", function()
                if(Menu.Option(v.name))then
                     v.f(v.name,v.param)
                end
            end)
        end
    end
end

function OpenClothesCop()
    Menu.SetupMenu("clothing_main","Personalizar roupa")
    Menu.Switch(nil, "clothing_main")
    for k,v in pairs(menu_optionsCop) do
        Menu.addOption("clothing_main", function()
            if(Menu.Option(v.name))then
                 v.f(v.name,v.param)
            end
        end)
    end
end

function listModels(title, table)
    Menu.SetupMenu("clothing_models", title)
    Menu.Switch("clothing_main", "clothing_models")
    for k,v in pairs(table) do
        Menu.addOption("clothing_models", function()
            if(Menu.Option(v))then
                TriggerEvent("clothes:changemodel", v)
            end
        end)
    end
end


function customise(title)
    Menu.SetupMenu("clothing_customise", title)
    Menu.Switch("clothing_main", "clothing_customise")
    if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") or GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then
        componentScroller = 0
        subComponentScroller = GetPedDrawableVariation(PlayerPedId(), componentScroller)
        textureScroller = GetPedTextureVariation(PlayerPedId(), componentScroller)
        paletteScroller = GetPedPaletteVariation(PlayerPedId(), componentScroller)
        Menu.addOption("clothing_customise", function()
            if(Menu.ScrollBarString({"Cabeça","Mascara","Cabelo","Braços","Calças","Paraquedas","Calçado","Fios & Gravatas","T-Shirt","Coletes","Decals","Camisolas"}, componentScroller, function(cb)  componentScroller = cb end)) then
                subComponentScroller = GetPedDrawableVariation(PlayerPedId(), componentScroller)
                textureScroller = GetPedTextureVariation(PlayerPedId(), componentScroller)
                paletteScroller = GetPedPaletteVariation(PlayerPedId(), componentScroller)
            end
        end)
        Menu.addOption("clothing_customise", function()
            if(Menu.ScrollBarInt("Componentes", subComponentScroller, GetNumberOfPedDrawableVariations(PlayerPedId(), componentScroller), function(cb)  subComponentScroller = cb end)) then
                if componentScroller == 0 then
                    SetPedHeadBlendData(PlayerPedId(), subComponentScroller, subComponentScroller, 0, subComponentScroller, subComponentScroller, 0, 0.5, 0.5, 0.0, false)
                end
                SetPedComponentVariation(PlayerPedId(), componentScroller, 0, 240, 0)
                SetPedComponentVariation(PlayerPedId(), componentScroller, subComponentScroller, textureScroller, paletteScroller)
                textureScroller = 0
                paletteScroller = 0
            end
        end)
        Menu.addOption("clothing_customise", function()
            local textureMax = 0
            if componentScroller == 2 then textureMax = GetNumHairColors() else textureMax = GetNumberOfPedTextureVariations(PlayerPedId(), componentScroller, subComponentScroller) end
            if(Menu.ScrollBarInt("Texturas", textureScroller, textureMax, function(cb)  textureScroller = cb end)) then
                if componentScroller == 2 then
                    SetPedComponentVariation(PlayerPedId(), componentScroller, subComponentScroller, 0, 1)
                    SetPedHairColor(PlayerPedId(), textureScroller, textureScroller)
                    player_data.clothing.textures[3] = textureScroller
                else
                    SetPedComponentVariation(PlayerPedId(), componentScroller, subComponentScroller, textureScroller, paletteScroller)
                end
            end
        end)
        Menu.addOption("clothing_customise", function()
            if(Menu.Option("Retirar T-shirt"))then
                SetPedComponentVariation(PlayerPedId(), 8, 0, 240, 0)
            end
        end)
        Menu.addOption("clothing_customise", function()
            if(Menu.Option("Aleatório"))then
                SetPedRandomComponentVariation(PlayerPedId(), true)
            end
        end)
    else
        componentScroller = 0
        subComponentScroller = GetPedDrawableVariation(PlayerPedId(), componentScroller)
        textureScroller = GetPedTextureVariation(PlayerPedId(), componentScroller)
        paletteScroller = GetPedPaletteVariation(PlayerPedId(), componentScroller)
        Menu.addOption("clothing_customise", function()
            local precomponentTable = {"Cabeça","Desconhecido","Cabelo","Camisolas","Calças","Desconhecido","Desconhecido","Desconhecido","Colares & Gravatas","Desconhecido","Desconhecido","Desconhecido"}
            local componentTable = {}
            for i = 0, 11 do
                if GetNumberOfPedDrawableVariations(PlayerPedId(), i) ~= 0 and GetNumberOfPedDrawableVariations(PlayerPedId(), i) ~= false then
                    componentTable[i+1] = precomponentTable[i+1]
                else
                    componentTable[i+1] = "Vazio"
                end
            end
            if(Menu.ScrollBarString(componentTable, componentScroller, function(cb)  componentScroller = cb end)) then
                subComponentScroller = GetPedDrawableVariation(PlayerPedId(), componentScroller)
                textureScroller = GetPedTextureVariation(PlayerPedId(), componentScroller)
                paletteScroller = GetPedPaletteVariation(PlayerPedId(), componentScroller)
            end
        end)
        Menu.addOption("clothing_customise", function()
            if(Menu.ScrollBarInt("Componentes", subComponentScroller, GetNumberOfPedDrawableVariations(PlayerPedId(), componentScroller), function(cb)  subComponentScroller = cb end)) then
                SetPedComponentVariation(PlayerPedId(), componentScroller, 0, 240, 0)
                SetPedComponentVariation(PlayerPedId(), componentScroller, subComponentScroller, textureScroller, paletteScroller)
                textureScroller = 0
                paletteScroller = 0
            end
        end)
        Menu.addOption("clothing_customise", function()
            if(Menu.ScrollBarInt("Texturas", textureScroller, GetNumberOfPedTextureVariations(PlayerPedId(), componentScroller, subComponentScroller), function(cb)  textureScroller = cb end)) then
                if componentScroller == 2 then player_data.clothing.textures[3] = textureScroller end
                SetPedComponentVariation(PlayerPedId(), componentScroller, subComponentScroller, textureScroller, paletteScroller)
            end
        end)
        Menu.addOption("clothing_customise", function()
            if(Menu.Option("Aleatório"))then
                SetPedRandomComponentVariation(PlayerPedId(), true)
            end
        end)
    end
end

function accessories(title)
    Menu.SetupMenu("clothing_accessories", title)
    Menu.Switch("clothing_main", "clothing_accessories")
    if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") or GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then
        componentScroller = 0
        subComponentScroller = GetPedPropIndex(PlayerPedId(), componentScroller)
        textureScroller = GetPedPropTextureIndex(PlayerPedId(), componentScroller)
        Menu.addOption("clothing_accessories", function()
            if(Menu.ScrollBarString({"Chapéus/Capacetes","Óculos","Brincos","Vazio","Vazio","Vazio","Pulso esquerdo","Pulso direito"}, componentScroller, function(cb)  componentScroller = cb end)) then
                subComponentScroller = GetPedPropIndex(PlayerPedId(), componentScroller)
                textureScroller = GetPedPropTextureIndex(PlayerPedId(), componentScroller)
            end
        end)
        Menu.addOption("clothing_accessories", function()
            if(Menu.ScrollBarInt("Componentes", subComponentScroller, GetNumberOfPedPropDrawableVariations(PlayerPedId(), componentScroller), function(cb)  subComponentScroller = cb end)) then
                SetPedPropIndex(PlayerPedId(), componentScroller, 0, 240, 0)
                SetPedPropIndex(PlayerPedId(), componentScroller, subComponentScroller, textureScroller, false)
                textureScroller = 0
            end
        end)
        Menu.addOption("clothing_accessories", function()
            if(Menu.ScrollBarInt("Texturas", textureScroller, GetNumberOfPedTextureVariations(PlayerPedId(), componentScroller, subComponentScroller), function(cb)  textureScroller = cb end)) then
                SetPedPropIndex(PlayerPedId(), componentScroller, subComponentScroller, textureScroller, false)
            end
        end)
        Menu.addOption("clothing_accessories", function()
            if(Menu.ScrollBarStringSelect({"Retirar Chapéus/Capacetes","Retirar óculos","Retirar brincos","Retirar Pulso esquerdo","Retirar Pulso direito"}, removeScroller, function(cb)  removeScroller = cb end)) then
                if removeScroller ~= 3 and removeScroller ~= 4 then
                    ClearPedProp(PlayerPedId(), tonumber(removeScroller))
                elseif removeScroller == 3 then
                    ClearPedProp(PlayerPedId(), 6)
                else
                    ClearPedProp(PlayerPedId(), 7)
                end
            end
        end)
        Menu.addOption("clothing_accessories", function()
            if(Menu.Option("Aleatório"))then
                SetPedRandomProps(PlayerPedId())
            end
        end)
    else
        local precomponentTable = {"Chapéus/Capacetes","Óculos","Brincos","Vazio","Vazio","Vazio","Pulso esquerdo","Pulso direito"}
        local componentTable = {}
        for i = 0, 7 do
            if GetNumberOfPedPropDrawableVariations(PlayerPedId(), i) ~= 0 and GetNumberOfPedPropDrawableVariations(PlayerPedId(), i) ~= false then
                componentTable[i+1] = precomponentTable[i+1]
            else
                componentTable[i+1] = "Vazio"
            end
        end
        componentScroller = 0
        subComponentScroller = GetPedDrawableVariation(PlayerPedId(), componentScroller)
        textureScroller = GetPedTextureVariation(PlayerPedId(), componentScroller)
        Menu.addOption("clothing_accessories", function()
            if(Menu.ScrollBarString(componentTable, componentScroller, function(cb)  componentScroller = cb end)) then
                subComponentScroller = GetPedPropIndex(PlayerPedId(), componentScroller)
                textureScroller = GetPedPropTextureIndex(PlayerPedId(), componentScroller)
            end
        end)
        Menu.addOption("clothing_accessories", function()
            if(Menu.ScrollBarInt("Componentes", subComponentScroller, GetNumberOfPedPropDrawableVariations(PlayerPedId(), componentScroller), function(cb)  subComponentScroller = cb end)) then
                SetPedPropIndex(PlayerPedId(), componentScroller, 0, 240, 0)
                SetPedPropIndex(PlayerPedId(), componentScroller, subComponentScroller, textureScroller, false)
                textureScroller = 0
            end
        end)
        Menu.addOption("clothing_accessories", function()
            if(Menu.ScrollBarInt("Texturas", textureScroller, GetNumberOfPedTextureVariations(PlayerPedId(), componentScroller, subComponentScroller), function(cb)  textureScroller = cb end)) then
                SetPedPropIndex(PlayerPedId(), componentScroller, subComponentScroller, textureScroller, false)
            end
        end)
        Menu.addOption("clothing_accessories", function()
            if(Menu.ScrollBarStringSelect({"Retirar Chapéus/Capacetes","Retirar Óculos","Retirar Brincos","Retirar Pulso esquerdo","Retirar Pulso direito"}, removeScroller, function(cb)  removeScroller = cb end)) then
                if removeScroller ~= 3 and removeScroller ~= 4 then
                    ClearPedProp(PlayerPedId(), tonumber(removeScroller))
                elseif removeScroller == 3 then
                    ClearPedProp(PlayerPedId(), 6)
                else
                    ClearPedProp(PlayerPedId(), 7)
                end
            end
        end)
        Menu.addOption("clothing_accessories", function()
            if(Menu.Option("Aleatório"))then
                SetPedRandomProps(PlayerPedId())
            end
        end)
    end
end

function overlays(title)
    Menu.SetupMenu("clothing_overlays", title)
    Menu.Switch("clothing_main", "clothing_overlays")
    if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") or GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then
        componentScroller = 0
        subComponentScroller = GetPedHeadOverlayValue(PlayerPedId(), componentScroller)
        Menu.addOption("clothing_overlays", function()
            if(Menu.ScrollBarString({"Blemishes","Facial Hair","Eyebrows","Ageing","Makeup","Blush","Complexion","Sun Damage","Lipstick","Moles/Freckles","Chest hair","Body blemishes","Add Body blemishes"}, componentScroller, function(cb)  componentScroller = cb end)) then
                subComponentScroller = GetPedHeadOverlayValue(PlayerPedId(), componentScroller)
            end
        end)
        Menu.addOption("clothing_overlays", function()
            if(Menu.ScrollBarInt("Components", subComponentScroller, GetNumHeadOverlayValues(PlayerPedId(), componentScroller), function(cb)  subComponentScroller = cb end)) then
                SetPedHeadOverlay(PlayerPedId(), componentScroller, subComponentScroller, 1.0)
                opacityScroller = 1.0
            end
        end)
        Menu.addOption("clothing_overlays", function()
            if(Menu.ScrollBarInt("Opacity", opacityScroller, 10, function(cb)  opacityScroller = cb end)) then
                SetPedHeadOverlay(PlayerPedId(), componentScroller, subComponentScroller, tonumber(opacityScroller/10))
                player_data.overlays.opacity[componentScroller+1] = tonumber(opacityScroller/10)
            end
        end)
        Menu.addOption("clothing_overlays", function()
            if(Menu.ScrollBarInt("Colours", colourScroller, 63, function(cb)  colourScroller = cb end)) then
                local colourType = 0
                if componentScroller == 1 or componentScroller == 2 or componentScroller == 10 then colourType = 1 elseif componentScroller == 5 or componentScroller == 8 then colourType = 2 else colourType = 0 end
                SetPedHeadOverlayColor(PlayerPedId(), componentScroller, colourType, colourScroller, colourScroller)
                player_data.overlays.colours[componentScroller+1] = {colourType = colourType, colour = colourScroller}
            end
        end)
    else
    end
end

function save()
    player_data.model = GetEntityModel(PlayerPedId())
    player_data.new = false
    for i = 0, 11 do
        player_data.clothing.drawables[i+1] = GetPedDrawableVariation(PlayerPedId(), i)
        if i ~= 2 then
            player_data.clothing.textures[i+1] = GetPedTextureVariation(PlayerPedId(), i)
        end
        player_data.clothing.palette[i+1] = GetPedPaletteVariation(PlayerPedId(), i)
    end
    for i = 0, 7 do
        player_data.props.drawables[i+1] = GetPedPropIndex(PlayerPedId(), i)
        player_data.props.textures[i+1] = GetPedPropTextureIndex(PlayerPedId(), i)
    end
    for i = 0, 12 do
        player_data.overlays.drawables[i+1] = GetPedHeadOverlayValue(PlayerPedId(), i)
    end

    if player_data.clothing.drawables[12] == 55 and GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") then player_data.clothing.drawables[12] = 56 SetPedComponentVariation(PlayerPedId(), 11, 56, 0, 2) end
    if player_data.clothing.drawables[12] == 48 and GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then player_data.clothing.drawables[12] = 49 SetPedComponentVariation(PlayerPedId(), 11, 49, 0, 2) end

    TriggerServerEvent("clothes:save", player_data)
end

AddEventHandler("clothes:changemodel", function(skin)
    local model = GetHashKey(skin)
    if IsModelInCdimage(model) and IsModelValid(model) then
        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(0)
        end
        SetPlayerModel(PlayerId(), model)
        if skin ~= "mp_f_freemode_01" and skin ~= "mp_m_freemode_01" then
            SetPedRandomComponentVariation(PlayerPedId(), true)
        else
            SetPedComponentVariation(PlayerPedId(), 11, 0, 240, 0)
            SetPedComponentVariation(PlayerPedId(), 8, 0, 240, 0)
            SetPedComponentVariation(PlayerPedId(), 11, 6, 1, 0)
        end
        SetModelAsNoLongerNeeded(model)
        TriggerEvent('esx:restoreLoadout')
    else
    end
end)

AddEventHandler("clothes:setComponents", function()
    if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") or GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then
        for i = 0, 11 do
            if i == 0 then
                SetPedHeadBlendData(PlayerPedId(), player_data.clothing.drawables[i+1], player_data.clothing.drawables[i+1], 0, player_data.clothing.drawables[i+1], player_data.clothing.drawables[i+1], 0, 0.5, 0.5, 0.0, false)
            elseif i == 2 then
                SetPedComponentVariation(PlayerPedId(), i, player_data.clothing.drawables[i+1], 0, 1)
                SetPedHairColor(PlayerPedId(), player_data.clothing.textures[i+1], player_data.clothing.textures[i+1])
            else
                SetPedComponentVariation(PlayerPedId(), i, player_data.clothing.drawables[i+1], player_data.clothing.textures[i+1], player_data.clothing.palette[i+1])
            end
        end
        for i = 0, 7 do
            SetPedPropIndex(PlayerPedId(), i, player_data.props.drawables[i+1], player_data.props.textures[i+1], false)
        end
        for i = 0, 12 do
            SetPedHeadOverlay(PlayerPedId(), i, player_data.overlays.drawables[i+1], player_data.overlays.opacity[i+1])
            SetPedHeadOverlayColor(PlayerPedId(), i, player_data.overlays.colours[i+1].colourType, player_data.overlays.colours[i+1].colour, player_data.overlays.colours[i+1].colour)
        end
    else
        for i = 0, 11 do
            SetPedComponentVariation(PlayerPedId(), i, player_data.clothing.drawables[i+1], player_data.clothing.textures[i+1], player_data.clothing.palette[i+1])
        end
        for i = 0, 7 do
            SetPedPropIndex(PlayerPedId(), i, player_data.props.drawables[i+1], player_data.props.textures[i+1], false)
        end
    end
    TriggerServerEvent("clothes:loaded")
end)

-- CARREGAR SKIN --
RegisterCommand("carregarped", function()
    TriggerEvent("clothes:comandoroupa")
end, false)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/carregarped', 'Carregar Ped')
end)

RegisterNetEvent("clothes:comandoroupa")
AddEventHandler("clothes:comandoroupa", function()
    local playerPed = PlayerPedId()
    if IsEntityDead(playerPed) then

    else
        TriggerServerEvent("clothes:spawn")
    end
end)

RegisterNetEvent("clothes:spawn")
AddEventHandler("clothes:spawn", function(data)
    player_data = data
    local model = player_data.model

    if IsModelInCdimage(model) and IsModelValid(model) then
        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(0)
        end

        SetPlayerModel(PlayerId(), model)

        if skin ~= "mp_f_freemode_01" and skin ~= "mp_m_freemode_01" then
            SetPedRandomComponentVariation(PlayerPedId(), true)
        else
            SetPedComponentVariation(PlayerPedId(), 11, 0, 240, 0)
            SetPedComponentVariation(PlayerPedId(), 8, 0, 240, 0)
            SetPedComponentVariation(PlayerPedId(), 11, 6, 1, 0)
        end

        SetModelAsNoLongerNeeded(model)

        TriggerEvent('esx:restoreLoadout')

        if not player_data.new then
            TriggerEvent("clothes:setComponents")
        else
            TriggerServerEvent("clothes:loaded")
        end
    end
end)

RegisterNetEvent("clothes:openmenucop")
AddEventHandler("clothes:openmenucop", function()
  GUI.maxVisOptions = 20
  titleTextSize = {0.85, 0.80} ------------ {p1, Size}
  titleRectSize = {0.23, 0.085} ----------- {Width, Height}
  optionTextSize = {0.5, 0.5} ------------- {p1, Size}
  optionRectSize = {0.23, 0.035} ---------- {Width, Height}
  menuX = 0.745 ----------------------------- X position of the menu
  menuXOption = 0.11 --------------------- X postiion of Menu.Option text
  menuXOtherOption = 0.06 ---------------- X position of Bools, Arrays etc text
  menuYModify = 0.1500 -------------------- Default: 0.1174   ------ Top bar
  menuYOptionDiv = 4.285 ------------------ Default: 3.56   ------ Distance between buttons
  menuYOptionAdd = 0.21 ------------------ Default: 0.142  ------ Move buttons up and down
  clothing_menu = not clothing_menu
  OpenClothesCop()
end)

function customiseCop(title)
    Menu.SetupMenu("clothing_customiseCop", title)
    Menu.Switch("clothing_main", "clothing_customiseCop")
    if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") or GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then
        componentScroller = 0
        subComponentScroller = GetPedDrawableVariation(PlayerPedId(), componentScroller)
        textureScroller = GetPedTextureVariation(PlayerPedId(), componentScroller)
        paletteScroller = GetPedPaletteVariation(PlayerPedId(), componentScroller)

        Menu.addOption("clothing_customiseCop", function()
            if(Menu.ScrollBarString({"Cabeça","Máscara","Cabelo","Braços","Calças","Paraquedas","Sapatos","Gravatas e colares","T-shirt","Colete","Decals","Torso"}, componentScroller, function(cb)  componentScroller = cb end)) then
                subComponentScroller = GetPedDrawableVariation(PlayerPedId(), componentScroller)
                textureScroller = GetPedTextureVariation(PlayerPedId(), componentScroller)
                paletteScroller = GetPedPaletteVariation(PlayerPedId(), componentScroller)
            end
        end)

            Menu.addOption("clothing_customiseCop", function()
                if componentScroller == 3 or componentScroller == 4 or componentScroller == 6 or componentScroller == 7 or componentScroller == 8 or componentScroller == 9 or componentScroller == 11 then
                    if(Menu.ScrollBarInt("Componentes", subComponentScroller, GetNumberOfPedDrawableVariations(PlayerPedId(), componentScroller), function(cb)  subComponentScroller = cb end)) then
                        if componentScroller == 0 then
                            SetPedHeadBlendData(PlayerPedId(), subComponentScroller, subComponentScroller, 0, subComponentScroller, subComponentScroller, 0, 0.5, 0.5, 0.0, false)
                        end
                        SetPedComponentVariation(PlayerPedId(), componentScroller, 0, 240, 0)
                        SetPedComponentVariation(PlayerPedId(), componentScroller, subComponentScroller, textureScroller, paletteScroller)
                        textureScroller = 0
                        paletteScroller = 0
                    end
                end
            end)

        Menu.addOption("clothing_customiseCop", function()
            if componentScroller == 3 or componentScroller == 4 or componentScroller == 6 or componentScroller == 7 or componentScroller == 8 or componentScroller == 9 or componentScroller == 11 then
                local textureMax = 0
                if componentScroller == 2 then textureMax = GetNumHairColors() else textureMax = GetNumberOfPedTextureVariations(PlayerPedId(), componentScroller, subComponentScroller) end
                if(Menu.ScrollBarInt("Texturas", textureScroller, textureMax, function(cb)  textureScroller = cb end)) then
                    if componentScroller == 2 then
                        SetPedComponentVariation(PlayerPedId(), componentScroller, subComponentScroller, 0, 1)
                        SetPedHairColor(PlayerPedId(), textureScroller, textureScroller)
                        player_data.clothing.textures[3] = textureScroller
                    else
                        SetPedComponentVariation(PlayerPedId(), componentScroller, subComponentScroller, textureScroller, paletteScroller)
                    end
                end
            end
        end)
    end
end

Citizen.CreateThread(function() while true do Citizen.Wait(30000) collectgarbage() end end) -- Fix RAM leaks by collecting garbage


--GARRIDO PED--
RegisterCommand("pedgarrido", function()
    TriggerEvent("clothes:comandogarrido")
end, false)

RegisterNetEvent("clothes:comandogarrido")
AddEventHandler("clothes:comandogarrido", function()
    local playerPed = PlayerPedId()
    if IsEntityDead(playerPed) then

    else
        TriggerServerEvent("clothes:spawn")
    end
end)

RegisterNetEvent("clothes:spawngarrido")
AddEventHandler("clothes:spawngarrido", function(data)
    player_data = data
    local model = player_data.model

    if IsModelInCdimage(model) and IsModelValid(model) then
        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(0)
        end

        SetPlayerModel(PlayerId(), model)

        if skin ~= "mp_f_freemode_01" and skin ~= "mp_m_freemode_01" then
            SetPedRandomComponentVariation(PlayerPedId(), true)
        else
            SetPedComponentVariation(PlayerPedId(), 2, 3, 0, 0)
            SET_PED_HELMET_PROP_INDEX(PlayerPedId(), 3)
        end

        SetModelAsNoLongerNeeded(model)

        TriggerEvent('esx:restoreLoadout')

        if not player_data.new then
            TriggerEvent("clothes:setComponents")
        else
            TriggerServerEvent("clothes:loaded")
        end
    end
end)

