local display = false
local trecut = false
local cam1 = nil
local cam = nil
local gameplaycam = nil
incarcrusher = false

cautamasina = false
vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP","oxy_showroom")
vRPccS = Tunnel.getInterface("oxy_showroom","oxy_showroom")
masini = {}
masinispawnate = {}
selectiecurenta = 1
current = 1

AddEventHandler("playerDropped", function(cfgg)
	masini = cfgg
end)

culoare = {}




local masini = Config.masini
testsh = false
testDriveSeconds = 60
local function f(n)
	return (n + 0.00001)
end
testDriveSeconds = 60
masinaTest = nil
isInTestDrive = false
function destroymasinaTest()
	if(masinaTest ~= nil)then
		if(DoesEntityExist(masinaTest))then
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(masinaTest))
		end
		masinaTest = nil
		TriggerEvent("iesic")
		isInTestDrive = false
	end
	testDriveSeconds = 60
	SetEntityCoords(GetPlayerPed(-1),-38.601848602295,-1109.7780761719,26.437822341919)
	SetEntityHeading(GetPlayerPed(-1), 180.0)
    vRP.notify({"Test driveul a luat sfarsit!"})

    SetEntityVisible(GetPlayerPed(-1),true)
    FreezeEntityPosition(GetPlayerPed(-1),false)
end

AddEventHandler("playerDropped", function()
	if(masinaTest ~= nil)then
		destroymasinaTest()
	end
end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1100)
		if(masinaTest ~= nil) and (isInTestDrive == false) then
			isInTestDrive = true
		else
			isInTestDrive = false
		end
		while(masinaTest ~= nil)do
			local IsInVehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
			if(IsInVehicle ~= nil)then
				if(masinaTest == IsInVehicle)then
					if(testDriveSeconds > 0)then
						testDriveSeconds = testDriveSeconds - 1
					else
						destroymasinaTest()
					end
					isInCar = true
				else
					isInCar = false
				end
			end
            Wait(1000)
		end
	end
end)
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
        local coords = GetEntityCoords(GetVehiclePedIsIn(GetPlayerPed(-1),false))
        if(testDriveSeconds < 60)then
            DrawText3D(coords.x,coords.y,coords.z+1.5,testDriveSeconds.." ~g~Secunde\n~w~Apasa ~g~E ~w~pentru a termina", 1.0, 4)
            if IsControlJustPressed(1, 51) then
                destroymasinaTest()
            end
		end
		if(isInTestDrive) then
			if(isInCar == false)then
				destroymasinaTest()
			end
		end
	end
end)



function deleteVehiclePedIsIn()
	local v = GetVehiclePedIsIn(GetPlayerPed(-1),false)
	SetVehicleHasBeenOwnedByPlayer(v,false)
	Citizen.InvokeNative(0xAD738C3085FE7E11, v, false, true) -- set not as mission entity
	SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(v))
	Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(v))
		for _,v1 in pairs(masinispawnate) do
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(v1))
	  end
  end




  local function tocoords()
	Wait(300)
	local ped = GetPlayerPed(-1)
	if testsh == false then
	TaskVehicleDriveToCoord(ped, GetVehiclePedIsIn(GetPlayerPed(-1),false), -45.767349243164,-1095.7797851562,26.422344207764, f(7), f(1), GetEntityModel(veh), 16777216, 0.51, true)
	Wait(100)
	TaskVehicleDriveToCoord(ped, GetVehiclePedIsIn(GetPlayerPed(-1),false), -45.767349243164,-1095.7797851562,26.422344207764, f(7), f(1), GetEntityModel(veh), 16777216, 0.51, true)
	Wait(100)
	TaskVehicleDriveToCoord(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1),false), -45.767349243164,-1095.7797851562,26.422344207764, f(7), f(1), GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1),false)), 16777216, 0.51, true)
	end
end


















local x, y, z = -421.03393554688, -1710.8310546875, 19.439516067504
local x2, y2, z2 = -467.8773803711, -1676.1942138672, 19.052968978882
local x3, y3, z3 = -461.22750854492,-1705.0541992188,18.815143585206

