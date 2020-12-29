tqrp_provas = {}
local MDF = tqrp_provas
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)

Citizen.CreateThread(function(...)
  while not ESX do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)
    Citizen.Wait(0)
  end
end)

MDF.BloodObject = "p_bloodsplat_s"
MDF.ResidueObject = "w_pi_flaregun_shell"

-- JOB Database Table: LABEL
MDF.PoliceJob = "LSPD"
MDF.AmbulanceJob = "SEM"

MDF.DNAAnalyzePos = vector3(334.39, -569.51, 43.32)
MDF.AmmoAnalyzePos = vector3(459.85, -989.64, 30.69)
MDF.DrawTextDist = 3.0
MDF.MaxObjCount = 10