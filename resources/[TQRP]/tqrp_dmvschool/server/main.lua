ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('tqrp_dmvschool:loadLicense', function(source, cb)
	local _source = source
	TriggerEvent('tqrp_license:getLicenses', _source, function(licenses)
		cb(licenses)
	end)
end)

RegisterNetEvent('tqrp_dmvschool:addLicense')
AddEventHandler('tqrp_dmvschool:addLicense', function(type)
	local _source = source
	TriggerEvent('tqrp_license:addLicense', _source, type)
end)
