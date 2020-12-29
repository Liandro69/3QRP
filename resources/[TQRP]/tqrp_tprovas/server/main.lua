local provas = {}
local provascoletadas = {}

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('tqrp_provas:criarProva_sv')
AddEventHandler('tqrp_provas:criarProva_sv', function(x, y, z, tipo, text, dna_blood, dna_weapon)
	TriggerClientEvent("tqrp_provas:criarProva_cl", -1, x, y, z, tipo, text, dna_blood, dna_weapon)
    table.insert(provas, {tipo = tipo, value = text, x = x , y = y , z = z, dna_blood = dna_blood, dna_weapon = dna_weapon})
end)

RegisterServerEvent('tqrp_provas:saveProva_sv')
AddEventHandler('tqrp_provas:saveProva_sv', function(x, y, z, tipo, dna_blood, dna_weapon)
	local id = math.random(3000, 7000)
    provascoletadas[id] = {x = x , y = y , z = z, tipo = tipo, dna_blood = dna_blood, dna_weapon = dna_weapon, analisado = false}
	TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'success', text = 'Prova recolhida! Número da prova: '.. id, length = 10000})
end)

RegisterServerEvent('tqrp_provas:coloc_prova_sv')
AddEventHandler('tqrp_provas:coloc_prova_sv', function(num2)
	local num = tonumber(num2)
	local _source = source
	if (provascoletadas[num] ~= nil) then
		if not provascoletadas[num].analisado then
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'success', text = 'Prova enviada para análise.'})
			Wait(300000)
			provascoletadas[num].analisado = true
			TriggerClientEvent("mythic_notify:client:SendAlert", _source, {type = 'success', text = "Prova Analisada! Prova número: " .. num})
		else
			TriggerClientEvent("mythic_notify:client:SendAlert", _source, {type = 'error', text = "Essa prova já foi analisada!"})
		end
	else
		TriggerClientEvent("mythic_notify:client:SendAlert", _source, {type = 'error', text = "Prova inexistente na base de dados!"})
	end
end)

RegisterServerEvent('tqrp_provas:verif_prova_sv')
AddEventHandler('tqrp_provas:verif_prova_sv', function(num2)
	local num = tonumber(num2)
	local _source = source
	if (provascoletadas[num] ~= nil) then
		if (provascoletadas[num].analisado == false) then
			TriggerClientEvent("mythic_notify:client:SendAlert", _source, {type = 'error', text = "Prova ainda não colocada para análise ou já em análise!"})
		else
			if (provascoletadas[num].tipo == 4) then
				TriggerClientEvent("mythic_notify:client:SendAlert", _source, {type = 'success', text = "Impressão Digital presente na prova pertence a: ".. provascoletadas[num].dna_blood, length = 10000})
			end
			if (provascoletadas[num].tipo == 2) then
				TriggerClientEvent("mythic_notify:client:SendAlert", _source, {type = 'success', text = "ADN presente na prova pertence a: ".. provascoletadas[num].dna_blood, length = 10000})
			end
			if (provascoletadas[num].tipo == 1) then
				TriggerClientEvent("mythic_notify:client:SendAlert", _source, {type = 'success', text = "Carregador analisado: ".. provascoletadas[num].dna_weapon, length = 10000})
			end
			if (provascoletadas[num].tipo == 0) then
				TriggerClientEvent("mythic_notify:client:SendAlert", _source, {type = 'success', text = "Bala analisada: ".. provascoletadas[num].dna_weapon, length = 10000})
			end
		end
	else
		TriggerClientEvent("mythic_notify:client:SendAlert", _source, {type = 'error', text = "Prova inexistente na base de dados!"})
	end
end)

RegisterServerEvent('tqrp_provas:deleteProvas_sv')
AddEventHandler('tqrp_provas:deleteProvas_sv', function(x, y, z)
    for i, v in ipairs(provas) do
        if v.x == x and v.y == y and v.z == z then 
          provas[i] = {}
		  TriggerClientEvent("tqrp_provas:deleteProvas_cl", -1, x, y, z)
        end
    end
end)

ESX.RegisterServerCallback('tqrp_provas:syncProvas', function(source, cb)
    cb(provas)
end)

ESX.RegisterServerCallback('tqrp_provas:getPlayerData', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = GetPlayerIdentifiers(source)[1]
		local result = MySQL.Sync.fetchAll('SELECT firstname, lastname, sex, dateofbirth, height FROM users WHERE identifier = @identifier', {
			['@identifier'] = identifier
		})

		local firstname = result[1].firstname
		local lastname  = result[1].lastname

		local name = firstname.. " " ..lastname

		local data = {
			dna_blood = name
		}
		cb(data)
end)

ESX.RegisterServerCallback('tqrp_provas:getADNCivName', function(source, cb ,num)
	local owner = false

	for i, v in ipairs(provascoletadas) do
		if v.tipo == 4 and i == num then
			nome = owner
		end
	end
	
	cb(nome)
end)