vehiclePrice = 0
vehicleName = ""
vehModel = ""
vtypes = ""
incircle = false
incircle2 = false
crusherBlip = nil
cevaVariabila = false
veh = nil

local function camera111()
	local ped = GetPlayerPed(-1)
	
	local coords = GetEntityCoords(GetVehiclePedIsIn(GetPlayerPed(-1),false))
	cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",true,2)
	SetCamCoord(cam, 1569.0533447266,3193.94140625,46.611038208008)
	PointCamAtCoord(cam, coords.x,coords.y,coords.z)
	--PointCamAtEntity(cam, GetVehiclePedIsUsing(ped), p2, p3, p4, 1)
	SetCamActive(cam, true)
	RenderScriptCams( 1, 0, cam, 0, 0)
	testDriveSeconds = 10
	TaskVehicleDriveToCoord(ped, masinaTest, 1494.6192626953,3193.7019042969,40.411594390869, f(150), f(1), GetEntityModel(veh), 16777216, f(2.1), true)
end

local function camera()
	local ped = GetPlayerPed(-1)
	local coords = -53.015544891357,-1096.0795898438,26.422330856323
	cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",true,2)
	SetCamCoord(cam, -55.371932983398,-1095.8937988281,27.722332763672)
	coords = -48.586601257324,-1098.7827148438,26.422344207764
	PointCamAtCoord(cam, -37.318260192871,-1097.1641845703,26.422344207764)
	--PointCamAtEntity(cam, GetVehiclePedIsUsing(ped), p2, p3, p4, 1)
	SetCamActive(cam, true)
	RenderScriptCams( 1, 0, cam, 0, 0)

end

local pos = GetEntityCoords(GetPlayerPed(-1), true)




Citizen.CreateThread(function()
	
	while true do
		tick = 500

		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		local ped = GetPlayerPed(-1)
		if incarcrusher == false then
		if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, -49.291751861572,-1095.1217041016,26.422330856323) < 40.0)then
			tick = 0
	
			DrawMarker(36, -49.291751861572,-1095.1217041016,26.422330856323-0.5, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 168, 104, 40, 255, true, 0, 0, true)
			if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z,-49.291751861572,-1095.1217041016,26.422330856323) < 7)then


							if IsControlJustPressed(0, 38) then
								incarcrusher = true
								cautamasina = false
								camera()
							

							end
						end
					end

		end
		Citizen.Wait(tick)
	end
end)


abletoenter = false
local function changeveh()
	local ped = GetPlayerPed(-1)
	

	while masinaTest ~= nil do Wait(1)  end
		local pos = GetEntityCoords(veh, true)
		if testsh == false then
		TaskVehicleDriveToCoord(ped, veh, -45.767349243164,-1095.7797851562,26.422344207764, f(7), f(1), GetEntityModel(veh), 16777216, f(2.1), true)
	Wait(250)
	tocoords()
		end
		

end



local function changeveh1()

	
	local ped = GetPlayerPed(-1)
	local pos = GetEntityCoords(GetPlayerPed(-1), true)

	
	if DoesEntityExist(veh) == false then 

		hash = GetHashKey(masini[selectiecurenta][current].modelname)					
		local i = 0
		if not HasModelLoaded(hash) and i < 50 then
			RequestModel(hash)
			Citizen.Wait(0)
			i = i+1

		end
		-- spawn car
		if HasModelLoaded(hash) and abletoenter == false  then
		--if timer < 255 then
			veh = CreateVehicle(hash,-32.113468170166,-1093.3572998047,26.422304153442,170.0,false,false)
			
			table.insert(masinispawnate, veh)
	
			SetPedIntoVehicle(ped,veh, -1)
			SetVehicleDoorsLocked(veh,4)
			SetModelAsNoLongerNeeded(hash)
			TaskWarpPedIntoVehicle(ped,veh,-1)
			TaskVehicleDriveToCoord(ped, veh, -45.767349243164,-1095.7797851562,26.422344207764, f(7), f(1), GetEntityModel(veh), 16777216, f(2.1), true)
			Wait(450)
			tocoords()
	
			
	
			--SetEntityCollision(veh,false,false)
			
			for i = 0,24 do
				SetVehicleModKit(veh,0)
				RemoveVehicleMod(veh,i)
			end
		end

		end


