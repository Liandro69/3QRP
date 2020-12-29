-- ModFreakz
-- For support, previews and showcases, head to https://discord.gg/ukgQa5K

MF_MobileMeth = {}
local MFM = MF_MobileMeth
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)

MFM.Version = '1.0.11'

Citizen.CreateThread(function(...)
  while not ESX do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)
    Citizen.Wait(10)
  end
end)

-- For the door.
MFM.ShowBlip = false

-- Police count and name
MFM.PoliceJobName = "police"
MFM.MinPolCount   = 0

-- Minutes.
MFM.CookTimerA = 0.8 -- prepare ingredients
MFM.CookTimerB = 0.5 -- cook meth
MFM.CookTimerC = 0.3 -- cool meth
MFM.CookTimerD = 0.6 -- package meth

-- The door.
MFM.HintLocation      =   vector4(6.42,-1816.55,25.35, 51.23)

-- Possible spawns.
MFM.TruckLocations    =   {
  [1] = vector4(1060.25,-2409.26,29.96,82.70),
  [2] = vector4(-1102.33,-2039.85,13.29,309.93),
  [3] = vector4(123.30,-2580.88,6.0,177.79),
}

-- Possible dropoffs.
MFM.DropoffLocations  =   {
  [1] = vector3(1372.69,3617.62,34.89),
  [2] = vector3(2343.59,2612.63,46.66),
  [3] = vector3(-1889.90,2045.38,140.87),
}

-- Models.
MFM.TruckModels = {
  [1] = 'boxville',
  [2] = 'boxville2',
  [3] = 'boxville3',
  [4] = 'boxville4',
}

-- Draw text at this distance.
MFM.DrawTextDist          =   0.5

-- How long the note hangs around for (when knocking on door).
MFM.NotificationTime      =   5

-- How long police have to track a notification (seconds).
MFM.TrackableNotifyTimer  =   15

-- Spawn truck at x meters.
MFM.TruckSpawnDist        =   50.0

-- Veh speed (KPH I think?).
MFM.MinSpeedForCook       =   20.0

-- Vehicle can stop for x amount of seconds before police get notified.
MFM.MaxVehicleStopTime    =   20
