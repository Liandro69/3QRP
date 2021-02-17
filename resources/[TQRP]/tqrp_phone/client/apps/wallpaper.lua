RegisterNUICallback( 'SaveWallpaper', function( data, cb )
	TriggerServerEvent('tqrp_phone:server:SaveWallpaper', 'SaveWallpaper', data.wallpaper)
end)