local airshop = {
	opened = false,
	title = "Aeroclub Los Santos",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 200, type = 7 },
	menu = {
		x = 0.9,
		y = 0.08,
		width = 0.2,
		height = 0.04,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.4,
		font = 0,
		["main"] = {
			title = "CATEGORIES",
			name = "main",
			buttons = {
				{name = "Aviones", description = ""},
				--{name = "Helicopteros", description = ""},
			}
		},
		["Aviones"] = {
			title = "Aviones",
			name = "Aviones",
			buttons = {
				{name = "Duster", costs = 600000, description = {}, model = "duster"},
				{name = "Cuban800", costs = 600000, description = {}, model = "cuban800"},
				{name = "Mammatus", costs = 600000, description = {}, model = "mammatus"},
				{name = "Stunt", costs = 600000, description = {}, model = "stunt"},
				{name = "Velum", costs = 600000, description = {}, model = "velum"},
				{name = "Velum2", costs = 600000, description = {}, model = "velum2"},

			}
		},
		["Helicopteros"] = {
			title = "Helicopteros",
			name = "Helicopteros",
			buttons = {
				--{name = "Annihilator", costs = 600000, description = {}, model = "annihilator"},
				--{name = "Frogger", costs = 600000, description = {}, model = "frogger"},
				--{name = "Valkyrie", costs = 600000, description = {}, model = "valkyrie"},
				--{name = "Cargobob", costs = 600000, description = {}, model = "cargobob2"},
		
			}
		},
	}
}
local fakecar = {model = '', car = nil}
local airshop_locations = {
{entering = {-1233.4050,-2883.5993,13.9450}, inside = {-1233.4050,-2883.5993,13.9450}, outside = {-1233.4050,-2883.5993,13.9450}},
}

local airshop_blips ={}
local inrangeofairshop = false
local currentlocation = nil
local boughtcar = false

local function LocalPed()
return GetPlayerPed(-1)
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

function IsPlayerInRangeOfAirshop()
return inrangeofairshop
end

function ShowAirshopBlips(bool)
	if bool and #airshop_blips == 0 then
		for station,pos in pairs(airshop_locations) do
			local loc = pos
			pos = pos.entering
			local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
			-- 60 58 137
			SetBlipSprite(blip,574)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Aeroclub')
			EndTextCommandSetBlipName(blip)
			SetBlipAsShortRange(blip,true)
			SetBlipAsMissionCreatorBlip(blip,true)
			table.insert(airshop_blips, {blip = blip, pos = loc})
		end
		Citizen.CreateThread(function()
			while #airshop_blips > 0 do
				Citizen.Wait(0)
				local inrange = false
				for i,b in ipairs(airshop_blips) do
					if IsPlayerWantedLevelGreater(GetPlayerIndex(),0) == false and airshop.opened == false and IsPedInAnyVehicle(LocalPed(), true) == false and  GetDistanceBetweenCoords(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3],GetEntityCoords(LocalPed())) < 5 then
						DrawMarker(1,b.pos.entering[1],b.pos.entering[2],b.pos.entering[3],0,0,0,0,0,0,2.001,2.0001,0.5001,0,155,255,200,0,0,0,0)
						drawTxt('Presiona ~g~ENTER~s~ para comprar un ~b~aeronave',0,1,0.5,0.8,0.6,255,255,255,255)
						currentlocation = b
						inrange = true
					end
				end
				inrangeofairshop = inrange
			end
		end)
	elseif bool == false and #airshop_blips > 0 then
		for i,b in ipairs(airshop_blips) do
			if DoesBlipExist(b.blip) then
				SetBlipAsMissionCreatorBlip(b.blip,false)
				Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(b.blip))
			end
		end
		airshop_blips = {}
	end
end

function f(n)
return n + 0.0001
end

function LocalPed()
return GetPlayerPed(-1)
end

function try(f, catch_f)
local status, exception = pcall(f)
if not status then
catch_f(exception)
end
end
function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end
--local veh = nil
function OpenCreator()
	boughtcar = false
	local ped = LocalPed()
	local pos = currentlocation.pos.inside
	FreezeEntityPosition(ped,true)
	SetEntityVisible(ped,false)
	local g = Citizen.InvokeNative(0xC906A7DAB05C8D2B,pos[1],pos[2],pos[3],Citizen.PointerValueFloat(),0)
	SetEntityCoords(ped,pos[1],pos[2],g)
	SetEntityHeading(ped,pos[4])
	airshop.currentmenu = "main"
	airshop.opened = true
	airshop.selectedbutton = 0
	--[[Citizen.CreateThread(function()
		RequestModel(GetHashKey('t20'))
		while not HasModelLoaded(GetHashKey('t20')) do
			Citizen.Wait(0)
		end
		veh = CreateVehicle(GetHashKey('t20'),GetOffsetFromEntityInWorldCoords(ped,2.001,0,0),false,true)
		SetModelAsNoLongerNeeded(GetHashKey('t20'))
		SetEntityHeading(veh,pos[4])
		FreezeEntityPosition(veh,true)
		SetEntityCollision(veh,false,false)
		SetEntityInvincible(veh,true)
	end)]]
