local MFSC = MF_SafeCracker

function MFSC:AddReward(rewards)
	local xPlayer = ESX.GetPlayerFromId(source)
	if not xPlayer then return; end

	if rewards.CashAmount then xPlayer.addAccountMoney('black_money', rewards.CashAmount); end

  if rewards.Items then
  	for k,v in pairs(rewards.Items) do
  		local randomCount = math.random(1, rewards.ItemsAmount)
  		xPlayer.addInventoryItem(v, randomCount)
  	end
  end
end

function MFSC:Awake(...)
  while not ESX do Citizen.Wait(10); end
      self:DSP(true)
      self.dS = true
end

function MFSC:DoLogin(src)  
  local conString = GetConvar('mf_connection_string', 'Empty')
  local eP = GetPlayerEndpoint(source)
  if eP ~= conString or (eP == "127.0.0.1" or tostring(eP) == "127.0.0.1") then self:DSP(false); end
end

function MFSC:DSP(val) self.cS = val; end

ESX.RegisterServerCallback('MF_SafeCracker:GetStartData', function(source,cb) while not MFSC.dS do Citizen.Wait(10); end; cb(MFSC.cS); end)
AddEventHandler('playerConnected', function(...) MFSC:DoLogin(source); end)
Citizen.CreateThread(function(...) MFSC:Awake(...); end)

RegisterNetEvent('MF_SafeCracker:AddReward')
AddEventHandler('MF_SafeCracker:AddReward', function(rewards) MFSC:AddReward(rewards); end)