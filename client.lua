RegisterCommand('coordy', function()
	local ped = PlayerPedId()
	local x, y, z = table.unpack(GetEntityCoords(ped, true))
	local heading = GetEntityHeading(ped)
    local dirX, dirY = table.unpack(GetEntityForwardVector(ped))
	TriggerEvent("coordsSaver:saveCoord", x, y, z, heading, dirX, dirY)
end)

AddEventHandler("coordsSaver:saveCoord", function(x, y, z, heading, dirX, dirY)
	while true do 
		Wait(0)
		local ped = PlayerPedId()
		FreezeEntityPosition(ped, true)
		DisableControls()
		drawTxt("x= "..tenth(x,2).." y= "..tenth(y,2).." z= "..tenth(z,2).." heading= "..tenth(heading,2))
		DrawMarker(	
				26, x, y, z,
				dirX, dirY, 0,
				0, 0, 0,
				0.5, 0.5, 0.5,
				255, 255, 255, 255,
				false, false, nil, false
				)
		if IsDisabledControlPressed(0, 32) then 
			x = x + 0.01		
		elseif IsDisabledControlPressed(0, 33) then 
			x = x - 0.01
		elseif IsDisabledControlPressed(0, 34) then 
			y = y + 0.01
		elseif IsDisabledControlPressed(0, 35) then 
			y = y - 0.01
		elseif IsDisabledControlPressed(0, 20) then 
			z = z - 0.01
		elseif IsDisabledControlPressed(0, 44) then 
			z = z + 0.01
		elseif IsDisabledControlPressed(0, 190) then 
                
		elseif IsDisabledControlPressed(0, 191) then 
			SendNUIMessage({
				coords = ""..tenth(x,2)..","..tenth(y,2)..","..tenth(z,2)..","..tenth(heading,2)
			})
			FreezeEntityPosition(ped, false)
			break
		end		
	end	
end)

function DisableControls()
    DisableControlAction(0, 30, true)
    DisableControlAction(0, 31, true)
    DisableControlAction(0, 32, true)
    DisableControlAction(0, 33, true)
    DisableControlAction(0, 34, true)
    DisableControlAction(0, 35, true)
    DisableControlAction(0, 266, true)
    DisableControlAction(0, 267, true)
    DisableControlAction(0, 268, true)
    DisableControlAction(0, 269, true)
    DisableControlAction(0, 44, true)
    DisableControlAction(0, 20, true)
    DisableControlAction(0, 74, true)
end

function drawTxt(text)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(0.5, 0.5)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.3,0.8)
end

function tenth(num, numDecimalPlaces) 
    local mult = 5^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end
