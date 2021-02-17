-- Written by @vjuton#2137 --
-- Set ped to user script --

-- Version: 1.0.2

-- Requirements:

-- Mythic_Notify
-- https://github.com/mythicrp/mythic_notify

--[[

PEDS

s_m_y_cop_01
s_m_y_swat_01
a_m_y_musclbeac_01
s_m_m_movspace_01
s_m_m_movalien_01

--]]


RegisterNetEvent('cop')
AddEventHandler('cop', function()
local ped = 's_m_y_cop_01'
local hash = GetHashKey(ped)
	RequestModel(hash)
	while not HasModelLoaded(hash)
			do RequestModel(hash)
				Citizen.Wait(0)
			end	
			SetPlayerModel(PlayerId(), hash)
		end)

RegisterNetEvent('alien')
AddEventHandler('alien', function()
local ped = 's_m_m_movalien_01'
local hash = GetHashKey(ped)
	RequestModel(hash)
	while not HasModelLoaded(hash)
			do RequestModel(hash)
				Citizen.Wait(0)
			end	
			SetPlayerModel(PlayerId(), hash)
		end)

RegisterNetEvent('space')
AddEventHandler('space', function()
local ped = 's_m_m_movspace_01'
local hash = GetHashKey(ped)
	RequestModel(hash)
	while not HasModelLoaded(hash)
			do RequestModel(hash)
				Citizen.Wait(0)
			end	
			SetPlayerModel(PlayerId(), hash)
		end)

RegisterNetEvent('muscle')
AddEventHandler('muscle', function()
local ped = 'a_m_y_musclbeac_01'
local hash = GetHashKey(ped)
	RequestModel(hash)
	while not HasModelLoaded(hash)
			do RequestModel(hash)
				Citizen.Wait(0)
			end	
			SetPlayerModel(PlayerId(), hash)
		end)

RegisterNetEvent('fat')
AddEventHandler('fat', function()
local ped = 'a_m_m_afriamer_01'
local hash = GetHashKey(ped)
	RequestModel(hash)
	while not HasModelLoaded(hash)
			do RequestModel(hash)
				Citizen.Wait(0)
			end	
			SetPlayerModel(PlayerId(), hash)
		end)

RegisterNetEvent('k9')
AddEventHandler('k9', function()
local ped = 'a_c_pug'
local hash = GetHashKey(ped)
	RequestModel(hash)
	while not HasModelLoaded(hash)
			do RequestModel(hash)
				Citizen.Wait(0)
			end	
			SetPlayerModel(PlayerId(), hash)
		end)

RegisterNetEvent('miniansio')
AddEventHandler('miniansio', function()
local ped = 'Child'
local hash = GetHashKey(ped)
	RequestModel(hash)
	while not HasModelLoaded(hash)
			do RequestModel(hash)
				Citizen.Wait(0)
			end	
			SetPlayerModel(PlayerId(), hash)
		end)

RegisterNetEvent('Goku')
AddEventHandler('Goku', function()
local ped = 'Goku'
local hash = GetHashKey(ped)
	RequestModel(hash)
	while not HasModelLoaded(hash)
			do RequestModel(hash)
				Citizen.Wait(0)
			end	
			SetPlayerModel(PlayerId(), hash)
		end)

RegisterNetEvent('Deadpool')
AddEventHandler('Deadpool', function()
local ped = 'Deadpool'
local hash = GetHashKey(ped)
	RequestModel(hash)
	while not HasModelLoaded(hash)
			do RequestModel(hash)
				Citizen.Wait(0)
			end	
			SetPlayerModel(PlayerId(), hash)
		end)
RegisterNetEvent('donatello')
AddEventHandler('donatello', function()
local ped = 'Don'
local hash = GetHashKey(ped)
	RequestModel(hash)
	while not HasModelLoaded(hash)
			do RequestModel(hash)
				Citizen.Wait(0)
			end	
			SetPlayerModel(PlayerId(), hash)
		end)
RegisterNetEvent('spiderman')
AddEventHandler('spiderman', function()
local ped = '2017_SMHC'
local hash = GetHashKey(ped)
	RequestModel(hash)
	while not HasModelLoaded(hash)
			do RequestModel(hash)
				Citizen.Wait(0)
			end	
			SetPlayerModel(PlayerId(), hash)
		end)
RegisterNetEvent('harley')
AddEventHandler('harley', function()
local ped = 'HarleyB'
local hash = GetHashKey(ped)
	RequestModel(hash)
	while not HasModelLoaded(hash)
			do RequestModel(hash)
				Citizen.Wait(0)
			end	
			SetPlayerModel(PlayerId(), hash)
		end)
RegisterNetEvent('wick')
AddEventHandler('wick', function()
local ped = 'wick'
local hash = GetHashKey(ped)
	RequestModel(hash)
	while not HasModelLoaded(hash)
			do RequestModel(hash)
				Citizen.Wait(0)
			end	
			SetPlayerModel(PlayerId(), hash)
		end)

TriggerEvent('chat:addSuggestion', '/setped', 'Set ped to guy', {
    { name="id", help="Id of the player" },
    { name="Model", help="Peds: fat, cop, swat, muscle, alien, space" }
})