end
function comma_value(amount)
	local formatted = amount
	while true do  
	  formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
	  if (k==0) then
		break
	  end
	end
	return formatted
  end

 
Citizen.CreateThread(function()
	--NetworkSetEntityVisibleToNetwork(entity, toggle)

	--SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(veh), false)
	--SetEntityLocallyVisible(veh,true)
	--SetEntityLocallyInvisible(veh,false)
	while true do
	Wait(0)

			if incarcrusher then 

				local ped = GetPlayerPed(-1)
				currentuul = current.."/"..#masini[selectiecurenta]
				SetDisplay(true,comma_value(masini[selectiecurenta][current].pret), masini[selectiecurenta][current].nume,masini[selectiecurenta][current].topspeed,masini[selectiecurenta][current].frane,masini[selectiecurenta][current].acceleratie,currentuul)
				

					if DoesEntityExist(veh) == false and testsh == false then 
						hash = GetHashKey(masini[selectiecurenta][current].modelname)
						if DoesEntityExist(veh) then
							
							scaleform = nil
						end							
						local i = 0
						if not HasModelLoaded(hash) and i < 50 then
							RequestModel(hash)
							Citizen.Wait(0)
							i = i+1

						end
						-- spawn car
						if HasModelLoaded(hash) and abletoenter == false  then
						--if timer < 255 then
							veh = CreateVehicle(hash,-32.113468170166,-1093.3572998047,26.422304153442,170.0,false,false)
							table.insert(masinispawnate, veh)
							SetEntityInvincible(veh,true)
							SetPedIntoVehicle(ped,veh, -1)
							SetVehicleDoorsLocked(veh,4)
							SetModelAsNoLongerNeeded(hash)
							changeveh()
							--SetEntityCollision(veh,false,false)
							TaskWarpPedIntoVehicle(ped,veh,-1)
							for i = 0,24 do
								SetVehicleModKit(veh,0)
								RemoveVehicleMod(veh,i)
							end
							TaskVehicleDriveToCoord(ped, veh, -45.767349243164,-1095.7797851562,26.422344207764, f(7), f(1), GetEntityModel(veh), 16777216, f(2.1), true)
							Wait(300)
							TaskVehicleDriveToCoord(ped, veh, -45.767349243164,-1095.7797851562,26.422344207764, f(7), f(1), GetEntityModel(veh), 16777216, 0.51, true)
							tocoords()
						end

						end
					end
				end

	
	--If vehicle is damaged then it will open repair menu
	
end)



RegisterNetEvent('iesic')
AddEventHandler('iesic', function()
	deleteVehiclePedIsIn()
    SetDisplay(false)
	Wait(50)
	incarcrusher = false
	local ped = GetPlayerPed(-1)
	SetDisplay(false)
	SetCamCoord(cam,GetGameplayCamCoords())
	SetCamRot(cam, GetGameplayCamRot(2), 2)
	RenderScriptCams( 1, 1, 0, 0, 0)
	RenderScriptCams( 0, 1, 1000, 0, 0)
	SetCamActive(gameplaycam, true)
	EnableGameplayCam(true)
	SetCamActive(cam, false)
	DestroyCam(cam1, false)
    SetCamActive(cam1, false)
    RenderScriptCams(0, false, 100, false, false)
	deleteVehiclePedIsIn()
	Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
	Wait(10)
	SetEntityCoords(ped, -49.233615875244,-1096.7620849609,26.422332763672,false, false, false, false)
	deleteVehiclePedIsIn()
end)



RegisterNetEvent('iesicc')
AddEventHandler('iesicc', function()
    SetDisplay(false)
	Wait(50)
	incarcrusher = false
	local ped = GetPlayerPed(-1)
	SetDisplay(false)
	SetCamCoord(cam,GetGameplayCamCoords())
	SetCamRot(cam, GetGameplayCamRot(2), 2)
	RenderScriptCams( 1, 1, 0, 0, 0)
	RenderScriptCams( 0, 1, 1000, 0, 0)
	SetCamActive(gameplaycam, true)
	EnableGameplayCam(true)
	SetCamActive(cam, false)
	DestroyCam(cam1, false)
    SetCamActive(cam1, false)
    RenderScriptCams(0, false, 100, false, false)
end)
RegisterNetEvent('iesiccc')
AddEventHandler('iesicc', function()
    SetDisplay(false)
	Wait(50)
	incarcrusher = false
	local ped = GetPlayerPed(-1)
	SetDisplay(false)
end)





















