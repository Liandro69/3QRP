ESX        = nil
percent    = false
searching  = false
cachedBins = {}
closestBin = {
    'prop_dumpster_01a',
    'prop_dumpster_02a',
    'prop_dumpster_02b',
    'prop_bin_01a',
    'prop_bin_03a',
    'prop_bin_05a',
	'prop_bin_02a',
    'prop_bin_04a',
    'prop_bin_08open',
	'prop_bin_07a',
    'prop_bin_07d',
    'prop_bin_06a',
	'prop_bin_delpiero',
    'prop_bin_delpiero_b',
    'prop_bin_beach_01a',
	'prop_dumpster_3a',
    'prop_dumpster_4a',
    'prop_dumpster_4b',
	'prop_cs_dumpster_01a',
    'prop_dumpster_t',
    'prop_bin_07c',
    'prop_bin_08a',
    'prop_bin_07b'
}

--[[closestBin = {
    [1] = {'prop_bin_07c', 'prop_bin_07d' },
    [2] = {'prop_bin_08a', 'prop_bin_08open' },
    [3] = {'prop_bin_07b', 'prop_bin_07a' },
    [4] = {'prop_bin_delpiero_b', 'prop_bin_delpiero' },
    [5] = {'prop_dumpster_01a', 'p_dumpster_t' },
    [6] = {'prop_dumpster_4a', 'prop_cs_dumpster_01a' },
    [7] = {'prop_dumpster_3a', 'prop_cs_dumpster_01a' }
}]]

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(10)

		TriggerEvent("esx:getSharedObject", function(library)
			ESX = library
		end)
    end

    if ESX.IsPlayerLoaded() then
		ESX.PlayerData = ESX.GetPlayerData()
	end
end)

RegisterNetEvent("tqrp_base:procurar")
AddEventHandler("tqrp_base:procurar", function()
    for i = 1, #closestBin do
        local x = GetClosestObjectOfType(coords, 1.0, GetHashKey(closestBin[i]), false, false, false)
        if DoesEntityExist(x) and not searching and not cachedBins[x] then
            openBin(x)
        end
    end
end)

RegisterCommand("procurar", function()
    TriggerEvent("tqrp_base:procurar")
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(response)
	ESX.PlayerData = response
end)

Citizen.CreateThread(function() while true do Citizen.Wait(30000) collectgarbage() end end) -- Prevents RAM LEAKS :)