Config = {}

Config.objects = {
	SitAnimation = {anim='PROP_HUMAN_SEAT_CHAIR_MP_PLAYER'},
	locations = {
		{object="v_serv_ct_chair02", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.0, direction=168.0, hash = nil},
		{object="prop_off_chair_04", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, hash = nil},
		{object="prop_off_chair_03", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, hash = nil},
		{object="prop_off_chair_05", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, hash = nil},
		{object="v_club_officechair", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, hash = nil},
		{object="v_ilev_leath_chr", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, hash = nil},
		{object="v_corp_offchair", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, hash = nil},
		{object="prop_table_03_chr", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, hash = nil},
		{object="prop_off_chair_01", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.5, direction=168.0, hash = nil},
		{object=nil, verticalOffsetX=0.0, verticalOffsetY=0.10, verticalOffsetZ=0.1, direction=180.0, hash = -853526657},
		{object=nil, verticalOffsetX=0.0, verticalOffsetY=0.10, verticalOffsetZ=0.1, direction=180.0, hash = -1531508740},
	}
}

-- // OPTIMIZE PAIR!
local ObjectAr = {}
local currObject = 0

-- // BASIC
local InUse = false
local PlyLastPos = 0


CreateThread(function()
    local sleep = 2000
    while true do
        Wait(sleep)
        if (InUse == false) then
            plyCoords = GetEntityCoords(PlayerPedId(), 0)
            local oObject = nil
            for k, v in pairs(Config.objects.locations) do
                if v.object ~= nil then
                    oObject = GetClosestObjectOfType(plyCoords.x, plyCoords.y, plyCoords.z, 1.0, GetHashKey(v.object), 0, 0, 0)
                elseif v.hash ~= nil then
                    oObject = GetClosestObjectOfType(plyCoords.x, plyCoords.y, plyCoords.z, 1.0, v.hash, 0, 0, 0)
                end
                if (oObject ~= 0) then
                    local oObjectCoords = GetEntityCoords(oObject)
                    local ObjectDistance = #(vector3(oObjectCoords) - plyCoords)
                    if (ObjectDistance < 2) and DoesEntityExist(oObject) then
                        currObject = oObject
                        ObjectAr = {
                            fObject = oObject,
                            fObjectCoords = oObjectCoords,
                            fObjectcX = v.verticalOffsetX,
                            fObjectcY = v.verticalOffsetY,
                            fObjectcZ = v.verticalOffsetZ,
                            fObjectDir = v.direction,
                            fObjectIsBed = v.bed
                        }
                        sleep = 7
                        break
                    end
                else
                    sleep = 2000
                end
                Citizen.Wait(250)
            end
        end
    end
end)


RegisterNetEvent('tqrp_base:Client:RequestChair')
RegisterNetEvent('tqrp_base:Client:RequestChair', function()
	if ObjectAr.fObject ~= nil then
		ply = PlayerPedId()
		plyCoords = GetEntityCoords(ply, 0)
		ObjectCoords = ObjectAr.fObjectCoords
		local ObjectDistance = #(vector3(ObjectCoords) - plyCoords)
		if (ObjectDistance < 1.8 and not InUse) then
			if not inUse then
				TriggerServerEvent('tqrp_base:Server:EnterChair', ObjectAr, ObjectCoords)
			else
				inUse = false
				TriggerServerEvent('tqrp_base:Server:LeaveChair', ObjectAr.fObjectCoords)
				--FreezeEntityPosition(ObjectAr.fObject, false)
				ClearPedTasksImmediately(ply)
				FreezeEntityPosition(ply, false)
				
				local x, y, z = table.unpack(PlyLastPos)
				if GetDistanceBetweenCoords(x, y, z, plyCoords) < 10 then
					SetEntityCoords(ply, PlyLastPos)
				end
			end
		end
	end
end)


RegisterNetEvent('tqrp_base:Client:ChairAnimation')
AddEventHandler('tqrp_base:Client:ChairAnimation', function(v, objectcoords)
    local object = v.fObject
    local vertx = v.fObjectcX
    local verty = v.fObjectcY
    local vertz = v.fObjectcZ
    local dir = v.fObjectDir
    local objectcoords = objectcoords
    
    local ped = PlayerPedId()
    PlyLastPos = GetEntityCoords(ped)
    --FreezeEntityPosition(object, true)
    FreezeEntityPosition(ped, true)
	inUse = true
	
	if Config.objects.SitAnimation.dict ~= nil then
		SetEntityCoords(ped, objectcoords.x, objectcoords.y, objectcoords.z + 0.5)
		SetEntityHeading(ped, GetEntityHeading(object) - 180.0)
		local dict = Config.objects.SitAnimation.dict
		local anim = Config.objects.SitAnimation.anim
		
		AnimLoadDict(dict, anim, ped)
	else
		TaskStartScenarioAtPosition(ped, Config.objects.SitAnimation.anim, objectcoords.x + vertx, objectcoords.y + verty, objectcoords.z - vertz, GetEntityHeading(object) + dir, 0, true, true)
	end
end)

function Animation(dict, anim, ped)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end
    
    TaskPlayAnim(ped, dict, anim, 8.0, 1.0, -1, 1, 0, 0, 0, 0)
end