end
local vehicle_price = 0
function CloseCreator()
	Citizen.CreateThread(function()
		local ped = LocalPed()
		if not boughtcar then
			local pos = currentlocation.pos.entering
			SetEntityCoords(ped,pos[1],pos[2],pos[3])
			FreezeEntityPosition(ped,false)
			SetEntityVisible(ped,true)
		else
			local veh = GetVehiclePedIsUsing(ped)
			local model = GetEntityModel(veh)
			local colors = table.pack(GetVehicleColours(veh))
			local extra_colors = table.pack(GetVehicleExtraColours(veh))

			local mods = {}
			for i = 0,24 do
				mods[i] = GetVehicleMod(veh,i)
			end
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
			local pos = currentlocation.pos.outside

			FreezeEntityPosition(ped,false)
			RequestModel(model)
			while not HasModelLoaded(model) do
				Citizen.Wait(0)
			end
			personalvehicle = CreateVehicle(model,pos[1],pos[2],pos[3],pos[4],true,false)
			SetModelAsNoLongerNeeded(model)
			for i,mod in pairs(mods) do
				SetVehicleModKit(personalvehicle,0)
				SetVehicleMod(personalvehicle,i,mod)
			end
			SetVehicleOnGroundProperly(personalvehicle)
			SetVehicleHasBeenOwnedByPlayer(personalvehicle,true)
			local id = NetworkGetNetworkIdFromEntity(personalvehicle)
			SetNetworkIdCanMigrate(id, true)
			Citizen.InvokeNative(0x629BFA74418D6239,Citizen.PointerValueIntInitialized(personalvehicle))
			SetVehicleColours(personalvehicle,colors[1],colors[2])
			SetVehicleExtraColours(personalvehicle,extra_colors[1],extra_colors[2])
			--local blip = AddBlipForEntity(personalvehicle)
			--SetBlipSprite(blip,326)
			--BeginTextCommandSetBlipName("STRING")
			--AddTextComponentString('Personal vehicle')
			--EndTextCommandSetBlipName(blip)
			--personalvehicle_blip = blip
			TaskWarpPedIntoVehicle(GetPlayerPed(-1),personalvehicle,-1)
			SetEntityVisible(ped,true)


		end
		airshop.opened = false
		airshop.menu.from = 1
		airshop.menu.to = 10
	end)
end

function drawMenuButton(button,x,y,selected)
	local menu = airshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(menu.scale, menu.scale)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(button.name)
	if selected then
		DrawRect(x,y,menu.width,menu.height,255,255,255,255)
	else
		DrawRect(x,y,menu.width,menu.height,0,0,0,150)
	end
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function drawMenuInfo(text)
	local menu = airshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.45, 0.45)
	SetTextColour(255, 255, 255, 255)
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawRect(0.675, 0.95,0.65,0.050,0,0,0,150)
	DrawText(0.365, 0.934)
end

function drawMenuRight(txt,x,y,selected)
	local menu = airshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(menu.scale, menu.scale)
	SetTextRightJustify(1)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawText(x + menu.width/2 - 0.03, y - menu.height/2 + 0.0028)
end

