--[[Register]]--

RegisterNetEvent("ply_aeroclub:GetLicences")
RegisterNetEvent("ply_aeroclub:CheckForRealVeh")


--[[Local/Global]]--

LICENCES = {}
local aeroclub_location = {-1239.55,-2893.97,12.94}
local inrangeofgarage = false
local currentlocation = nil
local aeroclub = {title = "Registro", currentpos = nil, marker = { r = 0, g = 155, b = 255, a = 200, type = 1 }}



--[[Events]]--

AddEventHandler("playerSpawned", function()
    TriggerServerEvent("ply_aeroclub:GetLicences")
end)

AddEventHandler("ply_aeroclub:GetLicences", function(THELICENCES)
    LICENCES = {}
    LICENCES = THELICENCES
end)


AddEventHandler("ply_aeroclub:CheckForRealVeh", function(personalvehicle)
	Citizen.CreateThread(function()
		local flymodel = personalvehicle
		local personalvehicle = string.lower(personalvehicle)
		local zona = GetClosestVehicle(aeroclub_location[1],aeroclub_location[2],aeroclub_location[3], 8.000, 0, 16384)
		SetEntityAsMissionEntity(zona, true, true)		
		if DoesEntityExist(zona) then
			local flyname = GetDisplayNameFromVehicleModel(GetEntityModel(zona))
			local flyname = string.lower(flyname)
			local flyname = flyname:gsub("%s+", "")
			local flyname = flyname.gsub(flyname, "%s+", "")
			if personalvehicle ~= flyname then					
				drawNotification("Vehiculo sancionado")
			else
				local name = personalvehicle
				local plate = GetVehicleNumberPlateText(zona)
				local vehicle = personalvehicle
				local colors = table.pack(GetVehicleColours(zona))
				local extra_colors = table.pack(GetVehicleExtraColours(zona))
				GetVehicleExtraColours(zona,extra_colors[1],extra_colors[2])
				local primarycolor = GetVehicleColours(zona,colors[1])
				local secondarycolor = GetVehicleColours(zona,colors[2])	
				local pearlescentcolor = GetVehicleExtraColours(zona,extra_colors[1])
				local wheelcolor = GetVehicleExtraColours(zona,extra_colors[2])

				TriggerServerEvent('ply_aeroclub:SetLicenceForVeh', name, flymodel, plate, primarycolor, secondarycolor, pearlescentcolor, wheelcolor)
			end
		else
			drawNotification("Ningun vehiculo presente")
		end   
	end)

end)



--[[Functions]]--

function MenuAeroclub()
    ped = GetPlayerPed(-1);
    MenuTitle = "Registro"
    ClearMenu()
    Menu.addButton("Comprar un permiso","AcheterPermis",nil)
    Menu.addButton("Registrar un vehiculo","EnregistrerVehicule",nil)
    Menu.addButton("Cerrar","CloseMenu",nil) 
end

function EnregistrerVehicule()
	TriggerServerEvent('ply_aeroclub:CheckForVeh',source)
	CloseMenu()
end

function AcheterPermis()
    ped = GetPlayerPed(-1);
    MenuTitle = "Permiso"
    ClearMenu()
    for ind, value in pairs(LICENCES) do
            Menu.addButton(tostring(value.name) .. " : " .. tostring(value.price), "OptionPermis", value.id)
    end    
    Menu.addButton("Volver","MenuAeroclub",nil)
end

function OptionPermis(licID)
	local licID = licID
	TriggerServerEvent('ply_aeroclub:CheckForLicences', licID)	
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

function IsPlayerInRangeOfGarage()
	return inrangeofgarage
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



--[[Citizen]]--

Citizen.CreateThread(function()
	local loc = aeroclub_location
	pos = aeroclub_location
	local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
	SetBlipSprite(blip,90)
	SetBlipColour(blip,1)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Registro de vehiculos')
	EndTextCommandSetBlipName(blip)
	SetBlipAsShortRange(blip,true)
	SetBlipAsMissionCreatorBlip(blip,true)
	while true do
		Wait(0)
		DrawMarker(1,aeroclub_location[1],aeroclub_location[2],aeroclub_location[3],0,0,0,0,0,0,4.001,4.0001,0.5001,0,155,255,200,0,0,0,0)
		if GetDistanceBetweenCoords(aeroclub_location[1],aeroclub_location[2],aeroclub_location[3],GetEntityCoords(LocalPed())) < 5 and IsPedInAnyVehicle(LocalPed(), true) == false then
			drawTxt('Presiona ~g~E~s~ para abrir el menu',0,1,0.5,0.8,0.6,255,255,255,255)		
			if IsControlJustPressed(1, 86) then
				MenuAeroclub()
				Menu.hidden = not Menu.hidden
			end
			Menu.renderGUI()
		end
	end
end)
