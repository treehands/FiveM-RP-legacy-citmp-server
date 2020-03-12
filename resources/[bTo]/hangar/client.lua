--[[Register]]--

RegisterNetEvent("ply_hangares:getVehicles")
RegisterNetEvent('ply_hangares:SpawnVehicle')
RegisterNetEvent('ply_hangares:StoreVehicle')
RegisterNetEvent('ply_hangares:SelVehicle')



--[[Local/Global]]--

VEHICLES = {}
local venta_location = {-985.33, -2972.25, 12.94}
local inrangeofhangar = false
local currentlocation = nil

local hangares = {
	{name="Hangar", colour=46, id=307, x=-999.92, y=-2995.49, z=12.94},
  	{name="Hangar", colour=46, id=307, x=1740.29, y=3268.47, z=40.21},
  	{name="Hangar", colour=46, id=307, x=2133.32, y=4808.77, z=40.19},
}

hangarSelected = { {x=nil, y=nil, z=nil}, }

--[[Functions]]--

function MenuHangar()
    ped = GetPlayerPed(-1);
    MenuTitle = "Hangar"
    ClearMenu()
    Menu.addButton("Guardar el avion","RentrerVehicule",nil)
    Menu.addButton("Sacar un avion","ListeVehicule",nil)
    Menu.addButton("Cerrar","CloseMenu",nil) 
end

function RentrerVehicule()
	TriggerServerEvent('ply_hangares:CheckForVeh',source)
	CloseMenu()
end

function ListeVehicule()
    ped = GetPlayerPed(-1);
    MenuTitle = "Aviones"
    ClearMenu()
    for ind, value in pairs(VEHICLES) do
            Menu.addButton(tostring(value.vehicle_name) .. " : " .. tostring(value.vehicle_state), "OptionVehicle", value.id)
    end    
    Menu.addButton("Guardar","MenuHangar",nil)
end

function OptionVehicle(vehID)
	local vehID = vehID
    MenuTitle = "Opciones"
    ClearMenu()
    Menu.addButton("Sacar", "SortirVehicule", vehID)
    Menu.addButton("Guardar", "ListeVehicule", nil)
end

function SortirVehicule(vehID)
	local vehID = vehID
	TriggerServerEvent('ply_hangares:CheckForSpawnVeh', vehID)
	CloseMenu()
end

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function CloseMenu()
    Menu.hidden = true
end

function LocalPed()
	return GetPlayerPed(-1)
end

function IsPlayerInRangeOfHangar()
	return inrangeofhangar
end

function Chat(debugg)
    TriggerEvent("chatMessage", '', { 0, 0x99, 255 }, tostring(debugg))
end

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		for _, hangar in pairs(hangares) do
			DrawMarker(1, hangar.x, hangar.y, hangar.z, 0, 0, 0, 0, 0, 0, 3.001, 3.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
			if GetDistanceBetweenCoords(hangar.x, hangar.y, hangar.z, GetEntityCoords(LocalPed())) < 3 then
				drawTxt('~g~E~s~ para abrir el menu',0,1,0.5,0.8,0.6,255,255,255,255)
				if IsControlJustPressed(1, 86) then
					hangarSelected.x = hangar.x
					hangarSelected.y = hangar.y
					hangarSelected.z = hangar.z
					MenuHangar()
					Menu.hidden = not Menu.hidden 
				end
				Menu.renderGUI() 
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local near = false
		Citizen.Wait(0)
		for _, hangar in pairs(hangares) do		
			if (GetDistanceBetweenCoords(hangar.x, hangar.y, hangar.z, GetEntityCoords(LocalPed())) < 3 and near ~= true) then 
				near = true							
			end
		end
		if near == false then 
			Menu.hidden = true;
		end
	end
end)

Citizen.CreateThread(function()
    for _, item in pairs(hangares) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, item.id)
      SetBlipAsShortRange(item.blip, true)
	    SetBlipColour(item.blip, item.colour)
	    SetBlipScale(item.blip, 0.9)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(item.name)
      EndTextCommandSetBlipName(item.blip)
    end
end)

Citizen.CreateThread(function()
	local loc = venta_location
	pos = venta_location
	local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
	SetBlipSprite(blip,207)
	SetBlipColour(blip, 46)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Revente')
	EndTextCommandSetBlipName(blip)
	SetBlipAsShortRange(blip,true)
	SetBlipAsMissionCreatorBlip(blip,true)
	checkgarage = 0
	while true do
		Wait(0)
		DrawMarker(1,venta_location[1],venta_location[2],venta_location[3],0,0,0,0,0,0,3.001,3.0001,0.5001,0,155,255,200,0,0,0,0)
		--if GetDistanceBetweenCoords(venta_location[1],venta_location[2],venta_location[3],GetEntityCoords(LocalPed())) < 5 and IsPedInAnyVehicle(LocalPed(), true) == false then
		if GetDistanceBetweenCoords(venta_location[1],venta_location[2],venta_location[3],GetEntityCoords(LocalPed())) < 5 then
			drawTxt('Presiona ~g~E~s~ para destruir el avion',0,1,0.5,0.8,0.6,255,255,255,255)
			if IsControlJustPressed(1, 86) then
				TriggerServerEvent('ply_hangares:CheckForSelVeh',source)
			end
		end
	end
end)