RegisterNUICallback("urmatoareamasina", function(data)
	deleteVehiclePedIsIn()
	while GetVehiclePedIsIn(GetPlayerPed(-1),false) > 0 do Wait(0) deleteVehiclePedIsIn() rablactuala = GetVehiclePedIsUsing(GetPlayerPed(-1))
		DeleteEntity(rablactuala) end

	print("urmatoareamasina")
	if current ~= #masini[selectiecurenta] then
		current = current + 1
		changeveh1()
	else
		print("ultima masina")
	end

	local ped = GetPlayerPed(-1)
	if abletoenter == false then
	TaskVehicleDriveToCoord(ped, veh, -45.767349243164,-1095.7797851562,26.422344207764, f(7), f(1), GetEntityModel(veh), 16777216, 0.51, true)
    end
	
end)

RegisterNUICallback("masinanaterioara", function(data)
	deleteVehiclePedIsIn()
	while GetVehiclePedIsIn(GetPlayerPed(-1),false) > 0 do Wait(0) deleteVehiclePedIsIn() rablactuala = GetVehiclePedIsUsing(GetPlayerPed(-1))
		DeleteEntity(rablactuala) end
	Wait(50)
	print("masinanaterioara")
	if current > 1 then
		current = current - 1
		changeveh1()
	else
		print("ultima masina")
	end
	Wait(20)
	local ped = GetPlayerPed(-1)
	while masinaTest ~= nil do Wait(1)  end
	if abletoenter == false then
	TaskVehicleDriveToCoord(ped, veh, -45.767349243164,-1095.7797851562,26.422344207764, f(7), f(1), GetEntityModel(veh), 16777216, 0.51, true)

end
	
end)






RegisterNUICallback("selectiaurmatoare", function(data)
	deleteVehiclePedIsIn()
	while GetVehiclePedIsIn(GetPlayerPed(-1),false) > 0 do Wait(0) deleteVehiclePedIsIn() rablactuala = GetVehiclePedIsUsing(GetPlayerPed(-1))
		DeleteEntity(rablactuala) end
	print("urmatoareamasina")
	current = (current - current)+1
	if selectiecurenta ~= #masini then
		selectiecurenta = selectiecurenta + 1
		changeveh1()
	else
		print("ultima masina")
	end

    
	
end)

RegisterNUICallback("selectiaanterioara", function(data)
	deleteVehiclePedIsIn()
	while GetVehiclePedIsIn(GetPlayerPed(-1),false) > 0 do Wait(0) deleteVehiclePedIsIn()     rablactuala = GetVehiclePedIsUsing(GetPlayerPed(-1))
		DeleteEntity(rablactuala) end
	print("masinanaterioara")
	
	if selectiecurenta > 1 then
		current = (current - current)+1
		selectiecurenta = selectiecurenta - 1
		changeveh1()
	else
		print("ultima masina")
	end


    
	
end)
















--very important cb 
RegisterNUICallback("exit", function(data)
	abletoenter = false
	isInTestDrive = false
	masinaTest = nil
	deleteVehiclePedIsIn()
    SetDisplay(false)
	Wait(50)
	incarcrusher = false
	local ped = GetPlayerPed(-1)
	SetDisplay(false)
	SetCamCoord(cam,GetGameplayCamCoords())
	SetCamRot(cam, GetGameplayCamRot(2), 2)
	RenderScriptCams( 1, 1, 0, 0, 0)
	RenderScriptCams( 0, 1, 1000, 0, 0)
	SetCamActive(gameplaycam, true)
	EnableGameplayCam(true)
	SetCamActive(cam, false)
	DestroyCam(cam1, false)
    SetCamActive(cam1, false)
    RenderScriptCams(0, false, 100, false, false)
	deleteVehiclePedIsIn()
	Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
	Wait(10)
	SetEntityCoords(ped, -49.233615875244,-1096.7620849609,26.422332763672,false, false, false, false)
	deleteVehiclePedIsIn()
	Wait(500)
	deleteVehiclePedIsIn()
end)


