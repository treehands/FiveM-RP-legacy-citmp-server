--[[Register]]--

RegisterNetEvent("ply_prefecture:GetLicences")
RegisterNetEvent("ply_prefecture:CheckForRealVeh")


--[[Local/Global]]--

LICENCES = {}
local prefecture_location = {-1239.55,-2893.97,12.94}
local inrangeofgarage = false
local currentlocation = nil
local prefecture = {title = "Registro", currentpos = nil, marker = { r = 0, g = 155, b = 255, a = 200, type = 1 }}



--[[Events]]--

AddEventHandler("playerSpawned", function()
    TriggerServerEvent("ply_prefecture:GetLicences")
end)

AddEventHandler("ply_prefecture:GetLicences", function(THELICENCES)
    LICENCES = {}
    LICENCES = THELICENCES
end)


AddEventHandler("ply_prefecture:CheckForRealVeh", function(personalvehicle)
	Citizen.CreateThread(function()
		local brutmodel = personalvehicle
		local personalvehicle = string.lower(personalvehicle)
		local caisse = GetClosestVehicle(prefecture_location[1],prefecture_location[2],prefecture_location[3], 5.000, 0, 70)
		SetEntityAsMissionEntity(caisse, true, true)		
		if DoesEntityExist(caisse) then
			local vname = GetDisplayNameFromVehicleModel(GetEntityModel(caisse))
			local vname = string.lower(vname)
			local vname = vname:gsub("%s+", "")
			local vname = vname.gsub(vname, "%s+", "")
			if personalvehicle ~= vname then					
				drawNotification("Vehiculo sancionado")
			else
				local name = personalvehicle
				local plate = GetVehicleNumberPlateText(caisse)
				local vehicle = personalvehicle
				local colors = table.pack(GetVehicleColours(caisse))
				local extra_colors = table.pack(GetVehicleExtraColours(caisse))
				GetVehicleExtraColours(caisse,extra_colors[1],extra_colors[2])
				local primarycolor = GetVehicleColours(caisse,colors[1])
				local secondarycolor = GetVehicleColours(caisse,colors[2])	
				local pearlescentcolor = GetVehicleExtraColours(caisse,extra_colors[1])
				local wheelcolor = GetVehicleExtraColours(caisse,extra_colors[2])

				TriggerServerEvent('ply_prefecture:SetLicenceForVeh', name, brutmodel, plate, primarycolor, secondarycolor, pearlescentcolor, wheelcolor)
			end
		else
			drawNotification("Ningun vehiculo presente")
		end   
	end)

end)



--[[Functions]]--

function MenuPrefecture()
    ped = GetPlayerPed(-1);
    MenuTitle = "Registro"
    ClearMenu()
    Menu.addButton("Comprar un permiso","AcheterPermis",nil)
    Menu.addButton("Registrar un vehiculo","EnregistrerVehicule",nil)
    Menu.addButton("Cerrar","CloseMenu",nil) 
end

function EnregistrerVehicule()
	TriggerServerEvent('ply_prefecture:CheckForVeh',source)
	CloseMenu()
end

function AcheterPermis()
    ped = GetPlayerPed(-1);
    MenuTitle = "Permiso"
    ClearMenu()
    for ind, value in pairs(LICENCES) do
            Menu.addButton(tostring(value.name) .. " : " .. tostring(value.price), "OptionPermis", value.id)
    end    
    Menu.addButton("Volver","MenuPrefecture",nil)
end

function OptionPermis(licID)
	local licID = licID
	TriggerServerEvent('ply_prefecture:CheckForLicences', licID)	
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
	local loc = prefecture_location
	pos = prefecture_location
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
		DrawMarker(1,prefecture_location[1],prefecture_location[2],prefecture_location[3],0,0,0,0,0,0,4.001,4.0001,0.5001,0,155,255,200,0,0,0,0)
		if GetDistanceBetweenCoords(prefecture_location[1],prefecture_location[2],prefecture_location[3],GetEntityCoords(LocalPed())) < 5 and IsPedInAnyVehicle(LocalPed(), true) == false then
			drawTxt('Presiona ~g~E~s~ para abrir el menu',0,1,0.5,0.8,0.6,255,255,255,255)		
			if IsControlJustPressed(1, 86) then
				MenuPrefecture()
				Menu.hidden = not Menu.hidden
			end
			Menu.renderGUI()
		end
	end
end)
