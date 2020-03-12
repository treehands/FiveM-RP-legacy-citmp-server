---------------------------------------------------------------------
                --[[SCRIPT MADE BY : ALEXMIHAI04]]--
               --[[DO NOT SELL OR COPY THIS SCRIPT]]--
                   --[[github.com/ItsAlexYTB]]--
        --[[ENJOY THE SCRIPT , DO NOT MAKE 1000 NPCS :))))) ]]
---------------------------------------------------------------------

--[[EXPLANATION [EN]: 

-1,2,3 : Coordonates
-4 : Name for the drawtext
-5 : Ped heading
-6 : Ped hash
-7: Ped model

]]--

--[[DO NOT TOUCH IF YOU DON'T KNOW WHAT YOU DO]]--

--[[EXPLANATION [RO]
-1,2,3 : sunt coordonatele de la npc
-4 : Numele care apare deasupra npc-ului
-5 : Heading (partea in care sta orientat)
-6 : Hash de la ped , se poate lua de pe net
-7 : Modelul de la ped , asemenea , il gasiti pe net


]]--

local coordonate = {

    -- Markets
	
    {-47.24,-1758.68,28.42,"Vendedor",54.73,0x18CE57D0,"mp_m_shopkeep_01"},
	{1959.1,3741.48,31.34,"Vendedor",296.51,0x18CE57D0,"mp_m_shopkeep_01"},
	{1392.33,3606.27,33.98,"Vendedor",197.18,0x18CE57D0,"mp_m_shopkeep_01"},
	{549.33,2669.77,41.15,"Vendedor",111.27,0x18CE57D0,"mp_m_shopkeep_01"},	
	{2555,380.83,107.62,"Vendedor",4.25,0x18CE57D0,"mp_m_shopkeep_01"},	
	{-1819.45,793.68,137.08,"Vendedor",132.59,0x18CE57D0,"mp_m_shopkeep_01"},	
	{-1221.37,-907.95,11.33,"Vendedor",30.08,0x18CE57D0,"mp_m_shopkeep_01"},	

 -- Ammunations
    {810.39,-2159.13,28.62,"Vendedor",7.62,0x9E08633D,"s_m_y_ammucity_01"},
    {23.15,-1105.72,28,"Vendedor",153.24,0x9E08633D,"s_m_y_ammucity_01"},
    {842.19,-1035.34,27.19,"Vendedor",356.79,0x9E08633D,"s_m_y_ammucity_01"},
    {-661.81,-933.35,20.83,"Vendedor",192.2,0x9E08633D,"s_m_y_ammucity_01"},
    {-1304.06,-394.9,35.7,"Vendedor",77.25,0x9E08633D,"s_m_y_ammucity_01"},
    {2567.4,292.6,107.73,"Vendedor",358.85,0x9E08633D,"s_m_y_ammucity_01"},
    {-3173.57,1088.71,19.84,"Vendedor",248.39,0x9E08633D,"s_m_y_ammucity_01"},
    {-1118.99,2699.88,17.55,"Vendedor",224.92,0x9E08633D,"s_m_y_ammucity_01"},
    {-331.4,6085.45,30.45,"Vendedor",218.1,0x9E08633D,"s_m_y_ammucity_01"},
    {1692.51,3761.17,33.7,"Vendedor",219.1,0x9E08633D,"s_m_y_ammucity_01"},
	{254.46,-48.95,68.94,"Vendedor",64.54,0x9E08633D,"s_m_y_ammucity_01"},
	
	-- AirShop
    {-997.60,-2958.33,12.9450,"AeroClub",87.03,0x62018559,"s_m_y_airworker"},
	
	-- Simeon
    {-32.13,-1114.37,26.42,"Simeon",70.06,"cs_siemonyetarian"},
	
}

Citizen.CreateThread(function()

    for _,v in pairs(coordonate) do
      RequestModel(GetHashKey(v[7]))
      while not HasModelLoaded(GetHashKey(v[7])) do
        Wait(1)
      end
  
      RequestAnimDict("mini@strip_club@idles@bouncer@base")
      while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
        Wait(1)
      end
      ped =  CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
      SetEntityHeading(ped, v[5])
      FreezeEntityPosition(ped, true)
      SetEntityInvincible(ped, true)
      SetBlockingOfNonTemporaryEvents(ped, true)
      TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    end
end)

Citizen.CreateThread(function()
    while true do
        local pos = GetEntityCoords(GetPlayerPed(-1), true)
        Citizen.Wait(0)
        for _,v in pairs(coordonate) do
            x = v[1]
            y = v[2]
            z = v[3]
            if(Vdist(pos.x, pos.y, pos.z, x, y, z) < 20.0)then
                DrawText3D(x,y,z+2.10, "~g~"..v[4], 1.2, 1)
                DrawText3D(x,y,z+1.95, "~w~Bienvenido", 1.0, 1)
            end
        end
    end
end)


function DrawText3D(x,y,z, text, scl, font) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

--[[ENJOY]]--