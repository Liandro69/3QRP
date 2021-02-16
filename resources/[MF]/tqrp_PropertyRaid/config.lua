-- ModFreakz
-- For support, previews and showcases, head to https://discord.gg/ukgQa5K

MF_PropertyRaid = {}
local MFR = MF_PropertyRaid

MFR.Version = '1.0.10'

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)
Citizen.CreateThread(function(...)
  while not ESX do 
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end) 
    
  end
end)

MFR.DrawTextDist = 10.0
MFR.InteractDist = 03.0
MFR.PoliceJobName = 'police'