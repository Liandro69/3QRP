RegisterNUICallback( 'UpdateInfo', function( data, cb )
	--TriggerServerEvent('tqrp_phone:server:UpdateInfo')
	TriggerServerEvent('tqrp_phone:server:SetupInfo')
end)