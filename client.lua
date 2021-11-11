ESX              = nil
local PlayerData = {}
local HasAlreadyGotMessage = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)


Citizen.CreateThread(function()
   -- marker position is in grapeseed airfield	
   local markerPos = vector3(1989.7, 4694.69, 41.44)
   
   while true do
	Citizen.Wait(1)
	local ped = GetPlayerPed(-1)
	local playerCoords = GetEntityCoords(ped)
	local distance = #(playerCoords - markerPos)
	local isInMarker = false	

		if distance < 8.0 then
		
			DrawMarker(1, markerPos.x, markerPos.y, markerPos.z , 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, 255, 0, 0, 50, false, false, 2, nil, nil, false)
	    		if distance < 2.0 then
				isInMarker = true
				else
				HasAlreadyGotMessage = false
				end
		else
			Citizen.Wait(500)
		end
	
		if isInMarker and not HasAlreadyGotMessage then
			
			-- removes clothes from player
			local ped = GetPlayerPed(PlayerId())
			SetPedComponentVariation(ped, 1, 0, 0, 0)
			SetPedComponentVariation(ped, 3, 15, 0, 0)
			SetPedComponentVariation(ped, 4, 21, 0, 0)
			SetPedComponentVariation(ped, 5, 0, 1, 2)
			SetPedComponentVariation(ped, 6, 34, 0, 0) 
			SetPedComponentVariation(ped, 7, 0, 0, 0)
			SetPedComponentVariation(ped, 8, 15, 0, 0)
			SetPedComponentVariation(ped, 11, 15, 1, 1) 
  	
			Citizen.Wait(500)
			

			-- Transports to Legion Square
			ESX.Game.Teleport(ped, {x = 246.71, y = -879.29, z = 30.29, h = 260.19} )
			
			-- Gives Message
			TriggerEvent('chatMessage', 'You should not enter unknown markers.')
			HasAlreadyGotMessage = true
			Citizen.Wait(500)
		end
		


			
   end
	
end)