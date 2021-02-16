https://www.ModFreakz.net
https://discord.gg/ukgQa5K

Requirements
-- ESX

Installation
- 1. Place MF_SafeCracker folder into resources folder.
- 2. Start MF_SafeCracker in server.cfg
- 3. Join https://discord.gg/ukgQa5K to be activated to use script (user activations happen twice a day in bulk - so it may take upto 24 hours to get this processed)

Usage

Start:
TriggerEvent('MF_SafeCracker:StartMinigame', rewardsTable, stayClosed)

Finish:
AddEventHandler('MF_SafeCracker:EndMinigame', function(didWin)
end)

Example Rewards Table:
rewards = {}
rewards.CashAmount = 10000
rewards.ItemsAmount = 5
rewards.Items = { 'rolex','diamond','gold' }