--[[Events]]--

AddEventHandler("ply_hangares:getVehicles", function(THEVEHICLES)
    VEHICLES = {}
    VEHICLES = THEVEHICLES
end)

AddEventHandler("playerSpawned", function()
    TriggerServerEvent("ply_hangares:CheckHangarForVeh")
end)

AddEventHandler('ply_hangares:SpawnVehicle', function(vehicle, plate, state, primarycolor, secondarycolor, pearlescentcolor, wheelcolor)
	local plane = GetHashKey(vehicle)
	local plate = plate
	local state = state
	local primarycolor = tonumber(primarycolor)
	local secondarycolor = tonumber(secondarycolor)
	local pearlescentcolor = tonumber(pearlescentcolor)
	local wheelcolor = tonumber(wheelcolor)
	Citizen.CreateThread(function()
		Citizen.Wait(3000)
		local zonao = GetClosestVehicle(hangarSelected.x, hangarSelected.y, hangarSelected.z, 5.000, 0, 16384)
		if DoesEntityExist(zonao) then
			drawNotification("La zona esta ocupada") 
		else
			if state == "Sortit" then
				drawNotification("Este avion no esta en el hangar")
			else
				local mods = {}
				for i = 0,32 do
					mods[i] = GetVehicleMod(veh,i)
				end
				RequestModel(plane)
				while not HasModelLoaded(plane) do
				Citizen.Wait(0)
				end
				veh = CreateVehicle(plane, hangarSelected.x, hangarSelected.y, hangarSelected.z, 0.0, true, false)
				for i,mod in pairs(mods) do
					SetVehicleModKit(personalvehicle,0)
					SetVehicleMod(personalvehicle,i,mod)
				end
				SetVehicleNumberPlateText(veh, plate)
				SetVehicleOnGroundProperly(veh)
				SetVehicleHasBeenOwnedByPlayer(veh,true)
				local id = NetworkGetNetworkIdFromEntity(veh)
				SetNetworkIdCanMigrate(id, true)
				SetVehicleColours(veh, primarycolor, secondarycolor)
				SetVehicleExtraColours(veh, pearlescentcolor, wheelcolor)
				SetEntityInvincible(veh, false) 
				drawNotification("Vehiculo sacado.")				
				TriggerServerEvent('ply_hangares:SetVehOut', vehicle, plate)
   				TriggerServerEvent("ply_hangares:CheckHangarForVeh")
			end
		end
	end)
end)

AddEventHandler('ply_hangares:StoreVehicle', function(vehicle, plate)
	local plane = GetHashKey(vehicle)	
	local plate = plate
	Citizen.CreateThread(function()
		Citizen.Wait(3000)
		local zonai = GetClosestVehicle(hangarSelected.x, hangarSelected.y, hangarSelected.z, 5.000, 0, 16384)
		SetEntityAsMissionEntity(zonai, true, true)		
		local platezonai = GetVehicleNumberPlateText(zonai)
		if DoesEntityExist(zonai) then	
			if plate ~= platezonai then					
				drawNotification("Este avion no es tuyo.")
			else
				Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(zonai))
				drawNotification("Avion guardado")
				TriggerServerEvent('ply_hangares:SetVehIn', plate)
				TriggerServerEvent("ply_hangares:CheckHangarForVeh")
			end
		else
			drawNotification("Ningun avion presente.")
		end   
	end)
end)

AddEventHandler('ply_hangares:SelVehicle', function(vehicle, plate)
	local plane = GetHashKey(vehicle)	
	local plate = plate
	Citizen.CreateThread(function()		
		Citizen.Wait(0)
		local zonai = GetClosestVehicle(venta_location[1],venta_location[2],venta_location[3], 5.000, 0, 16384)
		SetEntityAsMissionEntity(zonai, true, true)
		local platezonai = GetVehicleNumberPlateText(zonai)
		if DoesEntityExist(zonai) then
			if plate ~= platezonai then
				drawNotification("Este avion no es tuyo.")
			else
				Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(zonai))
				TriggerServerEvent('ply_hangares:SelVeh', plate)
				TriggerServerEvent("ply_hangares:CheckHangarForVeh")
			end
		else
			drawNotification("Ningun avion presente.")
		end
	end)
end)

local firstspawn = 0
AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == 0 then
		RemoveIpl('v_carshowroom')
		RemoveIpl('shutter_open')
		RemoveIpl('shutter_closed')
		RemoveIpl('shr_int')
		RemoveIpl('csr_inMission')
		RequestIpl('v_carshowroom')
		RequestIpl('shr_int')
		--RequestIpl('csr_inMission')
		RequestIpl('shutter_closed')
		firstspawn = 1
	end
end)
