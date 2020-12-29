local oArray = {}
local oPlayerUse = {}


AddEventHandler('playerDropped', function()
    local oSource = source
    if oPlayerUse[oSource] ~= nil then
        oArray[oPlayerUse[oSource]] = nil
        oPlayerUse[oSource] = nil
    end
end)


RegisterServerEvent('tqrp_base:Server:EnterChair')
AddEventHandler('tqrp_base:Server:EnterChair', function(object, objectcoords)
    local oSource = source
    oPlayerUse[oSource] = objectcoords
    oArray[objectcoords] = true
    TriggerClientEvent('tqrp_base:Client:ChairAnimation', oSource, object, objectcoords)
end)


RegisterServerEvent('tqrp_base:Server:LeaveChair')
AddEventHandler('tqrp_base:Server:LeaveChair', function(objectcoords)
    local oSource = source
    oPlayerUse[oSource] = nil
    oArray[objectcoords] = nil
end)