RegisterNUICallback("cumparamasina", function(data)
	local colorPrimary , colorSecondary = GetVehicleColours(veh)
	print("asd")
	TriggerServerEvent("cuumparamasina",masini[selectiecurenta][current].pret,masini[selectiecurenta][current].modelname,colorPrimary,colorSecondary)
	TriggerEvent("iesic")
    SetDisplay(false)
	Wait(500)
	deleteVehiclePedIsIn()
end)
RegisterNUICallback("testeaza", function(data)
	if abletoenter then
	destroymasinaTest()
	Wait(100)
	
	Wait(50)
	
	isInTestDrive = true
	local ped = GetPlayerPed(-1)
	hash = GetHashKey(masini[selectiecurenta][current].modelname)
	if HasModelLoaded(hash) then
		masinaTest = CreateVehicle(hash,1705.1414794922,3250.7551269531,41.001625061035,200.0,false)
		SetModelAsNoLongerNeeded(hash)
		TaskWarpPedIntoVehicle(GetPlayerPed(-1),masinaTest,-1)
		-- vRP.notify({"Ai 1 Minut pentru a testa masina!"})
		for i = 0,24 do
			SetVehicleModKit(masinaTest,0)
			RemoveVehicleMod(masinaTest,i)
		end
		if(masinaTest)then
	
			SetEntityVisible(GetPlayerPed(-1),true)
			FreezeEntityPosition(GetPlayerPed(-1),false)
		end
	
	TriggerEvent("iesiccc")
	Wait(250)
	camera111()
    SetDisplay(false)
end
end
end)



-- this cb is used as the main route to transfer data back 
-- and also where we hanld the data sent from js
RegisterNUICallback("main", function(data)
    chat(data.text, {0,255,0})
    SetDisplay(false)
end)

RegisterNUICallback("error", function(data)
    chat(data.error, {255,0,0})
    SetDisplay(false)
end)

function SetDisplay(bool,pret1, nume1,topspead1,frane1,acceleratie1,catcat)
    display = bool
	Wait(500)

    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
        pret = pret1,
        nume = nume1,
		acceleratie = acceleratie1,
		frane = frane1,
		cat = catcat,
    })

end












function chat(str, color)
    TriggerEvent(
        'chat:addMessage',
        {
            color = color,
            multiline = true,
            args = {str}
        }
    )
end
function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end

RegisterNUICallback('schimbaCuloare', function(data, cb)
    if data.culoareselectata == 1 then
        SetVehicleColours(veh,5, 0)
    elseif data.culoareselectata == 2 then
        SetVehicleColours(veh,12, 12)
    elseif data.culoareselectata == 3 then
        SetVehicleColours(veh,14, 0)
    elseif data.culoareselectata == 4 then
        SetVehicleColours(veh,42, 0)
    elseif data.culoareselectata == 5 then
		SetVehicleColours(veh,55, 0)
    elseif data.culoareselectata == 6 then
		SetVehicleColours(veh,39, 0)
    elseif data.culoareselectata == 7 then
		SetVehicleColours(veh,84, 0)
    elseif data.culoareselectata == 8 then
		SetVehicleColours(veh,135, 0)
    elseif data.culoareselectata == 9 then
		SetVehicleColours(veh,74, 0)
    elseif data.culoareselectata == 10 then
		SetVehicleColours(veh,142, 0)
    elseif data.culoareselectata == 11 then
		SetVehicleColours(veh,158, 0)
    elseif data.culoareselectata == 12 then
		SetVehicleColours(veh,36, 0)
    end
end)

function DrawText3D(x, y, z, text, scl, font)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

    local scale = (1 / dist) * scl
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    if onScreen then
        SetTextScale(0.0 * scale, 1.1 * scale)
        SetTextFont(fontId)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end