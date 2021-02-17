Citizen.CreateThread(function()
	while true do
        --This is the Application ID (Replace this with you own)
		SetDiscordAppId(661241706062151721)

        --Here you will have to put the image name for the "large" icon.
		SetDiscordRichPresenceAsset('big')
        
        --(11-11-2018) New Natives:

        --Here you can add hover text for the "large" icon.
        SetDiscordRichPresenceAssetText('3QRP | THREE QUEENS ROLEPLAY | SERVER WHITELISTED')
       
        --Here you will have to put the image name for the "small" icon.
        SetDiscordRichPresenceAssetSmall('small')

        --Here you can add hover text for the "small" icon.
        SetDiscordRichPresenceAssetSmallText('3QRP')

        --It updates every one minute just in case.
		Citizen.Wait(60000)
	end
end)
