MF_DopePlant = {}
local MFD = MF_DopePlant
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)

Citizen.CreateThread(function(...)
  while not ESX do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)
    Citizen.Wait(100)
  end
end)

MFD.FoodDrainSpeed      = 0.0100
MFD.WaterDrainSpeed     = 0.0100
MFD.QualityDrainSpeed   = 0.0100

MFD.GrowthGainSpeed     = 0.0880
MFD.QualityGainSpeed    = 0.0680

MFD.SyncDist = 50.0
MFD.InteractDist = 1.5
MFD.PoliceJobLabel = "LSPD"
MFD.WeedPerBag = 10
MFD.JointsPerBag = 6
MFD.BagsPerPapers = 1

MFD.PlantTemplate = {
   ["Gender"] = "Female",
  ["Quality"] = 0.0,
   ["Growth"] = 0.0,
    ["Water"] = 14.0,
     ["Food"] = 14.0,
    ["Stage"] = 1,
}

MFD.ItemTemplate = {
     ["Type"] = "Water",
  ["Quality"] = 0.0,
}

MFD.Objects = {
  [1] = "bkr_prop_weed_01_small_01c",
  [2] = "bkr_prop_weed_01_small_01b",
  [3] = "bkr_prop_weed_01_small_01a",
  [4] = "bkr_prop_weed_med_01a",
  [5] = "bkr_prop_weed_med_01b",
  [6] = "bkr_prop_weed_lrg_01a",
  [7] = "bkr_prop_weed_lrg_01b",
}