function drawMenuTitle(txt,x,y)
local menu = airshop.menu
	SetTextFont(2)
	SetTextProportional(0)
	SetTextScale(0.5, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawRect(x,y,menu.width,menu.height,0,0,0,150)
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
function Notify(text)
SetNotificationTextEntry('STRING')
AddTextComponentString(text)
DrawNotification(false, false)
end

function DoesPlayerHaveVehicle(model,button,y,selected)
		local t = false
		--TODO:check if player own car
		if t then
			drawMenuRight("OWNED",airshop.menu.x,y,selected)
		else
			drawMenuRight(button.costs.."$",airshop.menu.x,y,selected)
		end
end

local backlock = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1,201) and IsPlayerInRangeOfAirshop() then
			if airshop.opened then
				CloseCreator()
			else
				OpenCreator()
			end
		end
		if airshop.opened then
			local ped = LocalPed()
			local menu = airshop.menu[airshop.currentmenu]
			drawTxt(airshop.title,1,1,airshop.menu.x,airshop.menu.y,1.0, 255,255,255,255)
			drawMenuTitle(menu.title, airshop.menu.x,airshop.menu.y + 0.08)
			drawTxt(airshop.selectedbutton.."/"..tablelength(menu.buttons),0,0,airshop.menu.x + airshop.menu.width/2 - 0.0385,airshop.menu.y + 0.067,0.4, 255,255,255,255)
			local y = airshop.menu.y + 0.12
			buttoncount = tablelength(menu.buttons)
			local selected = false

			for i,button in pairs(menu.buttons) do
				if i >= airshop.menu.from and i <= airshop.menu.to then

					if i == airshop.selectedbutton then
						selected = true
					else
						selected = false
					end
					drawMenuButton(button,airshop.menu.x,y,selected)
					if button.costs ~= nil then
						if airshop.currentmenu == "Aviones" or airshop.currentmenu == "Helicopteros" then
							DoesPlayerHaveVehicle(button.model,button,y,selected)
						else
						drawMenuRight(button.costs.."$",airshop.menu.x,y,selected)
						end
					end
					y = y + 0.04
					if airshop.currentmenu == "Aviones" or airshop.currentmenu == "Helicopteros" then
						if selected then
							if fakecar.model ~= button.model then
								if DoesEntityExist(fakecar.car) then
									Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
								end
								local pos = currentlocation.pos.inside
								local hash = GetHashKey(button.model)
								RequestModel(hash)
								while not HasModelLoaded(hash) do
									Citizen.Wait(0)
									drawTxt("~b~Chargement...",0,1,0.5,0.5,1.5,255,255,255,255)

								end
								local veh = CreateVehicle(hash,pos[1],pos[2],pos[3],pos[4],false,false)
								while not DoesEntityExist(veh) do
									Citizen.Wait(0)
									drawTxt("~b~Chargement...",0,1,0.5,0.5,1.5,255,255,255,255)
								end
								FreezeEntityPosition(veh,true)
								SetEntityInvincible(veh,true)
								SetVehicleDoorsLocked(veh,4)
								--SetEntityCollision(veh,false,false)
								TaskWarpPedIntoVehicle(LocalPed(),veh,-1)
								for i = 0,24 do
									SetVehicleModKit(veh,0)
									RemoveVehicleMod(veh,i)
								end
								fakecar = { model = button.model, car = veh}
							end
						end
					end
					if selected and IsControlJustPressed(1,201) then
						ButtonSelected(button)
					end
				end
			end
		end
		if airshop.opened then
			if IsControlJustPressed(1,202) then
				Back()
			end
			if IsControlJustReleased(1,202) then
				backlock = false
			end
			if IsControlJustPressed(1,188) then
				if airshop.selectedbutton > 1 then
					airshop.selectedbutton = airshop.selectedbutton -1
					if buttoncount > 10 and airshop.selectedbutton < airshop.menu.from then
						airshop.menu.from = airshop.menu.from -1
						airshop.menu.to = airshop.menu.to - 1
					end
				end
			end
			if IsControlJustPressed(1,187)then
				if airshop.selectedbutton < buttoncount then
					airshop.selectedbutton = airshop.selectedbutton +1
					if buttoncount > 10 and airshop.selectedbutton > airshop.menu.to then
						airshop.menu.to = airshop.menu.to + 1
						airshop.menu.from = airshop.menu.from + 1
					end
				end
			end
		end

	end
end)


function round(num, idp)
  if idp and idp>0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end
function ButtonSelected(button)
	local ped = GetPlayerPed(-1)
	local this = airshop.currentmenu
	local btn = button.name
	if this == "main" then
		if btn == "Aviones" then
			OpenMenu('Aviones')
		elseif btn == "Helicopteros" then
			OpenMenu('Helicopteros')
		end
	elseif this == "Aviones" or this == "Helicopteros" then
		TriggerServerEvent('CheckMoneyForFly',button.model,button.costs)
	end
end

RegisterNetEvent('FinishMoneyCheckForFly')
AddEventHandler('FinishMoneyCheckForFly', function()
	boughtcar = true
	CloseCreator()
end)

function OpenMenu(menu)
	fakecar = {model = '', car = nil}
	airshop.lastmenu = airshop.currentmenu
	if menu == "Aviones" then
		airshop.lastmenu = "main"
	elseif menu == "Helicopteros"  then
		airshop.lastmenu = "main"
	elseif menu == 'race_create_objects' then
		airshop.lastmenu = "main"
	elseif menu == "race_create_objects_spawn" then
		airshop.lastmenu = "race_create_objects"
	end
	airshop.menu.from = 1
	airshop.menu.to = 10
	airshop.selectedbutton = 0
	airshop.currentmenu = menu
end


function Back()
	if backlock then
		return
	end
	backlock = true
	if airshop.currentmenu == "main" then
		CloseCreator()
	elseif airshop.currentmenu == "Aviones" or airshop.currentmenu == "Helicopteros" then
		if DoesEntityExist(fakecar.car) then
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
		end
		fakecar = {model = '', car = nil}
		OpenMenu(airshop.lastmenu)
	else
		OpenMenu(airshop.lastmenu)
	end

end

function stringstarts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

local firstspawn = 0
AddEventHandler('playerSpawned', function(spawn)
if firstspawn == 0 then
	--326 car blip 227 225
	ShowAirshopBlips(true)
	firstspawn = 1
end
end)

RegisterNetEvent('airshop:spawnVehicle')
AddEventHandler('airshop:spawnVehicle', function(v)
	local car = GetHashKey(v)
	local playerPed = GetPlayerPed(-1)
	if playerPed and playerPed ~= -1 then
		RequestModel(car)
		while not HasModelLoaded(car) do
				Citizen.Wait(0)
		end
		local playerCoords = GetEntityCoords(playerPed)

		veh = CreateVehicle(car, playerCoords, 0.0, true, false)
		TaskWarpPedIntoVehicle(playerPed, veh, -1)
		SetEntityInvincible(veh, true)
	end
end)
