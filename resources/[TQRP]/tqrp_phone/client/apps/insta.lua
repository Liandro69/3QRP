local frontCam = false
local processing = false

function CellFrontCamActivate(activate)
    return Citizen.InvokeNative(0x2491A93618B7D838, activate)
end

RegisterNUICallback('phoneAnimInsta', function(data, cb)
    PhonePlayAnim('text', false, true)
end)

RegisterNUICallback('takeInstaPhoto', function(data, cb)
    CreateMobilePhone(1)
    CellCamActivate(true, true)
    takeInsPro = true
    Citizen.Wait(0)
    SetNuiFocus(false, false)
    SendNUIMessage( { action = 'hide' } )
    while takeInsPro do
        Citizen.Wait(7)

        if IsControlJustPressed(1, 27) then -- SELFIE MODE
            frontCam = not frontCam
            CellFrontCamActivate(frontCam)
        elseif IsDisabledControlJustPressed(0, 177) then -- CANCEL
            DestroyMobilePhone()
            CellCamActivate(false, false)
            cb(nil)
            takeInsPro = false
            SetNuiFocus(true, true)
            SendNUIMessage( { action = 'show' } )
            break
        elseif IsControlJustPressed(1, 24) then -- TAKE PHOTO
            if not processing then
                processing = true
                takeInsPro = false
                SetNuiFocus(true, true)
                exports['screenshot-basic']:requestScreenshotUpload(InstaLink, 'files[]', function(data)
                    local resp = json.decode(data)
                    DestroyMobilePhone()
                    CellCamActivate(false, false)
                    processing = false
                    cb(resp.files[1].url)
                end)
            end
        end
        HideHudComponentThisFrame(7)
        HideHudComponentThisFrame(8)
        HideHudComponentThisFrame(9)
        HideHudComponentThisFrame(6)
        HideHudComponentThisFrame(19)
        HideHudAndRadarThisFrame()

        ------------------------------
    end
    Citizen.Wait(1000)
    PhonePlayAnim('text', false, true)
end)



RegisterNUICallback('SumbitNewInsta', function(data, cb)
    ESX.TriggerServerCallback('tqrp_phone:server:SumbitNewInsta', function(callback)
        cb(callback)
    end, data.newInsta)
end)

RegisterNetEvent('tqrp_phone:client:RecieveNewInsta')
AddEventHandler('tqrp_phone:client:RecieveNewInsta', function(insta)
    SendNUIMessage({
     	action = 'receiveInsta',
     	data = {
	        identifier = insta.identifier,
	        author = insta.author,
	        descricao = insta.descricao,
	        likes = insta.likes,
	        photo = insta.photo,
        }
    })
end)

RegisterNUICallback('DeleteInsta', function( data, cb )
    ESX.TriggerServerCallback('tqrp_phone:server:DeleteInsta', function(callback)
        cb(callback)
    end, data.link)
end)

RegisterNetEvent('tqrp_phone:client:RemoveInsta')
AddEventHandler('tqrp_phone:client:RemoveInsta', function(photo)
    SendNUIMessage({
        action = 'removeInsta',
        data = {
        	photo = photo,
        }
    })
end)