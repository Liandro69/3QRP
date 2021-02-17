local ultimaAccion = nil
local currentGarage = nil
local fetchedVehicles = {}
local fueravehicles = {}

function MenuGarage(action)
    if not action then action = ultimaAccion; elseif not action and not ultimaAccion then action = "menu"; end
    ped = GetPlayerPed(-1);
    MenuTitle = "Garage"
    ClearMenu()
    ultimaAccion = action
    Citizen.Wait(150)
    DeleteActualVeh()
    if action == "menu" then
        Menu.addButton("Ver veículos","ListeVehicule",nil)
        Menu.addButton("Perdidos","recuperar",nil)
        Menu.addButton("Fechar","CloseMenu",nil) 
    elseif action == "vehicle" then
        PutInVehicle()
    end
end

function MenuApreendidos(action)
    if not action then action = ultimaAccion; elseif not action and not ultimaAccion then action = "menu"; end
    ped = GetPlayerPed(-1);
    MenuTitle = "Apreendidos"
    ClearMenu()
    ultimaAccion = action
    Citizen.Wait(150)
    DeleteActualVeh()
    if action == "menu" then
        Menu.addButton("Apreendidos","apreend",nil)
        Menu.addButton("Fechar","CloseMenu",nil) 
    elseif action == "vehicle" then
        exports['mythic_notify']:SendAlert('error', 'Queres mesmo colocar o teu carro nos apreendidos???')	
        CloseMenu()
    end
end

function EnvioVehLocal(veh)
    local slots = {}
    for c,v in pairs(veh) do
        table.insert(slots,{["garage"] = v.garage, ["vehiculo"] = json.decode(v.vehicle)})
    end
    fetchedVehicles = slots
end

function EnvioVehFuera(data)
    local slots = {}
    for c,v in pairs(data) do
        if v.state == 0 or v.state == 2 or v.state == false or v.garage == nil then
            table.insert(slots,{["vehiculo"] = json.decode(v.vehicle),["state"] = v.state})
        end
    end
    fueravehicles = slots
end

function EnvioVehApreend(data)
    local slots = {}
    for c,v in pairs(data) do
        table.insert(slots,{["vehiculo"] = json.decode(v.vehicle),["finance"] = v.finance})
    end
    apreendvehs = slots
end

function recuperar()
    currentGarage = cachedData["currentGarage"]

    if not currentGarage then
        CloseMenu()
        return 
    end

   HandleCamera(currentGarage, true)
   ped = GetPlayerPed(-1);
   MenuTitle = "Recuperar :"
   ClearMenu()
   Menu.addButton("Voltar","MenuGarage",nil)
    for c,v in pairs(fueravehicles) do
        local vehicle = v.vehiculo
        if v.state == 0 or v.state == false then
            Menu.addButton("Recuperar | "..GetDisplayNameFromVehicleModel(vehicle.model), "pagorecupero", vehicle, "Perdido", " Motor : " .. round(vehicle.engineHealth) /10 .. "%", "Combustível : " .. round(vehicle.fuelLevel) .. "%","SpawnLocalVehicle")
        end
    end 
end

function apreend()
    currentGarage = cachedData["currentGarage"]

    if not currentGarage then
        CloseMenu()
        return 
    end

   HandleCamera(currentGarage, true)
   ped = GetPlayerPed(-1);
   MenuTitle = "Apreendidos :"
   ClearMenu()
   Menu.addButton("Voltar","MenuApreendidos",nil)
    for c,v in pairs(apreendvehs) do
        local vehicle = v.vehiculo
        Menu.addButton("Pagar | "..GetDisplayNameFromVehicleModel(vehicle.model), "pagoapreend", vehicle, "Montante a Pagar: "..v.finance, " Matrícula : " .. vehicle.plate, " ","SpawnLocalVehicle")
    end 
end

function pagoapreend(data)
    ESX.TriggerServerCallback("betrayed_garage:retirarApreend", function(cb)
        if cb then
            SpawnVehicle({data, nil}, false)
            exports['mythic_notify']:SendAlert('success', 'O teu veiculo não se encontra mais apreendido!')	
            TriggerServerEvent('tqrp_base:buylog', "Financimento (TIROU DOS APREENDIDOS)", "Modelo: "..GetDisplayNameFromVehicleModel(data.model).."\nMatricula: "..data.plate.."\nPagou :"..cb, 1467323)
            CloseMenu()
        elseif not cb then
            exports['mythic_notify']:SendAlert('error', 'Não tens dinheiro suficiente!')	
        else
            exports['mythic_notify']:SendAlert('error', 'Ocorreu um Erro!')	
        end
    end,data)
end

function pagorecupero(data)
    ESX.TriggerServerCallback('betrayed_garage:checkMoney', function(hasEnoughMoney)
        if hasEnoughMoney == true then
            SpawnVehicle({data, nil}, true)
        elseif hasEnoughMoney == "deudas" then
            recuperar()
            exports['mythic_notify']:SendAlert('error', 'Tens dívidas superiores a $2000, não podes pedir o resgate até as pagares!')
        else
            recuperar()
            exports['mythic_notify']:SendAlert('error', 'Não tens dinheiro suficiente')							
        end
    end)
end


function AbrirMenuGuardar()
    currentGarage = cachedData["currentGarage"]
    if not currentGarage then
        CloseMenu()
        return 
    end
   ped = GetPlayerPed(-1);
   MenuTitle = "Save :"
   ClearMenu()
   Menu.addButton("Fechar","CloseMenu",nil)
   Menu.addButton("GARAGEM: "..currentGarage.." | Guardar", "SaveInGarage", currentGarage, "", "", "","DeleteActualVeh")
end

function ListeVehicule()
    currentGarage = cachedData["currentGarage"]

    if not currentGarage then
        CloseMenu()
        return 
    end

   HandleCamera(currentGarage, true)
   ped = GetPlayerPed(-1);
   MenuTitle = "My vehicles :"
   ClearMenu()
   Menu.addButton("Voltar","MenuGarage",nil)
    for c,v in pairs(fetchedVehicles) do
        if v then
            local vehicle = v.vehiculo
            Menu.addButton("" ..(vehicle.plate).." | "..GetDisplayNameFromVehicleModel(vehicle.model), "OptionVehicle", {vehicle,nil}, "Guardado - Garagem: "..currentGarage.."", " Motor : " .. round(vehicle.engineHealth) /10 .. "%", "Combustível : " .. round(vehicle.fuelLevel) .. "%","SpawnLocalVehicle")
        end
    end
end

function round(n)
    if not n then return 0; end
    return n % 1 >= 0.5 and math.ceil(n) or math.floor(n)
end

function OptionVehicle(data)
   MenuTitle = "Opções :"
   ClearMenu()
   Menu.addButton("Retirar", "SpawnVehicle", data)
   Menu.addButton("Voltar", "ListeVehicule", nil)
end

function CloseMenu()
    HandleCamera(currentGarage, false)
	TriggerEvent("inmenu",false)
    Menu.hidden = true
end

function LocalPed()
	return GetPlayerPed(-1)
end
