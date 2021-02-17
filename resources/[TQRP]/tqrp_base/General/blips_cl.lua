--Blips aqui Bucetas 

local blips = {
	 --{title="Escola de Condução (Fechada pra Obras)", colour=31, id=225, x = 231.48, y = 363.38, z = 105.83},
	 {title="Camara Municipal", colour=4, id=475, x = -543.11, y = -207.63, z = 37.65},
	 --{title="The Lost MC", colour=72, id=226, x = 976.53, y = -118.5, z = 74.21},
	 --{title="Levanta te e Ri", colour=75, id=416, x = -430.2, y = 259.19, z = 83},
	 {title="Tribunal", colour=4, id=457, x = 315.1, y = -1622.77, z = 32.53},
	 {title="Banco Maze", colour=4, id=108, x = -1318.32, y = -832.46, z = 16.97},
	 --{title="Beans Coffee", colour=4, id=480, x = -629.06, y = 245.61, z = 81.78},
   {title="AutoLux Concessionária", colour=6, id=225, x = -805.65, y = -225.49, z = 37.22},
   {title="Ammunation", colour=1, id=110, x = -1114.982421875, y = 2694.6545410156, z = 18.554141998291},
   {title="Ammunation", colour=1, id=110, x = 1695.0703125, y = 3756.5126953125, z = 34.70531463623},
   {title="Ammunation", colour=1, id=110, x = -328.69863891602, y = 6080.0971679688, z = 31.454761505127},
	 --{title="Não pagas,Não Mamas", colour=409, id=225, x = -143.319, y = -1352.69, z = 28.33},
  }
      
Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4) 
      SetBlipScale(info.blip, 0.6)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	    BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)